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
       PROGRAM-ID.             ORCHC33.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 会計照会
      *  コンポーネント名  : カルテ３号様式（診療録）印刷（外来）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/07/04    NACL−多々納  新規作成
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
           SELECT  PRT-FILE       ASSIGN  HC01PARA
                                   FILE    STATUS  IS  STS-PARA.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    印刷用データ
       FD  PRT-FILE.
       01  PRT-REC                 PIC X(10000).
      *
       WORKING-STORAGE             SECTION.
      *
      *     印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *    カルテ３号様式
           COPY    "HCM33.INC".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-SRYACCT         PIC 9(01).
           03  FLG-SRYACT          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
      *
           03  FLG-SYORI           PIC 9(01).
           03  FLG-OK              PIC 9(01).
           03  FLG-ARI             PIC 9(01).
           03  FLG-HKNKBN              PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PAGE            PIC 9(06).
           03  CNT-MEI             PIC 9(06).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
      *
           03  SYS-TIME            PIC 9(08).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX-T               PIC 9(04).
           03  IDX-T1              PIC 9(04).
           03  IDX-T2              PIC 9(04).
      *
           03  IDXH                PIC 9(04).
           03  IDX-H               PIC 9(04).
           03  IDX-MAX             PIC 9(04).
      *
           03  IDZ                 PIC 9(04).
           03  IDX-D               PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
      *
           03  WRK-YMDS1.
               05  WRK-YYS1            PIC 9(04).
               05  WRK-MMS1            PIC 9(02).
               05  WRK-DDS1            PIC 9(02).
           03  WRK-YMDS2.
               05  WRK-YYS2            PIC 9(04).
               05  WRK-MMS2            PIC 9(02).
               05  WRK-DDS2            PIC 9(02).
           03  WRK-NENREI-G.
               05  WRK-NENREI-YY       PIC 9(03).
               05  WRK-NENREI-MM       PIC 9(02).
           03  WRK-SRYYM.
               05  WRK-SRYYY           PIC 9(04).
               05  WRK-SRYMM           PIC 9(02).
           03  WRK-SRYYM-END.
               05  WRK-SRYYY-END       PIC 9(04).
               05  WRK-SRYMM-END       PIC 9(02).
           03  WRK-BIRTHDAY            PIC X(30).
      *
           03  WRK-SRYYMD              PIC X(08).
      *
           03  WRK-ZZ9                 PIC ZZ9.
           03  WRK-Z9                  PIC Z9.
           03  WRK-Z59                 PIC ZZZZ9.
           03  WRK-Z89                 PIC ZZZZZZZ9.
           03  WRK-Z79S                PIC -------9.
      *
           03  WRK-SRYYM-N             PIC X(40).
           03  WRK-SRYYM-N1            PIC X(40).
           03  WRK-SRYYM-N2            PIC X(40).
      *
           03  WRK-HKNCOMBIMEI         PIC X(120).
           03  WRK-HEN-HKNCOMBIMEI     PIC X(120).
           03  WRK-MEI-1               PIC X(02).
           03  WRK-MEI-2               PIC X(02).
           03  WRK-MEI-3               PIC X(02).
           03  WRK-MEI-4               PIC X(02).
           03  WRK-MEI-5               PIC X(02).
           03  WRK-HONKZKKBN           PIC X(06).
      *
           03  WRK-ORC-DBPATH          PIC X(64).
           03  WRK-SRYKA-MEI           PIC X(20).
      *
           03  WRK-HEN-DAY.
               05  WRK-H-MM            PIC Z9.
               05  WRK-H-P             PIC X(01).
               05  WRK-H-DD            PIC Z9.
           03  WRK-DAY                 PIC 9(02).
      *     集計
           03  WRK-GOK-ZAITEN          PIC 9(07).
           03  WRK-GOK-JIHIKEI         PIC 9(07).
           03  WRK-JIHIKEI             PIC 9(07).
           03  WRK-SKYMONEY            PIC S9(07).
      *
           03  WRK-SUM-TEN             PIC 9(07).
           03  WRK-ZAITEN              PIC 9(07).
           03  WRK-RSI-MONEY           PIC 9(07).
      *
           03  WRK-TUK-ZAITEN          PIC 9(07).
           03  WRK-TUK-SKYMONEY        PIC S9(07).
           03  WRK-TUK-RSI-MONEY       PIC 9(07).
      *
           03  WRK-PAGE                PIC 9(03).
           03  WRK-PRT-CNT             PIC 9(03).
      *
      *    集計テーブル
       01  TBL-AREA.
           03  TBL-OCC-1               OCCURS   10.
      *        剤点数
               05  TBL-OCC-2           OCCURS   200.
                   07  TBL-ZAITEN          PIC 9(05).
                   07  TBL-OCC-3           OCCURS   31.
                       09  TBL-DAY         PIC 9(03).
      *
      *    保険テーブル
       01  TBL-HKNCOMBI-AREA.
           03  TBL-HKNCOMBI-OCC        OCCURS   20.
               05  TBL-HKNCOMBI            PIC X(04).
               05  TBL-HKNCOMBIMEI         PIC X(100).
               05  TBL-HONKZKKBN           PIC X(04).
               05  TBL-HKNKBN              PIC 9(01).
      *
      *    帳票編集テーブル
       01  TBL-HEN-AREA.
           03  TBL-HEN-OCC            OCCURS   200.
               05  TBL-HEN-OCC2            OCCURS   9.
                   07  TBL-NAIYO           PIC X(08).
               05  TBL-MEISYO              PIC X(12).
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMDG         PIC X(22).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC X(02).
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC X(02).
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC X(02).
      *
           03  WRK-HENTIME.
               05  WRK-THH         PIC 99.
               05  FILLER          PIC X(01)   VALUE  ":".
               05  WRK-TMM         PIC 99.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *    ドクター
           COPY  "CPSK1010.INC".
      *    診療科
           COPY  "CPSK1005.INC".
      *
      *    患者番号構成管理情報
           COPY  "CPSK1009.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    診療行為
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    保険組合せ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    収納
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    点数マスタ−
      *01  TENSU-REC.
           COPY    "CPTENSU.INC".
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
      *    数字変換領域
           COPY  "CPORCSNUM.INC".
      *
      *    患者番号変換サブ
           COPY  "CPORCSPTID.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    印刷パラメタ
           COPY    "CPORCSMKPRT.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      *一括用
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "COMMON-SPA".
      *    カルテ３号様式出力パラメタ
           COPY    "CPORCHC33.INC".
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
           ORCHC33AREA
           .
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
      *    初期　処理
           PERFORM 100-INIT-SEC
           IF      FLG-END             =   1
               GO      TO      000-PROC-EXT
           END-IF
      *
      *    メイン処理
           PERFORM 200-MAIN-SEC
      *
           .
       000-PROC-EXT.
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  CNT-AREA
      *
           ACCEPT  SYS-TIME            FROM    TIME
           MOVE    ZERO                TO  WRK-PAGE
      *
           EVALUATE    ORCHC33-KBN
               WHEN    "1"
      *            出力先プリンタ名編集処理
                   PERFORM 110-SYS1031-HENSYU-SEC
           END-EVALUATE
      *
      *    パラメタ編集処理
           PERFORM 120-PARA-HENSYU-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    出力先プリンタ名編集処理
      *****************************************************************
       110-SYS1031-HENSYU-SEC                   SECTION.
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
           IF      ORCSPRTNM-RC    NOT =   ZERO
               MOVE    1                   TO  FLG-END
           END-IF
      *
           .
       110-SYS1031-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       120-PARA-HENSYU-SEC                   SECTION.
      *
      *    患者ＩＤ
           IF      ORCHC33-PTID        =   ZERO
               MOVE    9               TO  ORCHC33-RC
               MOVE    1               TO  FLG-END
               GO      TO      120-PARA-HENSYU-EXT
           END-IF
      *
      *    患者番号
           IF      ORCHC33-PTNUM       =   SPACE
               INITIALIZE                      ORCSPTIDAREA
               MOVE    SPA-HOSPID          TO  SPTID-HOSPID
               MOVE    ORCHC33-PTID        TO  SPTID-PTID
               CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                                   SPA-1009-TBL
               IF      SPTID-RC            =   ZERO
                   MOVE    SPTID-PTNUM     TO  ORCHC33-PTNUM
               ELSE
                   MOVE    9               TO  ORCHC33-RC
                   MOVE    1               TO  FLG-END
                   GO      TO      120-PARA-HENSYU-EXT
               END-IF
           END-IF
      *
      **** 患者マスター検索
      *    INITIALIZE                      PTINF-REC
      *    MOVE    SPA-HOSPID          TO  PTINF-HOSPID
      *    MOVE    ORCHC33-PTID        TO  PTINF-PTID
      *    PERFORM 900-PTINF-READ-SEC
      *    IF      FLG-PTINF           =   1
      *        DISPLAY "*** PTINF  INVALIE:"   PTINF-KEY
      *        MOVE    9               TO  ORCHC33-RC
      *        MOVE    1               TO  FLG-END
      *        GO      TO      120-PARA-HENSYU-EXT
      **** END-IF
      *
      *    診療科
           IF      ORCHC33-SRYKA       =   SPACE  OR  ZERO
               MOVE    SPACE               TO  WRK-SRYKA-MEI
           ELSE
               MOVE    SPACE               TO  SYS-1005-REC
               INITIALIZE                  SYS-1005-REC
               MOVE    "1005"              TO  SYS-1005-KANRICD
               MOVE    ORCHC33-SRYKA       TO  SYS-1005-KBNCD
               MOVE    SYS-1005-REC        TO  MCPDATA-REC
               PERFORM 900-SYSKANRI-READ-SEC
               IF      FLG-SYSKANRI        =   ZERO
                   MOVE    MCPDATA-REC         TO  SYS-1005-REC
                   MOVE    SYS-1005-SRYKANAME2
                                               TO  WRK-SRYKA-MEI
               ELSE
                   MOVE    SPACE               TO  WRK-SRYKA-MEI
               END-IF
           END-IF
      *
      *
      *    診療日
           MOVE    SPACE               TO  WRK-SRYYM-N
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    ORCHC33-SRYYM       TO  LNK-DAY2-YMD(1:6)
           MOVE    "01"                TO  LNK-DAY2-YMD(7:2)
           CALL    "ORCSDAY"           USING  STS-AREA-DAY
                                              LNK-DAY2-AREA
           IF      STS-DAY-RC1         =   ZERO
               STRING      LNK-DAY2-EDTYMD2-G   DELIMITED  BY  SIZE
                           LNK-DAY2-EDTYMD2-Y   DELIMITED  BY  SIZE
                           "年"                 DELIMITED  BY  SIZE
                           LNK-DAY2-EDTYMD2-M   DELIMITED  BY  SIZE
                           "月"                 DELIMITED  BY  SIZE
                                       INTO    WRK-SRYYM-N1
               END-STRING
           ELSE
               MOVE    SPACE               TO  WRK-SRYYM-N1
           END-IF
      *    診療日（終了）
           IF     (ORCHC33-SRYYM-END   =   SPACE )  OR
                  (ORCHC33-SRYYM-END   =   ORCHC33-SRYYM)
               MOVE    SPACE               TO  WRK-SRYYM-N2
           ELSE
               INITIALIZE                  LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    ORCHC33-SRYYM-END   TO  LNK-DAY2-YMD(1:6)
               MOVE    "01"                TO  LNK-DAY2-YMD(7:2)
               CALL    "ORCSDAY"           USING  STS-AREA-DAY
                                                  LNK-DAY2-AREA
               IF      STS-DAY-RC1         =   ZERO
                   STRING      LNK-DAY2-EDTYMD2-G  DELIMITED  BY  SIZE
                               LNK-DAY2-EDTYMD2-Y  DELIMITED  BY  SIZE
                               "年"                DELIMITED  BY  SIZE
                               LNK-DAY2-EDTYMD2-M  DELIMITED  BY  SIZE
                               "月"                DELIMITED  BY  SIZE
                                           INTO    WRK-SRYYM-N2
                   END-STRING
               ELSE
                   MOVE    SPACE               TO  WRK-SRYYM-N2
               END-IF
           END-IF
           IF      WRK-SRYYM-N2        =   SPACE
               STRING      WRK-SRYYM-N1    DELIMITED  BY  SPACE
                           "分"            DELIMITED  BY  SIZE
                                       INTO    WRK-SRYYM-N
               END-STRING
           ELSE
               STRING      WRK-SRYYM-N1    DELIMITED  BY  SPACE
                           "〜"            DELIMITED  BY  SIZE
                           WRK-SRYYM-N2    DELIMITED  BY  SPACE
                           "分"            DELIMITED  BY  SIZE
                                       INTO    WRK-SRYYM-N
               END-STRING
           END-IF
      *
      *    年齢計算（末日時点の年齢とする）
           MOVE    ORCHC33-BIRTHDAY    TO  WRK-YMDS1
           MOVE    ORCHC33-SRYYM       TO  WRK-YMDS2
           MOVE    "31"                TO  WRK-DDS2
           COMPUTE WRK-NENREI-YY       =   WRK-YYS2
                                       -   WRK-YYS1
           IF      WRK-YMDS1(5:4)      >   WRK-YMDS2(5:4)
               COMPUTE WRK-NENREI-YY   =   WRK-NENREI-YY
                                           -   1
               COMPUTE WRK-NENREI-MM   =  (WRK-MMS2  +  12 )
                                           -   WRK-MMS1
           ELSE
               COMPUTE WRK-NENREI-MM   =   WRK-MMS2
                                       -   WRK-MMS1
           END-IF
      *    生年月日
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    ORCHC33-BIRTHDAY    TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING  STS-AREA-DAY
                                              LNK-DAY2-AREA
           IF      STS-DAY-RC1         =   ZERO
               STRING      LNK-DAY2-EDTYMD2-G  DELIMITED  BY  SIZE
                           LNK-DAY2-EDTYMD2-Y  DELIMITED  BY  SIZE
                           "年"                DELIMITED  BY  SIZE
                           LNK-DAY2-EDTYMD2-M  DELIMITED  BY  SIZE
                           "月"                DELIMITED  BY  SIZE
                           LNK-DAY2-EDTYMD2-D  DELIMITED  BY  SIZE
                           "日生"              DELIMITED  BY  SIZE
                                       INTO    WRK-BIRTHDAY
               END-STRING
           ELSE
               MOVE    SPACE               TO  WRK-BIRTHDAY
           END-IF
           .
       120-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    メイン処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           MOVE    ZERO                TO  IDX-T
           MOVE    ZERO                TO  CNT-PAGE
           MOVE    ZERO                TO  CNT-MEI
           MOVE    SPACE               TO  HCM33
      *
           MOVE    ORCHC33-SRYYM       TO  WRK-SRYYM
           IF      ORCHC33-SRYYM-END   =   SPACE
               MOVE    WRK-SRYYM           TO  WRK-SRYYM-END
           ELSE
               MOVE    ORCHC33-SRYYM-END   TO  WRK-SRYYM-END
           END-IF
           PERFORM UNTIL       WRK-SRYYM   >   WRK-SRYYM-END
      *        集計処理
               PERFORM 2001-SYUKEI-SYORI-SEC
      *        印刷処理
               IF      FLG-SYORI           =   1
                   PERFORM 2002-PRINT-SYORI-SEC
               END-IF
      *        診療年月＋１
               COMPUTE WRK-SRYMM           =   WRK-SRYMM    +   1
               IF      WRK-SRYMM           >   12
                   COMPUTE WRK-SRYYY       =   WRK-SRYYY    +   1
                   MOVE    1               TO  WRK-SRYMM
               END-IF
           END-PERFORM
      *
           IF      CNT-MEI             >   ZERO
               PERFORM 2003-HC33-PRINT-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    集計処理
      *****************************************************************
       2001-SYUKEI-SYORI-SEC                SECTION.
      *
           MOVE    ZERO                TO  FLG-SYORI
      *    集計テーブル
           INITIALIZE                  TBL-AREA
           INITIALIZE                  TBL-HKNCOMBI-AREA
      *
      *    診療会計マスターを編集
           INITIALIZE                      SRYACCT-REC 
           MOVE    SPA-HOSPID          TO  ACCT-HOSPID
           MOVE    ORCHC33-NYUGAIKBN   TO  ACCT-NYUGAIKBN
           MOVE    ORCHC33-PTID        TO  ACCT-PTID
           MOVE    WRK-SRYYM           TO  ACCT-SRYYM
           IF      ORCHC33-SRYKA       =   ZERO
               MOVE    "SRYACCT-KEY19"     TO  WRK-ORC-DBPATH
           ELSE
               MOVE    ORCHC33-SRYKA       TO  ACCT-SRYKA
               MOVE    "SRYACCT-KEY18"     TO  WRK-ORC-DBPATH
           END-IF
      *
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-ORC-DBPATH      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-ORC-DBPATH      TO  ORC-DBPATH
               PERFORM 900-SRYACCT-READ-SEC
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1               TO  FLG-SRYACCT
           END-IF
           PERFORM
               UNTIL      (FLG-SRYACCT     =   1   )
      *        保険編集
               PERFORM 20013-HKNCOMBI-HEN-SEC
      *
               IF      ACCT-ZAITEN         >   ZERO
                   MOVE    1                   TO  FLG-SYORI
                   PERFORM 20011-SRYACCT-HEN-SEC
               END-IF
      *
               MOVE    WRK-ORC-DBPATH      TO  ORC-DBPATH
               PERFORM 900-SRYACCT-READ-SEC
           END-PERFORM
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    WRK-ORC-DBPATH      TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *
           .
       2001-SYUKEI-SYORI-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    集計処理
      *****************************************************************
       20011-SRYACCT-HEN-SEC                SECTION.
      *
           EVALUATE    ACCT-SRYKBN(1:1)
      *        診察
               WHEN    "1"
                   MOVE    1               TO  IDX1
      *        投薬
               WHEN    "2"
                   MOVE    2               TO  IDX1
      *        注射
               WHEN    "3"
                   MOVE    3               TO  IDX1
      *        処置・手術
               WHEN    "4"
               WHEN    "5"
                   MOVE    4               TO  IDX1
      *        検査
               WHEN    "6"
                   MOVE    5               TO  IDX1
      *        画像診断
               WHEN    "7"
                   MOVE    6               TO  IDX1
      *        その他
               WHEN    "8"
                   MOVE    7               TO  IDX1
      *        その他
               WHEN    OTHER
                   GO      TO      20011-SRYACCT-HEN-EXT
           END-EVALUATE
      *
           MOVE    ZERO                TO  IDX2
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   200
               IF      TBL-ZAITEN (IDX1 IDX)   =   ZERO
                   MOVE    IDX             TO  IDX2
                   MOVE    200             TO  IDX
               END-IF
           END-PERFORM
           IF      IDX2                =   ZERO
               DISPLAY "** ORCHC33 ZAI TBL 200 OVER **"
               GO      TO      20011-SRYACCT-HEN-EXT
           END-IF
      *
      *    労災・自賠責の時、円分を減算する
           IF     (FLG-HKNKBN          =   1  )  AND
                  (ACCT-SRYKBN         =   "11"
                                       OR  "12"
                                       OR  "13"
                                       OR  "80" ) 
               PERFORM 200111-RSI-ZAITEN-SEC
           ELSE
               MOVE    ACCT-ZAITEN         TO  WRK-ZAITEN
           END-IF
      *
           IF      WRK-ZAITEN          =   ZERO
               GO      TO      20011-SRYACCT-HEN-EXT
           END-IF
      *
      *    点数編集
           MOVE    WRK-ZAITEN          TO  TBL-ZAITEN (IDX1 IDX2)
      *    回数編集
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   31
               MOVE    ACCT-DAY(1  IDX)    TO  TBL-DAY (IDX1 IDX2 IDX)
           END-PERFORM
      *
           .
       20011-SRYACCT-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災・自賠責点数減算処理
      *****************************************************************
       200111-RSI-ZAITEN-SEC                SECTION.
      *
           MOVE    ZERO                TO  WRK-SUM-TEN
      *    診療行為マスター読み込み
           INITIALIZE                      SRYACT-REC
           MOVE    ACCT-HOSPID         TO  SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN      TO  SRY-NYUGAIKBN
           MOVE    ACCT-PTID           TO  SRY-PTID
           MOVE    ACCT-SRYKA          TO  SRY-SRYKA
           MOVE    ACCT-SRYYM          TO  SRY-SRYYM
           MOVE    ACCT-ZAINUM         TO  SRY-ZAINUM
      *    点数検索用日付編集
           MOVE    ACCT-SRYYM          TO  WRK-SRYYMD(1:6)
           MOVE    "01"                TO  WRK-SRYYMD(7:2)
           PERFORM VARYING     IDX-D   FROM    1   BY  1
                   UNTIL       IDX-D   >   31
               IF      ACCT-DAY (1 IDX-D)  NOT =   ZERO
                   MOVE    IDX-D           TO  WRK-SRYYMD(7:2)
                   MOVE    31              TO  IDX-D
               END-IF
           END-PERFORM
      *
           MOVE    SRYACT-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 930-SRYACT-RAED-SEC
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
           PERFORM UNTIL       FLG-SRYACT      =   1
      *        剤明細編集
               PERFORM VARYING     IDZ     FROM    1   BY  1
                       UNTIL      (IDZ         >   5        )  OR
                                  (SRY-SRYCD (IDZ) =   SPACE)
      *            点数マスタ検索
                   IF      (SRY-SRYCD (IDZ)(1:3)   =   "101"  )  OR
                           (SRY-SRYCD (IDZ)(1:5)   =   "09591" OR
                                                       "09592" OR
                                                       "09593" )
                       MOVE    SRY-SRYCD (IDZ)     TO  TNS-SRYCD
                       PERFORM 910-TENSU-READ-SEC
      *                労災の金額算定分の時、点数をゼロとする
                       IF      TNS-TENSIKIBETU     =   1
                           COMPUTE WRK-SUM-TEN     =   WRK-SUM-TEN
                                                   +  (TNS-TEN
                                                   /   10  )
                       END-IF
                   END-IF
               END-PERFORM
      *
               MOVE    "SRYACT-KEY2"       TO  ORC-DBPATH
               PERFORM 930-SRYACT-RAED-SEC
           END-PERFORM
      *
           IF      ACCT-ZAITEN         >=  WRK-SUM-TEN
               COMPUTE WRK-ZAITEN          =   ACCT-ZAITEN
                                           -   WRK-SUM-TEN
           ELSE
               MOVE    ZERO                TO  WRK-ZAITEN
           END-IF
      *
           .
       200111-RSI-ZAITEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ編集処理
      *****************************************************************
       20013-HKNCOMBI-HEN-SEC                SECTION.
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   20
               IF      TBL-HKNCOMBI (IDX)  =   SPACE
                   MOVE    ACCT-HKNCOMBI       TO  TBL-HKNCOMBI (IDX)
                   PERFORM 200131-HKNCOMBI-MEI-SEC
                   MOVE    WRK-HKNCOMBIMEI     TO  TBL-HKNCOMBIMEI(IDX)
                   MOVE    TBL-HKNKBN (IDX)    TO  FLG-HKNKBN
                   MOVE    20                  TO  IDX
               ELSE
                   IF      TBL-HKNCOMBI (IDX)  =   ACCT-HKNCOMBI
                       MOVE    TBL-HKNKBN (IDX)    TO  FLG-HKNKBN
                       MOVE    20              TO  IDX
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       20013-HKNCOMBI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ編集処理
      *****************************************************************
       200131-HKNCOMBI-MEI-SEC                SECTION.
      *
           INITIALIZE                  HKNCOMBI-REC
           MOVE    ACCT-HOSPID         TO  COMB-HOSPID
           MOVE    ACCT-PTID           TO  COMB-PTID
           MOVE    ACCT-HKNCOMBI       TO  COMB-HKNCOMBINUM
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               PERFORM 910-HKNCOMBI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-HKNCOMBI
               INITIALIZE                  HKNCOMBI-REC
           END-IF
      *
           MOVE    SPACE               TO  WRK-HKNCOMBIMEI
           IF      COMB-SYU-TANSEIDONAME   NOT =   SPACE
               MOVE    "・"                TO  WRK-MEI-1
           END-IF
           IF      COMB-KOH1-TANSEIDONAME  NOT =   SPACE
               MOVE    "・"                TO  WRK-MEI-2
           END-IF
           IF      COMB-KOH2-TANSEIDONAME  NOT =   SPACE
               MOVE    "・"                TO  WRK-MEI-3
           END-IF
           IF      COMB-KOH3-TANSEIDONAME  NOT =   SPACE
               MOVE    "・"                TO  WRK-MEI-4
           END-IF
           IF      COMB-KOH4-TANSEIDONAME  NOT =   SPACE
               MOVE    "・"                TO  WRK-MEI-5
           END-IF
           STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                   WRK-MEI-1               DELIMITED  BY  SIZE
                   COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                   WRK-MEI-2               DELIMITED  BY  SIZE
                   COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                   WRK-MEI-3               DELIMITED  BY  SIZE
                   COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                   WRK-MEI-5               DELIMITED  BY  SIZE
                   COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                         INTO              WRK-HKNCOMBIMEI
           END-STRING
      *    最後の’・’をはずす
           PERFORM VARYING    IDX-H    FROM    99  BY  -2
                   UNTIL      IDX-H    <=  1
               IF      WRK-HKNCOMBIMEI(IDX-H:2)     =   "・"
                   MOVE    SPACE           TO  WRK-HKNCOMBIMEI(IDX-H:2)
                   MOVE    2               TO  IDX-H
               END-IF
           END-PERFORM
      *
      *    本人家族区分
           EVALUATE    COMB-HONKZKKBN
               WHEN    "1"
                   MOVE    "本人"          TO  TBL-HONKZKKBN (IDX)
               WHEN    "2"
                   MOVE    "家族"          TO  TBL-HONKZKKBN (IDX)
           END-EVALUATE
      *
           IF      COMB-HKNNUM         =   "971"  OR  "973"
               MOVE    1               TO  TBL-HKNKBN (IDX)
           ELSE
               MOVE    ZERO            TO  TBL-HKNKBN (IDX)
           END-IF
           .
       200131-HKNCOMBI-MEI-EXT.
           EXIT.
      *
      *****************************************************************
      *     印刷処理
      *****************************************************************
       2002-PRINT-SYORI-SEC                SECTION.
      *
           MOVE    ZERO                TO  WRK-TUK-ZAITEN
           MOVE    ZERO                TO  WRK-TUK-SKYMONEY
           MOVE    ZERO                TO  WRK-TUK-RSI-MONEY
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   31
               MOVE    ZERO                TO  FLG-ARI
               MOVE    ZERO                TO  WRK-GOK-ZAITEN
      *        点数
               PERFORM VARYING     IDX1    FROM    1   BY  1
                       UNTIL       IDX1    >   10
                   PERFORM VARYING     IDX2    FROM    1   BY  1
                           UNTIL       IDX2    >   200
                       IF      TBL-DAY (IDX1 IDX2 IDX) >   ZERO
                           PERFORM 20021-TBL-HENSYU-SEC
                       END-IF
                   END-PERFORM
               END-PERFORM
      *        日ごとに編集する
               IF      FLG-ARI             =   1
                   PERFORM 20023-HC33-DAYHEN-SEC
               END-IF
           END-PERFORM
      *
      *    月計印刷
           PERFORM 20024-TUKIKEI-SEC
      *
           .
       2002-PRINT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集テーブル編集処理
      *****************************************************************
       20021-TBL-HENSYU-SEC                SECTION.
      *
           IF      FLG-ARI             =   ZERO
               INITIALIZE                  TBL-HEN-AREA
               MOVE    ZERO                TO  IDX-T1
               MOVE    ZERO                TO  IDX-MAX
           END-IF
           MOVE    1                   TO  FLG-ARI
      *    最終行を求める
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL       IDY     >   200
               IF      TBL-NAIYO (IDY IDX1)    =   SPACE
                   MOVE    IDY             TO  IDX-T1
                   MOVE    200             TO  IDY
               END-IF
           END-PERFORM
      *
           MOVE    TBL-ZAITEN (IDX1 IDX2)  TO  WRK-Z59
           COMPUTE WRK-GOK-ZAITEN      =   WRK-GOK-ZAITEN
                                       +  (TBL-ZAITEN (IDX1 IDX2)
                                       *   TBL-DAY (IDX1 IDX2 IDX) )
      *
           IF     (IDX1                =   2  OR  3 )  OR
                  (TBL-DAY (IDX1 IDX2 IDX) >  1     )
      *        回数あり
               MOVE    TBL-DAY (IDX1 IDX2 IDX) TO  WRK-Z9
               MOVE    WRK-Z59         TO  TBL-NAIYO(IDX-T1 IDX1)(1:5)
               MOVE    "x"             TO  TBL-NAIYO(IDX-T1 IDX1)(6:1)
               MOVE    WRK-Z9          TO  TBL-NAIYO(IDX-T1 IDX1)(7:2)
           ELSE
      *        点数のみ
               MOVE    WRK-Z59         TO  TBL-NAIYO(IDX-T1 IDX1)
           END-IF
      *    最大行編集
           IF      IDX-T1              >   IDX-MAX
               MOVE    IDX-T1          TO  IDX-MAX
           END-IF
      *
           .
       20021-TBL-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    日ごとに編集処理
      *****************************************************************
       20023-HC33-DAYHEN-SEC           SECTION.
      *
      *    収納より負担金編集
           MOVE    IDX                 TO  WRK-DAY
           PERFORM 200231-SYUNOU-HEN-SEC
      *
      *    診療日
           MOVE    WRK-SRYMM           TO  WRK-H-MM
           MOVE    "."                 TO  WRK-H-P
           MOVE    WRK-DAY             TO  WRK-H-DD
      *
      *    点数合計
           MOVE    WRK-GOK-ZAITEN      TO  WRK-Z89
           MOVE    WRK-Z89             TO  TBL-NAIYO(01 08)
      *    月点数合計
           ADD     WRK-GOK-ZAITEN      TO  WRK-TUK-ZAITEN
      *
           PERFORM VARYING     IDX1    FROM    1   BY  1
                   UNTIL       IDX1    >   IDX-MAX
               ADD     1                   TO  CNT-MEI
               IF      CNT-MEI             >   40
      *            印刷処理
                   PERFORM 2003-HC33-PRINT-SEC
                   MOVE    1                   TO  CNT-MEI
               END-IF
               IF      CNT-MEI             =   1
                   PERFORM 20031-HEAD-HEN-SEC
               END-IF
      *
      *        日付
               IF      IDX1                =   1
                   MOVE    WRK-HEN-DAY     TO  HCM33-SRYMD (CNT-MEI)
               END-IF
               PERFORM VARYING     IDX2    FROM    1   BY  1
                       UNTIL       IDX2    >   9
                   MOVE    TBL-NAIYO (IDX1 IDX2)   TO  HCM33-NAIYO
                                                          (CNT-MEI IDX2)
               END-PERFORM
               MOVE    TBL-MEISYO (IDX1)   TO  HCM33-BIKOU (CNT-MEI)
           END-PERFORM
      *
           .
       20023-HC33-DAYHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納編集処理
      *****************************************************************
       200231-SYUNOU-HEN-SEC           SECTION.
      *
           MOVE    ZERO                TO  IDX-T1
           MOVE    ZERO                TO  WRK-GOK-JIHIKEI
      *
      *    収納テーブル読み込み
           MOVE    SPACE               TO  SYUNOU-REC
           INITIALIZE                  SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    ORCHC33-NYUGAIKBN   TO  SYU-NYUGAIKBN
           MOVE    ORCHC33-PTID        TO  SYU-PTID
           MOVE    WRK-SRYYM           TO  SYU-SRYYMD(1:6)
           MOVE    WRK-DAY             TO  SYU-SRYYMD(7:2)
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY14"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYUNOU-KEY14"     TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYUNOU-REC
               INITIALIZE                  SYUNOU-REC
               MOVE    1               TO  FLG-SYUNOU
           END-IF
           PERFORM UNTIL    FLG-SYUNOU     =   1
      *
               IF      (ORCHC33-SRYKA  NOT =   ZERO  AND  SPACE) AND
                       (ORCHC33-SRYKA  NOT =   SYU-SRYKA)
                   CONTINUE
               ELSE
      *            自費計
                   COMPUTE WRK-JIHIKEI     =   SYU-JIHI-TOTAL
                                           +   SYU-JIHI-TOTAL-TAX
                                           +   SYU-JIHI-TAX
                                           +   SYU-TOTAL-TGMONEY
                                           +   SYU-TOTAL-TGMONEY-TAX
                   ADD     WRK-JIHIKEI         TO  WRK-GOK-JIHIKEI
      *            請求金額−自費計
                   COMPUTE WRK-SKYMONEY    =   SYU-SKYMONEY
                                           -   WRK-JIHIKEI
      *            負担額
                   ADD     1                   TO  IDX-T1
                   MOVE    WRK-SKYMONEY        TO  WRK-Z79S
                   MOVE    WRK-Z79S            TO  TBL-NAIYO (IDX-T1 9)
      *            月計負担額
                   ADD     WRK-SKYMONEY        TO  WRK-TUK-SKYMONEY
      *            労災・自賠責金額
                   COMPUTE WRK-RSI-MONEY       =   SYU-RSISHOSHIN-MONEY
                                               +   SYU-RSISAISHIN-MONEY
                                               +   SYU-RSISDO-MONEY
                                               +   SYU-RSISDO-MONEY
                   IF      WRK-RSI-MONEY       >   ZERO
                       ADD     1                   TO  IDX-T1
                       MOVE    WRK-RSI-MONEY       TO  WRK-Z89
                       MOVE    WRK-Z89             TO  TBL-NAIYO
                                                           (IDX-T1 9)
                       MOVE    "*"                 TO  TBL-NAIYO
                                                           (IDX-T1 9)
                                                                (1:1)
                       MOVE    "（労・自）"        TO  TBL-MEISYO
                                                            (IDX-T1)
                       ADD     WRK-RSI-MONEY       TO  WRK-TUK-RSI-MONEY
                   END-IF
               END-IF
      *
               MOVE    "SYUNOU-KEY14"     TO  ORC-DBPATH
               PERFORM 980-SYUNOU-READ-SEC
           END-PERFORM
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
      *    CALL    "MCPDBSUB"          USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
      *    最大行編集
           IF      IDX-T1              >   IDX-MAX
               MOVE    IDX-T1          TO  IDX-MAX
           END-IF
      *
      *    自費
           IF      WRK-GOK-JIHIKEI     NOT =   ZERO
               MOVE    WRK-GOK-JIHIKEI     TO  WRK-Z89
      *        最終行へ
               IF     (TBL-NAIYO (IDX-MAX 8)   NOT =   SPACE )  OR
                      (TBL-NAIYO (IDX-MAX 9)   NOT =   SPACE )
                   ADD     1                   TO  IDX-MAX
               END-IF
               MOVE    WRK-Z89             TO  TBL-NAIYO (IDX-MAX 9)
               MOVE    "保険外"            TO  TBL-MEISYO (IDX-MAX)
           END-IF
      *
      *
           .
       200231-SYUNOU-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    月計印刷処理
      *****************************************************************
       20024-TUKIKEI-SEC                SECTION.
      *
           ADD     1                   TO  CNT-MEI
           IF      CNT-MEI             >   40
      *        印刷処理
               PERFORM 2003-HC33-PRINT-SEC
               MOVE    1                   TO  CNT-MEI
           END-IF
           IF      CNT-MEI             =   1
               PERFORM 20031-HEAD-HEN-SEC
           END-IF
           MOVE    "月合計"            TO  HCM33-BIKOU (CNT-MEI)
           MOVE    WRK-TUK-ZAITEN      TO  WRK-Z89
           MOVE    WRK-Z89             TO  HCM33-NAIYO (CNT-MEI 8)
           MOVE    WRK-TUK-SKYMONEY    TO  WRK-Z89
           MOVE    WRK-Z89             TO  HCM33-NAIYO (CNT-MEI 9)
      *
           IF      WRK-TUK-RSI-MONEY   =   ZERO
               GO      TO      20024-TUKIKEI-EXT
           END-IF
      *
      *    労災・自賠責金額計処理
           ADD     1                   TO  CNT-MEI
           IF      CNT-MEI             >   40
               PERFORM 2003-HC33-PRINT-SEC
               MOVE    1                   TO  CNT-MEI
           END-IF
           IF      CNT-MEI             =   1
               PERFORM 20031-HEAD-HEN-SEC
           END-IF
           MOVE    "（労・自）"        TO  HCM33-BIKOU (CNT-MEI)
           MOVE    WRK-TUK-RSI-MONEY   TO  WRK-Z89
           MOVE    WRK-Z89             TO  HCM33-NAIYO (CNT-MEI 9)
           MOVE    "*"                 TO  HCM33-NAIYO (CNT-MEI 9)(1:1)
      *
           .
       20024-TUKIKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    カルテ見出し編集処理
      *****************************************************************
       20031-HEAD-HEN-SEC             SECTION.
      *
           MOVE    SPACE               TO  HCM33
           INITIALIZE                      HCM33
      *
           ADD     1                   TO  ORCHC33-PAGE
           MOVE    ORCHC33-PAGE        TO  WRK-ZZ9
           MOVE    WRK-ZZ9             TO  HCM33-PAGE
      *
           MOVE    ORCHC33-PTNUM       TO  HCM33-PTNUM
      *    患者マスターより
      *    患者氏名
           MOVE    ORCHC33-NAME        TO  HCM33-NAME
      *    性別
           EVALUATE    ORCHC33-SEX(1:1)
               WHEN    "1"
                   MOVE    "男"                TO  HCM33-SEX
               WHEN    "2"
                   MOVE    "女"                TO  HCM33-SEX
               WHEN    OTHER
                   MOVE    ORCHC33-SEX         TO  HCM33-SEX
           END-EVALUATE
      *
           MOVE    WRK-BIRTHDAY        TO  HCM33-TANJYOBI
      *　　年齢
           IF      WRK-NENREI-YY       >   ZERO
               MOVE    WRK-NENREI-YY       TO  WRK-ZZ9
               MOVE    WRK-ZZ9             TO  HCM33-NENREI
               MOVE    "才"                TO  HCM33-NENREIMEI
           ELSE
               MOVE    WRK-NENREI-MM       TO  WRK-ZZ9
               MOVE    WRK-ZZ9             TO  HCM33-NENREI
               MOVE    "ヶ月"              TO  HCM33-NENREIMEI
           END-IF
      *    診療科
           MOVE    WRK-SRYKA-MEI       TO  HCM33-SRYKA
      *    期間
           MOVE    WRK-SRYYM-N         TO  HCM33-SRYYM
      *
      *    保険名称
           PERFORM VARYING     IDX-H   FROM    1   BY  1
                   UNTIL      (IDX-H   >   20  )  OR
                              (TBL-HKNCOMBI (IDX-H)  =   SPACE )
               MOVE    WRK-HEN-HKNCOMBIMEI     TO  WRK-HKNCOMBIMEI
               MOVE    SPACE                   TO  WRK-HEN-HKNCOMBIMEI
               MOVE    SPACE                   TO  WRK-MEI-1
               MOVE    TBL-HONKZKKBN (IDX-H)   TO  WRK-HONKZKKBN
               MOVE    "　"                    TO  WRK-HONKZKKBN(5:2)
               IF      IDX-H               >   1
                   MOVE    "／"                TO  WRK-MEI-1
                   IF      TBL-HONKZKKBN (IDX-H)   =
                                               TBL-HONKZKKBN (IDX-H - 1)
                       MOVE    SPACE           TO  WRK-HONKZKKBN
                   END-IF
               END-IF
               STRING  WRK-HKNCOMBIMEI         DELIMITED  BY  SPACE
                       WRK-MEI-1               DELIMITED  BY  SPACE
                       WRK-HONKZKKBN           DELIMITED  BY  SPACE
                       TBL-HKNCOMBIMEI(IDX-H)  DELIMITED  BY  SPACE
                                           INTO    WRK-HEN-HKNCOMBIMEI
               END-STRING
           END-PERFORM
           MOVE    WRK-HEN-HKNCOMBIMEI     TO  HCM33-HKNSYUBETU
           .
       20031-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    カルテ印刷処理
      *****************************************************************
       2003-HC33-PRINT-SEC                SECTION.
      *
           EVALUATE    ORCHC33-KBN
      *        オンライン印刷
               WHEN    "1"
                   PERFORM 20031-HC33-ONL-SEC
      *        バッチ印刷
               WHEN    "2"
                   PERFORM 20032-HC33-BAT-SEC
           END-EVALUATE
           .
       2003-HC33-PRINT-EXT.
           EXIT.
      *
      *****************************************************************
      *    カルテ印刷処理（オンライン）
      *****************************************************************
       20031-HC33-ONL-SEC                SECTION.
      *
      *    ファイルＯＰＥＮ
           MOVE    "HC01"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
           ADD     1                   TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  HC01PARA-CNT
           OPEN    OUTPUT              PRT-FILE
      *    印刷用データ出力
           MOVE    HCM33               TO  PRT-REC
           WRITE   PRT-REC
      *
           CLOSE                       PRT-FILE
      *
            INITIALIZE                 ORCSMKPRTAREA
            MOVE   "HC01.sh"           TO  MKPRT-ID
            MOVE   "HCM33.red"         TO  MKPRT-DIA
            MOVE   SPACE               TO  MKPRT-DEF
            MOVE   HC01PARA            TO  MKPRT-DAT
            MOVE   SYS-1031-PRTNM(10)  TO  MKPRT-PRTNM
      *TEST
      *システム管理ができるまで
            MOVE   SYS-1031-PRTNM(1)   TO  MKPRT-PRTNM
      *TEST
            CALL   "ORCSMKPRT"         USING
                                       ORCSMKPRTAREA
      *
           .
       20031-HC33-ONL-EXT.
           EXIT.
      *****************************************************************
      *    カルテ印刷処理（バッチ）
      *****************************************************************
       20032-HC33-BAT-SEC         SECTION.
      *
           MOVE    ORCHC33-PRTAREA     TO  ORCSPRTAREA
      *
           MOVE    HCM33               TO  SPRT-PRTDATA
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               MOVE    9               TO  ORCHC33-RC
           END-IF
      *
           MOVE    ORCSPRTAREA        TO  ORCHC33-PRTAREA
      *
           .
       20032-HC33-BAT-EXT.
           EXIT.
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
      *    診療行為マスター読込
      *****************************************************************
       920-SRYACT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYACT-REC
               MOVE    ZERO                TO  FLG-SRYACT
           ELSE
               INITIALIZE                      SRYACT-REC
               MOVE    1                   TO  FLG-SRYACT
           END-IF
      *
           .
       920-SRYACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計マスタ読み込み
      *****************************************************************
       900-SRYACCT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYACCT-REC
               MOVE    ZERO                TO  FLG-SRYACCT
           ELSE
               INITIALIZE                      SRYACCT-REC
               MOVE    1                   TO  FLG-SRYACCT
           END-IF
      *
           .
       900-SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    主キー管理マスタ読み込み
      *****************************************************************
       900-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
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
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
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
       900-SYSKANRI-READ-EXT.
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
      *    診療行為マスター読込
      *****************************************************************
       930-SRYACT-RAED-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYACT-REC
               MOVE    ZERO                TO  FLG-SRYACT
           ELSE
               INITIALIZE                      SRYACT-REC
               MOVE    1                   TO  FLG-SRYACT
           END-IF
      *
           .
       930-SRYACT-RAED-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込
      *****************************************************************
       910-TENSU-READ-SEC         SECTION.
      *
           MOVE    ZERO                TO  TNS-YUKOSTYMD
           MOVE    ALL "9"             TO  TNS-YUKOEDYMD
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           MOVE    WRK-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TENSU-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   INITIALIZE                  TNS-TENSU-REC
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "TENSU-KEY"         TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      *                                 MCPDATA-REC
      *
           .
       910-TENSU-READ-EXT.
           EXIT.
      *
