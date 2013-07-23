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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGXG03.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 統計ＣＳＶ出力
      *  コンポーネント名  : 電子お薬手帳送信画面
      *  管理者            : 
      *  作成日付    作業者        記述
      *  12/11/30    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    CSVデータファイル
           SELECT  CSVDATA-FILE    ASSIGN   ASS-CSVDATA
                                   ORGANIZATION    IS  LINE SEQUENTIAL.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       FD  CSVDATA-FILE.
       01  CSVDATA-REC         PIC X(20000).
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPERRFL.INC"   REPLACING  //ERRFLPARA//
                                   BY         //XG03ERR//.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    再印刷処理共通パラメタ
           COPY    "XG01COMMON-SPA".
      *
       01  SPA-XG03.
           03  SPA-XG03-AREA.
               05  SPA-GMN-PAGE        PIC 9(05).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-TITLE1              PIC X(08).
                   07  SPA-GMN-TITLE2              PIC X(10).
                   07  SPA-GMN-CREYMD              PIC X(10).
      *
                   07  SPA-GMN-TBL-NEXT            PIC 9(01).
      *
                   07  SPA-GMN-TBL.
                       09  SPA-GMN-OCC             OCCURS  300.
                           11  SPA-GMN-TNO         PIC 9(05).
                           11  SPA-GMN-TTBL-GROUP  PIC X(14).
                           11  SPA-GMN-TRENNUM     PIC 9(04).
                           11  SPA-GMN-TSHORI-RENNUM
                                                   PIC 9(04).
                           11  SPA-GMN-TCNT        PIC 9(05).
                           11  SPA-GMN-TGYOUMU     PIC X(12).
                           11  SPA-GMN-TSRYYMD     PIC X(09).
                           11  SPA-GMN-TLPTNUM     PIC X(20).
                           11  SPA-GMN-TLPTNAME    PIC X(50).
                           11  SPA-GMN-TLDRNAME    PIC X(50).
                           11  SPA-GMN-TCSV-TITLE  PIC X(60).
      *
                   07  SPA-GMN-BODY.
                       09  SPA-GMN-BODY1.
                           11  SPA-GMN-SELNUM      PIC 9(03).
                           11  SPA-GMN-SRYYMD      PIC X(10).
                           11  SPA-GMN-TBL-UUID    PIC X(36).
                           11  SPA-GMN-RENNUM      PIC 9(04).
                           11  SPA-GMN-SHORI-RENNUM PIC 9(04).
                           11  SPA-GMN-CSV-TITLE   PIC X(60).
      *
                       09  SPA-GMN-BODY2.
                           11  SPA-GMN-PTNUM       PIC X(20).
                           11  SPA-GMN-NAME        PIC X(50).
      *
               05  SPA-NAI-AREA.
                   07  SPA-NAI-ICCARDRW            PIC X(01).
                   07  SPA-NAI-CLIENT-SAVE         PIC X(01).
                   07  SPA-NAI-CREYMD              PIC X(08).
                   07  SPA-NAI-CREYMD-OLD          PIC X(08).
      *
                   07  SPA-NAI-BODY.
                       09  SPA-NAI-BODY1.
                           11  SPA-NAI-SELNUM      PIC 9(03).
                           11  SPA-NAI-TBL-GROUP   PIC X(14).
                           11  SPA-NAI-TBL-KEY     PIC X(08).
                           11  SPA-NAI-SRYYMD      PIC X(08).
                       09  SPA-NAI-BODY2.
                           11  SPA-NAI-PTID        PIC 9(10).
      *
                   07  SPA-NAI-TBL.
                       09  SPA-NAI-OCC             OCCURS  300.
                           11  SPA-NAI-TTBL-KEY    PIC X(08).
                           11  SPA-NAI-TTBL-GROUP  PIC X(14).
                           11  SPA-NAI-TTBL-UUID   PIC X(36).
                           11  SPA-NAI-TPUTFLG     PIC X(01).
                           11  SPA-NAI-LPTID       PIC 9(10).
                           11  SPA-NAI-TSRYYMD     PIC X(09).
      *
               05  SPA-WRK-TBL-KEY                 PIC X(08).
               05  SPA-NAI-SMCNDATE-YMD            PIC 9(08).
               05  SPA-GMN-SMCNDATE-YMD            PIC X(09).
      *
           COPY    "ENUM-VALUE".
           COPY    "CMJOBNAME.INC".
           COPY    "CPLOCKCONST.INC".
      *
       01  ASS-AREA.
           03  ASS-CSVDATA         PIC X(255).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-CSVDATA         PIC X(02).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-MNOTE-H        PIC 9(05).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-MNOTE-H     PIC 9(01).
           03  FLG-MNOTE-B     PIC 9(01).
           03  FLG-END             PIC 9(01).
           03  FLG-LIST-ROW        PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-PTNUM           PIC 9(01).
           03  FLG-LOOPEND         PIC 9(01).
           03  FLG-NEXT            PIC 9(01).
           03  FLG-SENDDATA        PIC 9(01).
           03  FLG-SENT            PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-RESET           PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                PIC 9(05).
           03  IDXL                PIC 9(05).
           03  IDXN                PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-TBL-GROUP       PIC X(14).
           03  WRK-RENNUM          PIC 9(04).
           03  WRK-XGIDMSG         PIC X(70).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-CNT             PIC ZZZZ9.   
           03  WRK-SELNUM          PIC S9(05). 
      *
           03  WRK-ZZ              PIC ZZZZ9.
           03  WRK-YMD             PIC X(10).
           03  WRK-ZOGENPTN        PIC X(01).
           03  WRK-ZOGEN           PIC S9(05).
      *
           03  WRK-START           PIC 9(05).
      *  
           03  WRK-MOTOPG          PIC X(08).
           03  WRK-MCP-WIDGET      PIC X(64).
           03  WRK-YMD1.
               05  WRK-YY1         PIC 9(04).
               05  WRK-MM1         PIC 9(02).
               05  WRK-DD1         PIC 9(02).
      *
           03  WRK-YMD2.
               05  WRK-YY2         PIC 9(04).
               05  WRK-MM2         PIC 9(02).
               05  WRK-DD2         PIC 9(02).
           03  WRK-AGE-G.
               05  WRK-AGE         PIC 9(03).
           03  WRK-PTID            PIC 9(10).
           03  WRK-XG03-ROW        PIC 9(05).
           03  WRK-NAME            PIC X(50).
           03  WRK-HOST-G.
               05  WRK-HOST        PIC X(40).
               05  WRK-PORT        PIC X(05).
           03  WRK-AGE-X           PIC X(03).
           03  WRK-OBJECTDATA      PIC X(8).
           03  WRK-DL-FILENAME     PIC X(1024).
           03  WRK-DEL-FILENAME    PIC X(1024).
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
       01  WRK-ROW.
           05  WRK-LIST-ROW        PIC S9(9)   BINARY.
      *
           COPY    "CPSHELLTBL.INC".
      *
       01  CONST-AREA.
           03  CONST-TBL-MAX    PIC 9(03)   VALUE   300.
           03  CONST-TBL-KEY    PIC X(08)   VALUE   "MNOTE".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理
           COPY    "CPSYSKANRI.INC".
      *    職員情報
           COPY    "CPSK1010.INC".
           COPY    "CPSK1050.INC".
      *
      *    統計ＣＳＶ格納管理
       01  MNOTE-H-REC.
           COPY    "CPMNOTE-H.INC".
      *
      *    統計ＣＳＶ格納明細
       01  MNOTE-B-REC.
           COPY    "CPMNOTE-B.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
           COPY    "CPORCSGDAY.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
       01  UIDIO-AREA.
           03  UIDIO-RET   PIC X(2).
           03  UIDIO-UID   PIC X(36).
       01  UIDIO-ST        PIC 9(2).
      *
           COPY    "ORCA-BLOB".
      *
      *    文字コード変換
           COPY    "CPORCSFILEENCODE.INC".
      *
      *    クライアント保存可否情報取得サブ
           COPY    "CPORCSCLIENTSV.INC".
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
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
           COPY    "XG01.INC".
           COPY    "XG02.INC".
           COPY    "XG03.INC".
           COPY    "XG99.INC".
           COPY    "XGERR.INC".
           COPY    "XGID1.INC".
      *
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  CNT-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-XG03
           MOVE    SPA-WORK        TO  SPA-XG01KYOUTU
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
           MOVE    SPA-XG01KYOUTU  TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-XG03        TO  SPA-FREE
      *
           .
           EXIT    PROGRAM.
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                   SECTION.
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "XGERR"
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
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "XG03"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
           IF    ( SPA-MOTOPG          =   "XGID1" )
               CONTINUE
           ELSE
               IF    ( LINKAREA        NOT =   SPACE )
                   MOVE    LNK-KYOUTU  TO  SPA-KYOUTU
                   MOVE    SPA-MOTOPG  TO  WRK-MOTOPG
                   MOVE    SPA-MOTOPG  TO  SPA-MOTOPG2
               END-IF
           END-IF
      *
           EVALUATE    SPA-MOTOPG
           WHEN    "XGID1"
               PERFORM 330-XGID1-SET-SEC
           WHEN    OTHER
      *
               PERFORM 310-SPASET-SEC
      *
           END-EVALUATE
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC                  SECTION.
      *
           INITIALIZE                  SPA-XG03
                                       SPA-XG01KYOUTU
      *
      *    更新日取得
           PERFORM 800-ORCSMCNDATE-SEC
      *
           MOVE    SMCNDATE-YMD    TO  SPA-NAI-SMCNDATE-YMD
           MOVE    SMCNDATE-YMD    TO  WRK-SYMD 
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-SMCNDATE-YMD
      *
          MOVE    SPA-NAI-SMCNDATE-YMD
                                   TO  SPA-NAI-CREYMD
                                       SPA-NAI-CREYMD-OLD
          MOVE    SPA-GMN-SMCNDATE-YMD
                                   TO  SPA-GMN-CREYMD
      *
          MOVE    1                TO  SPA-GMN-PAGE
      *
          MOVE    "業務名"         TO  SPA-GMN-TITLE1
          MOVE    "患者番号"       TO  SPA-GMN-TITLE2
      *
      *    クライアント保存可否情報取得サブ
           INITIALIZE                      ORCSCLIENTSVAREA
           CALL    "ORCSCLIENTSV"  USING   ORCSCLIENTSVAREA
                                           SPA-AREA
           MOVE    SCLIENTSV-CLIENT-SAVE
                                   TO  SPA-NAI-CLIENT-SAVE
      *
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1050"              TO  SYS-KANRICD
           MOVE    SPA-STAFFCD         TO  SYS-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-1050-REC
           MOVE    SYS-1050-ICCARDRW   TO  SPA-NAI-ICCARDRW
      *
           MOVE    1               TO  FLG-LIST-ROW
      *
           MOVE    ZERO            TO  SPA-GMN-CUR
      *
           PERFORM 3101-SPA-LIST-HEN-SEC
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    コラムリスト編集処理
      *****************************************************************
       3101-SPA-LIST-HEN-SEC               SECTION.
      *
           INITIALIZE                      SPA-GMN-TBL
                                           SPA-NAI-TBL
      *
           PERFORM 900-MNOTE-H-KEY8-SEL-SEC
      *
           COMPUTE WRK-START       = ( SPA-GMN-PAGE  -  1 )
                                   *   CONST-TBL-MAX
                                   +   1
      *
           MOVE    ZERO                TO  IDXL
                                           IDXN
                                           SPA-GMN-MAX
      *
           PERFORM UNTIL ( IDXL           >=   CONST-TBL-MAX )
                   OR    ( FLG-MNOTE-H =   1   )
      *
               COMPUTE IDXN    =   IDXN    +   1
      *
               IF    ( IDXN   >=  WRK-START )
      *
                   COMPUTE IDXL    =   IDXL    +   1
      *
                   IF    ( IDXL   <=  CONST-TBL-MAX )
                       PERFORM 31011-MNOTE-H-SPA-SEC
                   END-IF
      *
               END-IF
      *
               PERFORM 900-MNOTE-H-KEY8-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_mnote_h"   TO  MCP-TABLE
           MOVE    "key8"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           IF    ( IDXL               >=   CONST-TBL-MAX )
            AND  ( FLG-MNOTE-H     =   ZERO )
               MOVE    1               TO  SPA-GMN-TBL-NEXT
           ELSE
               MOVE    ZERO            TO  SPA-GMN-TBL-NEXT
           END-IF
      *
           IF    ( SPA-GMN-MAX     >   ZERO )
               MOVE    1               TO  SPA-GMN-CUR
           ELSE
               MOVE    8               TO  SPA-GMN-CUR
           END-IF
      *
           .
       3101-SPA-LIST-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    コラムリスト編集処理
      *****************************************************************
       31011-MNOTE-H-SPA-SEC       SECTION.
      *
           MOVE    IDXN            TO  SPA-GMN-TNO        (IDXL)
      *
           MOVE    MNOTE-H-TBL-KEY
                                   TO  SPA-NAI-TTBL-KEY   (IDXL)
           MOVE    MNOTE-H-TBL-GROUP
                                   TO  SPA-NAI-TTBL-GROUP (IDXL)
           MOVE    MNOTE-H-TBL-UUID
                                   TO  SPA-NAI-TTBL-UUID  (IDXL)
      *
           IF    ( MNOTE-H-SRYYMD  = SPACE OR ZERO )
               CONTINUE
           ELSE
               MOVE    MNOTE-H-SRYYMD
                                   TO  SPA-NAI-TSRYYMD(IDXL)
                                       WRK-SYMD 
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-TSRYYMD(IDXL)
           END-IF
      *
           MOVE    MNOTE-H-TBL-GROUP
                                   TO  SPA-GMN-TTBL-GROUP (IDXL)
      *
           SET     TBLLOCK-IDX TO  1
           SEARCH  ORC-LOCKCONST-TX    VARYING  TBLLOCK-IDX
           AT  END
               MOVE    "その他"
                                   TO  SPA-GMN-TGYOUMU (IDXL)
           WHEN  ( MNOTE-H-GYOUMU-CD   =
                                  ORC-LOCKCONST-GNUM (TBLLOCK-IDX))
               MOVE    ORC-LOCKCONST-NAME (TBLLOCK-IDX)
                                   TO  SPA-GMN-TGYOUMU (IDXL)
           END-SEARCH
      *
           MOVE    MNOTE-H-RENNUM
                                   TO  SPA-GMN-TRENNUM (IDXL)
           MOVE    MNOTE-H-SHORI-RENNUM
                                   TO  SPA-GMN-TSHORI-RENNUM (IDXL)
           MOVE    MNOTE-H-CNT
                                   TO  SPA-GMN-TCNT (IDXL)
           MOVE    MNOTE-H-TITLE
                                   TO  SPA-GMN-TCSV-TITLE (IDXL)
           MOVE    MNOTE-H-PUTFLG
                                   TO  SPA-NAI-TPUTFLG (IDXL)
      *
           PERFORM 3101-SPA-PTINFO-SEC
      *
           MOVE    IDXL            TO  SPA-GMN-MAX
      *
           .
       31011-MNOTE-H-SPA-EXT.
           EXIT.
      *
      *****************************************************************
      *     患者情報取得
      *****************************************************************
       3101-SPA-PTINFO-SEC             SECTION.
      *
           MOVE    MNOTE-H-PTID    TO  SPA-NAI-LPTID (IDXL)
      *
           MOVE    MNOTE-H-PTID    TO  WRK-PTID
           PERFORM 900-PTNUM-KEY-SEL-SEC
           PERFORM 900-PTINF-KEY-SEL-SEC
      *
           MOVE    PTNUM-PTNUM         TO  SPA-GMN-TLPTNUM   (IDXL)
           MOVE    PTINF-NAME          TO  SPA-GMN-TLPTNAME  (IDXL)
      *
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1010"              TO  SYS-KANRICD
           MOVE    MNOTE-H-DRCD        TO  SYS-KBNCD
           MOVE    MNOTE-H-SRYYMD      TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY10-SEL-SEC
           MOVE    SYSKANRI-REC        TO  SYS-1010-REC
           MOVE    SYS-1010-NAME       TO  SPA-GMN-TLDRNAME  (IDXL)
      *
           .
       3101-SPA-PTINFO-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-XGID1-SET-SEC            SECTION.
      *
           IF    ( SPA-XGID1-FLG    =   "OK" )
               EVALUATE    SPA-XGIDCD
               WHEN    "3002"
               WHEN    "3003"
                   PERFORM 430-DELETE-SEC
               WHEN    "3004"
                   MOVE     1      TO  FLG-SENT
                   PERFORM 4501-CHANGE-STATUS-SEC
               WHEN    "3005"
                   MOVE     0      TO  FLG-SENT
                   PERFORM 4501-CHANGE-STATUS-SEC
               END-EVALUATE
           END-IF
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
           MOVE    SPACE           TO  SPA-XGID1-FLG
                                       SPA-XG99-FLG
           MOVE    SPACE           TO  SPA-XGIDCD
           .
       330-XGID1-SET-EXT.
           EXIT.
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    終了
           WHEN    "CLICKED"       ALSO    "B01"
               MOVE   "CHANGE"         TO  MCP-PUTTYPE
               PERFORM 210-BACK
      *    クリア
           WHEN    "CLICKED"       ALSO    "B02"
               PERFORM 420-CLEAR-SEC
      *    削除
           WHEN    "CLICKED"       ALSO    "B03"
               PERFORM 430-DELETE-GID-SEC
      *    前日
           WHEN    "CLICKED"       ALSO    "B06"
               PERFORM 440-BEFORE-SEC
      *    次日
           WHEN    "CLICKED"       ALSO    "B07"
               PERFORM 450-NEXT-SEC
      *    前頁
           WHEN    "CLICKED"       ALSO    "B06S"
               PERFORM 440-BACK-PAGE-SEC
      *    次頁
           WHEN    "CLICKED"       ALSO    "B07S"
               PERFORM 450-NEXT-PAGE-SEC
      *    クライアント保存
           WHEN    "CLICKED"       ALSO    "B09"
               PERFORM 460-SAVE-SEC
      *    状態変更
           WHEN    "CLICKED"       ALSO    "B10"
               PERFORM 450-CHANGE-STATUS-SEC
      *    リセット
           WHEN    "CLICKED"       ALSO    "B11"
               PERFORM 460-RESET-SEC
      *    一覧更新
           WHEN    "CLICKED"       ALSO    "B11S"
               PERFORM 470-REFRESH-SEC
      *    送信
           WHEN    "CLICKED"       ALSO    "B12"
               PERFORM 460-SEND-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
      *    入力箇所のセット
           MOVE    MCP-WIDGET      TO  WRK-MCP-WIDGET
           MOVE    ZERO            TO  SPA-GMN-CUR
      *
           EVALUATE    MCP-EVENT   ALSO    MCP-WIDGET
           WHEN    "ACTIVATE"      ALSO    "SELNUM"
               PERFORM 201-SELNUM-SEC
           WHEN    "ACTIVATE"      ALSO    "PTNUM"
               PERFORM 207-PTNUM-SEC
           WHEN    "ACTIVATE"      ALSO    "CREYMD"
               PERFORM 209-CREYMD-SEC
      *    行選択
           WHEN    ANY             ALSO    "LIST"
               PERFORM 203-SELECT-SEC
           WHEN    OTHER
      *        入力チェック処理
               PERFORM 410-INPUT-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC       SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *
      *    入力箇所のセット
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN-CUR
      *
      *    基本チェック処理
           PERFORM 4102-KIHON-CHK-SEC
      *
           .
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面をＳＰＡセット処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC            SECTION.
      *
      *
           .
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェック処理
      *****************************************************************
       4102-KIHON-CHK-SEC              SECTION.
      *
           .
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択番号入力処理
      *****************************************************************
       201-SELNUM-SEC                  SECTION.
      *
           INITIALIZE                  SPA-GMN-BODY
                                       SPA-NAI-BODY
      *
           MOVE    XG03-SELNUM         TO  SPA-GMN-SELNUM
      *
           IF    ( SPA-GMN-SELNUM  =   ZERO )
               CONTINUE
           ELSE
      *
               MOVE    ZERO        TO  SPA-NAI-SELNUM
               PERFORM VARYING IDXL    FROM    1   BY  1
                       UNTIL ( IDXL        >   SPA-GMN-MAX )
                        OR   ( SPA-NAI-SELNUM
                                           >   ZERO )
      *
                   IF    ( SPA-GMN-TNO (IDXL)
                                   =   SPA-GMN-SELNUM )
                       MOVE    IDXL
                                   TO  SPA-NAI-SELNUM
                   END-IF
      *
               END-PERFORM
      *
               IF    ( SPA-NAI-SELNUM  =    ZERO )
                   MOVE    "0001"      TO  SPA-ERRCD
                   MOVE    1           TO  SPA-GMN-CUR
               ELSE
                   PERFORM 2011-SELECT-HENSYU-SEC
                   MOVE    SPA-NAI-SELNUM
                                       TO  WRK-XG03-ROW
                   MOVE    99          TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           .
       201-SELNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者検索処理
      *****************************************************************
       2011-SELECT-HENSYU-SEC          SECTION.
      *
           MOVE    SPA-NAI-SELNUM      TO  IDXL
      *
           MOVE    SPA-NAI-TTBL-GROUP (IDXL)
                                       TO  SPA-NAI-TBL-GROUP
           MOVE    SPA-NAI-TTBL-KEY   (IDXL)
                                       TO  SPA-NAI-TBL-KEY
           MOVE    SPA-GMN-TSRYYMD    (IDXL)
                                       TO  SPA-GMN-SRYYMD
           MOVE    SPA-NAI-TSRYYMD    (IDXL)
                                       TO  SPA-NAI-SRYYMD
           MOVE    SPA-NAI-TTBL-UUID  (IDXL)
                                       TO  SPA-GMN-TBL-UUID 
           MOVE    SPA-GMN-TRENNUM    (IDXL)
                                       TO  SPA-GMN-RENNUM
           MOVE    SPA-GMN-TSHORI-RENNUM (IDXL)
                                       TO  SPA-GMN-SHORI-RENNUM
           MOVE    SPA-GMN-TLPTNUM     (IDXL)
                                       TO  SPA-GMN-PTNUM  
           MOVE    SPA-GMN-TLPTNAME    (IDXL)
                                       TO  SPA-GMN-NAME
           MOVE    SPA-NAI-LPTID       (IDXL)
                                       TO  SPA-NAI-PTID
           MOVE    SPA-GMN-TCSV-TITLE  (IDXL)
                                       TO  SPA-GMN-CSV-TITLE
      *
           .
       2011-SELECT-HENSYU-EXT.
           EXIT.
           .
      *     
      *****************************************************************
      *    患者番号入力処理
      *****************************************************************
       207-PTNUM-SEC                    SECTION.
      *
           MOVE    XG03-PTNUM       TO  SPA-GMN-PTNUM
      *
           IF    ( SPA-GMN-PTNUM    =   SPACE )
               CONTINUE
           ELSE
               PERFORM 2071-PTNUM-SEC
           END-IF
      *
           .
       207-PTNUM-EXT.
           EXIT.
      *****************************************************************
      *    患者番号入力処理
      *****************************************************************
       2071-PTNUM-SEC                   SECTION.
      *
           MOVE    SPACE           TO  SPA-GMN-NAME
           MOVE    ZERO            TO  SPA-NAI-PTID
      *
           INITIALIZE                   ORCSPTIDAREA
           MOVE    SPA-HOSPNUM     TO  SPTID-HOSPNUM
           MOVE    SPA-GMN-PTNUM
                                   TO  SPTID-PTNUM
           CALL    "ORCSPTID"      USING
                                   ORCSPTIDAREA
                                   SPA-AREA
           IF    ( SPTID-RC    NOT =   ZERO )
               MOVE    "0008"      TO  SPA-ERRCD
               MOVE    7           TO  SPA-GMN-CUR
           ELSE
               MOVE    SPTID-PTNUM TO  SPA-GMN-PTNUM
               MOVE    SPTID-PTID  TO  SPA-NAI-PTID
      *
      *        患者マスター存在チェック
               MOVE    SPA-NAI-PTID
                                   TO  WRK-PTID
               PERFORM 900-PTINF-KEY-SEL-SEC
               IF    ( FLG-PTINF   NOT =  ZERO )
                   MOVE    "0008"  TO  SPA-ERRCD
                   MOVE    7       TO  SPA-GMN-CUR
               ELSE
                   MOVE    PTINF-NAME
                                   TO  SPA-GMN-NAME
               END-IF
           END-IF
      *
           IF    ( SPA-ERRCD       =   SPACE )
               MOVE    ZERO        TO  SPA-NAI-SELNUM
               PERFORM VARYING IDXL    FROM    1   BY  1
                       UNTIL ( IDXL    >   SPA-GMN-MAX )
                         OR  ( SPA-NAI-SELNUM
                                       >   ZERO )
                   IF    ( SPA-NAI-PTID
                                       =   SPA-NAI-LPTID  (IDXL))
                       MOVE    IDXL    TO  SPA-NAI-SELNUM
                       INITIALIZE          SPA-GMN-BODY
                       MOVE    SPA-GMN-TNO (IDXL)
                                       TO  SPA-GMN-SELNUM
                       PERFORM 2011-SELECT-HENSYU-SEC
                       MOVE    SPA-NAI-SELNUM
                                       TO  WRK-XG03-ROW
                       MOVE    99      TO  SPA-GMN-CUR
                   END-IF
               END-PERFORM
      *
               IF    ( SPA-NAI-SELNUM  =   ZERO )
                   INITIALIZE              SPA-GMN-BODY1
                                           SPA-NAI-BODY1
                   MOVE    "0009"      TO  SPA-ERRCD
                   MOVE    7           TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           .
       2071-PTNUM-EXT.
           EXIT.
      *****************************************************************
      *    診療年月日入力処理
      *****************************************************************
       209-CREYMD-SEC               SECTION.
      *
           MOVE    XG03-CREYMD      TO  SPA-GMN-CREYMD
           MOVE    SPACE            TO  SPA-NAI-CREYMD
      *
           IF    ( SPA-GMN-CREYMD   =   SPACE )
               MOVE    SPA-NAI-SMCNDATE-YMD
                                    TO  SPA-NAI-CREYMD
               MOVE    SPA-GMN-SMCNDATE-YMD
                                    TO  SPA-GMN-CREYMD
           ELSE
      *        日付画面チェックサブ
               INITIALIZE               ORCSGDAYAREA
               MOVE    SPA-GMN-CREYMD
                                    TO  SGDAY-INDAY
               CALL    "ORCSGDAY"   USING
                                    ORCSGDAYAREA
               IF    ( SGDAY-RC     =   ZERO )
                   MOVE    SGDAY-OTDAY  TO  SPA-GMN-CREYMD
                   MOVE    SGDAY-SDAY   TO  SPA-NAI-CREYMD
               ELSE
                   MOVE    "0010"   TO  SPA-ERRCD
                   MOVE    8        TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-ERRCD        =   SPACE )
               IF    ( SPA-NAI-CREYMD-OLD
                                NOT =   SPA-NAI-CREYMD )
                   MOVE    SPA-NAI-CREYMD
                                    TO  SPA-NAI-CREYMD-OLD
                   PERFORM 420-CLEAR-SEC
                   MOVE    1        TO  SPA-GMN-PAGE
      *            コラムリストの編集
                   PERFORM 3101-SPA-LIST-HEN-SEC
               ELSE
                   IF    ( SPA-GMN-MAX  >   ZERO )
                       MOVE    1    TO  SPA-GMN-CUR
                   ELSE
                       MOVE    8    TO  SPA-GMN-CUR
                   END-IF
               END-IF
           ELSE
               MOVE   SPACE         TO  SPA-NAI-CREYMD-OLD
           END-IF
      *
           .
       209-CREYMD-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       203-SELECT-SEC              SECTION.
      *
           INITIALIZE              SPA-GMN-BODY
                                   SPA-NAI-BODY
      *
           PERFORM VARYING IDXL    FROM    1   BY  1
                   UNTIL ( IDXL    >   SPA-GMN-MAX )
                    OR   ( SPA-NAI-SELNUM
                                   >   ZERO )
               IF    ( XG03-SELECT (IDXL)   =   "T" )
                   MOVE    SPA-GMN-TNO (IDXL)
                                   TO  XG03-SELNUM
                   PERFORM 201-SELNUM-SEC
                   MOVE    ZERO    TO  WRK-XG03-ROW
               END-IF
           END-PERFORM
      *
           MOVE    99              TO  SPA-GMN-CUR
      *
           .
       203-SELECT-EXT.
           EXIT.
      *     
      *****************************************************************
      *    更新前チェック処理
      *****************************************************************
       4103-KAKUTEI-CHK-SEC        SECTION.
      *
           IF    ( SPA-NAI-TBL-GROUP   =   SPACE )
               MOVE    "0001"      TO  SPA-ERRCD
           END-IF
      *
           .
       4103-KAKUTEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           PERFORM 210-BACK-SYORI-SEC
           .
       210-BACK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    戻る処理
      *****************************************************************
       210-BACK-SYORI-SEC              SECTION.
      *
           MOVE    "M01"               TO  SPA-SAKIPG
           MOVE    "XG03"              TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  SPA-WORK 
           INITIALIZE                  SPA-KYOTUKEY
                                       SPA-KYOTU-SET
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
      *****************************************************************
      *    クリア処理
      *****************************************************************
       420-CLEAR-SEC                SECTION.
      *
           INITIALIZE               SPA-GMN-BODY
                                    SPA-NAI-BODY
      *
           MOVE    1            TO  SPA-GMN-CUR
      *
           .
       420-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理
      *****************************************************************
       430-DELETE-GID-SEC                SECTION.
      *
      *    入力チェック
           PERFORM 410-INPUT-CHK-SEC
      *
      *    更新前
           IF    ( SPA-ERRCD   =   SPACE )
               PERFORM 4103-KAKUTEI-CHK-SEC
           END-IF
      *
           IF    ( SPA-ERRCD   =   SPACE )
      *
      *        帳票管理ＤＢのチェック
               PERFORM 900-MNOTE-H-KEY3-SEL-SEC
      *
               MOVE    SPACE       TO  SPA-WRK-TBL-KEY
      *
      *        未処理の帳票があるとき
               PERFORM UNTIL ( FLG-MNOTE-H    =   1 )
      *
                   MOVE    MNOTE-H-TBL-KEY
                                       TO  SPA-WRK-TBL-KEY
      *
                   IF    ( MNOTE-H-PUTFLG     =   SPACE )
                       MOVE    "3003"  TO  SPA-XGIDCD
                       MOVE    1       TO  FLG-MNOTE-H
                   END-IF
      *
                   PERFORM 900-MNOTE-H-KEY3-FET-SEC
      *
               END-PERFORM
      *
               MOVE    "tbl_mnote_h"   TO  MCP-TABLE
               MOVE    "key3"              TO  MCP-PATHNAME
               PERFORM 910-DBCLOSECURSOR-SEC
      *
      *        指定のグループが存在しないとき
               IF    ( SPA-WRK-TBL-KEY =   SPACE )
                       MOVE    "0005"  TO  SPA-ERRCD
               ELSE
                   IF    ( SPA-XGIDCD  =   SPACE )
      *                ガイドメッセージセット
                       MOVE    "3002"  TO  SPA-XGIDCD
                   END-IF
               END-IF
      *
           END-IF
      *
           .
       430-DELETE-GID-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除処理
      *****************************************************************
       430-DELETE-SEC                SECTION.
      *
           INITIALIZE                      MNOTE-H-REC
           MOVE    SPA-WRK-TBL-KEY     TO  MNOTE-H-TBL-KEY
           MOVE    SPA-NAI-TBL-GROUP   TO  MNOTE-H-TBL-GROUP
           MOVE    SPA-GMN-TBL-UUID    TO  MNOTE-H-TBL-UUID 
           MOVE    SPA-GMN-SHORI-RENNUM
                                       TO  MNOTE-H-SHORI-RENNUM
           MOVE    SPA-GMN-RENNUM      TO  MNOTE-H-RENNUM
           MOVE    SPA-HOSPNUM         TO  MNOTE-H-HOSPNUM
           MOVE    MNOTE-H-REC     TO  MCPDATA-REC
           MOVE    "tbl_mnote_h"   TO  MCP-TABLE
           MOVE    "del2"              TO  MCP-PATHNAME
           PERFORM 910-DBDELETE-SEC
           IF    ( MCP-RC         NOT  =   ZERO )
               MOVE    "1001"          TO  SPA-ERRCD
           END-IF
      *
           IF    ( SPA-ERRCD           =   SPACE )
               INITIALIZE                  MNOTE-B-REC
               MOVE    SPA-WRK-TBL-KEY     TO  MNOTE-B-TBL-KEY
               MOVE    SPA-NAI-TBL-GROUP   TO  MNOTE-B-TBL-GROUP
               MOVE    SPA-GMN-TBL-UUID    TO  MNOTE-B-TBL-UUID
               MOVE    SPA-GMN-SHORI-RENNUM
                                           TO  MNOTE-B-SHORI-RENNUM
               MOVE    SPA-GMN-RENNUM      TO  MNOTE-B-RENNUM
               MOVE    SPA-HOSPNUM         TO  MNOTE-B-HOSPNUM
               MOVE    MNOTE-B-REC     TO  MCPDATA-REC
               MOVE    "DBDELETE"          TO  MCP-FUNC
               MOVE    "tbl_mnote_b"   TO  MCP-TABLE
               MOVE    "del2"              TO  MCP-PATHNAME
               PERFORM 910-DBDELETE-SEC
               IF      MCP-RC         NOT  =   ZERO
                   MOVE    "1002"              TO  SPA-ERRCD
               END-IF
           END-IF
      *
           IF    ( SPA-ERRCD               =   SPACE )
               PERFORM 470-REFRESH-SEC
           END-IF
      *
           .
       430-DELETE-EXT.
           EXIT.
      *
      *****************************************************************
      *    前日処理
      *****************************************************************
       440-BEFORE-SEC                  SECTION.
      *
           MOVE    ZERO            TO  FLG-NEXT
           PERFORM 4401-CHANGE-DATE-SEC
      *
           .
       440-BEFORE-EXT.
           EXIT.
      *
      *****************************************************************
      *    次日処理
      *****************************************************************
       450-NEXT-SEC                    SECTION.
      *
           MOVE    1               TO  FLG-NEXT
           PERFORM 4401-CHANGE-DATE-SEC
      *
           .
       450-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    日付変更処理
      *****************************************************************
       4401-CHANGE-DATE-SEC            SECTION.
      *
          INITIALIZE                   SPA-GMN-BODY
                                       SPA-GMN-TBL
                                       SPA-NAI-BODY
                                       SPA-NAI-TBL
      *
           MOVE    1                   TO  SPA-GMN-PAGE
      *
           MOVE    SPA-NAI-CREYMD      TO  WRK-YMD
           MOVE    "1"                 TO  WRK-ZOGENPTN
      *
           IF    ( FLG-NEXT            =   1 )
               MOVE    1               TO  WRK-ZOGEN
           ELSE
               MOVE    -1              TO  WRK-ZOGEN
           END-IF
      *
           PERFORM 800-CALENDAR-SEC
           MOVE    LNK-DAY6-KEISAN     TO  SPA-NAI-CREYMD
                                           SPA-NAI-CREYMD-OLD
      *    コラムリストの編集
           PERFORM 3101-SPA-LIST-HEN-SEC
      *
           PERFORM 470-EDIT-CREYMD-SEC
      *
           .
       4401-CHANGE-DATE-EXT.
           EXIT.
      *****************************************************************
      *    前頁処理
      *****************************************************************
       440-BACK-PAGE-SEC               SECTION.
      *
           IF    ( SPA-GMN-PAGE    >   1 )
               MOVE    ZERO        TO  FLG-NEXT
               PERFORM 4401-CHANGE-PAGE-SEC
           END-IF
      *
           .
       440-BACK-PAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    次頁処理
      *****************************************************************
       450-NEXT-PAGE-SEC           SECTION.
      *
           IF    ( SPA-GMN-TBL-NEXT    =   1 )
               MOVE    1           TO  FLG-NEXT
               PERFORM 4401-CHANGE-PAGE-SEC
           END-IF
      *
           .
       450-NEXT-PAGE-EXT.
           EXIT.
      *
      *****************************************************************
      *    頁変更処理
      *****************************************************************
       4401-CHANGE-PAGE-SEC        SECTION.
      *
           INITIALIZE              SPA-GMN-BODY
                                   SPA-GMN-TBL
                                   SPA-NAI-BODY
                                   SPA-NAI-TBL
      *
           IF    ( FLG-NEXT            =   1 )
               COMPUTE     SPA-GMN-PAGE
                   =       SPA-GMN-PAGE
                   +       1
           ELSE
               COMPUTE     SPA-GMN-PAGE
                   =       SPA-GMN-PAGE
                   -       1
           END-IF
      *
      *    コラムリストの編集
           PERFORM 3101-SPA-LIST-HEN-SEC
      *
           .
       4401-CHANGE-PAGE-EXT.
           EXIT.
      *****************************************************************
      *    状態変更処理
      *****************************************************************
       450-CHANGE-STATUS-SEC       SECTION.
      *
      *    入力チェック
           PERFORM 410-INPUT-CHK-SEC
      *
      *    更新前
           IF    ( SPA-ERRCD   =   SPACE )
               PERFORM 4103-KAKUTEI-CHK-SEC
           END-IF
      *
           IF    ( SPA-NAI-SELNUM  >   ZERO )
               IF    ( SPA-NAI-TPUTFLG (SPA-NAI-SELNUM)
                                   =  SPACE )
                   MOVE    "3004"      TO SPA-XGIDCD
               ELSE
                   MOVE    "3005"      TO SPA-XGIDCD
               END-IF
           END-IF
      *
           .
       450-CHANGE-STATUS-EXT.
           EXIT.
      *****************************************************************
      *    状態変更処理
      *****************************************************************
       4501-CHANGE-STATUS-SEC      SECTION.
      *
           PERFORM 800-ORCSMCNDATE-SEC
      *
           INITIALIZE                      MNOTE-H-REC
           MOVE    SPA-NAI-TBL-KEY     TO  MNOTE-H-TBL-KEY
           MOVE    SPA-NAI-TBL-GROUP   TO  MNOTE-H-TBL-GROUP
           MOVE    SPA-GMN-TBL-UUID    TO  MNOTE-H-TBL-UUID 
           MOVE    SPA-GMN-SHORI-RENNUM
                                       TO  MNOTE-H-SHORI-RENNUM
           MOVE    SPA-GMN-RENNUM      TO  MNOTE-H-RENNUM
           MOVE    SPA-HOSPNUM         TO  MNOTE-H-HOSPNUM
           IF    ( FLG-SENT            =   1 )
               MOVE    "1"             TO  MNOTE-H-PUTFLG
           ELSE
               MOVE    SPACE           TO  MNOTE-H-PUTFLG
           END-IF
           MOVE    SMCNDATE-YMD        TO  MNOTE-H-UPYMD
           MOVE    SMCNDATE-HMS        TO  MNOTE-H-UPHMS
           MOVE    MNOTE-H-REC     TO  MCPDATA-REC
           MOVE    "tbl_mnote_h"   TO  MCP-TABLE
           MOVE    "upd1"              TO  MCP-PATHNAME
           PERFORM 910-DBUPDATE-SEC
           IF    ( MCP-RC         NOT  =   ZERO )
               MOVE    "1003"          TO  SPA-ERRCD
           END-IF
      *
           PERFORM 470-REFRESH-SEC
      *
           .
       4501-CHANGE-STATUS-EXT.
           EXIT.
      *****************************************************************
      *    リフレッシュ処理
      *****************************************************************
       470-REFRESH-SEC                 SECTION.
      *
          INITIALIZE               SPA-GMN-BODY
                                   SPA-GMN-TBL
                                   SPA-NAI-BODY
                                   SPA-NAI-TBL
           PERFORM 3101-SPA-LIST-HEN-SEC
      *
           .
       470-REFRESH-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療日編集処理
      *****************************************************************
       470-EDIT-CREYMD-SEC             SECTION.
      *
           MOVE    SPA-NAI-CREYMD  TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-CREYMD
      *
           .
       470-EDIT-CREYMD-EXT.
           EXIT.
      *****************************************************************
      *    クライアント保存
      *****************************************************************
       460-SAVE-SEC                    SECTION.
      *
           IF    ( SPA-ERRCD           =   SPACE )
               IF    ( SPA-NAI-PTID    =   ZERO )
                   MOVE    "0101"      TO  SPA-ERRCD
                   MOVE    1           TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-ERRCD           =   SPACE )
               PERFORM 4601-SAVE-SEC
           END-IF
      *
           .
       460-SAVE-EXT.
           EXIT.
      *****************************************************************
      *    クライアント保存
      *****************************************************************
       4601-SAVE-SEC                   SECTION.
      *
      *    帳票管理ＤＢのチェック
           PERFORM 900-MNOTE-H-KEY3-SEL-SEC
           IF    ( FLG-MNOTE-H     =   ZERO )
      *
               MOVE    SPACE           TO  ASS-CSVDATA
      *
               PERFORM 800-ORCSMCNDATE-SEC
      *
               PERFORM 800-ORCUIDSET-SEC
      *
               STRING  "/tmp/"         DELIMITED BY SIZE
                       "/okusuri_techo-"
                                       DELIMITED BY SIZE
                       SMCNDATE-YMD    DELIMITED BY SIZE
                       "-"             DELIMITED BY SIZE
                       SMCNDATE-HMS    DELIMITED BY SIZE
                       "-"             DELIMITED BY SIZE
                       UIDIO-UID       DELIMITED BY SPACE
                       ".csv"          DELIMITED BY SIZE
               INTO    ASS-CSVDATA
               END-STRING
      *
               OPEN    OUTPUT          CSVDATA-FILE
      *
               PERFORM 900-MNOTE-B-KEY2-SEL-SEC
      *
               PERFORM UNTIL ( FLG-MNOTE-B NOT =   ZERO )
      *
                   MOVE    MNOTE-B-CSVDATA
                                       TO  CSVDATA-REC
                   WRITE   CSVDATA-REC
      *
                   PERFORM 900-MNOTE-B-KEY2-FET-SEC
      *
               END-PERFORM
      *
               MOVE    "tbl_mnote_b"   TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 910-DBCLOSECURSOR-SEC
      *
               CLOSE   CSVDATA-FILE
      *
               INITIALIZE                      ORCSFILEENCODEAREA
               MOVE    ASS-CSVDATA         TO  FLEN-INFILENAME
               STRING  ASS-CSVDATA             DELIMITED BY SPACE
                       ".sjis"                 DELIMITED BY SIZE
               INTO    FLEN-OUTFILENAME
               END-STRING
               MOVE    "3"                 TO  FLEN-OPTION
               CALL    "orcfileencode"     USING
                                           ORCSFILEENCODEAREA
      *
               INITIALIZE                      ORCA-BLOB
               MOVE    "key"               TO  MCP-PATHNAME
               MOVE    "blob"              TO  MCP-TABLE
               MOVE    FLEN-OUTFILENAME    TO  ORCA-BLOB-FILE
               PERFORM 910-BLOBIMPORT-SEC
               MOVE    ORCA-BLOB-OBJECT    TO  WRK-OBJECTDATA
               MOVE    MNOTE-H-TO-DATA     TO  WRK-DL-FILENAME
      *
               MOVE    FLEN-INFILENAME     TO  WRK-DEL-FILENAME
               PERFORM 800-ORCFILEDEL-SEC
      *
               MOVE    FLEN-OUTFILENAME    TO  WRK-DEL-FILENAME
               PERFORM 800-ORCFILEDEL-SEC
      *
           END-IF
      *
           MOVE    "tbl_mnote_h"       TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       4601-SAVE-EXT.
           EXIT.
      *****************************************************************
      *    リセット処理
      *****************************************************************
       460-RESET-SEC                   SECTION.
      *
           MOVE    SPACE           TO  ASS-CSVDATA
      *
           PERFORM 800-ORCUIDSET-SEC
      *
           STRING  "/tmp/"         DELIMITED BY SIZE
                   "/okusuri_techo-reset-"
                   UIDIO-UID       DELIMITED BY SPACE
                   ".ksr"          DELIMITED BY SIZE
           INTO    ASS-CSVDATA
           END-STRING
      *
           OPEN    OUTPUT          CSVDATA-FILE
           MOVE    SPACE           TO  CSVDATA-REC
           WRITE   CSVDATA-REC
      *
           CLOSE   CSVDATA-FILE
      *
           INITIALIZE                      ORCA-BLOB
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    "blob"              TO  MCP-TABLE
           MOVE    ASS-CSVDATA         TO  ORCA-BLOB-FILE
           PERFORM 910-BLOBIMPORT-SEC
           MOVE    ORCA-BLOB-OBJECT    TO  WRK-OBJECTDATA
           MOVE    "okusuri_techo-reset.ksr"
                                       TO  WRK-DL-FILENAME
      *
           MOVE    1                   TO  FLG-RESET
      *
           MOVE    ASS-CSVDATA         TO  WRK-DEL-FILENAME
           PERFORM 800-ORCFILEDEL-SEC
      *
           .
       460-RESET-EXT.
           EXIT.
      *****************************************************************
      *    送信処理
      *****************************************************************
       460-SEND-SEC                    SECTION.
      *
           IF    ( SPA-ERRCD           =   SPACE )
               IF    ( SPA-NAI-PTID    =   ZERO )
                   MOVE    "0101"      TO  SPA-ERRCD
                   MOVE    1           TO  SPA-GMN-CUR
               END-IF
           END-IF
      *
           IF    ( SPA-ERRCD           =   SPACE )
               PERFORM 4601-SEND-SEC
           END-IF
      *
           .
       460-SEND-EXT.
           EXIT.
      *****************************************************************
      *    送信処理
      *****************************************************************
       4601-SEND-SEC                   SECTION.
      *
           MOVE    SPA-NAI-PTID        TO  WRK-PTID
           PERFORM 900-PTINF-KEY-SEL-SEC
           IF    ( PTINF-BIRTHDAY      <   SPA-NAI-SMCNDATE-YMD )
               MOVE    ZERO            TO  WRK-AGE
           ELSE
               MOVE    SPA-NAI-SMCNDATE-YMD
                                       TO  WRK-YMD1
               MOVE    PTINF-BIRTHDAY  TO  WRK-YMD2
               COMPUTE WRK-AGE     =   WRK-YY2
                                   -   WRK-YY1
               IF    ( WRK-YMD1(5:4)  >   WRK-YMD2(5:4) )
                   COMPUTE WRK-AGE    =   WRK-AGE
                                      -   1
               END-IF
           END-IF
      *
      *
      *    帳票管理ＤＢのチェック
           PERFORM 900-MNOTE-H-KEY3-SEL-SEC
           IF    ( FLG-MNOTE-H     =   ZERO )
      *
               MOVE    SPACE           TO  ASS-CSVDATA
      *
               PERFORM 800-ORCSMCNDATE-SEC
      *
               PERFORM 800-ORCUIDSET-SEC
      *
               STRING  "/tmp/"         DELIMITED BY SIZE
                       "/okusuri_techo-"
                                       DELIMITED BY SIZE
                       SMCNDATE-YMD    DELIMITED BY SIZE
                       "-"             DELIMITED BY SIZE
                       SMCNDATE-HMS    DELIMITED BY SIZE
                       "-"             DELIMITED BY SIZE
                       UIDIO-UID       DELIMITED BY SPACE
                       ".ksr"          DELIMITED BY SIZE
               INTO    ASS-CSVDATA
               END-STRING
      *
               OPEN    OUTPUT          CSVDATA-FILE
      *
               PERFORM 46011-HEADER-EDIT-SEC
      *
               MOVE    "{{{"           TO  CSVDATA-REC
               WRITE   CSVDATA-REC
      *
               PERFORM 900-MNOTE-B-KEY2-SEL-SEC
      *
               PERFORM UNTIL ( FLG-MNOTE-B NOT =   ZERO )
      *
                   MOVE    MNOTE-B-CSVDATA
                                       TO  CSVDATA-REC
                   WRITE   CSVDATA-REC
      *
                   PERFORM 900-MNOTE-B-KEY2-FET-SEC
      *
               END-PERFORM
      *
               MOVE    "tbl_mnote_b"   TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 910-DBCLOSECURSOR-SEC
      *
               MOVE    "}}}"           TO  CSVDATA-REC
               WRITE   CSVDATA-REC
      *
               CLOSE   CSVDATA-FILE
      *
               INITIALIZE                      ORCSFILEENCODEAREA
               MOVE    ASS-CSVDATA         TO  FLEN-INFILENAME
               STRING  ASS-CSVDATA             DELIMITED BY SPACE
                       ".sjis"                 DELIMITED BY SIZE
               INTO    FLEN-OUTFILENAME
               END-STRING
               MOVE    "3"                 TO  FLEN-OPTION
               CALL    "orcfileencode"     USING
                                           ORCSFILEENCODEAREA
      *
               INITIALIZE                      ORCA-BLOB
               MOVE    "key"               TO  MCP-PATHNAME
               MOVE    "blob"              TO  MCP-TABLE
               MOVE    FLEN-OUTFILENAME    TO  ORCA-BLOB-FILE
               PERFORM 910-BLOBIMPORT-SEC
               MOVE    ORCA-BLOB-OBJECT    TO  WRK-OBJECTDATA
               MOVE    "okusuri_techo.ksr"
                                           TO  WRK-DL-FILENAME
      *
               MOVE    SPA-GMN-NAME    TO  WRK-NAME
      *
               MOVE    1               TO   FLG-SENT
               PERFORM 4501-CHANGE-STATUS-SEC
      *
               MOVE    1               TO  FLG-SENDDATA
      *
               MOVE    FLEN-INFILENAME TO  WRK-DEL-FILENAME
               PERFORM 800-ORCFILEDEL-SEC
      *
               MOVE    FLEN-OUTFILENAME TO  WRK-DEL-FILENAME
               PERFORM 800-ORCFILEDEL-SEC
      *
           END-IF
      *
           MOVE    "tbl_mnote_h"       TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       4601-SEND-EXT.
           EXIT.
      *****************************************************************
      *    ヘッダー編集処理
      *****************************************************************
       46011-HEADER-EDIT-SEC           SECTION.
      *
           MOVE    SPACE               TO  CSVDATA-REC
           STRING  "id="               DELIMITED BY SIZE
                   SPA-GMN-PTNUM       DELIMITED BY SPACE
           INTO    CSVDATA-REC
           END-STRING
           WRITE   CSVDATA-REC
      *
           MOVE    SPACE               TO  CSVDATA-REC
           STRING  "name="             DELIMITED BY SIZE
                   SPA-GMN-NAME        DELIMITED BY SPACE
           INTO    CSVDATA-REC
           END-STRING
           WRITE   CSVDATA-REC
      *
           MOVE    WRK-AGE-G           TO  WRK-AGE-X
           EVALUATE    TRUE
           WHEN   ( WRK-AGE             <  10 )
               MOVE    WRK-AGE-G (3:)  TO  WRK-AGE-X
           WHEN   ( WRK-AGE             <  100 )
               MOVE    WRK-AGE-G (2:)  TO  WRK-AGE-X
           END-EVALUATE
           MOVE    SPACE               TO  CSVDATA-REC
           STRING  "age="              DELIMITED BY SIZE
                   WRK-AGE-X           DELIMITED BY SPACE
           INTO    CSVDATA-REC
           END-STRING
           WRITE   CSVDATA-REC
      *
           IF    ( PTINF-SEX           =   "1" )
               MOVE    "gender=male"   TO  CSVDATA-REC
               WRITE   CSVDATA-REC
           ELSE
               MOVE    "gender=female" TO  CSVDATA-REC
               WRITE   CSVDATA-REC
           END-IF
      *
           MOVE    "mime=application/x-medication-note"
                                       TO  CSVDATA-REC
           WRITE   CSVDATA-REC
      *
           MOVE    "charset=Shift-JIS"
                                       TO  CSVDATA-REC
           WRITE   CSVDATA-REC
      *
           .
       46011-HEADER-EDIT-EXT.
           EXIT.
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
           IF      SPA-XGIDCD       NOT =   SPACE
               PERFORM 520-TIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "XG03    "          TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面内容編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           IF    ( WRK-XG03-ROW        >   ZERO )
               MOVE    WRK-XG03-ROW    TO  WRK-LIST-ROW
               MOVE    2               TO  FLG-LIST-ROW
           ELSE
               MOVE    XG03-ROW        TO  WRK-LIST-ROW
           END-IF
      *
           MOVE    SPACE               TO  XG03
           INITIALIZE                      XG03
      *
           EVALUATE    FLG-LIST-ROW
           WHEN    1
               MOVE    ZERO            TO  XG03-ROW
               MOVE    ZERO            TO  XG03-ROWATTR
           WHEN    2
               MOVE    WRK-LIST-ROW    TO  XG03-ROW
               MOVE    2               TO  XG03-ROWATTR
           WHEN    OTHER
               MOVE    WRK-LIST-ROW    TO  XG03-ROW
               MOVE    ZERO            TO  XG03-ROWATTR
           END-EVALUATE
      *
           MOVE    SPA-GMN-TITLE1      TO  XG03-HEAD1
           MOVE    SPA-GMN-TITLE2      TO  XG03-HEAD2
      *
           MOVE    SPA-GMN-SELNUM      TO  XG03-SELNUM
      *
           MOVE    "blue"              TO  XG03-LBLSRYYMD-STYLE
                                           XG03-SRYYMD-STYLE
      *
           IF    ( SPA-NAI-SRYYMD  NOT =   SPACE )
            AND  ( SPA-NAI-SRYYMD  NOT =   SPA-NAI-SMCNDATE-YMD )
               MOVE    "診療年月日"    TO  XG03-LBLSRYYMD
               MOVE    SPA-GMN-SRYYMD  TO  XG03-SRYYMD
           END-IF
      *
           PERFORM VARYING     IDXL    FROM    1   BY  1
                   UNTIL       IDXL        >   SPA-GMN-MAX
      *
               MOVE    SPA-GMN-TNO (IDXL)
                                       TO  WRK-ZZ
               MOVE    WRK-ZZ          TO  XG03-TNO    (IDXL)
      *
               IF    ( IDXL            =   1 )
                OR   ( SPA-GMN-TTBL-GROUP (IDXL)
                                   NOT = SPA-GMN-TTBL-GROUP (IDXL - 1))
      *
                   MOVE    SPA-GMN-TGYOUMU   (IDXL)
                                           TO  XG03-GYOMUNM   (IDXL)
                   MOVE    SPA-GMN-TTBL-GROUP (IDXL) (1:8)
                                           TO  WRK-SYMD
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG     TO  XG03-SAKU-YMD(IDXL)
                   STRING  SPA-GMN-TTBL-GROUP(IDXL)(9:2)
                                               DELIMITED  BY  SIZE
                           ":"                 DELIMITED  BY  SIZE
                           SPA-GMN-TTBL-GROUP(IDXL)(11:2)
                                               DELIMITED  BY  SIZE
                           ":"                 DELIMITED  BY  SIZE
                           SPA-GMN-TTBL-GROUP(IDXL)(13:2)
                                               DELIMITED  BY  SIZE
                   INTO    XG03-SAKU-TIME(IDXL)
                   END-STRING
                   MOVE    SPA-GMN-TSRYYMD (IDXL)
                                           TO  XG03-TSRYYMD(IDXL)
               END-IF
      *        MOVE    SPA-GMN-TCNT (IDXL) TO  WRK-CNT
      *        MOVE    WRK-CNT             TO  XG03-TCNT   (IDXL)
      *
               MOVE    SPA-GMN-TLPTNUM   (IDXL)
                                           TO  XG03-LPTNUM (IDXL)
               MOVE    SPA-GMN-TLDRNAME(IDXL)
                                           TO  XG03-DRNAME    (IDXL)
               MOVE    SPA-GMN-TLPTNAME  (IDXL)
                                           TO  XG03-PTNAME    (IDXL)
               IF    ( SPA-NAI-TPUTFLG (IDXL)
                                           =   SPACE )
                   MOVE    "未送信"        TO  XG03-TSTATUS   (IDXL)
               ELSE
                   MOVE    "送信済"        TO  XG03-TSTATUS   (IDXL)
               END-IF
      *
               IF    ( IDXL                =   SPA-NAI-SELNUM )
                   MOVE    "T"             TO  XG03-SELECT (IDXL)
               ELSE
                   MOVE    "F"             TO  XG03-SELECT (IDXL)
               END-IF
      *
           END-PERFORM
      *
           MOVE    SPA-GMN-MAX         TO  XG03-COUNT
      *
           MOVE    SPA-GMN-PTNUM       TO  XG03-PTNUM 
           MOVE    "blue"              TO  XG03-PTNAME-STYLE
           MOVE    SPA-GMN-NAME        TO  XG03-PTNAME-VALUE
      *
           MOVE    SPA-GMN-CREYMD      TO  XG03-CREYMD
      *
           MOVE    WIDGET-NORMAL       TO  XG03-B06S-STATE
                                           XG03-B07S-STATE
                                           XG03-B09-STATE
                                           XG03-B11-STATE
                                           XG03-B12-STATE
      *
           IF    ( SPA-NAI-SELNUM      >   ZERO )
               IF    ( SPA-NAI-TPUTFLG(SPA-NAI-SELNUM)
                                       =   SPACE )
                   MOVE    "済に変更"  TO  XG03-B10-LABEL
               ELSE
                   MOVE    "未に変更"  TO  XG03-B10-LABEL
               END-IF
           END-IF
      *
           IF    ( SPA-GMN-PAGE        =   1 )
               MOVE    WIDGET-INSENSITIVE
                                       TO  XG03-B06S-STATE
           END-IF
      *
           IF    ( SPA-GMN-TBL-NEXT    =   ZERO )
               MOVE    WIDGET-INSENSITIVE
                                       TO  XG03-B07S-STATE
           END-IF
      *
           IF    ( SPA-NAI-CLIENT-SAVE NOT =   "1" )
               MOVE    WIDGET-INSENSITIVE
                                       TO  XG03-B09-STATE
           END-IF
      *
           IF    ( SPA-NAI-ICCARDRW    NOT =   "1" )
               MOVE    WIDGET-INSENSITIVE
                                       TO  XG03-B11-STATE
                                           XG03-B12-STATE
           END-IF
      *
           MOVE    "blue"              TO  XG03-LBLMSG01-STYLE
           EVALUATE    TRUE
           WHEN  ( FLG-SENDDATA        =   1 )
               STRING  WRK-NAME        DELIMITED   BY  SPACE
                       "様のお薬手帳データを送信しました。"
                                       DELIMITED   BY  SIZE
               INTO    XG03-LBLMSG01
               END-STRING
           WHEN  ( FLG-RESET           =   1 )
               MOVE    "送信情報をリセットしました。"
                                       TO  XG03-LBLMSG01
           END-EVALUATE
      *
           MOVE    WRK-OBJECTDATA      TO  XG03-OBJECTDATA
           MOVE    WRK-DL-FILENAME     TO  XG03-FILENAME
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
           IF    ( SPA-ERRCD       =   SPACE )
           AND   ( SPA-GMN-CUR     =   ZERO  )
               PERFORM 50011-INPUT-CUR-SEC
           END-IF
      *
           EVALUATE    SPA-GMN-CUR
           WHEN    1
               MOVE    "SELNUM"   TO  MCP-WIDGET
           WHEN    7
               MOVE    "PTNUM"    TO  MCP-WIDGET
           WHEN    8
               MOVE    "CREYMD"   TO  MCP-WIDGET
           WHEN    99
               MOVE    "B12"      TO  MCP-WIDGET
           END-EVALUATE
          .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       50011-INPUT-CUR-SEC         SECTION.
      *
           EVALUATE    WRK-MCP-WIDGET
           WHEN    "SELNUM"
               MOVE    8          TO  SPA-GMN-CUR
           END-EVALUATE
      *
           .
      *
       50011-INPUT-CUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
           WHEN    "0001"
               MOVE    "該当の選択番号はありません" 
                                               TO  SPA-ERRMSG
           WHEN    "0005"
               MOVE    "該当の電送用のお薬情報が存在しません" 
                                               TO  SPA-ERRMSG
           WHEN    "0008"
               MOVE    "該当の患者が存在しません"
                                               TO  SPA-ERRMSG
           WHEN    "0009"
               MOVE    "該当患者の電送データはありません"
                                               TO  SPA-ERRMSG
           WHEN    "0010"
               MOVE    "診療年月日入力エラー"
                                               TO  SPA-ERRMSG
           WHEN    "0101"
               MOVE    "番号を選択してください"
                                               TO  SPA-ERRMSG
           WHEN    "1001"  THRU  "1003"
               MOVE    "更新処理に失敗しました"
                                               TO  SPA-ERRMSG
           WHEN    "8888"
                   MOVE
                   "　　開　　発　　中!!(しばらくお待ち下さい)"
                                               TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  XGERR
           MOVE    SPA-ERRCD            TO  XGERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  XGERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "XG03"                TO  SPA-MOTOPG
           MOVE    "XGERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                 TO  MCP-PUTTYPE
           MOVE    "XGERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       520-TIDSET-SEC              SECTION.
      *
           MOVE    SPACE                TO  WRK-XGIDMSG
      *
           MOVE    "B12"                TO  MCP-WIDGET
      *
           EVALUATE    SPA-XGIDCD
           WHEN    "3002"
              MOVE    "電送用のお薬情報を削除します"
                                       TO  WRK-XGIDMSG
               MOVE    "B01"           TO  MCP-WIDGET
           WHEN    "3003"
               MOVE    "未送信のデータですが削除しますか"
                                       TO  WRK-XGIDMSG
               MOVE    "B01"           TO  MCP-WIDGET
           WHEN    "3004"
               MOVE    "送信済に変更します。よろしいですか"
                                       TO  WRK-XGIDMSG
           WHEN    "3005"
               MOVE    "未送信に変更します。よろしいですか"
                                       TO  WRK-XGIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  XGID1
           MOVE    SPA-XGIDCD           TO  XGID1-ID1CODE
           MOVE    WRK-XGIDMSG          TO  XGID1-ID1MSG
      *
           MOVE    "XG03"               TO  SPA-MOTOPG
           MOVE    "XGID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "XGID1"              TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-TIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    カレンダー処理
      *****************************************************************
       800-CALENDAR-SEC                SECTION.
      *
      *    増減パターン 1:日／2:月／3:年
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY6-AREA
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    WRK-YMD             TO  LNK-DAY6-KIJUN
           MOVE    WRK-ZOGENPTN        TO  LNK-DAY6-ZOGENPTN
           MOVE    WRK-ZOGEN           TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY6-AREA
      *    MOVE    LNK-DAY6-KEISAN     TO  WRK-KEISANYMD
      *
           .
       800-CALENDAR-EXT.
           EXIT.
      *****************************************************************
      *    マシン日付取得
      *****************************************************************
       800-ORCSMCNDATE-SEC                SECTION.
      *
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *
           .
       800-ORCSMCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＵＵＩＤ取得
      *****************************************************************
       800-ORCUIDSET-SEC               SECTION.
      *
           INITIALIZE                  UIDIO-AREA
           CALL    "orcuidset" USING
                               UIDIO-ST
                               UIDIO-AREA
      *
           .
       800-ORCUIDSET-EXT.
           EXIT.
      *****************************************************************
      *    ファイル削除処理
      *****************************************************************
       800-ORCFILEDEL-SEC              SECTION.
      *
           MOVE    ZERO            TO  IF-RESULT
           MOVE    WRK-DEL-FILENAME TO IF-FILENAME
           CALL    "orcfiledel"    USING   ORCSFDELAREA
      *
           .
       800-ORCFILEDEL-EXT.
           EXIT.
      *****************************************************************
      *    統計ＣＳＶ格納管理検索処理
      *****************************************************************
       900-MNOTE-H-KEY3-SEL-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-MNOTE-H
      *
           INITIALIZE                      MNOTE-H-REC
      *
           MOVE    SPA-HOSPNUM         TO  MNOTE-H-HOSPNUM
           MOVE    CONST-TBL-KEY       TO  MNOTE-H-TBL-KEY
           MOVE    SPA-NAI-TBL-GROUP   TO  MNOTE-H-TBL-GROUP
           MOVE    SPA-GMN-TBL-UUID    TO  MNOTE-H-TBL-UUID
           MOVE    MNOTE-H-REC     TO  MCPDATA-REC
           MOVE    "tbl_mnote_h"   TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  MNOTE-H-REC
           ELSE
               MOVE    1               TO  FLG-MNOTE-H
               INITIALIZE                  MNOTE-H-REC
           END-IF
      *
           .
      *
       900-MNOTE-H-KEY3-SEL-EXT.
           EXIT.
      *****************************************************************
      *    統計ＣＳＶ格納管理FETCH処理
      *****************************************************************
       900-MNOTE-H-KEY3-FET-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-MNOTE-H
      *
           MOVE    "tbl_mnote_h"   TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  MNOTE-H-REC
           ELSE
               MOVE    1               TO  FLG-MNOTE-H
               INITIALIZE                  MNOTE-H-REC
           END-IF
      *
           .
      *
       900-MNOTE-H-KEY3-FET-EXT.
           EXIT.
      *****************************************************************
      *    統計ＣＳＶ格納管理検索処理
      *****************************************************************
       900-MNOTE-B-KEY2-SEL-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-MNOTE-B
      *
           INITIALIZE                  MNOTE-B-REC
           MOVE    SPA-HOSPNUM     TO  MNOTE-B-HOSPNUM
           MOVE    MNOTE-H-TBL-KEY
                                   TO  MNOTE-B-TBL-KEY
           MOVE    MNOTE-H-RENNUM
                                   TO  MNOTE-B-RENNUM
           MOVE    MNOTE-H-TBL-GROUP
                                   TO  MNOTE-B-TBL-GROUP
           MOVE    MNOTE-H-TBL-UUID
                                   TO  MNOTE-B-TBL-UUID
           MOVE    MNOTE-H-SHORI-RENNUM
                                   TO  MNOTE-B-SHORI-RENNUM
           MOVE    "tbl_mnote_b"
                                   TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  MNOTE-B-REC
           ELSE
               MOVE    1           TO  FLG-MNOTE-B
               INITIALIZE              MNOTE-B-REC
           END-IF
      *
           .
      *
       900-MNOTE-B-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    統計ＣＳＶ格納明細FETCH処理
      *****************************************************************
       900-MNOTE-B-KEY2-FET-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-MNOTE-B
      *
           MOVE    "tbl_mnote_b"   TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  MNOTE-B-REC
           ELSE
               MOVE    1               TO  FLG-MNOTE-B
               INITIALIZE                  MNOTE-B-REC
           END-IF
      *
           .
      *
       900-MNOTE-B-KEY2-FET-EXT.
           EXIT.
      *****************************************************************
      *    統計ＣＳＶ格納管理検索処理
      *****************************************************************
       900-MNOTE-H-KEY8-SEL-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-MNOTE-H
      *
           INITIALIZE                      MNOTE-H-REC
      *
           MOVE    SPA-HOSPNUM         TO  MNOTE-H-HOSPNUM
           MOVE    CONST-TBL-KEY       TO  MNOTE-H-TBL-KEY
           MOVE    SPA-NAI-CREYMD      TO  MNOTE-H-CREYMD
           MOVE    MNOTE-H-REC     TO  MCPDATA-REC
           MOVE    "tbl_mnote_h"   TO  MCP-TABLE
           MOVE    "key8"              TO  MCP-PATHNAME
           PERFORM 911-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               PERFORM 900-MNOTE-H-KEY8-FET-SEC
           ELSE
               MOVE    1               TO  FLG-MNOTE-H
               INITIALIZE                  MNOTE-H-REC
           END-IF
      *
           .
      *
       900-MNOTE-H-KEY8-SEL-EXT.
           EXIT.
      *****************************************************************
      *    統計ＣＳＶ格納管理FETCH処理
      *****************************************************************
       900-MNOTE-H-KEY8-FET-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-MNOTE-H
                                           FLG-LOOPEND
      *
           PERFORM UNTIL ( FLG-MNOTE-H NOT =   ZERO )
                    OR   ( FLG-LOOPEND     NOT =   ZERO )
      *
               MOVE    "tbl_mnote_h"   TO  MCP-TABLE
               MOVE    "key8"              TO  MCP-PATHNAME
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC              =   ZERO )
                   MOVE    MCPDATA-REC     TO  MNOTE-H-REC
      *
                   MOVE    1               TO  FLG-LOOPEND
      *
                   IF    ( MNOTE-H-TBL-KEY =   CONST-TBL-KEY )
                       CONTINUE
                   ELSE
                       MOVE    ZERO        TO  FLG-LOOPEND
                   END-IF
      *
               ELSE
                   MOVE    1               TO  FLG-MNOTE-H
                   INITIALIZE                  MNOTE-H-REC
               END-IF
      *
           END-PERFORM
      *
           .
      *
       900-MNOTE-H-KEY8-FET-EXT.
           EXIT.
      *****************************************************************
      *    統計ＣＳＶ格納明細検索処理
      *****************************************************************
       900-MNOTE-B-KEY-SEL-SEC         SECTION.
      *
           MOVE    ZERO                TO  FLG-MNOTE-B
      *
           INITIALIZE                      MNOTE-B-REC
           MOVE    SPA-HOSPNUM         TO  MNOTE-B-HOSPNUM
           MOVE    MNOTE-H-RENNUM  TO  MNOTE-B-RENNUM
           MOVE    MNOTE-H-SHORI-RENNUM
                                       TO  MNOTE-B-SHORI-RENNUM
           MOVE    MNOTE-H-TBL-GROUP
                                       TO  MNOTE-B-TBL-GROUP
           MOVE    MNOTE-H-TBL-UUID
                                       TO  MNOTE-B-TBL-UUID
           MOVE    MNOTE-H-TBL-KEY     TO  MNOTE-B-TBL-KEY
           MOVE    1                   TO  MNOTE-B-SEQ-NO
           MOVE    MNOTE-B-REC     TO  MCPDATA-REC
           MOVE    "tbl_mnote_b"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  MNOTE-B-REC
           ELSE
               MOVE    1               TO  FLG-MNOTE-B
           END-IF
      *
           MOVE    "tbl_mnote_b"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-MNOTE-B-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    患者情報検索処理
      *****************************************************************
       900-PTINF-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-PTINF
      *
           INITIALIZE                  PTINF-REC
           MOVE    SPA-HOSPNUM     TO  PTINF-HOSPNUM
           MOVE    WRK-PTID        TO  PTINF-PTID
           MOVE    PTINF-REC       TO  MCPDATA-REC
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  PTINF-REC
               MOVE    ZERO        TO  FLG-PTINF
           ELSE
               MOVE    1           TO  FLG-PTINF
               INITIALIZE              PTINF-REC
           END-IF
      *
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者番号検索処理
      *****************************************************************
       900-PTNUM-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO            TO  FLG-PTNUM
      *
           INITIALIZE                  PTNUM-REC
           MOVE    SPA-HOSPNUM     TO  PTNUM-HOSPNUM
           MOVE    WRK-PTID        TO  PTNUM-PTID
           MOVE    PTNUM-REC       TO  MCPDATA-REC
           MOVE    "tbl_ptnum"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  PTNUM-REC
               MOVE    ZERO        TO  FLG-PTNUM
           ELSE
               MOVE    1           TO  FLG-PTNUM
               INITIALIZE              PTNUM-REC
           END-IF
      *
           MOVE    "tbl_ptnum"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-PTNUM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ検索処理(KEY10)
      *****************************************************************
       900-SYSKANRI-KEY10-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SPA-HOSPNUM         TO  SYS-HOSPNUM
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SYSKANRI-KEY10-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理(KEY2)
      *****************************************************************
       900-SYSKANRI-KEY2-SEL-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SPA-HOSPNUM         TO  SYS-HOSPNUM
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ検索処理(KEY2)
      *****************************************************************
       900-SYSKANRI-KEY2-FET-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           .
       900-SYSKANRI-KEY2-FET-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       910-DBSELECT-SEC               SECTION.
      *
           MOVE    "DBSELECT"          TO      MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理(FETCHはしない)
      *****************************************************************
       911-DBSELECT-SEC               SECTION.
      *
           MOVE    "DBSELECT"          TO      MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＦＥＴＣＨ処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＣＬＯＳＥＣＵＲＳＯＲ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC           SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＩＮＳＥＲＴ処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＵＰＤＡＴＥ処理
      *****************************************************************
       910-DBUPDATE-SEC                SECTION.
      *
           MOVE    "DBUPDATE"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBUPDATE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢＤＥＬＥＴＥ処理
      *****************************************************************
       910-DBDELETE-SEC                SECTION.
      *
           MOVE    "DBDELETE"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBDELETE-EXT.
           EXIT.
      *****************************************************************
      *    ＢＬＯＢＩＭＰＯＲＴ処理
      *****************************************************************
       910-BLOBIMPORT-SEC              SECTION.
      *
           MOVE    "BLOBIMPORT"    TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       ORCA-BLOB
                                       SPA-AREA
      *
           .
      *
       910-BLOBIMPORT-EXT.
           EXIT.
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"      TO  MCP-FUNC.
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.

