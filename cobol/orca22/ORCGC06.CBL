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
       PROGRAM-ID.             ORCGC06.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 病名登録
      *  コンポーネント名  : 行為関連病名検索（Ｃ０６）　
      *  管理者            : 
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   01/07/02  日付画面用チェックサブ追加
      *  01.00.02    MCC-藤原     01/09/11  選択番号の編集
      *  01.00.03    MCC-藤原     01/09/12  診療区分、診療年月エラーのとき
      *                                     画面をクリアする     
      *  01.01.01    MCC-藤原     01/09/20  JOINの修正      
      *  01.01.02    MCC-藤原     01/11/05  C01の削除
      *                                     共通ＳＰＡから患者ＩＤ・診療科
      *                                     をセットする
      *  01.01.03    MCC-藤原     01/11/13  病名コードを７桁に変更 
      *                                     薬剤料逓減は表示しない    
      *  01.02.01    MCC-藤原     01/11/21  ORCMCPSUBへ変更  
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    病名登録用共通パラメタ
           COPY    "C01COMMON-SPA".
      *
      *    病名登録用画面ＳＰＡ
           COPY    "C02SCR-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-C06.
           03  SPA-C06-AREA.
               05  SPA-GMN-PAGE            PIC 9(02).
               05  SPA-GMN-LINE            PIC 9(02).
               05  SPA-GMN-MAX1            PIC 9(02).
               05  SPA-GMN-MAX2            PIC 9(02).
               05  SPA-GMN-CUR             PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-SRYKBN.
                       09  SPA-GMN-SRYKBNK     PIC X(02).
                       09  SPA-GMN-SK1         PIC X(01).
                       09  SPA-GMN-SRYKBNMEI   PIC X(10).
                   07  SPA-GMN-SRYKBNL     OCCURS   10.
                       09  SPA-GMN-TSRYKBN     PIC X(02).
                       09  SPA-GMN-TK1         PIC X(01).
                       09  SPA-GMN-TSRYKBNMEI  PIC X(10).
      *----(01.00.01) LINE UPD START ----------------------------------
      *************07  SPA-GMN-SINRYM          PIC X(06).
                   07  SPA-GMN-SINRYM          PIC X(07).
      *----(01.00.01) LINE UPD END   ----------------------------------
                   07  SPA-GMN-TBL1.
                       09  SPA-GMN-TBLO1   OCCURS  90.
                           11  SPA-GMN-TBANGO1     PIC 9(03).
                           11  SPA-GMN-TKOUIMEI    PIC X(30).
                   07  SPA-GMN-TBL2.
                       09  SPA-GMN-TBLO2   OCCURS  90.
                           11  SPA-GMN-TBANGO2     PIC 9(03).
                           11  SPA-GMN-TBYOMEI     PIC X(200).
                           11  SPA-GMN-TSTRYMD     PIC X(09).
                           11  SPA-GMN-TTENKI      PIC X(06).
                   07  SPA-GMN-SELNUM1         PIC X(04).
                   07  SPA-GMN-SELNUM2         PIC X(04).
      *
               05  SPA-NAI-SELNO               PIC 9(03).
      *         
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-SINRYM          PIC X(06).
                   07  SPA-NAI-SELNUM1         PIC 9(04).
                   07  SPA-NAI-SELNUM2         PIC 9(04).
                  07  SPA-NAI-TBL1.
                       09  SPA-NAI-TBL1O   OCCURS  90.
                           11  SPA-NAI-TYAKZCD PIC X(09).
                   07  SPA-NAI-TBL2.
                       09  SPA-NAI-TBL2O   OCCURS  90.
      *********************11  SPA-BYOCD       PIC X(05).
                           11  SPA-BYOCD       PIC X(07).
      *
               05  SPA-KNKYAK-AREA.
                   07  SPA-KNK-TBL             OCCURS   100.
                       09  SPA-KNK-SRYCD       PIC  X(09).
                       09  SPA-KNK-SRYMEI      PIC  X(40).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-BYOMEI          PIC X(02).
           03  STS-CHKMST          PIC X(02).
           03  STS-KNJBYO          PIC X(02).
           03  STS-SINKAI          PIC X(02).
           03  STS-SINKOUI         PIC X(02).
           03  STS-TENSU           PIC X(02).
           03  STS-C06-KEY         PIC X(02).
           03  STS-ERRMSG-KEY      PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-CHKMST          PIC 9(01).
           03  FLG-BYOMEI          PIC 9(01).
           03  FLG-SINKOUI         PIC 9(01).
           03  FLG-SINKAI          PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-CHK             PIC 9(01).
           03  FLG-KNJBYO          PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX1                PIC 9(01).
           03  IDX3                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX5                PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SELNO           PIC 9(03). 
           03  WRK-NUM             PIC ZZ9.
           03  WRK-KBNCD.
               05  WRK-KBNCD1      PIC 9(03).
               05  WRK-KBNCD2      PIC X(05).
      *
           03  WRK-KANRITBL1.
               05  WRK-KANBYOCD        OCCURS   6.
      *************07  WRK-BYOCD       PIC X(05).
                   07  WRK-BYOCD       PIC X(07).
      *
           03  WRK-BYOMEI          PIC X(200).
           03  WRK-SRYKBN          PIC X(02).
      *
           03  WRK-HENFLG          PIC 9(01).     
      *
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
      *
           03  WRK-STRYMDW         PIC X(09).
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
      *    薬剤料逓減
       01  CONS-TEIGEN             PIC X(09)   VALUE   "630010002".         
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *    チェックマスタ−
       01  CHK-REC.
           COPY    "CPCHK.INC".
      *    患者病名マスタ−
       01  PTBYOMEI-REC.
           COPY    "CPPTBYOMEI.INC".
      *    診療行為マスタ−
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *    点数マスタ−
           COPY    "CPTENSU.INC".
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
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *----(01.00.03) LINE ADD START ----------------------------------
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *----(01.00.03) LINE ADD END   ----------------------------------
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *     
           COPY    "CPORCMCP.INC".  
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *****COPY    "MCPAREA.INC".
           COPY    MCPAREA.
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "C02.INC".
           COPY    "C03.INC".
           COPY    "C04.INC".
           COPY    "C05.INC".
           COPY    "C06.INC".
           COPY    "C07.INC".
           COPY    "C08.INC".
           COPY    "CERR.INC".
           COPY    "CID1.INC".
           COPY    "CID2.INC".
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
           MOVE    SPA-WORK        TO  SPA-C01KYOUTU
           MOVE    SPA-FREE        TO  SPA-C02FREE
           MOVE    SPA-C02SONOTA   TO  SPA-C06 
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
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-C06         TO  SPA-C02SONOTA
           MOVE    SPA-C02FREE     TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    DISPLAY "*** ORCGC06    START  ***"
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "CERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE  SPACE  TO  LINKAREA
      *
      ***  MOVE  "NEW"      TO  MCP-PUTTYPE.
           MOVE  SPACE      TO  MCP-PUTTYPE.
           MOVE  "C06"      TO  MCP-WINDOW.
      *
           PERFORM  900-PUT-WINDOW.
      *
           MOVE  1  TO  FLG-END
          .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           INITIALIZE              SPA-C06
      *
           IF  LINKAREA  NOT = SPACE
               MOVE  LNK-KYOUTU  TO  SPA-KYOUTU
           END-IF 
      *
           MOVE    SPA-SYSYMD(1:6)    TO  SPA-NAI-SINRYM
           MOVE    SPA-SYSYMDWH(1:6)  TO  SPA-GMN-SINRYM
      *
      *    診療区分編集
      ***     MOVE   "13"              TO  SPA-GMN-TSRYKBN    (01)
      ***     MOVE   "指導料"          TO  SPA-GMN-TSRYKBNMEI (01)
           MOVE   "20"              TO  SPA-GMN-TSRYKBN    (01)
           MOVE   "投薬料"          TO  SPA-GMN-TSRYKBNMEI (01)
           MOVE   "30"              TO  SPA-GMN-TSRYKBN    (02)
           MOVE   "注射料"          TO  SPA-GMN-TSRYKBNMEI (02)
      *
           MOVE    SPA-GMN-SRYKBNL (01)    TO  SPA-GMN-SRYKBN
      *
      *    診療行為一覧編集処理
           PERFORM 410121-SINKOUI-HEN-SEC
      *
           MOVE    1               TO  SPA-GMN-PAGE
           MOVE    3               TO  SPA-GMN-CUR
           .
       3OO-SCREEN-EXT.
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
                   PERFORM 210-BACK
      *    前画面
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 430-MAEGMN-SEC
      *    次画面
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 440-ATOGMN-SEC
      *    確定
      **         WHEN    "CLICKED"       ALSO    "B12"
      **             PERFORM 450-KAKUTEI-SEC
           END-EVALUATE
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
               WHEN    "ACTIVATE"      ALSO    "SRYKBN"
                   PERFORM 41011-SRYKBN-HEN-SEC
      *
               WHEN    "ACTIVATE"      ALSO    "SRYYM"
                   PERFORM 41012-SINKOUI-HEN-SEC
      *
               WHEN    "ACTIVATE"      ALSO    "SELNUM1"
                   PERFORM 41013-SELNUM1-HEN-SEC
      *
               WHEN    "ACTIVATE"      ALSO    "SELNUM2"
                   PERFORM 41014-SELNUM2-HEN-SEC
      *        診療行為行選択
               WHEN    ANY             ALSO    "SRYACTLST"
                   PERFORM 41015-SRYACTSEL-SEC
      *        病名行選択
               WHEN    ANY             ALSO    "BYOMEILST"
                   PERFORM 41016-BYOMEISEL-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "C02"               TO  SPA-SAKIPG
           MOVE    "C06"               TO  SPA-MOTOPG
      *
      *
           MOVE    SPACE               TO  SPA-C01KYOUTU
           MOVE    SPA-C01KYOUTU       TO  SPA-WORK
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *****************************************************************
      *    前頁　処理
      *****************************************************************
       430-MAEGMN-SEC             SECTION.
      *
           .
       430-MAEGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁　処理
      *****************************************************************
       440-ATOGMN-SEC             SECTION.
      *
           .
       440-ATOGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療区分　入力処理
      *****************************************************************
       41011-SRYKBN-HEN-SEC      SECTION.
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           MOVE    SPA-GMN-SRYKBNK TO  WRK-SRYKBN
           MOVE    C06-SRYKBN    TO  SPA-GMN-SRYKBN
      *
           IF      SPA-GMN-SRYKBN  =   SPACE
               MOVE    "0004"               TO  SPA-ERRCD
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      10
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-SRYKBNK    =   SPA-GMN-TSRYKBN (IDY)
                       MOVE    SPA-GMN-SRYKBNL (IDY)
                                          TO  SPA-GMN-SRYKBN
                       MOVE    1          TO  WRK-HENFLG                    
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0001"               TO  SPA-ERRCD
               END-IF
           END-IF
      *
           MOVE    ZERO                TO  SPA-NAI-SELNO 
           MOVE    ZERO                TO  SPA-NAI-SELNUM1
                                           SPA-NAI-SELNUM2
           MOVE    SPACE               TO  SPA-GMN-SELNUM1
                                           SPA-GMN-SELNUM2 
           IF      SPA-ERRCD           NOT =   SPACE    
               INITIALIZE                      SPA-GMN-TBL1
               INITIALIZE                      SPA-NAI-TBL1
               INITIALIZE                      SPA-GMN-TBL2
               INITIALIZE                      SPA-NAI-TBL2
               INITIALIZE                      SPA-KNKYAK-AREA
               MOVE    ZERO                TO  SPA-GMN-MAX1
               MOVE    ZERO                TO  SPA-GMN-MAX2
           ELSE
      *             
      *        診療行為一覧編集処理
               IF      WRK-SRYKBN      NOT =   SPA-GMN-SRYKBNK   
                   PERFORM 410121-SINKOUI-HEN-SEC
               END-IF
      *
               MOVE    2                   TO  SPA-GMN-CUR
           END-IF    
           .
       41011-SRYKBN-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療年月　入力処理
      *****************************************************************
       41012-SINKOUI-HEN-SEC       SECTION.
      *
           MOVE    2               TO  SPA-GMN-CUR
      *
           MOVE    C06-SRYYM       TO  SPA-GMN-SINRYM
      *----(01.00.01) LINE ADD START ----------------------------------
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    SPA-GMN-SINRYM      TO  SGDAY-INDAY
           MOVE    "1"                 TO  SGDAY-INTYPE
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY(1:6)    TO  SPA-GMN-SINRYM
               MOVE    SGDAY-SDAY (1:6)    TO  SPA-NAI-SINRYM
           ELSE
               MOVE    "0002"          TO  SPA-ERRCD
           END-IF
      *----(01.00.01) LINE ADD END   ----------------------------------
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    MOVE    SPA-GMN-SINRYM     TO  WRK-YM
      *    PERFORM 5002-HIZUKE-CHK-SEC
      *    IF      SPA-ERRCD            =   SPACE
      *        MOVE    WRK-HENYMDG(1:6)    TO  SPA-GMN-SINRYM
      *        MOVE    WRK-SYMD   (1:6)    TO  SPA-NAI-SINRYM
      *    ELSE    
      *        GO  TO  41012-SINKOUI-HEN-EXT
      *****END-IF
      *----(01.00.01) LINE DEL END   ----------------------------------
      *
           MOVE    ZERO                TO  SPA-NAI-SELNO 
           MOVE    ZERO                TO  SPA-NAI-SELNUM1
                                           SPA-NAI-SELNUM2
           MOVE    SPACE               TO  SPA-GMN-SELNUM1
                                           SPA-GMN-SELNUM2
           IF      SPA-ERRCD           NOT =   SPACE    
               INITIALIZE                      SPA-GMN-TBL1
               INITIALIZE                      SPA-NAI-TBL1
               INITIALIZE                      SPA-GMN-TBL2
               INITIALIZE                      SPA-NAI-TBL2
               INITIALIZE                      SPA-KNKYAK-AREA
               MOVE    ZERO                TO  SPA-GMN-MAX1
               MOVE    ZERO                TO  SPA-GMN-MAX2
           ELSE
      *
      *    診療行為一覧編集処理
               PERFORM 410121-SINKOUI-HEN-SEC
               MOVE    3                   TO  SPA-GMN-CUR
           END-IF    
      *
           .
       41012-SINKOUI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為一覧編集処理
      *****************************************************************
       410121-SINKOUI-HEN-SEC       SECTION.
      *
           INITIALIZE                      SPA-GMN-TBL1
           INITIALIZE                      SPA-NAI-TBL1
           INITIALIZE                      SPA-GMN-TBL2
           INITIALIZE                      SPA-NAI-TBL2
           INITIALIZE                      SPA-KNKYAK-AREA
      *
           MOVE    ZERO                TO  SPA-GMN-MAX1
           MOVE    ZERO                TO  SPA-GMN-MAX2
      *
           MOVE    ZERO                TO  IDX
      *
      *    診療行為マスター検索
           INITIALIZE                      SRYACT-REC
           MOVE    SPA-HOSPID           TO  SRY-HOSPID
           MOVE    SPA-NYUGAIKBN        TO  SRY-NYUGAIKBN
      **** MOVE    SPA-PTID             TO  SRY-PTID
           MOVE    SPA-C01-PTID         TO  SRY-PTID
           MOVE    SPA-NAI-SINRYM      TO  SRY-SRYYM
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACT-KEY4"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACT-KEY4"     TO  ORC-DBPATH
               PERFORM 930-SINKOUI-READ-SEC
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SINKOUI
           END-IF
      *
           PERFORM UNTIL      (FLG-SINKOUI       =   1        )
               IF      SPA-NAI-SINRYM      =   SRY-SRYYM
                   EVALUATE    SPA-GMN-SRYKBNK
                       WHEN    "20"
                           IF      SRY-SRYKBN  = "21" OR "22" OR "23"
                               PERFORM 4101211-KNK-KOUI-SEC
                           END-IF
                       WHEN    "30"
                           IF      SRY-SRYKBN  = "31" OR "32" OR "33"
                               PERFORM 4101211-KNK-KOUI-SEC
                           END-IF
                   END-EVALUATE
               END-IF
               MOVE    "SRYACT-KEY4"       TO  ORC-DBPATH
               PERFORM 930-SINKOUI-READ-SEC
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACT-KEY4"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       90
                   OR      SPA-KNK-SRYCD (IDX) =   SPACE
               MOVE    IDX                  TO  SPA-GMN-TBANGO1 (IDX)
               MOVE    SPA-KNK-SRYCD (IDX)  TO  SPA-NAI-TYAKZCD (IDX)
               MOVE    SPA-KNK-SRYMEI(IDX)  TO  SPA-GMN-TKOUIMEI(IDX)
               MOVE    IDX                  TO  SPA-GMN-MAX1
           END-PERFORM
      *
           MOVE    1                   TO  SPA-GMN-PAGE
      *
           .
       410121-SINKOUI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    薬剤チェック用処理
      *****************************************************************
       4101211-KNK-KOUI-SEC           SECTION.
      *
      *    回数を診療会計マスタよりチェックする
           INITIALIZE                      SRYACCT-REC
           MOVE    SRY-HOSPID          TO  ACCT-HOSPID
           MOVE    SRY-NYUGAIKBN       TO  ACCT-NYUGAIKBN
           MOVE    SRY-PTID            TO  ACCT-PTID
           MOVE    SRY-SRYKA           TO  ACCT-SRYKA
           MOVE    SRY-SRYYM           TO  ACCT-SRYYM
           MOVE    SRY-SRYKBN          TO  ACCT-SRYKBN
           MOVE    SRY-ZAINUM          TO  ACCT-ZAINUM
           PERFORM 940-SINKAI-READ-SEC
           IF     (FLG-SINKAI          =   ZERO )  AND
                  (ACCT-ZAIKAISU       >   ZERO )
               CONTINUE
           ELSE
               GO      TO      4101211-KNK-KOUI-EXT
           END-IF
     *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2        >   5   )  
                   OR         (SRY-SRYCD(IDX2)     =   SPACE )
               IF      SRY-SRYCD (IDX2)(1:1)   =   "6"
               AND     SRY-SRYCD (IDX2)    NOT =   CONS-TEIGEN    
                   PERFORM VARYING     IDX3    FROM    1   BY  1
                           UNTIL       IDX3        >   90
                    IF      SPA-KNK-SRYCD (IDX3)   =   SRY-SRYCD (IDX2)
                           MOVE    90                  TO  IDX3
                    ELSE 
                       IF      SPA-KNK-SRYCD (IDX3)    =   SPACE
                         MOVE    SRY-SRYCD (IDX2)    TO  SPA-KNK-SRYCD
                                                                (IDX3)
                         INITIALIZE                      TNS-TENSU-REC 
                         MOVE    SRY-SRYCD (IDX2)    TO  TNS-KEY
                         PERFORM 910-TENSU-READ-SEC
                         IF      FLG-TENSU           =   ZERO
                            MOVE    TNS-NAME      TO  SPA-KNK-SRYMEI
                                                                (IDX3)
                          END-IF
                          MOVE    90                  TO  IDX3
                       END-IF
                    END-IF
                   END-PERFORM
               END-IF
           END-PERFORM
      *
           .
       4101211-KNK-KOUI-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号１　入力処理
      *****************************************************************
       41013-SELNUM1-HEN-SEC       SECTION.
      *
           MOVE    3             TO  SPA-GMN-CUR
      *
           MOVE    ZERO                TO  SPA-GMN-MAX2
           INITIALIZE                  SPA-GMN-TBL2
           INITIALIZE                  SPA-NAI-TBL2
                                       SPA-NAI-SELNO
      * 
           MOVE    C06-SELNUM1   TO  SPA-GMN-SELNUM1
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    C06-SELNUM1         TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "0006"                  TO  SPA-ERRCD
               GO      TO      41013-SELNUM1-HEN-EXT
           ELSE
               MOVE    SNUM-OUTNUM         TO  SPA-NAI-SELNUM1
           END-IF
      *    選択番号チェック
           IF      SPA-NAI-SELNUM1     >=  1   AND  <=  SPA-GMN-MAX1
               CONTINUE
           ELSE
               MOVE    "0003"          TO  SPA-ERRCD
               GO      TO      41013-SELNUM1-HEN-EXT
           END-IF
      *
           MOVE    SPA-NAI-SELNUM1     TO  SPA-NAI-SELNO
      *     
           PERFORM 410131-BYOMEI-HENSYU-SEC 
           .
       41013-SELNUM1-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名編集処理
      *****************************************************************
       410131-BYOMEI-HENSYU-SEC        SECTION.
      *
           MOVE    ZERO                TO  IDX
      *
           INITIALIZE                      CHK-REC
           MOVE    "1"                 TO  CHK-CHKKBN
           MOVE    SPA-NAI-TYAKZCD(SPA-NAI-SELNUM1)
                                       TO  CHK-SRYCD
           MOVE    CHK-REC             TO  MCPDATA-REC
           MOVE    SPA-NAI-SINRYM      TO  ORC-DBYMD(1:6)
           MOVE    "01"                TO  ORC-DBYMD(7:2)
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "CHK-KEY2"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "CHK-KEY2"     TO  ORC-DBPATH
               PERFORM 900-CHKMST-READ-SEC
           ELSE
               INITIALIZE                  CHK-REC
               MOVE    1               TO  FLG-CHKMST
           END-IF
      *
           PERFORM UNTIL       FLG-CHKMST          =   1
               IF      SPA-GMN-MAX2        =   ZERO
                   MOVE    CHK-TEKCDNUM       TO  SPA-GMN-MAX2
               END-IF
      *
               PERFORM 41012-BYOMEI-HEN-SEC
      *
               IF      IDX             =   90
                   MOVE    1         TO  FLG-CHKMST
               ELSE
                   MOVE    "CHK-KEY2"     TO  ORC-DBPATH
                   PERFORM 900-CHKMST-READ-SEC
               END-IF
      *
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "CHK-KEY2"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC

     *
           IF      SPA-GMN-MAX2    >   SPA-GMN-MAX1
               COMPUTE SPA-GMN-PAGE    =  (SPA-GMN-MAX2 -  1  )
                                       /   22
                                       +   1
           END-IF
      *
           IF      SPA-GMN-MAX2        >   ZERO
               MOVE    4                   TO  SPA-GMN-CUR
           END-IF 
           .
       410131-BYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名編集処理
      *****************************************************************
       41012-BYOMEI-HEN-SEC        SECTION.
      *
           PERFORM VARYING     IDX2    FROM    1   BY  1
                   UNTIL      (IDX2        >   10  )   OR
                              (CHK-CD (IDX2)
                                           =   SPACE)  OR
                              (IDX         =   90  )
               ADD     1                   TO  IDX
               MOVE    IDX                 TO  SPA-GMN-TBANGO2 (IDX)
               MOVE    CHK-CD (IDX2)       TO  SPA-BYOCD (IDX)
               INITIALIZE                      BYOMEI-REC 
               MOVE    CHK-CD (IDX2)       TO  BYO-BYOMEICD
               PERFORM 910-BYOMEI-READ-SEC
               IF      FLG-BYOMEI          =  ZERO
                   MOVE    BYO-BYOMEI      TO  SPA-GMN-TBYOMEI (IDX)
               END-IF
      *
      *        登録済チェック
               PERFORM 410121-KNJBYO-CHK-SEC
               MOVE    WRK-STRYMDW         TO  SPA-GMN-TSTRYMD(IDX)
           END-PERFORM
      *
           .
       41012-BYOMEI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録済チェック
      *****************************************************************
       410121-KNJBYO-CHK-SEC       SECTION.
      *
           MOVE    SPACE           TO  WRK-STRYMDW
           MOVE    ZERO           TO  FLG-CHK
      *    患者病名マスター検索
           INITIALIZE              PTBYOMEI-REC
           MOVE    SPA-HOSPID      TO  PTBYO-HOSPID
      *****MOVE    SPA-PTID        TO  PTBYO-PTID
      *****MOVE    SPA-SRYKA       TO  PTBYO-SRYKA
           MOVE    SPA-C01-PTID    TO  PTBYO-PTID
           MOVE    SPA-C01-SRYKA   TO  PTBYO-SRYKA
      *
           MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
               PERFORM 920-KNJBYO-READ-SEC
           ELSE
               INITIALIZE                  PTBYOMEI-REC
               MOVE    1               TO  FLG-KNJBYO
           END-IF

           PERFORM UNTIL    (FLG-KNJBYO        =   1        ) OR
                            (FLG-CHK           =   1        )
               PERFORM VARYING     IDX5    FROM    1   BY  1
                       UNTIL      (IDX5        >   6   )   OR
                                  (FLG-CHK     =   1 ) 
                   IF      CHK-CD (IDX2)       =   PTBYO-BYOMEICD (IDX5)
                       MOVE    1             TO  FLG-CHK
                   END-IF
               END-PERFORM
      *
               IF      FLG-CHK             =   1
                   MOVE    PTBYO-SRYYMD        TO  WRK-SYMD
                   INITIALIZE                      STS-AREA-DAY
                   INITIALIZE                      LNK-DAY2-AREA
                   MOVE    "21"                TO  LNK-DAY2-IRAI
                   MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
                   CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                       LNK-DAY2-AREA
                   MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
                   MOVE    WRK-HENYMDG         TO  WRK-STRYMDW
               END-IF
      *
               MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
               PERFORM 920-KNJBYO-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       410121-KNJBYO-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択処理
      *****************************************************************
       41014-SELNUM2-HEN-SEC       SECTION.
      *
           MOVE    4             TO  SPA-GMN-CUR
      *
           MOVE    C06-SELNUM2   TO  SPA-GMN-SELNUM2
      *
           INITIALIZE                      ORCSNUMAREA
           MOVE    C06-SELNUM2         TO  SNUM-INX
           CALL    "ORCSNUM"           USING
                                       ORCSNUMAREA
           IF     (SNUM-RC         NOT =   ZERO  )   OR
                  (SNUM-MINKBN     NOT =   SPACE )   OR
                  (SNUM-SYOKBN     NOT =   SPACE )
               MOVE    "0006"                  TO  SPA-ERRCD
               GO      TO      41014-SELNUM2-HEN-EXT
           ELSE
               MOVE    SNUM-OUTNUM         TO  SPA-NAI-SELNUM2
           END-IF
      *
      *    選択番号チェック
           IF      SPA-NAI-SELNUM2     >=  1   AND  <=  SPA-GMN-MAX2
               CONTINUE
           ELSE
               MOVE    "0003"          TO  SPA-ERRCD
               GO      TO      41014-SELNUM2-HEN-EXT
           END-IF
      *
      *    確定後前画面へ
           PERFORM 450-KAKUTEI-SEC
      *
           .
       41014-SELNUM2-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41015-SRYACTSEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX1
               IF      C06-SELECT1 (IDX)    =   "T"
                   IF      IDX             =   SPA-NAI-SELNO
                       CONTINUE
                   ELSE        
                       MOVE    IDX             TO  WRK-SELNO
                       MOVE    50              TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF      WRK-SELNO           >   ZERO
               MOVE    WRK-SELNO           TO  SPA-NAI-SELNO
           END-IF
      *
      *
           MOVE    ZERO                TO  SPA-GMN-MAX2
           INITIALIZE                  SPA-GMN-TBL2
           INITIALIZE                  SPA-NAI-TBL2
      *
           MOVE    SPA-GMN-TBANGO1 (SPA-NAI-SELNO)
                                       TO  SPA-GMN-SELNUM1
                                           SPA-NAI-SELNUM1
      *                                 
           PERFORM 410131-BYOMEI-HENSYU-SEC 
           .
       41015-SRYACTSEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41016-BYOMEISEL-SEC       SECTION.
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-MAX2
               IF      C06-SELECT (IDX)    =   "T"
                   MOVE    IDX             TO  WRK-SELNO
                   MOVE    50              TO  IDX
               END-IF    
           END-PERFORM
      *
           MOVE    SPA-GMN-TBANGO2 (WRK-SELNO)
                                       TO  SPA-GMN-SELNUM2
                                           SPA-NAI-SELNUM2
      *
      *    確定後前画面へ
           PERFORM 450-KAKUTEI-SEC
           .
       41016-BYOMEISEL-EXT.
           EXIT.
      *     
      *****************************************************************
      *    確定　処理
      *****************************************************************
       450-KAKUTEI-SEC             SECTION.
      *
           MOVE    "C02"               TO  SPA-SAKIPG
           MOVE    "C06"               TO  SPA-MOTOPG
      *
           INITIALIZE                  SPA-C01KYOUTU
           MOVE    SPA-GMN-TBYOMEI(SPA-NAI-SELNUM2)
                                       TO  SPA-C01-TBYOMEI (1)
           MOVE    SPA-NAI-TBL2O  (SPA-NAI-SELNUM2)
                                       TO  SPA-C01-TBYOMEICD (1)
           MOVE    SPA-C01KYOUTU       TO  SPA-WORK
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "C02"                TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .

       450-KAKUTEI-EXT.
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
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "C06    "           TO  MCP-WINDOW.
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
           MOVE   SPACE   TO                 C06
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX         >   10
                   OR          SPA-GMN-SRYKBNL (IDX) = SPACE 
               MOVE    SPA-GMN-SRYKBNL(IDX) 
                                           TO  C06-SRYKBNLST(IDX)
               MOVE    IDX                 TO  C06-COUNT3
           END-PERFORM
      *
           MOVE    SPA-GMN-SRYKBN      TO  C06-SRYKBN
      *
           MOVE    SPA-GMN-SINRYM      TO  C06-SRYYM
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX                     >   90
                   OR          SPA-GMN-TBANGO1 (IDX)   =   ZERO
               MOVE    SPA-GMN-TBANGO1 (IDX)   TO  WRK-NUM
               MOVE    WRK-NUM                 TO  C06-TBANGO1(IDX)
               MOVE    SPA-GMN-TKOUIMEI(IDX)   TO  C06-TKOUIMEI(IDX)
               MOVE    IDX        TO  C06-COUNT1
      *         
               IF      IDX             =   SPA-NAI-SELNO
                   MOVE    "T"             TO  C06-SELECT1 (IDX)
               ELSE
                   MOVE    "F"             TO  C06-SELECT1 (IDX)
               END-IF
          END-PERFORM
      *    
          PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX                     >   90
                   OR          SPA-GMN-TBANGO2 (IDX)   =   ZERO
               MOVE    SPA-GMN-TBANGO2 (IDX)   TO  WRK-NUM
               MOVE    WRK-NUM                 TO  C06-TBANGO2(IDX)
               MOVE    SPA-GMN-TBYOMEI (IDX)   TO  C06-TBYOMEI(IDX)
               MOVE    SPA-GMN-TSTRYMD (IDX)   TO  C06-TSTRYMD(IDX)
               MOVE    SPA-GMN-TTENKI  (IDX)   TO  C06-TTENKI (IDX)
               MOVE    IDX        TO  C06-COUNT2 
           END-PERFORM
      *     
           MOVE    SPA-GMN-SELNUM1     TO  C06-SELNUM1
           MOVE    SPA-GMN-SELNUM2     TO  C06-SELNUM2
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
                WHEN   1
                    MOVE  "SRYKBN"   TO  MCP-WIDGET
                WHEN   2
                    MOVE  "SRYYM"    TO  MCP-WIDGET
                WHEN   3
                    MOVE  "SELNUM1"  TO  MCP-WIDGET
                WHEN   4
                    MOVE  "SELNUM2"  TO  MCP-WIDGET
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
                   MOVE    "診療区分入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "診療年月入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "選択番号入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "診療区分が未入力です"
                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "診療年月が未入力です"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  CERR
           MOVE    SPA-ERRCD            TO  CERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  CERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "C06"                TO  SPA-MOTOPG
           MOVE    "CERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "CERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           IF      WRK-YM          =   SPACE
               MOVE    SPA-SYSYMD          TO  WRK-SYMD
               MOVE    SPA-SYSYMDWH        TO  WRK-HENYMDG
               GO  TO  5002-HIZUKE-CHK-EXT
           END-IF
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
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    チェックマスター読込
      *****************************************************************
       900-CHKMST-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-CHKMST
               MOVE    MCPDATA-REC     TO  CHK-REC
           ELSE
               MOVE    1               TO  FLG-CHKMST
           END-IF
      *
           .
       900-CHKMST-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名マスター読込
      *****************************************************************
       910-BYOMEI-READ-SEC         SECTION.
      *
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "BYOMEI-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "BYOMEI-KEY"           TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  BYOMEI-REC
                   MOVE    ZERO                TO  FLG-BYOMEI
               ELSE
                   MOVE    1                   TO  FLG-BYOMEI
                   INITIALIZE                  BYOMEI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-BYOMEI
               INITIALIZE                  BYOMEI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "BYOMEI-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .                            
      *

       910-BYOMEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者病名マスター読込
      *****************************************************************
       920-KNJBYO-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-KNJBYO
               MOVE    MCPDATA-REC     TO  PTBYOMEI-REC
           ELSE
               MOVE    1               TO  FLG-KNJBYO
           END-IF
      *
           .
       920-KNJBYO-READ-EXT.
           EXIT.
      *****************************************************************
      *    診療行為マスター読込
      *****************************************************************
       930-SINKOUI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SINKOUI
               MOVE    MCPDATA-REC     TO  SRYACT-REC
           ELSE
               MOVE    1               TO  FLG-SINKOUI
           END-IF
      *
           .
       930-SINKOUI-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスタ読み込み
      *****************************************************************
       940-SINKAI-READ-SEC         SECTION.
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SRYACCT-KEY"           TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  SRYACCT-REC
                   MOVE    ZERO                TO  FLG-SINKAI
               ELSE
                   MOVE    1                   TO  FLG-SINKAI
                   INITIALIZE                  SRYACCT-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SINKAI
               INITIALIZE                  SRYACCT-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SRYACCT-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       940-SINKAI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
      *    MOVE    ZERO                TO  TNS-YUKOSTYMD
      *    MOVE    ALL "9"             TO  TNS-YUKOEDYMD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TENSU-KEY"           TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   MOVE    1                   TO  FLG-TENSU
                   INITIALIZE                  TNS-TENSU-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TENSU-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
