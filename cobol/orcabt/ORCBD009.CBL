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
      * this licence along with this program. If not, stop using this
      * program and contact JMA, 2-28-16 Honkomagome, Bunkyo-ku, Tokyo,
      * 113-8621, Japan.
      ********************************************************************
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCBD009.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 日次帳票
      *  コンポーネント名  : 入院オーダーエラーリスト（ＨＣＭ４５）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  05/12/07    NACL-森脇     新規作成
      *****************************************************************
      *  プログラム修正履歴
      *  Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    並び替えファイル
           SELECT  BD009-FILE      ASSIGN   BD009PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  BD009-KEY
                                   FILE    STATUS  IS  STS-BD009.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    並び替えファイル
       FD  BD009-FILE.
       01  BD009-REC.
           02  BD009-KEY.
               03  BD009-UKEYMD    PIC X(08).
               03  BD009-KANANAME  PIC X(100).
               03  BD009-PTNUM     PIC X(20).
               03  BD009-PTID      PIC 9(10).
               03  BD009-SRYYMD    PIC X(08).
               03  BD009-UKEHMS    PIC X(06).
               03  BD009-KARTE-KEY PIC X(36).
               03  BD009-ORDERNUM  PIC 9(02).
           02  BD009-NAME          PIC X(100).
           02  BD009-ORDER-REC.
               COPY    "CPORDER.INC"
                                   REPLACING  //ORDER-//
                                   BY         //BD009-ORDER-//.
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    並び替えファイル
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //BD009//.
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    帳票領域
           COPY    "HCM45.INC".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-BD009           PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-ORDER           PIC 9(01).
           03  FLG-PTNUM           PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-BD009           PIC 9(01).
           03  FLG-END             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE            PIC 9(02).
           03  CNT-PAGE            PIC 9(05).
           03  CNT-NUM             PIC 9(05).
           03  CNT-ORDER           PIC 9(05).
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
           03  IDX                 PIC 9(05).
           03  IDY                 PIC 9(05).
           03  IDZ                 PIC 9(05).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-HOSPID     PIC X(24).
           03  WRK-PARA-UKESTYMD   PIC X(08).
           03  WRK-PARA-UKEEDYMD   PIC X(08).
           03  WRK-PARA-SYORIKBN   PIC X(01).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RECEERR         PIC X(200).
      *
           03  WRK-PATH-TABLE      PIC X(64).
           03  WRK-PATH-PATHNAME   PIC X(64).
      *
           03  WRK-UKEYMD          PIC X(08).
           03  WRK-UKEYMDWH        PIC X(09).
           03  WRK-SAKYMDWH        PIC X(09).
           03  WRK-SYORIKBN        PIC X(12).
           03  WRK-ITEM            PIC X(10000).
      *
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-HENYMDG         PIC X(09).
      *
           03  WRK-Z5              PIC ZZZZ9.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    医療機関情報
           COPY    "CPSK1001.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY    "CPSK1031.INC".
      *
      *    オーダーマスタ
       01  ORDER-REC.
           COPY    "CPORDER.INC".
      *
      *    患者番号マスタ
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
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
      *    入院オーダーＩＤ名
           COPY    "CPNORDERID.INC".
      *
      *    入院オーダーエラーリスト編集サブ
           COPY    "CPORCBD009S.INC".
      *
      *    入院オーダーエラーリスト編集サブ検索用オーダーマスタ
       01  LNK-ORDER-REC.
           COPY    "CPORDER.INC"   REPLACING  //ORDER-//
                                   BY         //LNK-ORDER-//.
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *    日付画面変換サブ
           COPY    "CPORCSGDAY.INC".
      *
      *    LIKE使用KEY対応
           COPY    "CPORCSADDSIGN.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
           COPY    "ORCA-DBPATH".
           COPY    "COMMON-SPA".
           COPY    "CPSHELLTBL.INC".
      *
      ****************************************************************
       LINKAGE                     SECTION.
      *
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      *
      ****************************************************************
       PROCEDURE               DIVISION
               USING
           COMMAND-PARAM.
      *
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
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
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
                                               WRK-PARA-HOSPID
                                               WRK-PARA-UKESTYMD
                                               WRK-PARA-UKEEDYMD
                                               WRK-PARA-SYORIKBN
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCBD009"      TO  JOB-PGID
           MOVE    "入院オーダー確認リスト"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           MOVE    "BD009ZZ"       TO  BD009PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  BD009PARA-TERMID
      *
           MOVE    "RECEERR"       TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  RECEERR-TERMID
      *
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       110-PARA-HENSYU-SEC         SECTION.
      *
      *    システム日付セット
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  WRK-SYSYMD
      *    作成日セット
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  WRK-SYMD
           PERFORM 400-YMD-HEN-SEC
           MOVE    WRK-HENYMDG     TO  WRK-SAKYMDWH
      *
           IF      WRK-PARA-SYORIKBN   =   "1"
               MOVE    "全て"      TO  WRK-SYORIKBN
           ELSE
               MOVE    "エラー分"  TO  WRK-SYORIKBN
           END-IF
      *
      *    キーをセット
           MOVE    "tbl_order"     TO  WRK-PATH-TABLE
           IF    ( WRK-PARA-UKESTYMD   =   SPACE ) AND
                 ( WRK-PARA-UKEEDYMD   =   SPACE )
               MOVE    "key9"          TO  WRK-PATH-PATHNAME
           ELSE
               MOVE    "key8"          TO  WRK-PATH-PATHNAME
               IF    ( WRK-PARA-UKESTYMD   NOT =   SPACE ) AND
                     ( WRK-PARA-UKEEDYMD       =   SPACE )
                   MOVE    WRK-PARA-UKESTYMD   TO  WRK-PARA-UKEEDYMD
               ELSE
                   IF    ( WRK-PARA-UKESTYMD       =   SPACE ) AND
                         ( WRK-PARA-UKEEDYMD   NOT =   SPACE )
                       MOVE    "00000000"      TO  WRK-PARA-UKESTYMD
                   END-IF
               END-IF
           END-IF
      *
           IF      WRK-PARA-UKESTYMD   >   WRK-PARA-UKEEDYMD
               MOVE    "日付範囲が正しくありません。"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  110-PARA-HENSYU-EXT
           END-IF
      *
      *    医療機関ＩＤ編集
           INITIALIZE                  SYS-1001-REC
           INITIALIZE                  ORCSADDSIGNAREA
           MOVE    "1001"          TO  SYS-1001-KANRICD
           MOVE    "*"             TO  SADDSIGN-STR
           CALL    "ORCSADDSIGN"       USING
                                       ORCSADDSIGNAREA
           MOVE    SADDSIGN-STR    TO  SYS-1001-KBNCD
           MOVE    WRK-SYSYMD      TO  SYS-1001-STYUKYMD
                                       SYS-1001-EDYUKYMD
           MOVE    SYS-1001-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1001-REC
               MOVE    SYS-1001-HOSPID TO  WRK-PARA-HOSPID
           ELSE
               MOVE    "医療機関ＩＤが取得できませんでした。"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    並び替えファイルをクリアする
           OPEN    OUTPUT              BD009-FILE
           CLOSE                       BD009-FILE
      *
      *    並び替えファイルを開く
           OPEN    I-O                 BD009-FILE
      *
      *    並び替えファイルセット処理
           PERFORM 900-ORDER-SELECT-SEC
           PERFORM UNTIL   FLG-ORDER     =   1
               PERFORM 300-BD009-SET-SEC
               PERFORM 900-ORDER-FETCH-SEC
           END-PERFORM
           PERFORM 900-ORDER-CLOSE-SEC
      *
      *    並び替えファイルを閉じる
           CLOSE                       BD009-FILE
      *
      *    並び替えファイルがないとき処理抜ける
           IF      CNT-ORDER       =   ZERO
               MOVE    1               TO  FLG-END
               GO  TO  200-MAIN-EXT
           END-IF
      *
      *    並び替えファイルを開く
           OPEN    INPUT               BD009-FILE
      *
      *    帳票セット処理
           PERFORM 900-BD009-NEXT-SEC
           PERFORM UNTIL   FLG-BD009   =   1
               PERFORM 300-ORDER-STR-SET-SEC
               IF      CNT-LINE    =   ZERO
                   PERFORM 310-HEAD-HEN-SEC
               END-IF
               PERFORM 320-BODY-HEN-SEC
               IF      CNT-LINE    >   40
                   PERFORM 390-PRINT-OUT-SEC
               END-IF
               PERFORM 900-BD009-NEXT-SEC
               PERFORM 300-ORDER-END-SET-SEC
           END-PERFORM
      *
      *    並び替えファイルを閉じる
           CLOSE                       BD009-FILE
      *
           MOVE    1               TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    並び替えファイルセット処理
      *****************************************************************
       300-BD009-SET-SEC            SECTION.
      *
      *    患者番号読み込み
           PERFORM 900-PTNUM-READ-SEC
      *    患者情報読み込み
           PERFORM 900-PTINF-READ-SEC
      *
      *    キーセット
           INITIALIZE                  BD009-REC
           MOVE    ORDER-UKEYMD    TO  BD009-UKEYMD
           MOVE    PTINF-KANANAME  TO  BD009-KANANAME
           MOVE    ORDER-PTNUM     TO  BD009-PTNUM
           MOVE    ORDER-PTID      TO  BD009-PTID
           MOVE    ORDER-SRYYMD    TO  BD009-SRYYMD
           MOVE    ORDER-UKEHMS    TO  BD009-UKEHMS
           MOVE    ORDER-KARTE-KEY TO  BD009-KARTE-KEY
           MOVE    ORDER-ORDERNUM  TO  BD009-ORDERNUM
      *
      *    並び替えファイル存在確認
           PERFORM 900-BD009-READ-SEC
           IF      FLG-BD009       =   1
               MOVE    PTINF-NAME      TO  BD009-NAME
               MOVE    ORDER-REC       TO  BD009-ORDER-REC
               WRITE   BD009-REC
               ADD     1               TO  CNT-ORDER
           END-IF
      *
           .
       300-BD009-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       300-ORDER-STR-SET-SEC       SECTION.
      *
      *    受付日切替え
           IF      BD009-UKEYMD    NOT =   WRK-UKEYMD
               MOVE    BD009-UKEYMD    TO  WRK-SYMD
               PERFORM 400-YMD-HEN-SEC
               MOVE    WRK-HENYMDG     TO  WRK-UKEYMDWH
               MOVE    BD009-UKEYMD    TO  WRK-UKEYMD
               MOVE    ZERO            TO  CNT-NUM
               PERFORM 310-HEAD-HEN-SEC
           END-IF
      *
           .
       300-ORDER-STR-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       300-ORDER-END-SET-SEC       SECTION.
      *
      *    受付日切替え、並び替えマスタ終了
           IF     ( BD009-UKEYMD   NOT =   WRK-UKEYMD )
               OR ( FLG-BD009          =   1 )
               PERFORM 390-PRINT-OUT-SEC
           END-IF
      *
           .
       300-ORDER-END-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<ヘッダー部>処理
      *****************************************************************
       310-HEAD-HEN-SEC            SECTION.
      *
           ADD     1               TO  CNT-PAGE
           MOVE    1               TO  CNT-LINE
      *
           INITIALIZE                  HCM45
      *
           MOVE    WRK-UKEYMDWH    TO  HCM45-UKEYMD
           MOVE    WRK-SAKYMDWH    TO  HCM45-SAKYMD
           MOVE    WRK-SYORIKBN    TO  HCM45-SYORIKBN
      *
           MOVE    CNT-PAGE        TO  WRK-Z5
           MOVE    WRK-Z5          TO  HCM45-PAGE
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
      *    患者情報セット
           ADD     1               TO  CNT-NUM
           MOVE    CNT-NUM         TO  WRK-Z5
           MOVE    WRK-Z5          TO  HCM45-NUM(CNT-LINE)
      *
           MOVE    BD009-PTNUM     TO  HCM45-PTNUM(CNT-LINE)
           MOVE    BD009-NAME      TO  HCM45-NAME(CNT-LINE)
      *
      *    異動日セット
           MOVE    BD009-SRYYMD    TO  WRK-SYMD
           PERFORM 400-YMD-HEN-SEC
           MOVE    WRK-HENYMDG     TO  HCM45-IDOYMD(CNT-LINE)
      *
      *    異動内容セット
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >   15
               IF      NORDERID-ORCAID(IDX)    =   BD009-ORDER-ORDERID
                   MOVE    NORDERID-ORCAMES2(IDX)
                                       TO  HCM45-IDONAIYO(CNT-LINE)
                   MOVE    15          TO  IDX
               END-IF
           END-PERFORM
      *
      *    状態セット
           EVALUATE    BD009-ORDER-STATUS-ORDER
               WHEN    "1"
                   MOVE    "重"        TO  HCM45-JYOTAI(CNT-LINE)
               WHEN    "2"
                   MOVE    "有"        TO  HCM45-JYOTAI(CNT-LINE)
               WHEN    "3"
                   MOVE    "削除"      TO  HCM45-JYOTAI(CNT-LINE)
               WHEN    "4"
                   MOVE    "未処理"    TO  HCM45-JYOTAI(CNT-LINE)
               WHEN    "5"
                   MOVE    "保留"      TO  HCM45-JYOTAI(CNT-LINE)
           END-EVALUATE
      *
           IF    ( BD009-ORDER-STATUS-ORDER    =   "1" )   OR
                 ( BD009-ORDER-STATUS-ORDER    =   "2" )   OR
                 ( BD009-ORDER-STATUS-ORDER    =   "4" )   OR
                 ( BD009-ORDER-STATUS-ORDER    =   "5" )
      *        入院オーダーエラーサブプロ読み込み
               MOVE    BD009-ORDER-REC TO  LNK-ORDER-REC
               CALL    "ORCBD009S"         USING
                                           ORCSBD009SAREA
                                           LNK-ORDER-REC
      *        エラー内容作業領域にセット
               MOVE    SPACE           TO  WRK-ITEM
               PERFORM VARYING IDX     FROM    1   BY  1
                       UNTIL   IDX     >   BD009S-ERR-CNT
                       OR      IDX     >=  100
                   STRING  WRK-ITEM            DELIMITED  BY  SPACE
                           BD009S-ERRMES(IDX)  DELIMITED  BY  SPACE
                                       INTO    WRK-ITEM
                   END-STRING
                   IF      IDX     <   BD009S-ERR-CNT
                       STRING  WRK-ITEM        DELIMITED  BY  SPACE
                               "／"            DELIMITED  BY  SIZE
                                       INTO    WRK-ITEM
                       END-STRING
                   END-IF
               END-PERFORM
               MOVE    WRK-ITEM(1:100) TO  HCM45-ITEM(CNT-LINE)
           END-IF
      *
           ADD     1               TO  CNT-LINE
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
           MOVE    "HCM45.red"     TO  SPRT-PRTID
           MOVE    "入院オーダー確認リスト"
                                   TO  SPRT-TITLE
           MOVE    HCM45           TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID
                                   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM
                                   TO  SPRT-PRTNM
           MOVE    "1"             TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           MOVE    ZERO            TO  CNT-LINE
      *
           .
       390-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    BD009PARA       TO  IF-FILENAME
           CALL    "orcfiledel"        USING
                                       ORCSFDELAREA
      *
           IF      CNT-ORDER       =   ZERO
               MOVE    "対象データがありませんでした"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-PAGE        TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付変換処理
      *****************************************************************
       400-YMD-HEN-SEC             SECTION.
      *
           INITIALIZE                  ORCSGDAYAREA
           MOVE    WRK-SYMD        TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           MOVE    SGDAY-OTDAY    TO  WRK-HENYMDG
           INSPECT WRK-HENYMDG    REPLACING  ALL "  "  BY  "　"
      *
           .
       400-YMD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR     =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR     TO  RECEERR-REC
               WRITE   RECEERR-REC
               CLOSE   RECEERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           END-IF
      *
           MOVE    1                   TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    並び替えファイル読込
      *****************************************************************
       900-BD009-READ-SEC          SECTION.
      *
           READ    BD009-FILE
               INVALID
                   MOVE    1           TO  FLG-BD009
               NOT INVALID
                   MOVE    ZERO        TO  FLG-BD009
           END-READ
      *
           .
       900-BD009-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *     並び替えファイル順読込
      *****************************************************************
       900-BD009-NEXT-SEC          SECTION.
      *
           READ    BD009-FILE      NEXT
               AT  END
                   MOVE    1           TO  FLG-BD009
               NOT AT  END
                   MOVE    ZERO        TO  FLG-BD009
           END-READ
      *
           .
       900-BD009-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    オーダーマスタ　受付日で検索
      *****************************************************************
       900-ORDER-SELECT-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-ORDER
      *
           INITIALIZE                      ORDER-REC
           MOVE    WRK-PARA-HOSPID     TO  ORDER-HOSPID
           MOVE    WRK-PARA-UKESTYMD   TO  ORDER-SELSTUKEYMD
           MOVE    WRK-PARA-UKEEDYMD   TO  ORDER-SELEDUKEYMD
           MOVE    ORDER-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-PATH-TABLE      TO  MCP-TABLE
           MOVE    WRK-PATH-PATHNAME   TO  MCP-PATHNAME
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               PERFORM 900-ORDER-FETCH-SEC
           ELSE
               MOVE    1           TO  FLG-ORDER
           END-IF
      *
           .
       900-ORDER-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *     オーダーマスタを検索処理
      *****************************************************************
       900-ORDER-FETCH-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    WRK-PATH-TABLE      TO  MCP-TABLE
           MOVE    WRK-PATH-PATHNAME   TO  MCP-PATHNAME
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    MCPDATA-REC     TO  ORDER-REC
               IF      ORDER-ITEMNUM   NOT =   1
                   GO  TO  900-ORDER-FETCH-SEC
               END-IF
               IF    ( WRK-PARA-SYORIKBN   NOT =   "1" )   AND
                     ( ORDER-STATUS-ORDER  NOT =   "1" )   AND
                     ( ORDER-STATUS-ORDER  NOT =   "2" )   AND
                     ( ORDER-STATUS-ORDER  NOT =   "4" )   AND
                     ( ORDER-STATUS-ORDER  NOT =   "5" )
                   GO  TO  900-ORDER-FETCH-SEC
               END-IF
               MOVE    ZERO            TO  FLG-ORDER
           ELSE
               MOVE    1               TO  FLG-ORDER
               INITIALIZE                  ORDER-REC
           END-IF
      *
           .
       900-ORDER-FETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    オーダーマスタクローズ処理
      *****************************************************************
       900-ORDER-CLOSE-SEC         SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           MOVE    WRK-PATH-TABLE      TO  MCP-TABLE
           MOVE    WRK-PATH-PATHNAME   TO  MCP-PATHNAME
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       900-ORDER-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスタ読み込み
      *****************************************************************
       900-SYSKANRI-READ-SEC       SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "tbl_syskanri"  TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          =   ZERO
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
           MOVE    "key"           TO  MCP-PATHNAME
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号マスター読込処理
      *****************************************************************
       900-PTNUM-READ-SEC          SECTION.
      *
           INITIALIZE                  PTNUM-REC
           INITIALIZE                  ORCSADDSIGNAREA
           MOVE    WRK-PARA-HOSPID TO  PTNUM-HOSPID
           MOVE    ORDER-PTNUM     TO  SADDSIGN-STR
           CALL    "ORCSADDSIGN"       USING
                                       ORCSADDSIGNAREA
           MOVE    SADDSIGN-STR    TO  PTNUM-PTNUM
           MOVE    PTNUM-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "tbl_ptnum"     TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC          =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "tbl_ptnum"     TO  MCP-TABLE
               MOVE    "key2"          TO  MCP-PATHNAME
               CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC     TO  PTNUM-REC
                   MOVE    ZERO            TO  FLG-PTNUM
               ELSE
                   MOVE    1               TO  FLG-PTNUM
                   INITIALIZE                  PTNUM-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTNUM
               INITIALIZE                  PTNUM-REC
           END-IF
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           MOVE    "tbl_ptnum"     TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       900-PTNUM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込処理
      *****************************************************************
       900-PTINF-READ-SEC          SECTION.
      *
           INITIALIZE                  PTINF-REC
           MOVE    WRK-PARA-HOSPID TO  PTINF-HOSPID
           MOVE    PTNUM-PTID      TO  PTINF-PTID
           MOVE    PTINF-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "tbl_ptinf"     TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
               IF      MCP-RC          =   ZERO
                   MOVE    MCPDATA-REC     TO  PTINF-REC
                   MOVE    ZERO            TO  FLG-PTINF
               ELSE
                   MOVE    1               TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       900-PTINF-READ-EXT.
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
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBSTART"       TO  MCP-FUNC.
           MOVE    LOW-VALUE       TO  MCP-TABLE.
           MOVE    LOW-VALUE       TO  MCP-PATHNAME.
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC.
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
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           MOVE    LOW-VALUE       TO  MCP-TABLE.
           MOVE    LOW-VALUE       TO  MCP-PATHNAME.
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC.
      *
           .
       900-DBDISCONNECT-EXT.
           EXIT.
