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
       PROGRAM-ID.             ORCGW06.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : システム管理情報設定
      *  コンポーネント名  : 職員情報（Ｗ０６）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     MCC-藤原     01/09/11  削除処理の修正 
      * 01.01.01     MCC-藤原     01/09/21  JOINの修正      
      * 01.01.02     MCC-森脇     02/05/14  麻薬ライセンスの追加
      *                                     画面の変更      
      * 01.01.03     MCC-多々納   02/06/13  オルカマスターの
      *                                     削除を非活性にする
      * 01.01.04     MCC-太田     02/06/20  人名辞書マスタ追加
      * 01.01.05     NACL-森脇    02/07/30  薬剤情報マスタ追加
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
      *    システム管理情報設定用共通パラメタ
           COPY    "W01COMMON-SPA".
      *
      *    画面用ＳＰＡ
       01  SPA-W06.
           03  SPA-W06-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-LINE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-STYUKYMD       PIC X(09).
                   07  SPA-GMN-EDYUKYMD       PIC X(09).
                   07  SPA-GMN-KBNCD          PIC X(05).
                   07  SPA-GMN-KBNNAME        PIC X(20).
                   07  SPA-GMN-MAYAKULICENSE  PIC X(40).
                   07  SPA-GMN-KOUMOKU.
                       09  SPA-GMN-USERID     PIC X(16).
                       09  SPA-GMN-KANANAME   PIC X(80).
                       09  SPA-GMN-NAME       PIC X(80).
                       09  SPA-GMN-ISEKINUM   PIC X(08).
                       09  SPA-GMN-HKNDRNUMS  PIC X(08).
                       09  SPA-GMN-HKNDRNUMK  PIC X(12).
      *----(01.01.05)----START------------
                       09  SPA-GMN-CHK        PIC X     OCCURS  26.
      *----(01.01.05)----END--------------
      *                
                   07  SPA-W06-SEMONKACD      OCCURS  5.
                       09  SPA-CD-L           PIC X(02).
                       09  SPA-CD-FL          PIC X(01).
                       09  SPA-CD-MEIL        PIC X(14).
                   07  SPA-W06-KANRIAUTHFLG. 
                       09  SPA-FLG-MEIL       PIC X(12).
                       07  SPA-FLG-L          PIC X(01).
      *
               05  SPA-GMN-SEMONKACD-AREA.
                   07  SPA-GMN-SEMONKACD      OCCURS  5.
                       09  SPA-GMNCD-LIST     OCCURS 10.
                           10  SPA-GMNCD-L    PIC X(02).
                           10  SPA-GMNCD-FL   PIC X(01).   
                           10  SPA-GMNCD-MEIL PIC X(14).
                       09  SPA-GMNCD-MAX      PIC 9(04).  
      *
               05  SPA-GMN-KANRIAUTHFLG-AREA.
                   07  SPA-GMNFLG-LIST        OCCURS  2. 
                       09  SPA-GMNFLG-MEIL    PIC X(12).
                   07  SPA-GMNFLG-MAX         PIC 9(04).  
      *
               05  SPA-NAIB-AREA.
                   07  SPA-NAI-STYUKYMD       PIC 9(08).
                   07  SPA-NAI-EDYUKYMD       PIC 9(08).
      *   
           COPY    "ENUM-VALUE".
      *
      *
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-CHK             PIC 9(01).
      *
      *    カウント領域
      *
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
      *
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *
      *    一時領域
      *
       01  WRK-AREA.
           03  WRK-GMN-CUR         PIC 9(02).
           03  WRK-PATH            PIC X(64).
           03  WRK-WIDMSG          PIC X(70). 
           03  WRK-YMD             PIC X(09). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
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
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY  "CPSYSKANRI.INC".
      *    診療内容情報
           COPY  "CPSK1005.INC".
      *    診療内容情報
           COPY  "CPSK1010.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    日付サブルーチン領域
      *
           COPY  "CPORCSDAY.INC".
      *
           COPY  "CPORCSLNK.INC".
      *
      *    カナチェック
           COPY  "CPORCSKANACHK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
           COPY    "W01.INC".
           COPY    "W02.INC".
           COPY    "W03.INC".
           COPY    "W04.INC".
           COPY    "W05.INC".
           COPY    "W06.INC".
           COPY    "W07.INC". 
           COPY    "W08.INC". 
           COPY    "W09.INC".
           COPY    "W10.INC".
           COPY    "W11.INC".
           COPY    "W12.INC".
           COPY    "W13.INC".
           COPY    "W14.INC".
           COPY    "WERR.INC".
           COPY    "WID1.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-W01KYOUTU
           MOVE    SPA-FREE        TO  SPA-W06
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN    "PUTG"          ALSO   "CLICKED"
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
           MOVE    SPA-W06         TO  SPA-FREE
           MOVE    SPA-W01KYOUTU   TO  SPA-WORK 
           MOVE    SPA-AREA        TO  SPA-COMMON
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
           IF      SPA-MOTOPG          =   "WERR"
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
               PERFORM 510-GSRAUTH-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      * 
      ***  MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    SPACE                TO  MCP-PUTTYPE
           MOVE    "W06"                TO  MCP-WINDOW
           PERFORM 900-PUT-WINDOW
           MOVE    1                    TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
      *
           EVALUATE    SPA-MOTOPG
               WHEN    "WID1"
                   PERFORM 330-WID1-SET-SEC
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
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-WID1-SET-SEC            SECTION.
      *
           IF      SPA-WID1-FLG    =   "OK"
               IF      SPA-WIDCD            =   "1002"
                   PERFORM 4031-DEL-SEC
               ELSE
                   PERFORM 490-KOUSHIN-SEC
               END-IF
           ELSE
               MOVE  2  TO  SPA-GMN-CUR
           END-IF
      *
           MOVE    SPACE           TO  SPA-WID1-FLG
           MOVE    SPACE           TO  SPA-WIDCD      
           .
       330-WID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE   SPA-W06-AREA
           INITIALIZE   SPA-GMN-SEMONKACD-AREA
           INITIALIZE   SPA-GMN-KANRIAUTHFLG-AREA
      *
           MOVE    SPA-W01-STYUKYMDH   TO  SPA-GMN-STYUKYMD
           MOVE    SPA-W01-EDYUKYMDH   TO  SPA-GMN-EDYUKYMD
           MOVE    SPA-W01-KBNCD       TO  SPA-GMN-KBNCD
           EVALUATE    SPA-W01-KBNCD (1:1)
               WHEN    "0"
                   MOVE    "マスター"         TO  SPA-GMN-KBNNAME
               WHEN    "1"
                   MOVE    "医師"             TO  SPA-GMN-KBNNAME
               WHEN    "2"
                   MOVE    "看護婦"           TO  SPA-GMN-KBNNAME
               WHEN    "3"
                   MOVE    "技師"             TO  SPA-GMN-KBNNAME
               WHEN    "4"
                   MOVE    "事務職"           TO  SPA-GMN-KBNNAME
               WHEN    "5"
                   MOVE    "管理職"           TO  SPA-GMN-KBNNAME
           END-EVALUATE 
      *
           INITIALIZE                         SPA-GMN-KOUMOKU
      * 
      *----(01.01.05)----START------------
      *    業務処理権限
           PERFORM  VARYING IDX FROM    1   BY  1
               UNTIL IDX  >   26 
               MOVE  "F"           TO  SPA-GMN-CHK (IDX)
           END-PERFORM
      *----(01.01.05)----END--------------
      *
      *    管理者権限
           MOVE  "管理者である"        TO  SPA-GMNFLG-MEIL(1)
           MOVE  "管理者でない"        TO  SPA-GMNFLG-MEIL(2)
           MOVE  2                     TO  SPA-GMNFLG-MAX
      *
           MOVE  "管理者でない"        TO  SPA-FLG-MEIL
      *
           PERFORM  320-SPASET-SEMONKACD-SEC
      *
      *    データ読み込み
           MOVE    SPACE               TO  SYS-1010-REC
           INITIALIZE                      SYS-1010-REC
           MOVE    "1010"                  TO  SYS-1010-KANRICD
           MOVE    SPA-W01-KBNCD           TO  SYS-1010-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-1010-REC            TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"          TO  WRK-PATH
           PERFORM 900-SYSKANRI-SELECT-SEC
           PERFORM 900-SYSKANRI-CLOSE-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-1010-REC
               MOVE    SYS-1010-USERID         TO  SPA-GMN-USERID
               MOVE    SYS-1010-KANANAME       TO  SPA-GMN-KANANAME
               MOVE    SYS-1010-NAME           TO  SPA-GMN-NAME
               MOVE    SYS-1010-ISEKINUM       TO  SPA-GMN-ISEKINUM
               MOVE    SYS-1010-HKNDRNUMS      TO  SPA-GMN-HKNDRNUMS
               MOVE    SYS-1010-HKNDRNUMK      TO  SPA-GMN-HKNDRNUMK
               MOVE    SYS-1010-MAYAKULICENSE  TO  SPA-GMN-MAYAKULICENSE
      *
               PERFORM 320-SPASET-GSRAUTH-SEC
      *         
               MOVE  SYS-1010-KANRIAUTHFLG TO  SPA-FLG-L
      *
               IF  SPA-FLG-L  =  "T"
                   MOVE  "管理者である"     TO  SPA-FLG-MEIL
               ELSE
                   MOVE  "管理者でない"     TO  SPA-FLG-MEIL
               END-IF            
      *
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       5
                   MOVE    SYS-1010-SEMONKACD (IDX)
                                           TO  SPA-CD-L (IDX)          
                   PERFORM 500-SYS-1005-HENSYU-SEC
                   IF      FLG-SYSKANRI        =   ZERO
                       MOVE    SYS-1005-SRYKANAME
                                           TO  SPA-CD-MEIL (IDX)
                   END-IF
               END-PERFORM
      *
           END-IF
      *
           MOVE    2                   TO  SPA-GMN-CUR
           . 
       31O-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ専門科コード初期編集処理 
      *****************************************************************
       320-SPASET-SEMONKACD-SEC              SECTION.
      *
      *    専門科コード
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"                  TO  SYS-1005-KANRICD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-1005-REC            TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY2"         TO  WRK-PATH
           PERFORM 900-SYSKANRI-SELECT-SEC
      *
           PERFORM  VARYING   IDX FROM    1   BY  1
               UNTIL         (IDX      >   10  )  OR
                             (FLG-SYSKANRI  =   1 )
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               MOVE    SYS-1005-KBNCD  TO  SPA-GMNCD-L(1,IDX)
               MOVE    SYS-1005-SRYKANAME 
                                       TO  SPA-GMNCD-MEIL(1,IDX)
               MOVE  IDX               TO  SPA-GMNCD-MAX(1)
      *               
               PERFORM 900-SYSKANRI-FETCH-SEC
           END-PERFORM
      *
           PERFORM 900-SYSKANRI-CLOSE-SEC
      *
           MOVE  SPA-GMN-SEMONKACD(1)    TO  SPA-GMN-SEMONKACD(2)
           MOVE  SPA-GMN-SEMONKACD(1)    TO  SPA-GMN-SEMONKACD(3)
           MOVE  SPA-GMN-SEMONKACD(1)    TO  SPA-GMN-SEMONKACD(4)
           MOVE  SPA-GMN-SEMONKACD(1)    TO  SPA-GMN-SEMONKACD(5) 
      *
           . 
       31O-SPASET-SEMONKACD-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ業務処理権限初期編集処理 
      *****************************************************************
       320-SPASET-GSRAUTH-SEC              SECTION.
      *
           IF  SYS-1010-GSRAUTH(1:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(1)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(1)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(16:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(2)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(2)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(17:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(3)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(3)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(18:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(4)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(4)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(19:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(5)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(5)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(21:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(6)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(6)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(22:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(7)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(7)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(23:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(8)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(8)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(24:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(9)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(9)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(26:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(10)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(10)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(27:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(11)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(11)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(28:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(12)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(12)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(29:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(13)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(13)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(31:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(14)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(14)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(32:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(15)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(15)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(41:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(16)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(16)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(47:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(17)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(17)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(51:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(18)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(18)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(52:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(19)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(19)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(61:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(20)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(20)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(62:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(21)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(21)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(63:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(22)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(22)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(64:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(23)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(23)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(65:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(24)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(24)
           END-IF
      *
           IF  SYS-1010-GSRAUTH(66:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(25)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(25)
           END-IF
      *
      *----(01.01.05)----START------------
           IF  SYS-1010-GSRAUTH(67:1)  =  1
               MOVE  "T"  TO  SPA-GMN-CHK(26)
           ELSE
               MOVE  "F"  TO  SPA-GMN-CHK(26)
           END-IF
      *----(01.01.05)----END--------------
           . 
       320-SPASET-GSRAUTH-EXT.
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
                   MOVE   "CHANGE"             TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *        削除
               WHEN    "CLICKED"      ALSO    "B03"
                   PERFORM  403-DEL-SEC
      *    登録
               WHEN    "CLICKED"      ALSO    "B12"
                   PERFORM 490-TOUROKU-SEC
               WHEN    "CLICKED"      ALSO    "CHK1"
               WHEN    "CLICKED"      ALSO    "CHK2"
               WHEN    "CLICKED"      ALSO    "CHK3"
               WHEN    "CLICKED"      ALSO    "CHK4"
               WHEN    "CLICKED"      ALSO    "CHK5"
               WHEN    "CLICKED"      ALSO    "CHK6"
               WHEN    "CLICKED"      ALSO    "CHK7"
               WHEN    "CLICKED"      ALSO    "CHK8"
               WHEN    "CLICKED"      ALSO    "CHK9"
               WHEN    "CLICKED"      ALSO    "CHK10"
               WHEN    "CLICKED"      ALSO    "CHK11"
               WHEN    "CLICKED"      ALSO    "CHK12"
               WHEN    "CLICKED"      ALSO    "CHK13"
               WHEN    "CLICKED"      ALSO    "CHK14"
               WHEN    "CLICKED"      ALSO    "CHK15"
               WHEN    "CLICKED"      ALSO    "CHK16"
               WHEN    "CLICKED"      ALSO    "CHK17"
               WHEN    "CLICKED"      ALSO    "CHK18"
               WHEN    "CLICKED"      ALSO    "CHK19"
               WHEN    "CLICKED"      ALSO    "CHK20"
               WHEN    "CLICKED"      ALSO    "CHK21"
               WHEN    "CLICKED"      ALSO    "CHK22"
               WHEN    "CLICKED"      ALSO    "CHK23"
               WHEN    "CLICKED"      ALSO    "CHK24"
               WHEN    "CLICKED"      ALSO    "CHK25"
      *----(01.01.05)----START------------
               WHEN    "CLICKED"      ALSO    "CHK26"
      *----(01.01.05)----END--------------
                   PERFORM 4119-GSRAUTH-CHK-SEC
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
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"      ALSO    "USERID"
                   PERFORM 4100-USERID-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "KANANAME"
                   PERFORM 4112-KANANAME-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NAME"
                   PERFORM 4113-NAME-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "ISEKINUM"
                   PERFORM 4114-ISEKINUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNDRNUMS" 
                   PERFORM 4115-HKNDRNUMS-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNDRNUMK"
                   PERFORM 4116-HKNDRNUMK-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "MAYAKULICENSE"
                   PERFORM 4117-MAYAKULICENSE-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SEMONKACD1"
               WHEN    "ACTIVATE"      ALSO    "SEMONKACD2"
               WHEN    "ACTIVATE"      ALSO    "SEMONKACD3"
               WHEN    "ACTIVATE"      ALSO    "SEMONKACD4"
               WHEN    "ACTIVATE"      ALSO    "SEMONKACD5"
                   PERFORM 4118-SEMONKACD-MAE-CHK-SEC 
               WHEN    "ACTIVATE"      ALSO    "KANRIAUTHFLG"
                   PERFORM 4120-KANRIAUTHFLG-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    オペレータＩＤチェック
      *****************************************************************
       4100-USERID-CHK-SEC       SECTION.
      *
           MOVE    2                   TO  SPA-GMN-CUR
      *
           MOVE    W06-USERID          TO  SPA-GMN-USERID
      *
           IF      SPA-GMN-USERID      =   SPACE
               MOVE    "0005"          TO  SPA-ERRCD
               GO  TO  4100-USERID-CHK-EXT
           ELSE 
      *    半角チェック
               INITIALIZE              ORCSKANACHKAREA
               MOVE  "1"               TO  KANACHK-SYORI
               MOVE  SPA-GMN-USERID    TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"   USING 
                                       ORCSKANACHKAREA
      *
               IF  (KANACHK-SYUBETU     NOT  =  1)
                   OR  (KANACHK-RC      NOT  =  0)
                   MOVE    "0010"            TO  SPA-ERRCD
                   GO TO 4100-USERID-CHK-EXT 
               END-IF     
      *
               INITIALIZE                  SYS-1010-REC
               MOVE    "1010"              TO  SYS-1010-KANRICD
               MOVE    SPA-GMN-USERID      TO  SYS-1010-USERID
               MOVE    SPA-SYSYMD          TO  ORC-DBYMD
               MOVE    SYS-1010-REC        TO  MCPDATA-REC
               MOVE    "SYSKANRI-KEY3"     TO  WRK-PATH
               PERFORM 900-SYSKANRI-SELECT-SEC
               PERFORM 900-SYSKANRI-CLOSE-SEC
               IF      FLG-SYSKANRI            =   ZERO
                   MOVE    MCPDATA-REC             TO  SYS-1010-REC
                   IF      SYS-1010-KBNCD(1:5) NOT =   SPA-GMN-KBNCD
                       MOVE    "0004"              TO  SPA-ERRCD
                       GO  TO  4100-USERID-CHK-EXT
                   END-IF
               END-IF
           END-IF    
      *  
           MOVE    3                   TO  SPA-GMN-CUR
           .
       4100-USERID-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    フリガナチェック処理
      *****************************************************************
       4112-KANANAME-CHK-SEC           SECTION.
      *
           MOVE    3                   TO  SPA-GMN-CUR
      *
           MOVE    W06-KANANAME        TO  SPA-GMN-KANANAME
      *
      *    全角チェック
           IF  SPA-GMN-KANANAME        NOT  =   SPACE
               INITIALIZE              ORCSKANACHKAREA
               MOVE  "1"               TO  KANACHK-SYORI
               MOVE  SPA-GMN-KANANAME  TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"   USING 
                                       ORCSKANACHKAREA
      *
               IF  (KANACHK-SYUBETU     NOT  =  2)
                   OR  (KANACHK-RC      NOT  =  0)
                   MOVE    "0011"            TO  SPA-ERRCD
                   GO TO 4112-KANANAME-CHK-EXT 
               END-IF
      *
               MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-KANANAME
           END-IF
      *  
           MOVE    4                   TO  SPA-GMN-CUR
           .
       4112-KANANAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    氏名チェック処理
      *****************************************************************
       4113-NAME-CHK-SEC        SECTION.
      *
           MOVE    4                   TO  SPA-GMN-CUR
      *
           MOVE    W06-NAME            TO  SPA-GMN-NAME
      *
      *    全角チェック
           IF  SPA-GMN-NAME            =   SPACE
               MOVE    "0006"          TO  SPA-ERRCD
               GO  TO  4113-NAME-CHK-EXT
           ELSE
               INITIALIZE              ORCSKANACHKAREA
               MOVE  "1"               TO  KANACHK-SYORI
               MOVE  SPA-GMN-NAME      TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"   USING 
                                       ORCSKANACHKAREA
      *
               IF  (KANACHK-SYUBETU     NOT  =  2)
                   OR  (KANACHK-RC      NOT  =  0)
                   MOVE    "0011"            TO  SPA-ERRCD
                   GO TO 4113-NAME-CHK-EXT 
               END-IF
      *
               MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-NAME
           END-IF
      *  
           MOVE    5                   TO  SPA-GMN-CUR
           . 
       4113-NAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    医籍登録番号チェック処理
      *****************************************************************
       4114-ISEKINUM-CHK-SEC        SECTION.
      *
           MOVE    5                   TO  SPA-GMN-CUR
      *
           MOVE    W06-ISEKINUM        TO  SPA-GMN-ISEKINUM
      *  
           MOVE    6                   TO  SPA-GMN-CUR
           .
       4114-ISEKINUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険医登録番号（社保）チェック処理
      *****************************************************************
       4115-HKNDRNUMS-CHK-SEC        SECTION.
      *
           MOVE    6                   TO  SPA-GMN-CUR
      *
           MOVE    W06-HKNDRNUMS       TO  SPA-GMN-HKNDRNUMS
      *  
           MOVE    7                   TO  SPA-GMN-CUR
           .
       4115-HKNDRNUMS-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険医登録番号（国保）チェック処理
      *****************************************************************
       4116-HKNDRNUMK-CHK-SEC        SECTION.
      *
           MOVE    7                   TO  SPA-GMN-CUR
      *
           MOVE    W06-HKNDRNUMK       TO  SPA-GMN-HKNDRNUMK
      *  
           MOVE    8                   TO  SPA-GMN-CUR
           .
       4116-HKNDRNUMk-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    麻薬ライセンス チェック処理
      *****************************************************************
       4117-MAYAKULICENSE-CHK-SEC        SECTION.
      *
           MOVE    8                   TO  SPA-GMN-CUR
      *
           MOVE   W06-MAYAKULICENSE    TO  SPA-GMN-MAYAKULICENSE
      *
      *    混在チェック
           IF  SPA-GMN-MAYAKULICENSE   NOT  =   SPACE
               INITIALIZE              ORCSKANACHKAREA
               MOVE  "1"               TO  KANACHK-SYORI
               MOVE  SPA-GMN-MAYAKULICENSE    TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"   USING 
                                       ORCSKANACHKAREA
      *
               IF  KANACHK-RC      NOT  =  0
                   MOVE    "0012"            TO  SPA-ERRCD
                  GO TO 4117-MAYAKULICENSE-CHK-EXT 
               END-IF
      *
               IF  KANACHK-SYUBETU       =  2
                   MOVE   KANACHK-OUT-INPUT  TO  SPA-GMN-MAYAKULICENSE
               END-IF
      *
           END-IF
      *  
           MOVE    9                   TO  SPA-GMN-CUR
           .
       4117-MAYAKULICENSE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    専門科コードチェック処理
      *****************************************************************
       4118-SEMONKACD-MAE-CHK-SEC        SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "SEMONKACD1"
                   MOVE    1               TO  IDX 
               WHEN    "SEMONKACD2"
                   MOVE    2               TO  IDX 
               WHEN    "SEMONKACD3"
                   MOVE    3               TO  IDX 
               WHEN    "SEMONKACD4"
                   MOVE    4               TO  IDX 
               WHEN    "SEMONKACD5"
                   MOVE    5               TO  IDX 
           END-EVALUATE
      *
           PERFORM  4118-SEMONKACD-CHK-SEC
           .
       4118-SEMONKACD-MAE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    専門科コードチェック処理
      *****************************************************************
       4118-SEMONKACD-CHK-SEC        SECTION.
      *
           COMPUTE SPA-GMN-CUR    =    IDX  +   8
      *
           MOVE    W06-SEMONKACD(IDX)  TO  SPA-W06-SEMONKACD(IDX)
      *
           IF  SPA-W06-SEMONKACD(IDX)  NOT  =  SPACE
               EVALUATE  SPA-CD-L(IDX)
                   WHEN  "1"
                       MOVE  "01"      TO  SPA-CD-L(IDX)
                   WHEN  "2"
                       MOVE  "02"      TO  SPA-CD-L(IDX)
                   WHEN  "3"
                       MOVE  "03"      TO  SPA-CD-L(IDX)
                   WHEN  "4"
                       MOVE  "04"      TO  SPA-CD-L(IDX)
                   WHEN  "5"
                       MOVE  "05"      TO  SPA-CD-L(IDX)
                   WHEN  "6"
                       MOVE  "06"      TO  SPA-CD-L(IDX)
                   WHEN  "7"
                       MOVE  "07"      TO  SPA-CD-L(IDX)
                   WHEN  "8"
                       MOVE  "08"      TO  SPA-CD-L(IDX)
                   WHEN  "9"
                       MOVE  "09"      TO  SPA-CD-L(IDX)
               END-EVALUATE
      *                
               PERFORM  VARYING IDY FROM 1 BY 1
                   UNTIL   IDY > SPA-GMNCD-MAX(IDX)
                   IF  SPA-GMNCD-L(IDX,IDY) =  SPA-CD-L(IDX)
                       MOVE  1             TO  FLG-CHK
                       MOVE  SPA-GMNCD-MAX(IDX) TO  IDY 
                   ELSE
                       MOVE  ZERO          TO  FLG-CHK
                   END-IF
               END-PERFORM
      *
               IF  FLG-CHK = ZERO
                   MOVE    "0007"          TO  SPA-ERRCD
                   GO  TO  4118-SEMONKACD-CHK-EXT
               END-IF
           END-IF
      *       
           ADD     1                   TO  SPA-GMN-CUR
           .
       4118-SEMONKACD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    業務処理権限チェック処理
      *****************************************************************
       4119-GSRAUTH-CHK-SEC             SECTION.
      *
           EVALUATE    MCP-WIDGET
               WHEN    "CHK1" 
                   MOVE    1               TO  IDX  
               WHEN    "CHK2"
                   MOVE    2               TO  IDX 
               WHEN    "CHK3"
                   MOVE    3               TO  IDX 
               WHEN    "CHK4"
                   MOVE    4               TO  IDX 
               WHEN    "CHK5"
                   MOVE    5               TO  IDX 
               WHEN    "CHK6"
                   MOVE    6               TO  IDX 
               WHEN    "CHK7"
                   MOVE    7               TO  IDX 
               WHEN    "CHK8"
                   MOVE    8               TO  IDX 
               WHEN    "CHK9"
                   MOVE    9               TO  IDX 
               WHEN    "CHK10"
                   MOVE    10              TO  IDX
               WHEN    "CHK11"
                   MOVE    11              TO  IDX 
               WHEN    "CHK12"
                   MOVE    12              TO  IDX 
               WHEN    "CHK13"
                   MOVE    13              TO  IDX 
               WHEN    "CHK14"
                   MOVE    14              TO  IDX
               WHEN    "CHK15"
                   MOVE    15              TO  IDX 
               WHEN    "CHK16"
                   MOVE    16              TO  IDX 
               WHEN    "CHK17"
                   MOVE    17              TO  IDX 
               WHEN    "CHK18"
                   MOVE    18              TO  IDX 
               WHEN    "CHK19"
                   MOVE    19              TO  IDX 
               WHEN    "CHK20"
                   MOVE    20              TO  IDX 
               WHEN    "CHK21"
                   MOVE    21              TO  IDX
               WHEN    "CHK22"
                   MOVE    22              TO  IDX 
               WHEN    "CHK23"
                   MOVE    23              TO  IDX 
               WHEN    "CHK24"
                   MOVE    24              TO  IDX
               WHEN    "CHK25"
                   MOVE    25              TO  IDX
      *----(01.01.05)----START------------
               WHEN    "CHK26"
                   MOVE    26              TO  IDX
      *----(01.01.05)----END--------------
           END-EVALUATE
      *
           EVALUATE    SPA-GMN-CHK (IDX)
               WHEN  "T"
                   MOVE  "F"           TO  SPA-GMN-CHK (IDX)
               WHEN  "F"
                   MOVE  "T"           TO  SPA-GMN-CHK (IDX)
           END-EVALUATE
      *
           COMPUTE    SPA-GMN-CUR     =  IDX  +  13 
      *
           IF  IDX  =  18  AND  SPA-FLG-L  =  "F"
               ADD     1                   TO  SPA-GMN-CUR
           END-IF
      *       
           ADD     1                   TO  SPA-GMN-CUR
           .
       4119-GSRAUTH-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理者権限フラグチェック処理
      *****************************************************************
       4120-KANRIAUTHFLG-CHK-SEC        SECTION.
      *
           MOVE    40                   TO  SPA-GMN-CUR
      *
           IF  W06-KANRIAUTHFLG  =  SPACE
               MOVE  "管理者でない"     TO  W06-KANRIAUTHFLG
           END-IF
      *
           MOVE  W06-KANRIAUTHFLG       TO  SPA-FLG-MEIL
      *
           EVALUATE  W06-KANRIAUTHFLG
               WHEN  "管理者である" 
                   MOVE    "T"          TO  SPA-FLG-L
               WHEN  "管理者でない"       
                   MOVE    "F"          TO  SPA-FLG-L
           END-EVALUATE
      *  
           PERFORM 510-GSRAUTH-SEC
      *
           MOVE    99                   TO  SPA-GMN-CUR
           .
       4120-KANRIAUTHFLG-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                        SECTION.
      *
           MOVE    "W01"               TO  SPA-SAKIPG
           MOVE    "W06"               TO  SPA-MOTOPG
      *
           INITIALIZE                  SPA-W01KYOUTU
      *
      ***  MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除確認画面表示処理
      *****************************************************************
       403-DEL-SEC                               SECTION.
      *
           MOVE    "1002"              TO  SPA-WIDCD
      *
           .    
       403-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理
      *****************************************************************
       4031-DEL-SEC                              SECTION.
      *
           MOVE    SPACE               TO  SYS-1010-REC
           INITIALIZE                      SYS-1010-REC
           MOVE    "1010"                  TO  SYS-1010-KANRICD
           MOVE    SPA-W01-KBNCD           TO  SYS-1010-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  SYS-1010-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD        TO  SYS-1010-EDYUKYMD
           MOVE    SYS-1010-REC            TO  MCPDATA-REC
           MOVE    "DBDELETE"              TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1002"                  TO  SPA-ERRCD
               DISPLAY "SYSKANRI-KEY =>" SYS-1010-KEY 
               GO  TO  4031-DEL-EXT
           END-IF
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK
           .
       4031-DEL-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録前処理
      *****************************************************************
       490-TOUROKU-SEC              SECTION.
      *
           PERFORM 4900-KANRENCHK-SEC
           IF      SPA-ERRCD        =   SPACE
              MOVE    "1001"           TO  SPA-WIDCD
           END-IF
           .
       490-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *       登録処理
      *****************************************************************
       490-KOUSHIN-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYS-1010-REC
           INITIALIZE                      SYS-1010-REC
           MOVE    "1010"                  TO  SYS-1010-KANRICD
           MOVE    SPA-W01-KBNCD           TO  SYS-1010-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-1010-REC            TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"          TO  WRK-PATH
           PERFORM 900-SYSKANRI-SELECT-SEC
           PERFORM 900-SYSKANRI-CLOSE-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-1010-REC
           ELSE
               MOVE    SPACE                   TO  SYS-1010-REC
               INITIALIZE                      SYS-1010-REC
               MOVE   "1010"                   TO  SYS-1010-KANRICD
               MOVE    SPA-W01-KBNCD           TO  SYS-1010-KBNCD
           END-IF
      *
           MOVE    SPA-W01-STYUKYMD          TO  SYS-1010-STYUKYMD
           MOVE    SPA-W01-EDYUKYMD          TO  SYS-1010-EDYUKYMD
           MOVE    SPA-GMN-USERID            TO  SYS-1010-USERID 
           MOVE    SPA-GMN-KANANAME          TO  SYS-1010-KANANAME 
           MOVE    SPA-GMN-NAME              TO  SYS-1010-NAME 
           MOVE    SPA-GMN-ISEKINUM          TO  SYS-1010-ISEKINUM 
           MOVE    SPA-GMN-HKNDRNUMS         TO  SYS-1010-HKNDRNUMS
           MOVE    SPA-GMN-HKNDRNUMK         TO  SYS-1010-HKNDRNUMK
           MOVE    SPA-GMN-MAYAKULICENSE     TO  SYS-1010-MAYAKULICENSE
      *
           PERFORM 4900-KOUSHIN-GSRAUTH-SEC
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       5
               MOVE    SPA-CD-L(IDX)     TO  SYS-1010-SEMONKACD (IDX)
           END-PERFORM
           MOVE    SPA-FLG-L             TO  SYS-1010-KANRIAUTHFLG
           MOVE    SYS-1010-REC              TO  SYSKANRI-REC
      *     
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    SYS-KANRICD             TO  SYSUP-KANRICD
               MOVE    SYS-KBNCD               TO  SYSUP-KBNCD
               MOVE    SPA-W01-SEL-STYUKYMD    TO  SYSUP-STYUKYMD
               MOVE    SPA-W01-SEL-EDYUKYMD    TO  SYSUP-EDYUKYMD
               MOVE    "SYSKANRI-UPD1"         TO  ORC-DBPATH
               MOVE    "DBUPDATE"              TO  MCP-FUNC
           ELSE
               MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
               MOVE    "DBINSERT"              TO  MCP-FUNC
           END-IF
           MOVE    SYSKANRI-REC            TO  MCPDATA-REC
           CALL    "ORCMCPSUB"              USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC              NOT =   ZERO 
               MOVE    "1001"                  TO  SPA-ERRCD
               GO  TO  490-KOUSHIN-EXT
           END-IF      
      *
           MOVE   "JOIN"               TO  MCP-PUTTYPE
           PERFORM 210-BACK 
           .
       490-KOUSHIN-EXT.
           EXIT.
      *
      *****************************************************************
      *       チェック登録処理
      *****************************************************************
       4900-KOUSHIN-GSRAUTH-SEC           SECTION.
      *
           IF  SPA-GMN-CHK(1)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(1:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(1:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(2)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(16:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(16:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(3)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(17:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(17:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(4)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(18:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(18:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(5)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(19:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(19:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(6)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(21:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(21:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(7)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(22:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(22:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(8)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(23:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(23:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(9)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(24:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(24:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(10)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(26:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(26:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(11)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(27:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(27:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(12)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(28:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(28:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(13)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(29:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(29:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(14)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(31:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(31:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(15)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(32:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(32:1)                                      
           END-IF
      *    
           IF  SPA-GMN-CHK(16)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(41:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(41:1)                                      
           END-IF
      *   
           IF  SPA-GMN-CHK(17)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(47:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(47:1)                                      
           END-IF
      *    
           IF  SPA-GMN-CHK(18)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(51:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(51:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(19)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(52:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(52:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(20)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(61:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(61:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(21)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(62:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(62:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(22)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(63:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(63:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(23)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(64:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(64:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(24)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(65:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(65:1)                                      
           END-IF
      *
           IF  SPA-GMN-CHK(25)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(66:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(66:1)                                      
           END-IF
      *
      *----(01.01.05)----START------------
           IF  SPA-GMN-CHK(26)  =  "T"
               MOVE     1    TO  SYS-1010-GSRAUTH(67:1)
           ELSE
               MOVE     0    TO  SYS-1010-GSRAUTH(67:1)                                      
           END-IF
      *----(01.01.05)----START------------
          .
       4900-KOUSHIN-GSRAUTH-EXT.
           EXIT.
      *
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       4900-KANRENCHK-SEC           SECTION.
      *
           MOVE    SPACE                TO  SPA-ERRCD
           MOVE    SPA-GMN-CUR          TO  WRK-GMN-CUR 
      *
           PERFORM 4100-USERID-CHK-SEC
           IF  SPA-ERRCD  =  SPACE
               PERFORM 4112-KANANAME-CHK-SEC
               IF  SPA-ERRCD  =  SPACE
                   PERFORM 4113-NAME-CHK-SEC
                   IF  SPA-ERRCD  =  SPACE
                       PERFORM 4117-MAYAKULICENSE-CHK-SEC
                       IF  SPA-ERRCD  =  SPACE
                           PERFORM VARYING IDX FROM    1   BY  1
                                   UNTIL   IDX >       5
                               PERFORM  4118-SEMONKACD-CHK-SEC
                               IF  SPA-ERRCD  NOT  =  SPACE
                                   MOVE  5  TO  IDX
                               END-IF
                           END-PERFORM
                           IF  SPA-ERRCD  =  SPACE
                               PERFORM  4120-KANRIAUTHFLG-CHK-SEC
                           END-IF
                       END-IF
                   END-IF
               END-IF
           END-IF             
           .
       4900-KANRENCHK-EXT.
           EXIT.
      *
      *****************************************************************
      *       入力項目の関連チェック処理
      *****************************************************************
       500-SYS-1005-HENSYU-SEC           SECTION.
      *
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"                  TO  SYS-1005-KANRICD
           MOVE    SPA-CD-L(IDX)           TO  SYS-1005-KBNCD
           MOVE    SPA-W01-STYUKYMD        TO  ORC-DBYMD
           MOVE    SYS-1005-REC            TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"          TO  WRK-PATH
           PERFORM 900-SYSKANRI-SELECT-SEC
           PERFORM 900-SYSKANRI-CLOSE-SEC
           IF      FLG-SYSKANRI            =   ZERO
               MOVE    MCPDATA-REC             TO  SYS-1005-REC
           END-IF
           .
       500-SYS-1005-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
           PERFORM 510-GSRAUTH-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-WIDCD       NOT =   SPACE
               PERFORM 520-WIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "W06    "           TO  MCP-WINDOW.
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
           MOVE    SPA-GMN-STYUKYMD        TO  W06-YUKOSTYMD
           MOVE    SPA-GMN-EDYUKYMD        TO  W06-YUKOEDYMD
           MOVE    SPA-GMN-KBNCD           TO  W06-KBNCD
           MOVE    SPA-GMN-KBNNAME         TO  W06-KBNNAME
      * 
           MOVE    SPA-GMN-USERID          TO  W06-USERID
           MOVE    SPA-GMN-KANANAME        TO  W06-KANANAME
           MOVE    SPA-GMN-NAME            TO  W06-NAME  
           MOVE    SPA-GMN-ISEKINUM        TO  W06-ISEKINUM
           MOVE    SPA-GMN-HKNDRNUMS       TO  W06-HKNDRNUMS
           MOVE    SPA-GMN-HKNDRNUMK       TO  W06-HKNDRNUMK
           MOVE    SPA-GMN-MAYAKULICENSE   TO  W06-MAYAKULICENSE
      *
           MOVE  SPA-GMN-CHK(1)            TO  W06-CHK1
           MOVE  SPA-GMN-CHK(2)            TO  W06-CHK2
           MOVE  SPA-GMN-CHK(3)            TO  W06-CHK3
           MOVE  SPA-GMN-CHK(4)            TO  W06-CHK4
           MOVE  SPA-GMN-CHK(5)            TO  W06-CHK5
           MOVE  SPA-GMN-CHK(6)            TO  W06-CHK6
           MOVE  SPA-GMN-CHK(7)            TO  W06-CHK7
           MOVE  SPA-GMN-CHK(8)            TO  W06-CHK8
           MOVE  SPA-GMN-CHK(9)            TO  W06-CHK9
           MOVE  SPA-GMN-CHK(10)           TO  W06-CHK10
           MOVE  SPA-GMN-CHK(11)           TO  W06-CHK11
           MOVE  SPA-GMN-CHK(12)           TO  W06-CHK12
           MOVE  SPA-GMN-CHK(13)           TO  W06-CHK13
           MOVE  SPA-GMN-CHK(14)           TO  W06-CHK14
           MOVE  SPA-GMN-CHK(15)           TO  W06-CHK15
           MOVE  SPA-GMN-CHK(16)           TO  W06-CHK16
           MOVE  SPA-GMN-CHK(17)           TO  W06-CHK17
           MOVE  SPA-GMN-CHK(18)           TO  W06-CHK18
           MOVE  SPA-GMN-CHK(19)           TO  W06-CHK19
           MOVE  SPA-GMN-CHK(20)           TO  W06-CHK20
           MOVE  SPA-GMN-CHK(21)           TO  W06-CHK21
           MOVE  SPA-GMN-CHK(22)           TO  W06-CHK22
           MOVE  SPA-GMN-CHK(23)           TO  W06-CHK23
           MOVE  SPA-GMN-CHK(24)           TO  W06-CHK24
           MOVE  SPA-GMN-CHK(25)           TO  W06-CHK25
      *----(01.01.05)----START------------
           MOVE  SPA-GMN-CHK(26)           TO  W06-CHK26
      *----(01.01.05)----START------------
      *    
           PERFORM  VARYING IDY FROM 1 BY 1
               UNTIL IDY > 5
               PERFORM  VARYING IDX FROM 1 BY 1
                   UNTIL   IDX > SPA-GMNCD-MAX(IDY)
                   MOVE  SPA-GMNCD-LIST(IDY,IDX) 
                                 TO  W06-CD-ITEM(IDY,IDX)
               END-PERFORM
      *
               MOVE  SPA-GMNCD-MAX(IDY)    TO  W06-CD-COUNT(IDY)
               MOVE  SPA-W06-SEMONKACD(IDY)    TO  W06-SEMONKACD(IDY)
           END-PERFORM
      *    
           PERFORM  VARYING IDX FROM 1 BY 1
               UNTIL   IDX > SPA-GMNFLG-MAX
               MOVE  SPA-GMNFLG-LIST(IDX)  TO  W06-FLG-ITEM(IDX)
           END-PERFORM
      *    
           MOVE  SPA-GMNFLG-MAX  TO  W06-FLG-COUNT
           MOVE  SPA-FLG-MEIL    TO  W06-KANRIAUTHFLG
      *
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    業務権限非活性処理
      *****************************************************************
       510-GSRAUTH-SEC             SECTION.
      *
           MOVE    WIDGET-INSENSITIVE      TO  W06-B03-STATE
           MOVE    WIDGET-INSENSITIVE      TO  W06-CHK19-STATE
      *
           IF      SPA-W01-SELNUM          >   ZERO    
               MOVE    WIDGET-NORMAL      TO  W06-B03-STATE
           END-IF
      *    オルカマスターのみ削除不可能にする
           IF      SPA-GMN-KBNCD       =   "00001"
               MOVE    WIDGET-INSENSITIVE      TO  W06-B03-STATE
           END-IF
      *
           IF      SPA-FLG-L  =  "T"
               MOVE    WIDGET-NORMAL      TO  W06-CHK19-STATE
           END-IF
           .
       51O-GSRAUTH-EXT.
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
                   MOVE    "入力エラー"        TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "オペレータＩＤが重複します"
                                               TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "オペレータＩＤを入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "氏名を入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "正しいコードを入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "半角で入力して下さい"  TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "全角で入力して下さい"  TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE    "半角か全角のどちらかで入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0099"
                   MOVE    "未入力の項目があります"
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新ができませんでした"
                                               TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除ができませんでした"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WERR
           MOVE    SPA-ERRCD            TO  WERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  WERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "W06"                TO  SPA-MOTOPG
           MOVE    "WERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "WERR"               TO  MCP-WINDOW
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
       520-WIDSET-SEC              SECTION.
      *
           MOVE    SPACE                TO  WRK-WIDMSG
      *
           EVALUATE    SPA-WIDCD
               WHEN    "1001"
                   MOVE    "職員情報を登録します"    TO  WRK-WIDMSG
               WHEN    "1002"
                   MOVE    "職員情報を削除します"    TO  WRK-WIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  WID1
           MOVE    SPA-WIDCD            TO  WID1-ID1CODE
           MOVE    WRK-WIDMSG           TO  WID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "W06"                TO  SPA-MOTOPG
           MOVE    "WID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "WID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-WIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理    
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
          EVALUATE    SPA-GMN-CUR
                WHEN    2
                    MOVE  "USERID"         TO   MCP-WIDGET
                WHEN    3
                    MOVE  "KANANAME"       TO   MCP-WIDGET
                WHEN    4
                    MOVE  "NAME"           TO   MCP-WIDGET
                WHEN    5
                    MOVE  "ISEKINUM"       TO   MCP-WIDGET
                WHEN    6
                    MOVE  "HKNDRNUMS"      TO   MCP-WIDGET
                WHEN    7
                    MOVE  "HKNDRNUMK"      TO   MCP-WIDGET
                WHEN    8
                    MOVE  "MAYAKULICENSE"  TO   MCP-WIDGET
                WHEN    9
                    MOVE  "SEMONKACD1"  TO   MCP-WIDGET
                WHEN    10
                    MOVE  "SEMONKACD2"  TO   MCP-WIDGET
                WHEN    11
                    MOVE  "SEMONKACD3"  TO   MCP-WIDGET
                WHEN    12
                    MOVE  "SEMONKACD4"  TO   MCP-WIDGET
                WHEN    13
                    MOVE  "SEMONKACD5"  TO   MCP-WIDGET
                WHEN    14
                    MOVE  "CHK1"           TO   MCP-WIDGET
                WHEN    15
                    MOVE  "CHK2"           TO   MCP-WIDGET
                WHEN    16
                    MOVE  "CHK3"           TO   MCP-WIDGET
                WHEN    17
                    MOVE  "CHK4"           TO   MCP-WIDGET
                WHEN    18
                    MOVE  "CHK5"           TO   MCP-WIDGET
                WHEN    19
                    MOVE  "CHK6"           TO   MCP-WIDGET
                WHEN    20
                    MOVE  "CHK7"           TO   MCP-WIDGET
                WHEN    21
                    MOVE  "CHK8"           TO   MCP-WIDGET
                WHEN    22
                    MOVE  "CHK9"           TO   MCP-WIDGET
                WHEN    23
                    MOVE  "CHK10"          TO   MCP-WIDGET
                WHEN    24
                    MOVE  "CHK11"          TO   MCP-WIDGET
                WHEN    25
                    MOVE  "CHK12"          TO   MCP-WIDGET
                WHEN    26
                    MOVE  "CHK13"          TO   MCP-WIDGET
                WHEN    27
                    MOVE  "CHK14"          TO   MCP-WIDGET
                WHEN    28
                    MOVE  "CHK15"          TO   MCP-WIDGET
                WHEN    29
                    MOVE  "CHK16"          TO   MCP-WIDGET
                WHEN    30
                    MOVE  "CHK17"          TO   MCP-WIDGET
                WHEN    31
                    MOVE  "CHK18"          TO   MCP-WIDGET
                WHEN    32
                    MOVE  "CHK19"          TO   MCP-WIDGET
                WHEN    33
                    MOVE  "CHK20"          TO   MCP-WIDGET
                WHEN    34
                    MOVE  "CHK21"          TO   MCP-WIDGET
                WHEN    35
                    MOVE  "CHK22"          TO   MCP-WIDGET
                WHEN    36
                    MOVE  "CHK23"          TO   MCP-WIDGET
                WHEN    37
                    MOVE  "CHK24"          TO   MCP-WIDGET
                WHEN    38
                    MOVE  "CHK25"          TO   MCP-WIDGET
      *----(01.01.05)----START------------
                WHEN    39
                    MOVE  "CHK25"          TO   MCP-WIDGET
      *----(01.01.05)----END--------------
                WHEN    40
                    MOVE  "KANRIAUTHFLG"   TO   MCP-WIDGET
                WHEN    99
                    MOVE  "B12"            TO   MCP-WIDGET
            END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *
           IF      WRK-YMD  (1:7)  NOT NUMERIC
               INSPECT     WRK-YMD      REPLACING   ALL " " BY  "0"
               MOVE    WRK-YMD(1:1)     TO  WRK-WGO
               MOVE    WRK-YMD(2:2)     TO  WRK-WYY
               MOVE    WRK-YMD(5:2)     TO  WRK-WMM
               MOVE    WRK-YMD(8:2)     TO  WRK-WDD
           ELSE
               MOVE    WRK-YMD(1:7)     TO  WRK-WYMD
           END-IF
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
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-SELECT-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               PERFORM  900-SYSKANRI-FETCH-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
            .
       900-SYSKANRI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-FETCH-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-SYSKANRI
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
            .
       900-SYSKANRI-FETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-CLOSE-SEC         SECTION.
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-SYSKANRI-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
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
