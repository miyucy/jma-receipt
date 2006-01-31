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
       PROGRAM-ID.             ORCT0020.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 定期請求
      *  コンポーネント名  : 請求書出力
      *  管理者            :
      *  作成日付    作業者        記述
      *  02/12/19    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    03.03.13  入院請求書複数枚一括印刷対応
      *  01.00.02    NACL-太田    03.03.18  入院カスタマイズ帳票対応
      *  01.00.03    NACL-太田    03.07.01  出力先プリンタサブ追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    エラーファイル
           SELECT  TEIKIERR-FILE   ASSIGN  TEIKIERR
                                   FILE    STATUS  IS  STS-TEIKIERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
      *    エラーファイル
       FD  TEIKIERR-FILE.
       01  TEIKIERR-REC                    PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT5.INC"      REPLACING  //TEIKI01PARA//
                                           BY         //TEIKIERR//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-TEIKIERR                PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-ERR                     PIC 9(01).
           03  FLG-END                     PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-SYUNOU                  PIC 9(01).
           03  FLG-SYUMEI                  PIC 9(01).
           03  FLG-TEIKIPRT                PIC 9(01).
           03  FLG-TAISYO                  PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-OUT1                    PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDX1                        PIC 9(04). 
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-DBPATH                  PIC X(100).
      *
           03  WRK-YMD.
               05  WRK-YY                  PIC 9(04).
               05  WRK-MM                  PIC 9(02).
               05  WRK-DD                  PIC 9(02).
           03  WRK-PRINT-PG                PIC X(20).
           03  WRK-NYUKIN-HOHO             PIC X(02).
           03  WRK-NYUKIN-JYOTAI           PIC X(01).
           03  WRK-NYUKIN-KBN              PIC X(01).
           03  WRK-NYUKINPRT-KBN           PIC X(01).
      *
       01  SRH-AREA.
           03  SRH-IDX                     PIC 9(05).
           03  SRH-1041-DAT.
               05  SRH-1041-JYOTAI         PIC X(01).
               05  SRH-1041-MAX            PIC 9(05).
               05  SRH-1041-OCC            OCCURS  99.
                   07  SRH-1041-KBNCDL     PIC X(02).
                   07  SRH-1041-JYOTAIL    PIC X(01).
      *
       01  ERR-EDIT-AREA.
           03  ERR-WARNING                 PIC 9(01).
           03  ERR-PTID                    PIC 9(10).
           03  ERR-PTNUM                   PIC X(20).
           03  ERR-ERRCD                   PIC X(04).
           03  ERR-ERRMSG                  PIC X(80).
           03  ERR-HEN-ERRMSG              PIC X(80).
      *
       01  ERR-MSG-AREA.
           03  ERR-MSG01                   PIC X(100)    VALUE
               "出力順の取得に失敗しました".
           03  ERR-MSG02                   PIC X(100)    VALUE
               "収納情報の取得に失敗しました".
           03  ERR-MSG03                   PIC X(100)    VALUE
               "患者定期請求情報の取得に失敗しました".
           03  ERR-MSG04                   PIC X(100)    VALUE
               "処理対象のデータがありませんでした".
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
      *
      *    定期請求一括処理パラメータ
           COPY    "CPTEIKI2PARA.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    帳票ＰＧ名
           COPY    "CPSK1035.INC".
      *
      *    入金方法
           COPY  "CPSK1041.INC".
      *
      *    定期請求情報
           COPY    "CPSK5010.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    収納明細
       01  SYUMEI-REC.
           COPY    "CPSYUMEI.INC".
      *
      *    患者定期請求履歴
       01  PTTEIKIRRK-REC.
           COPY    "CPPTTEIKIRRK.INC".
      *
      *    定期請求印刷
       01  TEIKIPRT-REC.
           COPY    "CPTEIKIPRT.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *    帳票サブ < 請求書兼領収書 >
           COPY    "CPORCHCN03.INC".
      *
      *    オンライン帳票名・出力先プリンタ名取得パラ
           COPY    "CPORCSPRTNM.INC".
      *
      ****************************************************************
       LINKAGE                         SECTION.
      *
           COPY    "CPCOMMAND-PARAM.INC".
      *
      ****************************************************************
       PROCEDURE                       DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-TERM-SEC
      *
           PERFORM 990-PROGRAM-FINISH-SEC
      *
           .
       000-PROC-EXT.
           EXIT.
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
                                       ERR-EDIT-AREA
      *
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    TEIKI2P-PRTJYUN
                                               TEIKI2P-BTUNUM-MAX
                                               TEIKI2P-BTUNUM-TBL
                                               TEIKI2P-SYSYMD
                                               TEIKI2P-TERMID
                                               TEIKI2P-JOBID
                                               TEIKI2P-SHELLID
                                               TEIKI2P-HOSPID
                                               TEIKI2P-STAFFCD
                                               TEIKI2P-ERRFILE
                                               TEIKI2P-SKYPRT
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    TEIKI2P-JOBID       TO  JOB-JOBID
           MOVE    TEIKI2P-SHELLID     TO  JOB-SHELLID
           MOVE    "ORCT0020"          TO  JOB-PGID
           MOVE    "請求書出力"
                                       TO  JOB-SHELLMSG
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
      *
           MOVE    TEIKI2P-ERRFILE     TO  TEIKIERR
      *
      *    定期請求情報
           INITIALIZE                      SYS-5010-REC
           MOVE    "5010"              TO  SYS-5010-KANRICD
           MOVE    "*"                 TO  SYS-5010-KBNCD
           MOVE    TEIKI2P-SYSYMD      TO  ORC-DBYMD
           MOVE    SYS-5010-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-5010-REC
           ELSE
               INITIALIZE                  SYS-5010-REC
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           PERFORM 1001-SRH-1041-HEN-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    入金方法
      *****************************************************************
       1001-SRH-1041-HEN-SEC               SECTION.
      *
      *    入金方法
           MOVE    ZERO            TO  SRH-1041-MAX
      *
           INITIALIZE                  SYS-1041-REC
           MOVE    "1041"          TO  SYS-1041-KANRICD
           MOVE    TEIKI2P-SYSYMD  TO  ORC-DBYMD
           MOVE    SYS-1041-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-1041-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SYSKANRI    NOT =   ZERO )
                    OR   ( SRH-1041-MAX    >=  99 )
      *
               COMPUTE SRH-1041-MAX    =   SRH-1041-MAX    +   1
      *
               MOVE    SYS-1041-KBNCD  TO  SRH-1041-KBNCDL
                                                        (SRH-1041-MAX)
      *
               IF    ( SYS-1041-NYKN-JYOTAI-T  =   SPACE )
                   MOVE    "3"     TO  SRH-1041-JYOTAIL (SRH-1041-MAX)
               ELSE
                   MOVE    SYS-1041-NYKN-JYOTAI-T
                                   TO  SRH-1041-JYOTAIL (SRH-1041-MAX)
               END-IF
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
               IF    ( FLG-SYSKANRI        =   ZERO )
                   MOVE    MCPDATA-REC TO  SYS-1041-REC
               END-IF
      *
           END-PERFORM
      *
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       1001-SRH-1041-HEN-EXT.
           EXIT.
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           MOVE    ZERO                TO  FLG-TEIKIPRT
      *
      *    出力順を取得
           MOVE    SPACE               TO  WRK-DBPATH
           EVALUATE    TEIKI2P-PRTJYUN
           WHEN    "01"
               MOVE    "TEIKIPRT-KEY2" TO  WRK-DBPATH
           WHEN    "02"
               MOVE    "TEIKIPRT-KEY3" TO  WRK-DBPATH
           WHEN    "03"
               MOVE    "TEIKIPRT-KEY4" TO  WRK-DBPATH
           WHEN    "04"
               MOVE    "TEIKIPRT-KEY5" TO  WRK-DBPATH
           WHEN    OTHER
                MOVE  "0001"           TO  ERR-ERRCD
                PERFORM 500-ERR-HENSYU-SEC
           END-EVALUATE
      *
      *    定期請求印刷情報検索
           MOVE    SPACE               TO  MCPDATA-REC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  TEIKIPRT-REC
           ELSE
               INITIALIZE                  TEIKIPRT-REC
               MOVE    1               TO  FLG-TEIKIPRT
           END-IF
      *
           INITIALIZE  ORCHCN03AREA
           MOVE    TEIKI2P-HOSPID      TO  ORCHCN03-HEAD-HOSPID
           MOVE    TEIKI2P-STAFFCD     TO  ORCHCN03-STAFFCD
           MOVE    TEIKI2P-SYSYMD      TO  ORCHCN03-SYSYMD
           MOVE    TEIKI2P-TERMID      TO  ORCHCN03-TERMID
      *
           PERFORM UNTIL ( FLG-TEIKIPRT    NOT =   ZERO )
      *
               PERFORM 20011-HENSYU-SEC
      *
               MOVE    WRK-DBPATH      TO  ORC-DBPATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC              =   ZERO )
                   MOVE    MCPDATA-REC TO  TEIKIPRT-REC
               ELSE
                   INITIALIZE              TEIKIPRT-REC
                   MOVE    1           TO  FLG-TEIKIPRT
               END-IF
      *
           END-PERFORM
      *
           MOVE     CNT-OUT1           TO  ORCHCN03-CNT
      *
      *    帳票プログラム名取得
           PERFORM 20011-PRINT-PG-EDIT-SEC
      *
      *    入院請求書印刷
           IF    ( ORCHCN03-CNT    >   ZERO )
               CALL    WRK-PRINT-PG    USING   ORCHCN03AREA
           END-IF
      *
      *    カーソルクロース
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           MOVE    1                   TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *   帳票プログラム名編集処理
      *****************************************************************
       20011-PRINT-PG-EDIT-SEC         SECTION.
      *
           INITIALIZE                      WRK-PRINT-PG
      *
           INITIALIZE  SPA-AREA
           MOVE    TEIKI2P-HOSPID      TO  SPA-HOSPID
           MOVE    TEIKI2P-STAFFCD     TO  SPA-STAFFCD
      *
           INITIALIZE                      ORCSPRTNMAREA
           MOVE    "1"                 TO  ORCSPRTNM-KBN
           MOVE    "00000003"          TO  ORCSPRTNM-KBNCD
           MOVE    TEIKI2P-SYSYMD      TO  ORCSPRTNM-SRYYMD
           MOVE    "1"                 TO  ORCSPRTNM-NYUGAIKBN
           CALL    "ORCSPRTNM"         USING
                                           ORCSPRTNMAREA
                                           SPA-AREA
                                           SYS-1035-REC
           IF    ( ORCSPRTNM-RC        =   ZERO )
              MOVE    ORCSPRTNM-PRTPG  TO  WRK-PRINT-PG
           ELSE
              MOVE    "ORCHCN03"       TO  WRK-PRINT-PG
           END-IF
      *
           .
       20011-PRINT-PG-EDIT-EXT.
           EXIT.
      *****************************************************************
      *   編集処理
      *****************************************************************
       20011-HENSYU-SEC              SECTION.
      *
           IF    ( TEIKI2P-PRTJYUN     = "01"  OR  "02" )
               MOVE    ZERO            TO  FLG-TAISYO
      *        該当病棟でない場合は読み飛ばす
               PERFORM VARYING IDX1    FROM    1   BY  1
                       UNTIL ( IDX1    >   TEIKI2P-BTUNUM-MAX )
      *
                   IF    ( TEIKIPRT-BTUNUM =   TEIKI2P-BTUNUM (IDX1) )
                       MOVE    1       TO  FLG-TAISYO
                       MOVE    TEIKI2P-BTUNUM-MAX
                                       TO  IDX1
                   END-IF
      *
               END-PERFORM
               IF    ( FLG-TAISYO      =   ZERO )
                   GO  TO  20011-HENSYU-EXT
               END-IF
           END-IF
      *
      *    患者情報を検索する
           MOVE    TEIKIPRT-HOSPID     TO  PTINF-HOSPID
           MOVE    TEIKIPRT-PTID       TO  PTINF-PTID
           PERFORM 900-PTINF-KEY-SEL-SEC
      *
      *    入金方法取得
           PERFORM 200111-NYUKIN-HOHO-HEN-SEC
      *
      *    収納データを検索する
           INITIALIZE  SYUNOU-REC
           MOVE    TEIKIPRT-HOSPID     TO  SYU-HOSPID
           MOVE    "1"                 TO  SYU-NYUGAIKBN
           MOVE    TEIKIPRT-PTID       TO  SYU-PTID
           MOVE    TEIKIPRT-DENPNUM    TO  SYU-DENPNUM
      *
           PERFORM 900-SYUNOU-KEY-SEL-SEC
           IF    ( FLG-SYUNOU      NOT =   ZERO )
                MOVE  "0002"           TO  ERR-ERRCD
                PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    患者定期請求履歴データを検索する
           INITIALIZE  PTTEIKIRRK-REC
           MOVE    TEIKIPRT-HOSPID     TO  PTTEIKIRRK-HOSPID
           MOVE    TEIKIPRT-PTID       TO  PTTEIKIRRK-PTID
           MOVE    TEIKIPRT-DENPNUM    TO  PTTEIKIRRK-DENPNUM
      *
           MOVE    PTTEIKIRRK-REC      TO  MCPDATA-REC
      *
           MOVE    "PTTEIKIRRK-KEY6"   TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTTEIKIRRK-REC
           ELSE
                MOVE  "0003"           TO  ERR-ERRCD
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           MOVE    "PTTEIKIRRK-KEY6"   TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( TEIKI2P-SKYPRT      =   "2" )
               IF    ( PTTEIKIRRK-SKYMONEY <=   ZERO )
                   GO  TO  20011-HENSYU-EXT
               END-IF
           END-IF
      *
           COMPUTE CNT-OUT1    =   CNT-OUT1    +   1
      *
      *    請求書サブ患者情報パラメタ設定
           MOVE    SYU-SKYSTYMD        TO  ORCHCN03-KJNYMD    (CNT-OUT1)
           MOVE    TEIKIPRT-HOSPID     TO  ORCHCN03-HOSPID    (CNT-OUT1)
           MOVE    TEIKIPRT-PTID       TO  ORCHCN03-PTID      (CNT-OUT1)
           MOVE    TEIKIPRT-PTNUM      TO  ORCHCN03-PTNUM     (CNT-OUT1)
           MOVE    "1"                 TO  ORCHCN03-NYUGAIKBN (CNT-OUT1)
      *
           MOVE    SYU-DENPNUM         TO  ORCHCN03-DENPNUM   (CNT-OUT1)
           MOVE    PTTEIKIRRK-SKYMONEY-TAX-SAI
                                       TO  ORCHCN03-SEIKYU-TAX-SAI
                                                              (CNT-OUT1)
           MOVE    PTTEIKIRRK-SKYMONEY TO  ORCHCN03-SEIKYU    (CNT-OUT1)
      *
           MOVE    ZERO                TO  ORCHCN03-NYUKIN    (CNT-OUT1)
      *
           IF    ( WRK-NYUKIN-KBN      =   "2" )
            AND  ( WRK-NYUKINPRT-KBN   =   "2" )
               IF    ( PTTEIKIRRK-SKYMONEY >   ZERO )
                   INITIALIZE              SYUMEI-REC
                   MOVE    PTTEIKIRRK-HOSPID       TO  SMEI-HOSPID
                   MOVE    "1"                     TO  SMEI-NYUGAIKBN
                   MOVE    PTTEIKIRRK-PTID         TO  SMEI-PTID
                   MOVE    PTTEIKIRRK-DENPNUM      TO  SMEI-DENPNUM
                   MOVE    PTTEIKIRRK-DENPEDANUM   TO  SMEI-DENPEDANUM
                   PERFORM 900-SYUMEI-KEY-SEL-SEC
                   MOVE    SMEI-NYUHEN-MONEY
                                       TO  ORCHCN03-NYUKIN    (CNT-OUT1)
               END-IF
           END-IF
      *
           IF    ( PTTEIKIRRK-SKYUPDFLG    =   1 )
               MOVE    2               TO  ORCHCN03-HAKKOFLG  (CNT-OUT1)
           ELSE
               MOVE    ZERO            TO  ORCHCN03-HAKKOFLG  (CNT-OUT1)
           END-IF
      *
           .
       20011-HENSYU-EXT.
           EXIT. 
      *
      *****************************************************************
      *    入金方法編集処理
      *****************************************************************
       200111-NYUKIN-HOHO-HEN-SEC      SECTION.
      *
           MOVE    "01"            TO  WRK-NYUKIN-HOHO
           MOVE    "3"             TO  WRK-NYUKIN-JYOTAI
           MOVE    SPACE           TO  WRK-NYUKIN-KBN
           MOVE    SPACE           TO  WRK-NYUKINPRT-KBN
      *
           IF    ( PTINF-NYUKIN-HOHO   NOT =   SPACE )
               MOVE    PTINF-NYUKIN-HOHO
                                   TO  WRK-NYUKIN-HOHO
           END-IF
      *
           MOVE    SPACE           TO  SRH-1041-JYOTAI
           PERFORM VARYING SRH-IDX FROM    1   BY  1
                   UNTIL ( SRH-IDX >   SRH-1041-MAX )
                    OR   ( SRH-1041-JYOTAI NOT =   SPACE )
      *
               IF    ( WRK-NYUKIN-HOHO =   SRH-1041-KBNCDL (SRH-IDX))
                   MOVE    SRH-1041-JYOTAIL (SRH-IDX)
                                   TO  SRH-1041-JYOTAI
               END-IF
      *
           END-PERFORM
      *
           IF    ( SRH-1041-JYOTAI NOT =   SPACE )
               MOVE    SRH-1041-JYOTAI TO  WRK-NYUKIN-JYOTAI
           END-IF
      *
           EVALUATE    WRK-NYUKIN-JYOTAI
           WHEN    "1"
               MOVE    "2"             TO  WRK-NYUKIN-KBN
               IF    ( SYS-5010-NYUKINKBN  =   "2" )
                   MOVE    SYS-5010-NYUKINPRTKBN
                                       TO  WRK-NYUKINPRT-KBN
               ELSE
                   MOVE    "2"         TO  WRK-NYUKINPRT-KBN
               END-IF
           WHEN    "2"
               MOVE    "1"             TO  WRK-NYUKIN-KBN
           WHEN    "3"
               MOVE    SYS-5010-NYUKINKBN
                                       TO  WRK-NYUKIN-KBN
               MOVE    SYS-5010-NYUKINPRTKBN
                                       TO  WRK-NYUKINPRT-KBN
           WHEN    OTHER
               MOVE    SYS-5010-NYUKINKBN
                                       TO  WRK-NYUKIN-KBN
               MOVE    SYS-5010-NYUKINPRTKBN
                                       TO  WRK-NYUKINPRT-KBN
           END-EVALUATE
      *
           .
       200111-NYUKIN-HOHO-HEN-EXT.
           EXIT. 
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC              SECTION.
      *
           PERFORM 800-GET-ERRMSG-SEC
      *
           OPEN    OUTPUT              TEIKIERR-FILE
      *
           MOVE    ERR-ERRMSG      TO  TEIKIERR-REC
           WRITE   TEIKIERR-REC
           CLOSE   TEIKIERR-FILE
      *
      *    ジョブ管理終了処理
           MOVE    "JBE"           TO  SJOBKANRI-MODE
      *
           INITIALIZE                  JOBKANRI-REC
           MOVE    TEIKI2P-JOBID   TO  JOB-JOBID
           MOVE    TEIKI2P-SHELLID
                                   TO  JOB-SHELLID
           MOVE    ERR-ERRMSG      TO  JOB-YOBI
           MOVE    ERR-ERRCD       TO  JOB-ERRCD
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           MOVE    1               TO  FLG-ERR
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
      *    プログラム終了処理
           PERFORM 990-PROGRAM-FINISH-SEC
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ取得処理
      *****************************************************************
       800-GET-ERRMSG-SEC              SECTION.
      *
           EVALUATE    ERR-ERRCD
           WHEN    "0001"
               MOVE    ERR-MSG01       TO  ERR-ERRMSG
           WHEN    "0002"
               MOVE    ERR-MSG02       TO  ERR-ERRMSG
           WHEN    "0003"
               MOVE    ERR-MSG03       TO  ERR-ERRMSG
           WHEN    "0004"
               MOVE    ERR-MSG04       TO  ERR-ERRMSG
           END-EVALUATE
      *
           .
       800-GET-ERRMSG-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           IF    ( CNT-OUT1            =   ZERO  )
                MOVE  "0004"           TO  ERR-ERRCD
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    TEIKI2P-JOBID   TO  JOB-JOBID
           MOVE    TEIKI2P-SHELLID TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *     
           DISPLAY "TEIKI02  CNT " CNT-OUT1 
           DISPLAY "*** ORCT0020 END ***"
      ***  ACCEPT  WRK-IN FROM CONSOLE 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納マスター読込（主キー）
      *****************************************************************
       900-SYUNOU-KEY-SEL-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-SYUNOU
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
           ELSE
               MOVE    1               TO  FLG-SYUNOU
               INITIALIZE                  SYUNOU-REC
           END-IF
      *
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-SYUNOU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    収納明細読込（主キー）
      *****************************************************************
       900-SYUMEI-KEY-SEL-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-SYUMEI
      *
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYUMEI-REC
           ELSE
               MOVE    1               TO  FLG-SYUMEI
               INITIALIZE                  SYUMEI-REC
           END-IF
      *
           MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-SYUMEI-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    患者マスター読込（主キー）
      *****************************************************************
       900-PTINF-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-PTINF
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTINF-REC
           ELSE
               MOVE    1               TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-PTINF-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ読込(KEY2)
      *****************************************************************
       900-SYSKANRI-KEY2-SEL-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ読込(KEY2)
      *****************************************************************
       900-SYSKANRI-KEY2-FET-SEC       SECTION.
      *
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-KEY2-FET-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHは行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       911-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSE-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC                SECTION.
      *
           MOVE    "DBOPEN"            TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBDISCONNECT-EXT.
           EXIT.
      *****************************************************************
      *    プログラム終了処理
      *****************************************************************
       990-PROGRAM-FINISH-SEC          SECTION.
      *
            STOP   RUN
      *
           .
       990-PROGRAM-FINISH-EXT.
           EXIT.
