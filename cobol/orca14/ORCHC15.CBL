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
       PROGRAM-ID.             ORCHC15.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 予約登録
      *  コンポーネント名  : 予約一覧表　印刷（ＨＣ１５）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  01/10/26    MCC−多々納   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02.03.18  帳票ファイル名の変更
      *  01.00.03    NACL-多々納  02.09.13  印刷サプの追加
      *  01.00.04    NACL-太田    03.06.12  フォームをDIAからMONPEに変更
      *  01.00.05    NACL-多々納  03/06/27  出力先プリンタサブ追加
      *  01.00.06    NACL-多々納  06/05/15  MONFUNC 対応 他
      *  04.05.00    NACL-多々納  09/06/XX  カスタマイズ帳票対応
      *  04.08.00    NACL-多々納  14/07/30  一時ディレクトリ対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    印刷用データ
      **** SELECT  PRT-FILE        ASSIGN  HC01PARA
           SELECT  PRT-FILE        ASSIGN  ASGNPARA
                                   FILE    STATUS  IS  STS-PARA.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    印刷用データ
       FD  PRT-FILE.
           COPY    "HCM15.INC".
      *
       WORKING-STORAGE             SECTION.
      *
      *     印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *v4.8
      *    一時デイレクトリ領域 
           COPY    "CPASGNPARA.INC".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-YYK             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-SYORI           PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-YYKEND          PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX-D               PIC 9(04).
           03  IDX-L               PIC 9(04).
           03  IDX-C               PIC 9(04).
      *
           03  IDX-STR             PIC 9(04).
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
           03  WRK-SYSYMDG         PIC X(22).
           03  WRK-ALLPAGE         PIC 9(03).
      *
           03  WRK-YYKYMD          PIC X(08).
           03  WRK-PAGE            PIC 9(03).
           03  WRK-LINE            PIC 9(04).
      *
           03  WRK-ZZ9             PIC ZZ9.
      *
           03  WRK-PATH                PIC X(64).
      *
      *    予約テーブル
       01  TBL-YYK-AREA.
           03  TBL-YYK-OCC             OCCURS  6.
               05  TBL-YYK-OCC2        OCCURS  330.
                   07  TBL-SRYNAIYO-MEI    PIC X(10).
                   07  TBL-YYKTIME         PIC X(05).
                   07  TBL-YYKNAME         PIC X(20).
      *
       01  TBL-YYKEND-AREA.
           03  TBL-YYKEND-OCC          OCCURS   6.
               05  TBL-CNTMAX              PIC 9(04).
               05  TBL-YYKEND              PIC 9(01).
      *
      *
      *    診療内容テーブル
       01  TBL-SRYNAIYO-AREA.
           03  TBL-SRYNAIYO-G          OCCURS   99.
               05  TBL-SRYNAIYO        PIC X(02).
               05  TBL-SRYNAIYOMEI     PIC X(24).
      *
      *    帳票最大行
       01  LINE-MAX                    PIC 9(03)   VALUE   33.
      *    テーブル最大行
       01  TBL-MAX                     PIC 9(03)   VALUE   330.
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENTIME.
               05  WRK-HTIME1          PIC X(02).
               05  FILLER              PIC X(01)   VALUE   ":".
               05  WRK-HTIME2          PIC X(02).
      *
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
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *    予約患者一覧パラメタ領域
           COPY    "CPORCHC15.INC".
      *
           COPY    "MCPDATA.INC".
      *
           COPY    "MCPAREA".
      *
      *v4.8
      *    一時ファイル名取得
           COPY    "CPORCSGETTEMP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
           COPY    "CPONPRTDATA.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ONPRTDATA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
      *    初期編集処理
           PERFORM 100-INIT-SYORI-SEC
      *
      *    一覧印刷処理
           PERFORM 200-MAIN-SYORI-SEC
                   UNTIL           FLG-YYKEND  =   1
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    初期編集処理
      *****************************************************************
       100-INIT-SYORI-SEC             SECTION.
      *
           MOVE    ONPRTDATA-DATA      TO  ORCHC15AREA
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  TBL-YYK-AREA
           INITIALIZE                  TBL-YYKEND-AREA
      *
      *
           ACCEPT  SYS-TIME            FROM    TIME
      *
      *    各ＤＢ読込
           PERFORM 100-SYORI-SEC
           .
       100-INIT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷開始処理
      *****************************************************************
       400-SYOKI-PRINT-SEC             SECTION.
      *
      *    ファイルＯＰＥＮ
           MOVE    SPA-HOSPNUM         TO  HC01PARA-HOSPNUM
           MOVE    "HC15"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
      *
           ADD     1                   TO  WRK-ALLPAGE
           MOVE    WRK-ALLPAGE         TO  HC01PARA-CNT
      *v4.8
      *    一時ファイル名取得
           INITIALIZE                      SGETTEMP-AREA
           MOVE    HC01PARA            TO  SGETTEMP-BASENAME
           CALL    "ORCSGETTEMP"       USING
                                           SGETTEMP-AREA
           MOVE    SGETTEMP-FULLNAME   TO  ASGNPARA
      *
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
      *    印刷用データ出力
           WRITE  HCM15
      *
           CLOSE                       PRT-FILE
      *
           INITIALIZE                  ORCSMKPRTAREA
           MOVE    "HC01.sh"           TO  MKPRT-ID
           MOVE    "HCM15.red"         TO  MKPRT-DIA
           MOVE    SPACE               TO  MKPRT-DEF
      **** MOVE    HC01PARA            TO  MKPRT-DAT
           MOVE    ASGNPARA            TO  MKPRT-DAT
           MOVE    SYS-1031-PRTNM(19)  TO  MKPRT-PRTNM
           CALL    "ORCSMKPRT"         USING
                                       ORCSMKPRTAREA
                                       SPA-AREA
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
           INITIALIZE                      SYS-1031-REC
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "2"                 TO  ORCSPRTNM-KBN
           MOVE    SPA-SYSYMD          TO  ORCSPRTNM-SRYYMD
           MOVE    "2"                 TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYS-1031-REC
      *    予約一覧の出力先設定がないときは、受付一覧（元の予約一覧）
           IF      SYS-1031-PRTNM(19)  =   SPACE
               MOVE    SYS-1031-PRTNM(7)   TO  SYS-1031-PRTNM(19)
           END-IF
      *
      *    発行日
           MOVE    SPA-SYSYMD          TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  WRK-SYSYMDG
      *
           .
       100-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    システム管理テーブル編集処理
      *****************************************************************
       1001-SYSKANRI-TBL-SEC           SECTION.
      *
           INITIALIZE                  TBL-SRYNAIYO-AREA
      *    診療内容
           MOVE    SPACE               TO  SYS-1012-REC
           MOVE    SPA-HOSPNUM         TO  SYS-1012-HOSPNUM
           MOVE    "1012"              TO  SYS-1012-KANRICD
           MOVE    WRK-YYKYMD          TO  SYS-1012-STYUKYMD
           MOVE    WRK-YYKYMD          TO  SYS-1012-EDYUKYMD
      *
           MOVE    SYS-1012-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"             TO  MCP-PATHNAME
               PERFORM 910-SYSKANRI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           MOVE    ZERO                TO  IDX-D
           PERFORM UNTIL   (FLG-SYSKANRI   =   1   )
                       OR  (IDX-D          >=  99  )
               MOVE    MCPDATA-REC         TO  SYS-1012-REC
               ADD     1                   TO  IDX-D
               MOVE    SYS-1012-KBNCD(1:2) TO  TBL-SRYNAIYO  (IDX-D)
               MOVE    SYS-1012-SRYNAIYODSP
                                           TO  TBL-SRYNAIYOMEI (IDX-D)
      *
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 910-SYSKANRI-READ-SEC
           END-PERFORM
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       1001-SYSKANRI-TBL-EXT.
           EXIT.
      *
      *****************************************************************
      *    予約患者一覧処理
      *****************************************************************
       200-MAIN-SYORI-SEC              SECTION.
      *
      *
           MOVE    ZERO                TO  IDY
           MOVE    ZERO                TO  IDX-D
           INITIALIZE                  TBL-YYK-AREA
      *    予約内容編集処理
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX         >   6   )   OR
                              (ORCHC15-YYKYMD (IDX)    =   SPACE )
               IF      TBL-YYKEND  (IDX)       =   ZERO
                   MOVE    TBL-CNTMAX (IDX)        TO  IDX-STR
                   MOVE    ORCHC15-YYKYMD (IDX)    TO  WRK-YYKYMD
      *            診療内容テーブル編集
                   PERFORM 1001-SYSKANRI-TBL-SEC
      *            予約テーブル編集
                   PERFORM 2001-YYK-SYORI-SEC
               END-IF
           END-PERFORM
      *
      *    印刷処理
           PERFORM 2010-HC15-SYORI-SEC
      *
      *    処理終了判定
           IF     (TBL-YYKEND  (1)     =   1  )  AND
                  (TBL-YYKEND  (2)     =   1  )  AND
                  (TBL-YYKEND  (3)     =   1  )  AND
                  (TBL-YYKEND  (4)     =   1  )  AND
                  (TBL-YYKEND  (5)     =   1  )  AND
                  (TBL-YYKEND  (6)     =   1  )
               MOVE    1                   TO  FLG-YYKEND
           END-IF
           .
       200-MAIN-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    予約テーブ編集処理
      *****************************************************************
       2001-YYK-SYORI-SEC              SECTION.
      *
      *    予約マスター検索
           INITIALIZE                  YYK-REC
           MOVE    SPA-HOSPNUM         TO  YYK-HOSPNUM
           MOVE    ORCHC15-SRYNAIYO    TO  YYK-SRYNAIYO
           MOVE    ORCHC15-DRCD-G      TO  YYK-DRCD
           MOVE    ORCHC15-YYKYMD(IDX) TO  YYK-YYKYMD
           IF     (ORCHC15-SRYNAIYO    =   "00"  )  OR
                  (ORCHC15-DRCD        =   "9999")
               MOVE    "key5"              TO  WRK-PATH
           ELSE
               MOVE    "key3"              TO  WRK-PATH
           END-IF
           MOVE    YYK-REC             TO  MCPDATA-REC
           MOVE    "tbl_yyk"           TO  MCP-TABLE
           MOVE    WRK-PATH            TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_yyk"           TO  MCP-TABLE
               MOVE    WRK-PATH            TO  MCP-PATHNAME
               PERFORM 900-YYK-READ-SEC
           ELSE
               INITIALIZE                  YYK-REC
               MOVE    1                   TO  FLG-YYK
           END-IF
      *
           MOVE    ZERO                TO  TBL-CNTMAX (IDX)
           MOVE    ZERO                TO  IDY
           MOVE    ZERO                TO  IDX-C
           PERFORM
                   UNTIL       FLG-YYK         =   1
               MOVE    ZERO                TO  FLG-SYORI
      *        選択内容判定
               IF     (ORCHC15-SRYNAIYO    =   "00"  )  OR
                      (ORCHC15-DRCD        =   "9999")
                   IF      ORCHC15-SRYNAIYO    NOT =   "00"
                       IF      ORCHC15-SRYNAIYO    =  YYK-SRYNAIYO
                           MOVE    1               TO  FLG-SYORI
                       END-IF
                   END-IF
                   IF      ORCHC15-DRCD        NOT =   "9999"
                       IF      ORCHC15-DRCD-G      =  YYK-DRCD
                           MOVE    1               TO  FLG-SYORI
                       END-IF
                   END-IF
                   IF     (ORCHC15-SRYNAIYO    =   "00"  )  AND
                          (ORCHC15-DRCD        =   "9999")
                       MOVE    1               TO  FLG-SYORI
                   END-IF
               ELSE
                   MOVE    1               TO  FLG-SYORI
               END-IF
      *        キーレコード判定
               IF      YYK-YYKID           =   ZERO
                   MOVE    ZERO            TO  FLG-SYORI
               END-IF
               IF      FLG-SYORI           =   1
                   ADD     1                   TO  IDX-C
      *            前回の読み飛ばし
                   IF      IDX-C               <   IDX-STR
                       CONTINUE
                   ELSE
                       PERFORM 2001-YYKTBL-HEN-SEC
                   END-IF
               END-IF
      *
               IF      FLG-YYK             =   ZERO
                   MOVE    "tbl_yyk"           TO  MCP-TABLE
                   MOVE    WRK-PATH            TO  MCP-PATHNAME
                   PERFORM 900-YYK-READ-SEC
               END-IF
           END-PERFORM
      *    カーソルクロース
           MOVE    "tbl_yyk"           TO  MCP-TABLE
           MOVE    WRK-PATH            TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *    次ページなし
           IF      TBL-CNTMAX (IDX)    =   ZERO
               MOVE    1               TO  TBL-YYKEND (IDX)
           END-IF
           .
       2001-YYK-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    予約テーブル内容編集処理
      *****************************************************************
       2001-YYKTBL-HEN-SEC                SECTION.
      *
           ADD     1                   TO  IDY
           IF      IDY                 >   TBL-MAX
      *        テーブルオーバー
               MOVE    IDX-C           TO  TBL-CNTMAX (IDX)
               MOVE    1               TO  FLG-YYK
           ELSE
      *        診療内容
               PERFORM VARYING     IDX-D   FROM    1   BY  1
                       UNTIL      (IDX-D   >   99   )
                   IF     YYK-SRYNAIYO     =   TBL-SRYNAIYO (IDX-D)
                       MOVE    TBL-SRYNAIYOMEI (IDX-D)
                                               TO  TBL-SRYNAIYO-MEI
                                                            (IDX IDY)
                       MOVE    99              TO  IDX-D
                   END-IF
               END-PERFORM
      *        予約時間
               MOVE    YYK-YYKTIME(1:2)    TO  WRK-HTIME1
               MOVE    YYK-YYKTIME(3:2)    TO  WRK-HTIME2
               MOVE    WRK-HENTIME         TO  TBL-YYKTIME (IDX IDY)
      *        予約氏名
               MOVE    YYK-NAME            TO  TBL-YYKNAME (IDX IDY)
           END-IF
           .
       2001-YYKTBL-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集処理
      *****************************************************************
       2010-HC15-SYORI-SEC                SECTION.
      *
           MOVE    ZERO                TO  WRK-LINE
           MOVE    ZERO                TO  IDX-L
           INITIALIZE                  HCM15
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   TBL-MAX
               ADD     1               TO  IDX-L
               IF      IDX-L           >   LINE-MAX
      *            帳票印刷開始処理
                   PERFORM 200-HC15-PRINT-SEC
                   MOVE    1               TO  IDX-L
               END-IF
               MOVE    ZERO                TO  FLG-SYORI
               PERFORM VARYING     IDY     FROM    1   BY  1
                       UNTIL       IDY     >   6
                   IF      TBL-YYKNAME (IDY IDX)
                                           NOT =   SPACE
                       MOVE    1               TO  FLG-SYORI
      *                明細編集処理
                       PERFORM 300-HC15-HEN-SEC
                   END-IF
               END-PERFORM
      *        明細終了
               IF      FLG-SYORI           =   ZERO
                   MOVE    TBL-MAX             TO  IDX
               END-IF
           END-PERFORM
      *
           IF      IDX-L           >   ZERO
      *        帳票印刷開始処理
               PERFORM 200-HC15-PRINT-SEC
           END-IF
      *
           .
       2010-HC15-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集処理
      *****************************************************************
       200-HC15-PRINT-SEC                SECTION.
      *
           ADD     1                   TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  WRK-ZZ9
           MOVE    WRK-ZZ9             TO  HCM15-PAGE 
      *
           MOVE    "予約患者一覧"      TO  HCM15-TITLE
      *
      *    診療日
           MOVE    WRK-SYSYMDG         TO  HCM15-HAKYMD
      *    ドクター
           MOVE    ORCHC15-DRCD-NAME   TO  HCM15-DRCD
      *
      *    診察内容
           IF      ORCHC15-SRYNAIYO    =   "00"
               MOVE    ORCHC15-SRYNAIYO-MEI    TO  HCM15-TITLE2
           END-IF
      *
           MOVE    ORCHC15-GMN-YYKYMD (01) TO  HCM15-YYKYMD (01)
           MOVE    ORCHC15-GMN-YYKYMD (02) TO  HCM15-YYKYMD (02)
           MOVE    ORCHC15-GMN-YYKYMD (03) TO  HCM15-YYKYMD (03)
           MOVE    ORCHC15-GMN-YYKYMD (04) TO  HCM15-YYKYMD (04)
           MOVE    ORCHC15-GMN-YYKYMD (05) TO  HCM15-YYKYMD (05)
           MOVE    ORCHC15-GMN-YYKYMD (06) TO  HCM15-YYKYMD (06)
      *
           PERFORM 400-PRINT-SEC
      *
           INITIALIZE                  HCM15
           MOVE    ZERO                TO  IDX-L
           .
       200-HC15-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集処理
      *****************************************************************
       300-HC15-HEN-SEC                SECTION.
      *
           MOVE    TBL-SRYNAIYO-MEI (IDY IDX)
                                       TO  HCM15-SRYNAIYO (IDY IDX-L)
           MOVE    TBL-YYKTIME    (IDY IDX)
                                       TO  HCM15-YYKTIME  (IDY IDX-L)
           MOVE    TBL-YYKNAME    (IDY IDX)
                                       TO  HCM15-NAME     (IDY IDX-L)
      *
           .
       310-HC15-HEN-EXT.
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
      *****************************************************************
      *    予約マスター読込
      *****************************************************************
       900-YYK-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-YYK
               MOVE    MCPDATA-REC         TO  YYK-REC
           ELSE
               MOVE    1                   TO  FLG-YYK
           END-IF
      *
           .
       900-YYK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       910-SYSKANRI-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
       910-SYSKANRI-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "ORCDBMAIN"     USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       920-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "ORCDBMAIN"     USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクロース処理
      *****************************************************************
       990-DBCLOSE-SEC         SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                           MCPAREA
                                           MCPDATA-REC
                                           SPA-AREA
      *
           .
       990-DBCLOSE-EXT.
           EXIT.
      *
      *
