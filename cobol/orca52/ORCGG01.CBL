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
       PROGRAM-ID.             ORCGG01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次統計
      *  コンポーネント名  : 月次統計
      *  管理者            : 
      *  01/06/19    MCC-藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02.03.18  端末ＩＤ
      *                                     X(16)からX(32)に変更
      *  01.00.02    MCC-森脇     02.04.23  パラメタ空白時日付セット
      *  01.00.03    MCC-藤原     02/04/15  印刷管理・印刷ＤＢ・
      *                                     ジョブ管理ＤＢの追加
      *  01.00.04    MCC-藤原     02/05/15  処理前にジョブ管理を削除する
      *  01.00.05    MCC-藤原     02/06/04  再印刷・情報削除ボタン追加
      *  01.00.06    NACL-藤原    02/09/12  ディレクトリをサブプロへ
      *  01.00.07    NACL-森脇    03/02/12  パラメタ入力チェック追加
      *  01.00.08    NACL-多々納  03/03/31  未入力時、画面編集追加
      *  01.00.09    NACL-太田    03/04/30  確定のとき自動的に情報確認画面を表示
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      * 
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
           COPY    "ENUM-VALUE".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    レセプト作成指示共通パラメタ
           COPY    "G01COMMON-SPA".
      *     
      *    画面用ＳＰＡ
       01  SPA-G01.
           03  SPA-G01-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-MAXPAGE     PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(02).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
           	   07  SPA-GMN-TBL    OCCURS  100.
                       09  SPA-GMN-CHK.
                           11  SPA-GMN-CHK-VALUE
                                              PIC X(01).
           	       09  SPA-GMN-NUM        PIC X(03). 
           	       09  SPA-GMN-HCNAME     PIC X(80).
           	       09  SPA-GMN-PRGNAME    PIC X(24).
                       09  SPA-GMN-PARAHYOJI-G    OCCURS  3.
                           11  SPA-GMN-PARAHYOJI
                                                  PIC X(20).
           	       09  SPA-GMN-PARA-TBL.  
                           11  SPA-GMN-PARA-G     OCCURS  3.
                               13  SPA-GMN-PARA   PIC X(10).
      *                         
               05  SPA-NAI-AREA.
                   07  SPA-NAI-TBL    OCCURS  100.
                       09  SPA-NAI-PARA-G         OCCURS  3.
                           11  SPA-NAI-PARA       PIC X(10).
           	       09  SPA-NAI-HENPARA-TBL.
           	           11  SPA-NAI-HENPARA-G  OCCURS  3.   
                               13  SPA-NAI-HENPARA
                                                  PIC X(10).
      *
       01  FLG-AREA.
           03  FLG-END                PIC 9(01).
           03  FLG-SYSKANRI           PIC 9(01).
      *
           03  FLG-CHK                PIC 9(01). 
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
      *
       01  IDX-AREA.
           03  IDX                    PIC 9(04).
           03  IDY                    PIC 9(04).
           03  IDZ                    PIC 9(04).
           03  IDZ1                   PIC 9(04).
           03  IDZ2                   PIC 9(04). 
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY  "CPMKPASS.INC".
      *
       01  SHELL-AREA.
           03  SHELL-NAME          PIC X(25)   VALUE
               "scripts/daily/execoprg.sh".
      *         
       01  WRK-AREA.
           03  WRK-PRTKANRI-RENNUM PIC 9(04).
           03  WRK-GIDMSG          PIC X(70).
           03  WRK-YMD             PIC X(10). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-PAGE            PIC ZZZZZZZZZ9.
      *
           03  WRK-NUM             PIC 9(03).
      *         
           03  WRK-RECEERR         PIC X(200).
      *
           03  WRK-WIDGET1         PIC 9(01).
           03  WRK-WIDGET2         PIC 9(02).  
      *      
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
           03  SYS-TIME            PIC X(06).
      *
       01  WRK-LNK-AREA.
           COPY    "CPORCSPRTLNK.INC".             
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
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
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".         
      *
       01  WRK-CONS-AREA.
      *    システム管理ＤＢ（３００３）のキー値  
           03  WRK-CONS-3003-KBNCD PIC X(08)   VALUE   "052".
      *    印刷管理ＤＢのキー値  
           03  WRK-CONS-PRTKANRI-TBL-KEY
                                   PIC X(08)   VALUE   "MONTHLY".
           03  WRK-CONS-PRTKANRI-TBL-GROUP
                                   PIC X(14)   VALUE   SPACE.
      *    ジョブ管理ＤＢのキー値  
           03  WRK-CONS-JOB-SHELLID
                                   PIC X(08)   VALUE   "MONTHLY".
           03  WRK-CONS-JOB-JOBID  PIC 9(07)   VALUE   ZERO.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理
           COPY    "CPSK1031.INC".
      *     
           COPY    "CPSK3002.INC".
      *     
           COPY    "CPSK3003.INC".
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
      *ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
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
           COPY    "G99.INC".
           COPY    "GERR.INC".
           COPY    "GID1.INC".
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
           MOVE    SPA-FREE        TO  SPA-G01
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
           MOVE    SPA-G01         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
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
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
      *
      ***  MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "G01"               TO  MCP-WINDOW.
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
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
      *
      *        元の画面へ戻す
               IF      SPA-MOTOPG      =   "XA01"  OR  "XB01"
                   MOVE    LNK-COMMON      TO  SPA-KYOTUKEY
                   MOVE    LNK-SCRSPA      TO  SPA-G01
                   INITIALIZE              SPA-G01KYOUTU
                   GO  TO  300-SCREEN-EXT
               END-IF
      *
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
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
           INITIALIZE                  SPA-G01-AREA
                                       SPA-G01KYOUTU
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       100
               MOVE    "F"             TO  SPA-GMN-CHK-VALUE (IDX)
           END-PERFORM
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       100
               MOVE    IDX (2:)        TO  SPA-GMN-NUM (IDX)
           END-PERFORM
      *
      *    システム管理マスタ読込
      *
           INITIALIZE                     SYS-3002-REC 
           MOVE  "3002"               TO  SYS-3002-KANRICD    
           MOVE  SYS-3002-REC         TO  MCPDATA-REC
           MOVE  "DBSELECT"           TO  MCP-FUNC
           MOVE  "SYSKANRI-KEY2"      TO  ORC-DBPATH
           MOVE  SPA-SYSYMD           TO  ORC-DBYMD
           CALL  "ORCMCPSUB"           USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF     MCP-RC              =   ZERO
               PERFORM 900-SYSKANRI-NEXT-SEC
           ELSE
               MOVE    1                  TO  FLG-SYSKANRI
           END-IF
           PERFORM UNTIL       FLG-SYSKANRI    =   1
               IF      SYS-3002-KBNCD(1:3) >   "100"
                   CONTINUE
               ELSE
                   MOVE    SYS-3002-KBNCD(1:3) TO  WRK-NUM
                   MOVE    WRK-NUM             TO  IDX
                   MOVE    SYS-3002-HCNAME     TO  SPA-GMN-HCNAME (IDX)
                   MOVE    SYS-3002-PRGNAME    TO  SPA-GMN-PRGNAME(IDX)
                   PERFORM VARYING IDY FROM    1   BY  1
                           UNTIL   IDY >       3
                       MOVE    SYS-3002-PARAHYOJI(IDY) TO
                                            SPA-GMN-PARAHYOJI(IDX IDY)
                       MOVE    SYS-3002-PARA     (IDY) TO
                                            SPA-NAI-PARA     (IDX IDY)
                   END-PERFORM
                   IF      IDX              >   SPA-GMN-MAX
                       MOVE    IDX              TO  SPA-GMN-MAX
                   END-IF     
               END-IF
      *
               PERFORM 900-SYSKANRI-NEXT-SEC
           END-PERFORM
      *
           MOVE  "DBCLOSE"                   TO  MCP-FUNC
           MOVE  "SYSKANRI-KEY2"             TO  ORC-DBPATH
           CALL  "ORCMCPSUB"                  USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
      * 
      *
           IF      SPA-GMN-MAX         =   ZERO
               MOVE    1                   TO  SPA-GMN-MAXPAGE
           ELSE    
               COMPUTE SPA-GMN-MAXPAGE  =   (SPA-GMN-MAX - 1)
                                       /   10  + 1
           END-IF                            
           MOVE    1                   TO  SPA-GMN-PAGE
      *
           MOVE    ZERO                TO  SPA-GMN-CUR    
           MOVE    ZERO                TO  IDX
           MOVE    3                   TO  IDY
           PERFORM 4101-NEXT-CUR-SEC
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-GID1-SET-SEC            SECTION.
      *
           IF      SPA-GID1-FLG    =   "OK"
               EVALUATE    SPA-GIDCD
                   WHEN    "6666"
                       MOVE    "JOIN"          TO  MCP-PUTTYPE
                       PERFORM 210-BACK-SYORI-SEC
                   WHEN    OTHER    
                       PERFORM 490-PRINT-SEC
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
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE    "CHANGE"    TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *     再印刷
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 450-REPRINT-SEC
      *        前頁
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 460-MAEGMN-SEC
      *        次頁
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 470-ATOGMN-SEC
      *     情報削除
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-JYOUHOU-DEL-SEC
      *        OK
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-PRINT-MAE-SEC
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
                   MOVE    MCP-WIDGET (4:2)    TO  WRK-WIDGET2
                   MOVE    WRK-WIDGET2         TO  IDX   
                   PERFORM 420-CHK-CHK-SEC
      *    処理確認
               WHEN    "CLICKED"       ALSO    "B13"
                   PERFORM 490-KAKUNIN-SEC
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
      *
           EVALUATE    MCP-EVENT        ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"       ALSO    "PARA011"
               WHEN    "ACTIVATE"       ALSO    "PARA012"
               WHEN    "ACTIVATE"       ALSO    "PARA013"
               WHEN    "ACTIVATE"       ALSO    "PARA021"
               WHEN    "ACTIVATE"       ALSO    "PARA022"
               WHEN    "ACTIVATE"       ALSO    "PARA023"
               WHEN    "ACTIVATE"       ALSO    "PARA031"
               WHEN    "ACTIVATE"       ALSO    "PARA032"
               WHEN    "ACTIVATE"       ALSO    "PARA033"
               WHEN    "ACTIVATE"       ALSO    "PARA041"
               WHEN    "ACTIVATE"       ALSO    "PARA042"
               WHEN    "ACTIVATE"       ALSO    "PARA043"
               WHEN    "ACTIVATE"       ALSO    "PARA051"
               WHEN    "ACTIVATE"       ALSO    "PARA052"
               WHEN    "ACTIVATE"       ALSO    "PARA053"
               WHEN    "ACTIVATE"       ALSO    "PARA061"
               WHEN    "ACTIVATE"       ALSO    "PARA062"
               WHEN    "ACTIVATE"       ALSO    "PARA063"
               WHEN    "ACTIVATE"       ALSO    "PARA071"
               WHEN    "ACTIVATE"       ALSO    "PARA072"
               WHEN    "ACTIVATE"       ALSO    "PARA073"
               WHEN    "ACTIVATE"       ALSO    "PARA081"
               WHEN    "ACTIVATE"       ALSO    "PARA082"
               WHEN    "ACTIVATE"       ALSO    "PARA083"
               WHEN    "ACTIVATE"       ALSO    "PARA091"
               WHEN    "ACTIVATE"       ALSO    "PARA092"
               WHEN    "ACTIVATE"       ALSO    "PARA093"
               WHEN    "ACTIVATE"       ALSO    "PARA101"
               WHEN    "ACTIVATE"       ALSO    "PARA102"
               WHEN    "ACTIVATE"       ALSO    "PARA103"
                   MOVE    MCP-WIDGET (5:2)    TO  WRK-WIDGET2
                   MOVE    WRK-WIDGET2         TO  IDX
                   MOVE    MCP-WIDGET (7:1)    TO  WRK-WIDGET1
                   MOVE    WRK-WIDGET1         TO  IDY  
                   PERFORM  4101-PARA-CHK-SEC
           END-EVALUATE        
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *  　パラメタチェック
      *****************************************************************
       4101-PARA-CHK-SEC                         SECTION.
      *
           COMPUTE SPA-GMN-CUR   =  (IDX  -   1)   *   4   +
                                     IDY  +   1 
           COMPUTE IDZ           =   IDX  +   (SPA-GMN-PAGE - 1 ) * 10
      *
           MOVE    G01-PARA (IDX IDY)     TO  SPA-GMN-PARA (IDZ IDY)
      *----01-00-02-START------
      *----01-00-07-START------
      *
           IF  SPA-GMN-PARA (IDZ IDY)    =   SPACE
               EVALUATE    SPA-NAI-PARA (IDZ IDY)
                   WHEN    "YMD"
                       MOVE    SPA-SYSYMD   TO  SPA-NAI-HENPARA(IDZ IDY)
                       MOVE    SPA-SYSYMDWH TO  SPA-GMN-PARA  (IDZ IDY)
                   WHEN    "YM"
                       MOVE    SPA-SYSYMD(1:6)
                                           TO  SPA-NAI-HENPARA (IDZ IDY)
                       MOVE    SPA-SYSYMDWH(1:6)
                                           TO  SPA-GMN-PARA  (IDZ IDY)
                   WHEN    "PSN1"
                       MOVE    0           TO  SPA-NAI-HENPARA (IDZ IDY)
                   WHEN     OTHER
                       MOVE    "0002"      TO  SPA-ERRCD
                       GO  TO  4101-PARA-CHK-EXT
               END-EVALUATE
           ELSE
               EVALUATE    SPA-NAI-PARA (IDZ IDY)
                   WHEN    "YMD"
                       MOVE    SPA-GMN-PARA (IDZ IDY)   TO  WRK-YMD
                       PERFORM 5002-HIZUKE-CHK-SEC
                       IF  SPA-ERRCD        =   SPACE
                           MOVE    WRK-SYMD
                                   TO  SPA-NAI-HENPARA (IDZ IDY)
                           MOVE    WRK-HENYMDG
                                   TO  SPA-GMN-PARA (IDZ IDY)
                       ELSE
                           GO  TO  4101-PARA-CHK-EXT
                       END-IF
                   WHEN    "YM"
                       MOVE    SPA-GMN-PARA (IDZ IDY)   TO  WRK-YMD
                       PERFORM 5003-NENGETSU-CHK-SEC
                       IF  SPA-ERRCD        =   SPACE
                           MOVE    WRK-SYMD(1:6)
                                   TO  SPA-NAI-HENPARA (IDZ IDY)
                           MOVE    WRK-HENYMDG(1:6)
                                   TO  SPA-GMN-PARA (IDZ IDY)
                       ELSE
                           GO  TO  4101-PARA-CHK-EXT
                       END-IF
                   WHEN    "PSN1"
                       IF      SPA-GMN-PARA (IDZ IDY)(1:1) IS  NUMERIC
                           IF      SPA-GMN-PARA (IDZ IDY)(2:)  =   SPACE
                               MOVE    SPA-GMN-PARA(IDZ IDY)(1:1)
                                   TO  SPA-NAI-HENPARA (IDZ IDY)
                           ELSE
                               MOVE    "0002"      TO  SPA-ERRCD
                               GO  TO  4101-PARA-CHK-EXT
                           END-IF
                       ELSE
                           MOVE    "0002"      TO  SPA-ERRCD
                           GO  TO  4101-PARA-CHK-EXT
                       END-IF
                   WHEN    OTHER
                       MOVE    SPA-GMN-PARA (IDZ IDY)
                               TO  SPA-NAI-HENPARA (IDZ IDY)
               END-EVALUATE
           END-IF
      *
      *----01-00-07-END
      *----01-00-02-END
      *
           PERFORM 4101-NEXT-CUR-SEC
           .
       4101-PARA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    次のカーソル位置を編集処理
      *****************************************************************
       4101-NEXT-CUR-SEC               SECTION.
      *
      *    カーソル位置の項目のＳＰＡ内ＩＮＤＥＸ     
           COMPUTE IDZ           =   IDX  +
                                    (SPA-GMN-PAGE - 1 ) * 10
      *
      *    最後の項目のとき     
           IF      IDY                 =   3
           AND     IDX                 =   10 
               MOVE    99                  TO  SPA-GMN-CUR
           ELSE
      *        同一行に次の入力項目はあるか     
               COMPUTE IDZ1    =   IDY     +   1     
               PERFORM VARYING IDZ2    FROM    IDZ1    BY  1
                       UNTIL   IDZ2    >       3
                   ADD     1                   TO  SPA-GMN-CUR
                   IF      SPA-NAI-PARA (IDZ IDZ2)  NOT =   SPACE
                       GO  TO  4101-NEXT-CUR-EXT
                   END-IF
               END-PERFORM    
      *        次行は入力可か              
               COMPUTE IDZ1    =   IDX     +   1
               PERFORM VARYING IDZ2    FROM    IDZ1   BY  1
                       UNTIL   IDZ2    >       10
                   ADD     1            TO  IDZ
                   IF      SPA-GMN-HCNAME (IDZ) NOT =   SPACE
                       COMPUTE SPA-GMN-CUR     =   IDZ2    *   4   -
                                                   3
                       GO  TO  4101-NEXT-CUR-EXT
                   END-IF
               END-PERFORM
               MOVE    99               TO  SPA-GMN-CUR
           END-IF
       
      * 
           .
       4101-NEXT-CUR-EXT.
           EXIT.
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *        
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD 
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SYS-3003-JOBID
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA  
                                           JOBKANRI-REC
                   IF      SJOBKANRI-RETURN
                                           =   ZERO
                       IF      JOB-ENDYMD      =   SPACE
      *********        AND     JOB-TERMID      =   SPA-TERMID
                           MOVE    "6666"          TO  SPA-GIDCD
                           GO  TO  210-BACK-EXT
                       END-IF
                   END-IF
               END-PERFORM
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
      * 
           MOVE    "M01"               TO  SPA-SAKIPG
           MOVE    "G01"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
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
      *
      *****************************************************************
      *    個別出力処理
      *****************************************************************
       420-CHK-CHK-SEC                SECTION.
      *
           COMPUTE SPA-GMN-CUR   =  (IDX  -   1)   *   4   +   1 
           COMPUTE IDZ           =   IDX  +   (SPA-GMN-PAGE - 1 ) * 10
      *
           EVALUATE    SPA-GMN-CHK-VALUE (IDZ)
               WHEN    "T"
                   MOVE    "F"             TO  SPA-GMN-CHK-VALUE (IDZ)
               WHEN    "F"
                   MOVE    "T"             TO  SPA-GMN-CHK-VALUE (IDZ)
           END-EVALUATE 
      *
           PERFORM VARYING IDZ2    FROM    1   BY  1
                   UNTIL   IDZ2    >       3
               ADD     1                    TO  SPA-GMN-CUR
               IF      SPA-NAI-PARA (IDZ IDZ2)  NOT =   SPACE
                   GO  TO  420-CHK-CHK-EXT
               END-IF
           END-PERFORM    
      *                 
      *
           MOVE    3                   TO  IDY
           PERFORM 4101-NEXT-CUR-SEC
           .
       420-CHK-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    前頁　処理
      *****************************************************************
       460-MAEGMN-SEC             SECTION.
      *
           IF      SPA-GMN-PAGE       =   1
               MOVE    "0006"             TO  SPA-ERRCD
               GO  TO  460-MAEGMN-EXT
           END-IF
           COMPUTE SPA-GMN-PAGE   =   SPA-GMN-PAGE    -   1
      *
           MOVE    ZERO                TO  IDX
           MOVE    3                   TO  IDY
           PERFORM 4101-NEXT-CUR-SEC
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
           IF      SPA-GMN-PAGE       =   SPA-GMN-MAXPAGE
               MOVE    "0007"             TO  SPA-ERRCD
               GO  TO  470-ATOGMN-EXT
           END-IF
           COMPUTE SPA-GMN-PAGE   =   SPA-GMN-PAGE    +   1       
      *
           MOVE    ZERO                TO  IDX
           MOVE    3                   TO  IDY
           PERFORM 4101-NEXT-CUR-SEC
           .
       470-ATOGMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    印刷前確認処理
      *****************************************************************
       490-PRINT-MAE-SEC                   SECTION.
      *
      *    ジョブ管理チェック        
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD 
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SYS-3003-JOBID
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA  
                                           JOBKANRI-REC
                   IF      SJOBKANRI-RETURN
                                           =   ZERO
                       IF      JOB-ENDYMD      =   SPACE
                           MOVE    "7777"          TO  SPA-ERRCD
                           MOVE    SPACE           TO  WRK-RECEERR
                           STRING  "処理中です【"  DELIMITED  BY  SIZE
                                   JOB-SHELLMSG    DELIMITED  BY  SPACE
                                   "】"            DELIMITED  BY  SIZE
                                                   INTO  WRK-RECEERR
                           MOVE    SYS-3003-JOBID  TO  IDX
                       END-IF
                   END-IF    
               END-PERFORM
           END-IF
      *
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    ZERO                TO  FLG-CHK 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL  (IDX >       100   )
                       OR     (SPA-ERRCD   NOT =   SPACE )
                   IF      SPA-GMN-CHK-VALUE   (IDX)   =   "T"
                       MOVE    1                   TO  FLG-CHK 
                       PERFORM VARYING IDZ FROM    1   BY  1
                               UNTIL   IDZ >       3
                           IF     (SPA-GMN-PARAHYOJI(IDX IDZ)
                                                   NOT =   SPACE )
                           AND    (SPA-NAI-HENPARA  (IDX IDZ)
                                                   =   SPACE )
                               MOVE    "0004"      TO  SPA-ERRCD
                           END-IF
                       END-PERFORM
                   END-IF
               END-PERFORM
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE   
               IF      FLG-CHK             =   ZERO           
                   MOVE    "0005"              TO  SPA-ERRCD
               END-IF
           END-IF    
      *
           IF      SPA-ERRCD           =   SPACE              
               MOVE    "1001"              TO  SPA-GIDCD
           END-IF    
           .
       490-PRINT-MAE-EXT.
           EXIT.               
      *
      *****************************************************************
      *    印刷処理
      *****************************************************************
       490-PRINT-SEC                       SECTION.
      * 
      *    ＪＯＢＩＤ（３００４）削除処理
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD 
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC
               MOVE    SYS-3003-REC        TO  MCPDATA-REC
               MOVE    "DBDELETE"          TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   CONTINUE
               ELSE                                 
                   MOVE    "1005"              TO  SPA-ERRCD
                   GO  TO  490-PRINT-EXT
               END-IF
           END-IF                 
      * 
      *    ジョブ管理削除処理
           MOVE    "ALL"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-CONS-JOB-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING   ORCSJOBKANRIAREA  
                                           JOBKANRI-REC
           IF      SJOBKANRI-RETURN    =   ZERO
               CONTINUE
           ELSE
               MOVE    "1004"              TO  SPA-ERRCD
               GO  TO  490-PRINT-EXT
           END-IF             
      *
           ACCEPT  SYS-YMD         FROM    DATE
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000
           MOVE    SYS-MM              TO  WRK-SYSMM
           MOVE    SYS-DD              TO  WRK-SYSDD
           ACCEPT  SYS-TIME            FROM    TIME
      *
           MOVE    ZERO                TO  WRK-CONS-JOB-JOBID     
                                           WRK-PRTKANRI-RENNUM
           MOVE    SPACE               TO  WRK-CONS-PRTKANRI-TBL-GROUP
      *     
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    SPA-TERMID          TO  RECEERR-TERMID
      *     
      *    出力先プリンタ名割り当て情報編集
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1031-REC
           ELSE    
               INITIALIZE                  SYS-1031-REC
           END-IF
      *     
           MOVE    WRK-SYSYMD          TO
                                   WRK-CONS-PRTKANRI-TBL-GROUP (1:8)
           MOVE    SYS-TIME            TO
                                   WRK-CONS-PRTKANRI-TBL-GROUP (9:)
      *
           PERFORM VARYING IDY FROM    1       BY  1
                   UNTIL  (IDY             >   100  )
                   OR     (SPA-ERRCD   NOT =   SPACE)   
               IF      SPA-GMN-CHK-VALUE   (IDY)   =   "T"
      *
                   PERFORM 45011-JOBKANRI-HENSYU-SEC
      *                                   
      *            印刷用スクリプト処理
      *
                   MOVE    SPACE           TO  LNK-PRTKANRI-AREA
                   INITIALIZE                  LNK-PRTKANRI-AREA
                   ADD     1               TO  WRK-PRTKANRI-RENNUM
                   MOVE    WRK-PRTKANRI-RENNUM
                                           TO  LNK-PRTKANRI-RENNUM 
                   MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                           TO  LNK-PRTKANRI-TBL-KEY 
                   MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                           TO  LNK-PRTKANRI-TBL-GROUP
                   MOVE    "000000"        TO  LNK-PRTKANRI-SRYYM
                   MOVE    SPA-SYSYMD      TO  LNK-PRTKANRI-SKYYMD
                   MOVE    "execoprg.sh"   TO  LNK-PRTKANRI-SHELLID
                   MOVE    ZERO            TO  LNK-PRTKANRI-PRIORITY
                   MOVE    SPA-TERMID      TO  LNK-PRTKANRI-TERMID
                   MOVE    SPA-OPID        TO  LNK-PRTKANRI-OPID
                   MOVE    SYS-1031-PRTNM (6)
                                           TO  LNK-PRTKANRI-PRTNM
      *                                     
                   MOVE    SPACE           TO  SHELLTBL
      *************MOVE    SHELL-NAME      TO  SHELLTBL-NAME
      *            ファイルデイレクトリ位置指定
                   INITIALIZE              ORCSMKPASSAREA
                   MOVE    SHELL-NAME      TO  MKPASS-IN-01
                   CALL    "ORCSMKPASS"    USING   ORCSMKPASSAREA
                   MOVE    MKPASS-OT-01    TO  SHELLTBL-NAME
                   MOVE    LNK-PRTKANRI-RENNUM
                                           TO  SHELLTBL-ARG1       
                   MOVE    LNK-PRTKANRI-TBL-KEY
                                           TO  SHELLTBL-ARG2     
                   MOVE    LNK-PRTKANRI-TBL-GROUP
                                           TO  SHELLTBL-ARG3       
                   MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                           TO  SHELLTBL-ARG4       
                   MOVE    LNK-PRTKANRI-SRYYM
                                           TO  SHELLTBL-ARG5       
                   MOVE    LNK-PRTKANRI-SKYYMD
                                           TO  SHELLTBL-ARG6       
                   MOVE    LNK-PRTKANRI-SHELLID
                                           TO  SHELLTBL-ARG7       
                   MOVE    LNK-PRTKANRI-PRIORITY
                                           TO  SHELLTBL-ARG8      
                   MOVE    LNK-PRTKANRI-TERMID
                                           TO  SHELLTBL-ARG9       
                   MOVE    LNK-PRTKANRI-OPID
                                           TO  SHELLTBL-ARG10      
                   MOVE    LNK-PRTKANRI-PRTNM
                                           TO  SHELLTBL-ARG11      
      *                 
                   MOVE    WRK-CONS-JOB-JOBID
                                           TO  SHELLTBL-ARG12
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  SHELLTBL-ARG13         
                   MOVE    SPA-HOSPID      TO  SHELLTBL-ARG14
                   MOVE    SPA-GMN-PRGNAME (IDY)
                                           TO  SHELLTBL-ARG15
                   MOVE    SPA-NAI-HENPARA (IDY 1)
                                           TO  SHELLTBL-ARG16
                   MOVE    SPA-NAI-HENPARA (IDY 2)
                                           TO  SHELLTBL-ARG17
                   MOVE    SPA-NAI-HENPARA (IDY 3)
                                           TO  SHELLTBL-ARG18
                   MOVE    RECEERR         TO  SHELLTBL-ARG19
                   MOVE    SHELLTBL        TO  MCPDATA-REC
                   MOVE    "SHELL"         TO  MCP-FUNC
                   MOVE    PATH-SHELL-SHELL
                                           TO  MCP-PATH
                   CALL    "MCPSUB"        USING
                                               MCPAREA
                                               MCPDATA-REC                         
               END-IF
           END-PERFORM
      *
      *    印刷処理
      *
           PERFORM 45011-JOBKANRI-HENSYU-SEC
      *             
           MOVE    SPACE               TO  SHELLTBL
      *****MOVE    "/usr/local/orca/scripts/allways/print.sh"
      *****                            TO  SHELLTBL-NAME
      *    ファイルデイレクトリ位置指定
           INITIALIZE                  ORCSMKPASSAREA
           MOVE    "/scripts/allways/print.sh"
                                       TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"        USING   ORCSMKPASSAREA
           MOVE    MKPASS-OT-01        TO  SHELLTBL-NAME
           MOVE    SPACE               TO  LNK-PRTKANRI-AREA
           INITIALIZE                      LNK-PRTKANRI-AREA
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                       TO  LNK-PRTKANRI-TBL-KEY 
           MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                       TO  LNK-PRTKANRI-TBL-GROUP
           MOVE    ZERO                TO  LNK-PRTKANRI-RENNUM
           MOVE    ZERO                TO  LNK-PRTKANRI-SHORI-RENNUM 
           MOVE    "000000"            TO  LNK-PRTKANRI-SRYYM 
           MOVE    SPA-SYSYMD          TO  LNK-PRTKANRI-SKYYMD
           MOVE    "print.sh"          TO  LNK-PRTKANRI-SHELLID
           MOVE    ZERO                TO  LNK-PRTKANRI-PRIORITY
           MOVE    SPA-TERMID          TO  LNK-PRTKANRI-TERMID
           MOVE    SPA-OPID            TO  LNK-PRTKANRI-OPID
           MOVE    LNK-PRTKANRI-RENNUM TO  SHELLTBL-ARG1       
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SHELLTBL-ARG2     
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SHELLTBL-ARG3       
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SHELLTBL-ARG4       
           MOVE    LNK-PRTKANRI-SRYYM  TO  SHELLTBL-ARG5       
           MOVE    LNK-PRTKANRI-SKYYMD TO  SHELLTBL-ARG6       
           MOVE    LNK-PRTKANRI-SHELLID
                                       TO  SHELLTBL-ARG7       
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SHELLTBL-ARG8      
           MOVE    LNK-PRTKANRI-TERMID TO  SHELLTBL-ARG9       
           MOVE    LNK-PRTKANRI-OPID   TO  SHELLTBL-ARG10      
           MOVE    LNK-PRTKANRI-PRTNM  TO  SHELLTBL-ARG11      
      *                 
           MOVE    RECEERR             TO  SHELLTBL-ARG12
           MOVE    WRK-CONS-JOB-JOBID  TO  SHELLTBL-ARG13
           MOVE    WRK-CONS-JOB-SHELLID
                                       TO  SHELLTBL-ARG14
           MOVE    0                   TO  SHELLTBL-ARG15
           MOVE    99999               TO  SHELLTBL-ARG16                                   
           MOVE    SHELLTBL            TO  MCPDATA-REC
           MOVE    "SHELL"             TO  MCP-FUNC
           MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC 
      *
      *    ＪＯＢＩＤ更新処理
      *
           PERFORM 45012-JOBID-UPD-SEC 
      *
      *
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       100
               MOVE    "F"             TO  SPA-GMN-CHK-VALUE(IDZ)
               INITIALIZE              SPA-GMN-PARA-TBL     (IDZ)
                                       SPA-NAI-HENPARA-TBL  (IDZ) 
           END-PERFORM
      *
           PERFORM 490-KAKUNIN-SEC
           .
       490-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ開始セット処理
      *****************************************************************
       45011-JOBKANRI-HENSYU-SEC       SECTION.
      *
           ADD     1               TO  WRK-CONS-JOB-JOBID
      *
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
           .
       45011-JOBKANRI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＪＯＢＩＤ更新処理
      *****************************************************************
       45012-JOBID-UPD-SEC    SECTION.
      *
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD 
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
      *       
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    ZERO                TO  SYS-3003-STYUKYMD
           MOVE    ALL "9"             TO  SYS-3003-EDYUKYMD
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                       TO  SYS-3003-TBL-KEY
           MOVE    WRK-CONS-PRTKANRI-TBL-GROUP
                                       TO  SYS-3003-TBL-GROUP
           MOVE    WRK-CONS-JOB-JOBID  TO  SYS-3003-JOBID                                      
      *
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           IF      FLG-SYSKANRI        =   ZERO     
               MOVE    "DBUPDATE"          TO  MCP-FUNC
           ELSE
               MOVE    "DBINSERT"          TO  MCP-FUNC
           END-IF         
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "SYSKANRI 3003  ERR KEY = ["
                                  MCP-RC  " " SYS-3003-KEY  "]"   
      *****    MOVE    "1010"          TO  SPA-ERRCD
           END-IF
      *
           .
       45012-JOBID-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    情報削除画面へ
      *****************************************************************
       490-JYOUHOU-DEL-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-G01             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "G01"               TO  SPA-MOTOPG
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
      *
      *****************************************************************
      *    再印刷画面へ
      *****************************************************************
       450-REPRINT-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-G01             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "G01"               TO  SPA-MOTOPG
           MOVE    "XA01"              TO  SPA-SAKIPG
      *
           MOVE    WRK-CONS-PRTKANRI-TBL-KEY
                                       TO  SPA-PRTKANRI-TBL-KEY
      *          
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "XA01   "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       450-REPRINT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    処理確認処理
      *****************************************************************
       490-KAKUNIN-SEC            SECTION.
      *
           MOVE    SPACE               TO  G99
           MOVE    ZERO                TO  G99-COUNT
      *        
           MOVE    SPACE               TO  SYS-3003-REC 
           INITIALIZE                      SYS-3003-REC
           MOVE    "3003"              TO  SYS-3003-KANRICD
           MOVE    WRK-CONS-3003-KBNCD TO  SYS-3003-KBNCD
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD 
           MOVE    SYS-3003-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-3003-REC 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SYS-3003-JOBID
      *            ジョブ管理チェック処理
                   MOVE    "CHK"           TO  SJOBKANRI-MODE
                   INITIALIZE                  JOBKANRI-REC
                   MOVE    IDX             TO  JOB-JOBID
                   MOVE    WRK-CONS-JOB-SHELLID
                                           TO  JOB-SHELLID
                   CALL    "ORCSJOB"       USING
                                           ORCSJOBKANRIAREA  
                                           JOBKANRI-REC 
                   IF      SJOBKANRI-RETURN    =   ZERO
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
                       MOVE    JOB-UPDCNT      TO  WRK-PAGE
                       MOVE    WRK-PAGE        TO  G99-PAGE     (IDX)
                       MOVE    JOB-YOBI        TO  G99-ERRMSG   (IDX)
                       IF      JOB-ENDYMD      =   SPACE
                           MOVE    "処理中です"    TO  G99-MSG
                       ELSE
                           IF      JOB-ERRCD       =   SPACE
                               CONTINUE
                           ELSE
                               STRING  JOB-YOBI    DELIMITED  BY  SPACE
                                       "【"        DELIMITED  BY  SIZE
                                      JOB-SHELLMSG DELIMITED  BY  SPACE
                                      "】"         DELIMITED  BY  SIZE      
                                                   INTO  G99-MSG
                           END-IF                          
                       END-IF    
                       MOVE    IDX                     TO  G99-COUNT    
                   END-IF
               END-PERFORM
           END-IF
           IF      G99-MSG              =   SPACE
               IF      G99-COUNT            >   ZERO    
                   MOVE    "処理は正常に終了しました"
                                                TO  G99-MSG
               ELSE
                   MOVE    "該当する処理はありません"
                                                TO  G99-MSG
               END-IF                                 
           END-IF                                 
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "G01"                TO  SPA-MOTOPG
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
               PERFORM 520-LIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "G01    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           COMPUTE IDY     =   SPA-GMN-PAGE    *   10
           COMPUTE IDZ     =   IDY             -   9
      *
           MOVE    ZERO                TO  IDX
           PERFORM VARYING     IDZ1     FROM    IDZ   BY  1
                   UNTIL       IDZ1     >       IDY
               ADD     1                        TO  IDX
               MOVE    SPA-GMN-NUM      (IDZ1)  TO  G01-NUM   (IDX) 
               MOVE    SPA-GMN-CHK-VALUE(IDZ1)  TO  G01-CHK-VALUE (IDX)
               MOVE    SPA-GMN-HCNAME   (IDZ1)  TO  G01-CHK-LABEL (IDX)
               PERFORM VARYING IDZ2 FROM    1   BY  1
                       UNTIL   IDZ2 >       3
                   MOVE    SPA-GMN-PARAHYOJI (IDZ1 IDZ2)
                                        TO  G01-PARAHYOJI (IDX IDZ2)
                   MOVE    SPA-GMN-PARA       (IDZ1 IDZ2)
                                        TO  G01-PARA      (IDX IDZ2)
               END-PERFORM
               MOVE    WIDGET-INSENSITIVE
                                       TO  G01-CHK-STATE (IDX)
                                           G01-NUM-STATE  (IDX)
                                           G01-PARA-STATE(IDX 1)
                                           G01-PARA-STATE(IDX 2)
                                           G01-PARA-STATE(IDX 3) 
               IF      SPA-GMN-HCNAME   (IDZ1)  NOT =   SPACE
                           MOVE    WIDGET-NORMAL
                                           TO  G01-NUM-STATE(IDX)
                                               G01-CHK-STATE(IDX)
                   PERFORM VARYING IDZ2 FROM    1   BY  1
                           UNTIL   IDZ2 >       3
                       IF      SPA-GMN-PARAHYOJI (IDZ1 IDZ2)
                                                NOT =   SPACE
                           MOVE    WIDGET-NORMAL
                                           TO  G01-PARA-STATE(IDX IDZ2)
                       END-IF
                   END-PERFORM                        
               END-IF
           END-PERFORM
      *
           IF      SPA-GMN-PAGE            =   1
               MOVE    WIDGET-INSENSITIVE  TO  G01-B06-STATE
           ELSE
               MOVE    WIDGET-NORMAL       TO  G01-B06-STATE
           END-IF    
           IF      SPA-GMN-PAGE            =   SPA-GMN-MAXPAGE
               MOVE    WIDGET-INSENSITIVE  TO  G01-B07-STATE
           ELSE
               MOVE    WIDGET-NORMAL       TO  G01-B07-STATE
           END-IF    
                             
      *
      *    カーソル位置
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソル位置処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    1
                   MOVE    "CHK01"             TO  MCP-WIDGET
               WHEN    2
                   MOVE    "PARA011"           TO  MCP-WIDGET
               WHEN    3
                   MOVE    "PARA012"           TO  MCP-WIDGET
               WHEN    4
                   MOVE    "PARA013"           TO  MCP-WIDGET
               WHEN    5
                   MOVE    "CHK02"             TO  MCP-WIDGET
               WHEN    6
                   MOVE    "PARA021"           TO  MCP-WIDGET
               WHEN    7
                   MOVE    "PARA022"           TO  MCP-WIDGET
               WHEN    8
                   MOVE    "PARA023"           TO  MCP-WIDGET
               WHEN    9
                   MOVE    "CHK03"             TO  MCP-WIDGET
               WHEN    10
                   MOVE    "PARA031"           TO  MCP-WIDGET
               WHEN    11
                   MOVE    "PARA032"           TO  MCP-WIDGET
               WHEN    12
                   MOVE    "PARA033"           TO  MCP-WIDGET
               WHEN    13
                   MOVE    "CHK04"             TO  MCP-WIDGET
               WHEN    14
                   MOVE    "PARA041"           TO  MCP-WIDGET
               WHEN    15
                   MOVE    "PARA042"           TO  MCP-WIDGET
               WHEN    16
                   MOVE    "PARA043"           TO  MCP-WIDGET
               WHEN    17
                   MOVE    "CHK05"             TO  MCP-WIDGET
               WHEN    18
                   MOVE    "PARA051"           TO  MCP-WIDGET
               WHEN    19
                   MOVE    "PARA052"           TO  MCP-WIDGET
               WHEN    20
                   MOVE    "PARA053"           TO  MCP-WIDGET
               WHEN    21
                   MOVE    "CHK06"             TO  MCP-WIDGET
               WHEN    22
                   MOVE    "PARA061"           TO  MCP-WIDGET
               WHEN    23
                   MOVE    "PARA062"           TO  MCP-WIDGET
               WHEN    24
                   MOVE    "PARA063"           TO  MCP-WIDGET
               WHEN    25
                   MOVE    "CHK07"             TO  MCP-WIDGET
               WHEN    26
                   MOVE    "PARA071"           TO  MCP-WIDGET
               WHEN    27
                   MOVE    "PARA072"           TO  MCP-WIDGET
               WHEN    28
                   MOVE    "PARA073"           TO  MCP-WIDGET
               WHEN    29
                   MOVE    "CHK08"             TO  MCP-WIDGET
               WHEN    30
                   MOVE    "PARA081"           TO  MCP-WIDGET
               WHEN    31
                   MOVE    "PARA082"           TO  MCP-WIDGET
               WHEN    32
                   MOVE    "PARA083"           TO  MCP-WIDGET
               WHEN    33
                   MOVE    "CHK09"             TO  MCP-WIDGET
               WHEN    34
                   MOVE    "PARA091"           TO  MCP-WIDGET
               WHEN    35
                   MOVE    "PARA092"           TO  MCP-WIDGET
               WHEN    36
                   MOVE    "PARA093"           TO  MCP-WIDGET
               WHEN    37
                   MOVE    "CHK10"             TO  MCP-WIDGET
               WHEN    38
                   MOVE    "PARA101"           TO  MCP-WIDGET
               WHEN    39
                   MOVE    "PARA102"           TO  MCP-WIDGET
               WHEN    40
                   MOVE    "PARA103"           TO  MCP-WIDGET
               WHEN    99
                   MOVE    "B12"               TO  MCP-WIDGET
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
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0002"
                   MOVE    "入力エラー"               TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "項目に入力がありません"   TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "パラメタが入力されてない項目があります"
                                                      TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "対象の処理が選択されていません"
                                                      TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "前頁はありません"         TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "次頁はありません"         TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新ができませんでした"
                                                      TO  SPA-ERRMSG
               WHEN    "1004"
                   MOVE    "ジョブ管理ＤＢが削除できませんでした"
                                                       TO  SPA-ERRMSG
               WHEN    "1005"
                   MOVE
                   "システム管理ＤＢ（３００３）が削除できませんでした"
                                                       TO  SPA-ERRMSG
               WHEN    "7777"
                   MOVE    WRK-RECEERR                TO  SPA-ERRMSG
               WHEN    "9999"
                   MOVE    WRK-RECEERR                TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  GERR
           MOVE    SPA-ERRCD            TO  GERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  GERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "G01"                TO  SPA-MOTOPG
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
       510-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ガイドメッセージ表示
      *****************************************************************
       520-LIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-GIDMSG
      *
           EVALUATE    SPA-GIDCD
               WHEN    "6666"
                   MOVE    "処理中です" TO  WRK-GIDMSG
               WHEN    "8888"
                   MOVE    "処理が正常終了しました"
                                        TO  WRK-GIDMSG
               WHEN    "1001"
                   MOVE    "選択された帳票の印刷を開始します"
                                        TO  WRK-GIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  GID1
           MOVE    SPA-GIDCD            TO  GID1-ID1CODE
           MOVE    WRK-GIDMSG           TO  GID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "G01"                TO  SPA-MOTOPG
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
       520-LIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    WRK-YMD             TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY         TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY          TO  WRK-SYMD
           ELSE
               MOVE    "0002"              TO  SPA-ERRCD
           END-IF
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *----01-00-07----START
      *****************************************************************
      *    年月チェック・編集処理
      *****************************************************************
       5003-NENGETSU-CHK-SEC         SECTION.
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    "1"                 TO  SGDAY-INTYPE
           MOVE    WRK-YMD             TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY         TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY          TO  WRK-SYMD
           ELSE
               MOVE    "0002"              TO  SPA-ERRCD
           END-IF
           .
       5003-NENGETSU-CHK-EXT.
           EXIT.
      *
      *----01-00-07----END
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
      *    システム管理マスタ読込処理
      *****************************************************************
       900-SYSKANRI-NEXT-SEC            SECTION.
      *
	   MOVE  "DBFETCH"            TO  MCP-FUNC
           MOVE  "SYSKANRI-KEY2"      TO  ORC-DBPATH
	   CALL  "ORCMCPSUB"           USING
 	                              MCPAREA
 	                              ORCMCPAREA
 	                              MCPDATA-REC
           IF     MCP-RC              =   ZERO
               MOVE    MCPDATA-REC        TO  SYS-3002-REC 
               MOVE    ZERO               TO  FLG-SYSKANRI
           ELSE
               MOVE    1                  TO  FLG-SYSKANRI
           END-IF
           .
      *
       120-FECH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"          TO  MCP-FUNC.
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
