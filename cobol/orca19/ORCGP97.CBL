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
       PROGRAM-ID.                 ORCGP97.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 氏名検索（Ｐ９７）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *   01.00.01    MCC-藤原     01/04/10　LINKAREAの初期化の削除
      *   01.00.02    MCC-太田     01/05/24  患者番号構成管理の追加
      *   01.00.03    MCC-多々納   01/08/20  仮名入力変換処理の追加
      *                                      漢字・かなの検索の一元化
      *   01.00.04    MCC-藤原     01/09/19  番号の編集    
      *   01.01.01    MCC-藤原     01/09/21  JOINの修正      
      *   01.00.06    MCC-多々納   01/09/25  一覧表選択の追加
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       01  SPA-P97.
           03  SPA-P97-AREA.
               05  SPA-GMN-PAGE        PIC 9(02).
               05  SPA-GMN-MAX         PIC 9(03).
               05  SPA-GMN-CUR         PIC 9(02).
      *
               05  SPA-GMN-AREA.
                   07  SPA-GMN-NAMEKEN     PIC X(30).
                   07  SPA-GMN-TBLG.
                       09  SPA-GMN-TBL     OCCURS  100.
                           11  SPA-GMN-NO          PIC 9(04).
                           11  SPA-GMN-PTNUM       PIC X(20).
                           11  SPA-GMN-NAME        PIC X(50).
                           11  SPA-GMN-SEX         PIC X(04).
                           11  SPA-GMN-BIRTH       PIC X(12).
                           11  SPA-GMN-RRKYMD      PIC X(10).
                   07  SPA-GMN-SELNO          PIC 9(04).
      *
                   07  SPA-GMN-MCPCHK         PIC X(02).
      *
               05  SPA-NAI-AREA.
                   07  SPA-NAI-MOTOPG         PIC X(08).
                   07  SPA-NAI-TBLG.
                       09  SPA-NAI-TBL            OCCURS  100.
                           11  SPA-NAI-SEX        PIC X(01).
                           11  SPA-NAI-BIRTH      PIC X(08).
                           11  SPA-NAI-PTID       PIC X(10).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-KNJHEN          PIC 9(01).
           03  FLG-KENSAKU         PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
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
           03  IDX2                PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-MOJISU          PIC 9(04).
           03  WRK-NAME            PIC X(15).
           03  WRK-YY              PIC 9(02).
           03  WRK-SAKIPG          PIC X(08).
      *
           03  WRK-ZZ              PIC ZZZ9.
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
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
      *
      *    日付サブルーチン領域
           COPY  "CPORCSDAY.INC".
           COPY  "CPORCSLNK.INC".
      *
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号変換
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
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
           COPY    "P97.INC".
           COPY    "P97ERR.INC".
      *
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-P97.
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
           MOVE    SPA-P97         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM.
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                   SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "P97ERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5011-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
      ***  MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "P97"               TO  MCP-WINDOW.
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
           INITIALIZE              SPA-P97
      *
           MOVE    1               TO  SPA-GMN-CUR
      *
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
           END-IF
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
           MOVE    SPA-MOTOPG          TO  SPA-NAI-MOTOPG
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
      *    前の画面より、氏名の受け取り
           IF      SPA-NAME        NOT =   SPACE
               MOVE    SPA-NAME        TO  SPA-GMN-NAMEKEN
               PERFORM 2011-KNJKEN-HEN-SEC
           ELSE
               MOVE    1               TO  SPA-GMN-PAGE
           END-IF
      *
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *            終了
               WHEN    "CLICKED"       ALSO    "B01"
                   PERFORM 210-BACK
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        検索項目入力(確定)
               WHEN    "ACTIVATE"      ALSO    "NAMEKEN"
                   PERFORM 201-NAMEKEN-SEC
                   MOVE    2           TO  SPA-GMN-CUR
      *        検索項目入力（変換）
               WHEN    "CHANGED"       ALSO    "NAMEKEN"
                   PERFORM 201-NAMEKEN-SEC
                   MOVE    1           TO  SPA-GMN-CUR
      *        番号選択入力
               WHEN    "ACTIVATE"      ALSO    "SELNO"
                   PERFORM 202-SELNO-SEC
      *        行選択
               WHEN    ANY             ALSO    "LIST"
                   PERFORM 203-SELECT-SEC
           END-EVALUATE
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    検索項目入力　処理
      *****************************************************************
       201-NAMEKEN-SEC                 SECTION.
      *
           MOVE    1                   TO  SPA-GMN-CUR
      *
           MOVE    P97-NAMEKEN         TO  SPA-GMN-NAMEKEN
           IF      SPA-GMN-NAMEKEN     =   SPACE
               INITIALIZE                  SPA-GMN-TBLG
               INITIALIZE                  SPA-NAI-TBLG
           ELSE
               MOVE    1                   TO  FLG-KENSAKU
               PERFORM 2011-KNJKEN-HEN-SEC
           END-IF
      *
           .
       201-NAMEKEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者検索処理
      *****************************************************************
       2011-KNJKEN-HEN-SEC        SECTION.
      *
           MOVE    ZERO                TO  SPA-GMN-MAX
           MOVE    ZERO                TO  SPA-GMN-PAGE
      *
           MOVE    ZERO                TO  WRK-MOJISU
           PERFORM VARYING     IDX     FROM    30  BY  -1
                   UNTIL       IDX     <       1
               IF      SPA-GMN-NAMEKEN(IDX:1)  NOT =   SPACE
                   MOVE    IDX                     TO  WRK-MOJISU 
                   MOVE    1                       TO  IDX
               END-IF  
           END-PERFORM
      *
           INITIALIZE                  SPA-GMN-TBLG
      *
           MOVE    ZERO                TO  IDX
      *
      *    漢字検索
           INITIALIZE                  PTINF-REC
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPACE               TO  PTINF-NAME
           MOVE    SPA-GMN-NAMEKEN(1:WRK-MOJISU)
                                       TO  PTINF-NAME(1:WRK-MOJISU)
           MOVE    SPA-GMN-NAMEKEN(1:WRK-MOJISU)
                                       TO  PTINF-KANANAME(1:WRK-MOJISU)
      *
      *    患者マスターを漢字氏名で検索
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTINF-KEY5"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTINF-KEY5"        TO  ORC-DBPATH
               PERFORM 810-PTINF-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-PTINF
           END-IF 
      *
           PERFORM UNTIL      (IDX             >   100       ) OR
                              (FLG-PTINF       =   1          )
               PERFORM 2012-PTINF-HENSYU-SEC
      *
               MOVE    "PTINF-KEY5"        TO  ORC-DBPATH
               PERFORM 810-PTINF-READ-SEC
           END-PERFORM
      *    カーソルクロース
           INITIALIZE                  MCPAREA
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTINF-KEY5"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF     (IDX             >   100  )  AND
                  (FLG-PTINF       =   ZERO )  AND
                  (FLG-KENSAKU     =   1    )
               MOVE    "0003"          TO  SPA-ERRCD
           END-IF
      *
      *    対象がある時、選択へ
           IF      SPA-GMN-MAX     >   ZERO
               MOVE    2               TO  SPA-GMN-CUR
           END-IF
      *
           IF      SPA-GMN-MAX     >   ZERO
               COMPUTE SPA-GMN-PAGE    =  (SPA-GMN-MAX  -  1  )
                                       /   100
                                       +   1
           ELSE
               MOVE   1                TO  SPA-GMN-PAGE
           END-IF
           .
       2011-KNJKEN-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスタ編集処理
      *****************************************************************
       2012-PTINF-HENSYU-SEC          SECTION.
      *
           ADD     1                   TO  IDX
      *
           IF      IDX                 >   100
               CONTINUE
           ELSE  
               MOVE    IDX                 TO  SPA-GMN-NO  (IDX)
      *
      *    患者番号変換より、患者IDより患者NOを取得する
      *
               MOVE    PTINF-PTID          TO  SPA-NAI-PTID  (IDX)
      *
               INITIALIZE                      ORCSPTIDAREA
               MOVE    SPA-HOSPID          TO  SPTID-HOSPID
               MOVE    PTINF-PTID          TO  SPTID-PTID
               CALL    "ORCSPTID"      USING   ORCSPTIDAREA
      *----(01.00.02) LINE ADD START -------------------------------
                                               SPA-1009-TBL
      *----(01.00.02) LINE ADD END   -------------------------------
               IF      SPTID-RC        NOT =   ZERO
                   MOVE    SPACE           TO  SPA-GMN-PTNUM  (IDX)
               ELSE
                   MOVE    SPTID-PTNUM     TO  SPA-GMN-PTNUM  (IDX)
               END-IF
      *
               MOVE    PTINF-NAME          TO  SPA-GMN-NAME   (IDX)
               MOVE    PTINF-SEX           TO  SPA-NAI-SEX    (IDX)
               EVALUATE    SPA-NAI-SEX (IDX)
                   WHEN    "1"
                       MOVE    "男"        TO  SPA-GMN-SEX (IDX)
                   WHEN    "2"
                       MOVE    "女"        TO  SPA-GMN-SEX (IDX)
               END-EVALUATE  
               MOVE    PTINF-BIRTHDAY      TO  SPA-NAI-BIRTH  (IDX)
               MOVE    PTINF-BIRTHDAY      TO  WRK-SYMD
               PERFORM 700-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG         TO  SPA-GMN-BIRTH  (IDX)
      *        最終受診日セット
               PERFORM 20121-JYURRK-HEN-SEC
      *
               MOVE    IDX                 TO  SPA-GMN-MAX
           END-IF
           .
       2012-PTINF-HENSYU-EXT.
           EXIT.
           .
      *****************************************************************
      *    最終受診日セット処理
      *****************************************************************
       20121-JYURRK-HEN-SEC               SECTION.
      *
           INITIALIZE                  JYURRK-REC
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    PTINF-PTID          TO  JYURRK-PTID
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY8"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "JYURRK-KEY8"      TO  ORC-DBPATH
               PERFORM 900-JYURRK-READ-SEC
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           IF      FLG-JYURRK          =   ZERO
               MOVE    JYURRK-SRYYMD       TO  WRK-SYMD
               PERFORM 700-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG         TO  SPA-GMN-RRKYMD (IDX)
           END-IF
      *
      *    カーソルクロース
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "JYURRK-KEY8"       TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
       20121-JYURRK-HEN-EXT.
           EXIT.
           .
      *****************************************************************
      *    検索項目入力　処理
      *****************************************************************
       202-SELNO-SEC               SECTION.
      *
           MOVE    P97-SELNO           TO  SPA-GMN-SELNO
      *
      *    選択番号チェック
           IF      SPA-GMN-SELNO       =   ZERO
               MOVE    1               TO  SPA-GMN-CUR
               GO      TO              202-SELNO-EXT
           END-IF
           IF      SPA-GMN-SELNO       =   ZERO   OR
                                       >   SPA-GMN-MAX
               MOVE    "0002"          TO  SPA-ERRCD
           END-IF
      *
      *        ＯＫの時、ＳＰＡ確定後、元の画面へ
           IF      SPA-ERRCD           =   SPACE
               PERFORM 2021-SPA-OKSET-SEC
               PERFORM 210-BACK
           END-IF
           .
       202-SELNO-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面選択入力　処理
      *****************************************************************
       203-SELECT-SEC               SECTION.
      *
           PERFORM VARYING     IDX   FROM   1   BY  1
                   UNTIL       IDX   >   SPA-GMN-MAX
              IF      P97-SELECT(IDX)        =  "T"
                  MOVE    SPA-GMN-NO (IDX)     TO  SPA-GMN-SELNO
              END-IF
           END-PERFORM
      *
      *    選択番号チェック
           IF      SPA-GMN-SELNO       =   ZERO   OR
                                       >   SPA-GMN-MAX
               MOVE    "0002"          TO  SPA-ERRCD
           END-IF
      *
      *    ＯＫの時、ＳＰＡ確定後、元の画面へ
           IF      SPA-ERRCD           =   SPACE
               PERFORM 2021-SPA-OKSET-SEC
               PERFORM 210-BACK
           END-IF
           .
       203-SELNO-EXT.
           EXIT.
      *
      *****************************************************************
      *   画面移行用のＳＰＡ編集
      *****************************************************************
       2021-SPA-OKSET-SEC          SECTION.
      *
           INITIALIZE                  SPA-KYOTUKEY
           IF      SPA-GMN-SELNO       =   ZERO
               MOVE    SPA-GMN-NAMEKEN     TO  SPA-NAME
           ELSE
               MOVE    SPA-GMN-SELNO       TO  IDX
               MOVE    SPA-NAI-PTID  (IDX) TO  SPA-PTID
               MOVE    SPA-GMN-PTNUM (IDX) TO  SPA-PTNUM
               MOVE    SPA-GMN-NAME  (IDX) TO  SPA-NAME
               MOVE    SPA-GMN-SEX   (IDX) TO  SPA-SEX
               MOVE    SPA-NAI-BIRTH (IDX) TO  SPA-BIRTHDAY
               MOVE    SPA-GMN-BIRTH (IDX) TO  SPA-BIRTHDAYW
           END-IF
      *
           .
       2021-SPA-OKSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    SPA-NAI-MOTOPG      TO  SPA-SAKIPG
           MOVE    "P97"               TO  SPA-MOTOPG
           IF      SPA-SAKIPG          =   SPACE  OR  "P97" 
               MOVE   "M01"            TO  SPA-SAKIPG
           END-IF
      *
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
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
      *    西暦和暦編集処理
      *****************************************************************
       700-SEIWA-HEN-SEC             SECTION.
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
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
      *    西暦和暦変更
           IF      WRK-SYMD            =   ALL "9"  OR   SPACE
               MOVE    ALL "9"             TO  WRK-WYMD
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY1-AREA
               MOVE    "11"                TO  LNK-DAY1-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY1-YMD
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY1-AREA
               MOVE    LNK-DAY1-GENGO      TO  WRK-WYMD(1:1)
               MOVE    LNK-DAY1-YMD(3:6)   TO  WRK-WYMD(2:6)
           END-IF
      *
           .
       700-SEIWA-HEN-EXT.
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
               PERFORM 502-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
      *----(01.00.01) LINE DEL START ----------------------------------
      *    MOVE    SPACE               TO  LINKAREA
      *----(01.00.01) LINE DEL END ------------------------------------
      *
           MOVE    "CURRENT"       TO  MCP-PUTTYPE.
           MOVE    "P97"           TO  MCP-WINDOW.
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
           MOVE    SPACE               TO  P97
      *
           MOVE    SPA-GMN-NAMEKEN     TO  P97-NAMEKEN
           MOVE    SPA-GMN-SELNO       TO  P97-SELNO
      *
           MOVE    ZERO                TO  P97-COUNT
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX             >   100  )
                           OR (SPA-GMN-NO (IDX)    =   ZERO)
      *
               MOVE    SPA-GMN-NO    (IDX)     TO  WRK-ZZ
               MOVE    WRK-ZZ                  TO  P97-NO     (IDX)
               MOVE    SPA-GMN-PTNUM (IDX)     TO  P97-PTNUM  (IDX)
               MOVE    SPA-GMN-NAME  (IDX)     TO  P97-NAME   (IDX)
               MOVE    SPA-GMN-SEX   (IDX)     TO  P97-SEX    (IDX)
               MOVE    SPA-GMN-BIRTH (IDX)     TO  P97-BIRTH  (IDX)
               MOVE    SPA-GMN-RRKYMD(IDX)     TO  P97-RRKYMD (IDX)
      *
               MOVE    IDX                     TO  P97-COUNT
           END-PERFORM
      *
      *
           PERFORM 5011-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5011-MAPCUR-SEC             SECTION.
      *
           EVALUATE    SPA-GMN-CUR
               WHEN    01
                   MOVE    "NAMEKEN"       TO  MCP-WIDGET
               WHEN    02
                   MOVE    "SELNO"         TO  MCP-WIDGET
           END-EVALUATE
          .
       5011-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       502-ERRSET-SEC              SECTION.
      *
            EVALUATE    SPA-ERRCD
                WHEN    "0001"
                    MOVE    "入力エラー"
                                                TO  SPA-ERRMSG
                WHEN    "0002"
                    MOVE    "選択番号が有りません"
                                                TO  SPA-ERRMSG
                WHEN    "0003"
                    MOVE    "対象者が１００人以上います"
                                                TO  SPA-ERRMSG
                WHEN    OTHER
                    MOVE    SPACE               TO  SPA-ERRMSG
            END-EVALUATE
      *
           MOVE    SPACE                TO  P97ERR
           MOVE    SPA-ERRCD            TO  P97ERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  P97ERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "P97"                TO  SPA-MOTOPG
           MOVE    "P97ERR"             TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "P97ERR"             TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       502-ERRSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込
      *****************************************************************
       810-PTINF-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTINF-REC
               MOVE    ZERO            TO  FLG-PTINF
           ELSE
               INITIALIZE                  PTINF-REC
               MOVE    1               TO  FLG-PTINF
           END-IF
      *
           .
       810-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴マスター読込
      *****************************************************************
       900-JYURRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  JYURRK-REC
               MOVE    ZERO            TO  FLG-JYURRK
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       900-JYURRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"                   TO  MCP-FUNC.
           CALL   "ORCMCPSUB"                    USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC.
      *
       900-PUT-WINDOW-EXT.
           EXIT.
