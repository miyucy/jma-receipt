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
       PROGRAM-ID.             ORCBN21.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 薬情マスタ一覧印刷
      *  コンポーネント名  : 薬情マスタ一覧印刷
      *  管理者            : 
      *  作成日付    作業者        記述
      *  06/05/15    NACL-森脇     新規作成
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
006900*    エラーファイル
           SELECT  YKJMERR-FILE        ASSIGN  YKJMERR
                                       FILE    STATUS  IS  STS-YKJMERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    エラーファイル
       FD  YKJMERR-FILE.
       01  YKJMERR-REC                 PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    シェル用領域
           COPY    "CPCOMMONSHELL.INC".
           COPY    "CPSHELLTBL.INC".
           COPY    "ORCA-DBPATH".
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"  REPLACING  //RECE01PARA//
                                       BY         //YKJMERR//.
           03  FILLER                  PIC X(04)   VALUE   ".dat".
      *
           COPY    "HCM47.INC".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-YKJMERR             PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-TENSU               PIC 9(01).
           03  FLG-YAKUJYO             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PAGE                PIC 9(04).
           03  CNT-NUM                 PIC 9(04).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY              PIC 9(02).
               05  SYS-MM              PIC 9(02).
               05  SYS-DD              PIC 9(02).
      *
      *    インデックス領域
       01  IDX-AREA.
           03  IDX                     PIC 9(03).
           03  IDY                     PIC 9(03).
           03  IDZ                     PIC 9(03).
           03  STR-KET                 PIC 9(03).
           03  END-KET                 PIC 9(03).
           03  NUM-KET                 PIC 9(03).
      *
           03  IDX-STR                 PIC 9(04).
           03  IDX-STR1                PIC 9(04).
           03  IDX-KET                 PIC 9(04).
           03  IDX-MAX                 PIC 9(04).
           03  IDX2                    PIC 9(04).
           03  IDX2-MAX                PIC 9(04).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID          PIC 9(07).
           03  WRK-PARA-SHELLID        PIC X(08).
           03  WRK-PARA-HOSPID         PIC X(24).
           03  WRK-PARA-JYO            PIC X(01).
           03  WRK-PARA-KBN            PIC X(01).
           03  WRK-PARA-IYK            PIC X(01).
           03  WRK-PARA-SYU            PIC X(01).
           03  WRK-PARA-NAME           PIC X(10).
           03  WRK-PARA-SRYCD          PIC X(09).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-YKJMERR             PIC X(200).
           03  WRK-TABLE               PIC X(20).
           03  WRK-PATHNAME            PIC X(20).
      *
           03  WRK-SYSYMD.
               05  WRK-SYSYY           PIC 9(04).
               05  WRK-SYSMM           PIC 9(02).
               05  WRK-SYSDD           PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
           03  WRK-HENYMDG             PIC X(22).
      *
           03  WRK-HENYKZNAME          PIC X(85).
           03  WRK-HENKONOKOKA         PIC X(200).
           03  WRK-HENKEIJYO           PIC X(180).
           03  WRK-HENNAIYO            PIC X(128).
           03  WRK-HENCYUJKO           PIC X(425).
           03  WRK-HENNAME             PIC X(100).
      *
           03  WRK-ZZZ9                PIC ZZZ9.
      *
      *    全角を行毎に編集
       01  WRK-HENSYU-AREA.
           03  WRK-HENSYU-OCC          OCCURS   10.
               05  WRK-HENSYU          PIC X(40).
           03  WRK-NAIYOU              PIC X(600).
           03  GYO-MAX                 PIC 9(04).
           03  KOU-MAX                 PIC 9(04).
      *
       01  WRK-YKJ-AREA.
           03  WRK-YKJ-TBL                         OCCURS  5.
               05  WRK-YKJ-NUM         PIC X(04).
               05  WRK-YKJ-SRYCD       PIC X(11).
               05  WRK-YKJ-YKZNAME     PIC X(26)   OCCURS  3.
               05  WRK-YKJ-KONOKOKA    PIC X(30)   OCCURS  6.
               05  WRK-YKJ-GAZO        PIC X(1024).
               05  WRK-YKJ-KEIJYO      PIC X(16)   OCCURS  10.
               05  WRK-YKJ-CYUJKO      PIC X(40)   OCCURS  10.
      *
       01  FILE-NAME                   PIC X(512).
      *
      *    空白の画像
       01  KUHAKU-NAME.
           03  FILLER                  PIC X(05)   VALUE   "data/".
           03  FILLER                  PIC X(15)   VALUE
                                                   "transparent.jpg".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    点数マスタ
           COPY    "CPTENSU.INC".
      *
      *    薬情マスタ
           COPY    "CPYAKUJYO.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    印刷管理
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
      *    印刷用データ
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
      *    ファイル存在チェック
           COPY    "CPORCSFILECHK.INC".
      *
      *    ファイルデイレクトリ位置指定サブ
           COPY    "CPMKPASS.INC".
      *
      *    全角変換サブ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       01  COMMAND-PARAM.
           02  FILLER                  PIC X(1000).
      *
      ******************************************************************
       PROCEDURE                   DIVISION
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
           INITIALIZE                  SYS-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                       INTO            LNK-PRTKANRI-RENNUM
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
                                       WRK-PARA-JYO
                                       WRK-PARA-KBN
                                       WRK-PARA-IYK
                                       WRK-PARA-SYU
                                       WRK-PARA-NAME
                                       WRK-PARA-SRYCD
      *
      *    ステップ管理開始処理
           MOVE    "STS"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    WRK-PARA-JOBID      TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID    TO  JOB-SHELLID
           MOVE    "ORCBN21"           TO  JOB-PGID
           MOVE    "薬剤情報マスタ一覧"
                                       TO  JOB-SHELLMSG
      *
           CALL    "ORCSJOB"               USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
      *
           MOVE    "YKJMERR"       TO  YKJMERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  YKJMERR-TERMID
      *
      *    ファイルデイレクトリ位置指定
           INITIALIZE                  ORCSMKPASSAREA
           MOVE    KUHAKU-NAME     TO  MKPASS-IN-01
           CALL    "ORCSMKPASS"        USING
                                       ORCSMKPASSAREA
           MOVE    MKPASS-OT-01    TO  FILE-NAME
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           PERFORM 900-YAKUJYO-SELECT-SEC
      *
           PERFORM UNTIL   FLG-YAKUJYO     =   1
               PERFORM 210-PRT-HEN-SEC
               PERFORM 220-PRT-SET-SEC
               PERFORM 230-PRT-PRINT-SEC
           END-PERFORM
      *
           PERFORM 900-YAKUJYO-CLOSE-SEC
      *
           MOVE    1               TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票明細処理
      *****************************************************************
       210-PRT-HEN-SEC             SECTION.
      *
           INITIALIZE                  WRK-YKJ-AREA
      *
      *    空白の画像
           MOVE    FILE-NAME       TO  WRK-YKJ-GAZO(1)
                                       WRK-YKJ-GAZO(2)
                                       WRK-YKJ-GAZO(3)
                                       WRK-YKJ-GAZO(4)
                                       WRK-YKJ-GAZO(5)
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   FLG-YAKUJYO     =   1
                   OR      IDX             >   5
      *        番号セット
               COMPUTE CNT-NUM     =   CNT-NUM     +   1
               MOVE    CNT-NUM         TO  WRK-ZZZ9
               MOVE    WRK-ZZZ9        TO  WRK-YKJ-NUM(IDX)
      *
      *        診療行為コードセット
               STRING  "("             DELIMITED  BY  SIZE
                       YAKUJYO-SRYCD   DELIMITED  BY  SPACE
                       ")"             DELIMITED  BY  SIZE
                       INTO     WRK-YKJ-SRYCD(IDX)
               END-STRING
      *
      *        効能効果セット
               MOVE    YAKUJYO-EFFECT  TO  WRK-HENKONOKOKA
               PERFORM 211-HENEFFECT-SET-SEC
      *
      *        注意事項
               MOVE    YAKUJYO-CAUTION TO  WRK-HENCYUJKO
               PERFORM 212-HENCAUTION-SET-SEC
      *
      *        薬剤名セット
               IF  YAKUJYO-NAME    NOT =   SPACE
                   MOVE    YAKUJYO-NAME    TO  WRK-HENYKZNAME
               ELSE
                   PERFORM 900-TENSU-READ-SEC
                   MOVE    TNS-NAME       TO  WRK-HENYKZNAME
               END-IF
               PERFORM 213-HENYKZNAME-SET-SEC
      *
      *        画像編集
               IF      YAKUJYO-PHOTO   NOT =   SPACE
      *            ファイル存在チェック
                   INITIALIZE                  ORCSFILECHKAREA
                   MOVE    YAKUJYO-PHOTO   TO  FILECHK-NAME
                   CALL    "ORCSFILECHK"       USING
                                               ORCSFILECHKAREA
                   IF      FILECHK-RC      =   ZERO
                       MOVE  YAKUJYO-PHOTO     TO  WRK-YKJ-GAZO(IDX)
                   END-IF
               END-IF
      *
      *        形状編集
               PERFORM 214-KEIJYO-SET-SEC
      *
      *        薬剤情報読み込み
               PERFORM 900-YAKUJYO-FETCH-SEC
           END-PERFORM
      *
           .
       220-HEN-BODY-EXT.
           EXIT.
      *
      *****************************************************************
      *   帳票効能効果データ編集処理
      *****************************************************************
       211-HENEFFECT-SET-SEC       SECTION.
      *
           INITIALIZE                  WRK-HENSYU-AREA
      *
           MOVE    WRK-HENKONOKOKA TO  WRK-NAIYOU
      *    行
           MOVE    6               TO  GYO-MAX
      *    文字数
           MOVE    30              TO  KOU-MAX
           PERFORM 216-HENSYU-SYORI-SEC
      *
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >   GYO-MAX
               MOVE    WRK-HENSYU(IDY)
                                   TO  WRK-YKJ-KONOKOKA(IDX IDY)
           END-PERFORM
      *
           .
       211-HENEFFECT-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *   帳票注意事項データ編集処理
      *****************************************************************
       212-HENCAUTION-SET-SEC      SECTION.
      *
           INITIALIZE                  WRK-HENSYU-AREA
      *
           MOVE    WRK-HENCYUJKO   TO  WRK-NAIYOU
      *    行
           MOVE    10              TO  GYO-MAX
      *    文字数
           MOVE    40              TO  KOU-MAX
           PERFORM 216-HENSYU-SYORI-SEC
      *
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >   GYO-MAX
               MOVE    WRK-HENSYU(IDY)
                                   TO  WRK-YKJ-CYUJKO(IDX IDY)
           END-PERFORM
      *
           .
       212-HENCAUTION-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *   帳票薬剤名データ編集処理
      *****************************************************************
       213-HENYKZNAME-SET-SEC      SECTION.
      *
           INITIALIZE                  WRK-HENSYU-AREA
      *
           MOVE    WRK-HENYKZNAME  TO  WRK-NAIYOU
      *    行
           MOVE    3               TO  GYO-MAX
      *    文字数
           MOVE    26              TO  KOU-MAX
           PERFORM 216-HENSYU-SYORI-SEC
      *
           PERFORM VARYING IDY     FROM    1   BY  1
                   UNTIL   IDY     >   GYO-MAX
               MOVE    WRK-HENSYU(IDY)
                                   TO  WRK-YKJ-YKZNAME(IDX IDY)
           END-PERFORM
      *
           .
       213-HENYKZNAME-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *   帳票形状データセット処理
      *****************************************************************
       214-KEIJYO-SET-SEC          SECTION.
      *
           INITIALIZE                  WRK-HENSYU-AREA
      *
           MOVE    1               TO  IDY
      *    行
           MOVE    10              TO  GYO-MAX
      *    文字数
           MOVE    16              TO  KOU-MAX
      *
      *    色編集
           MOVE    YAKUJYO-COLOR   TO  WRK-HENKEIJYO
           PERFORM 215-HENKEIJYO-SET-SEC
      *
      *    形編集
           MOVE    YAKUJYO-SHAPE   TO  WRK-HENKEIJYO
           PERFORM 215-HENKEIJYO-SET-SEC
      *
      *    記号編集
           IF      YAKUJYO-MARK    =   SPACE
               GO  TO  214-KEIJYO-SET-EXT
           END-IF
      *
      *    記号チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI
           MOVE    YAKUJYO-MARK    TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
      *
           IF      KANACHK-SYUBETU =   1
      *        文字数
               MOVE    14              TO  KOU-MAX
           END-IF
      *
           MOVE    YAKUJYO-MARK    TO  WRK-HENKEIJYO
           PERFORM 215-HENKEIJYO-SET-SEC
      *
           .
       214-KEIJYO-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *   帳票形状データ編集処理
      *****************************************************************
       215-HENKEIJYO-SET-SEC       SECTION.
      *
           MOVE    1               TO  IDX-STR
           MOVE    1               TO  IDX-KET
      *
           PERFORM UNTIL  (IDX-STR     >   180)
                   OR     (IDY         >   GYO-MAX)
                   OR     (WRK-HENKEIJYO(IDX-STR:) =   SPACE)
      *        改行は対象外
               IF      (WRK-HENKEIJYO(IDX-STR:1)   =   X"0A")
                   MOVE    KOU-MAX         TO  IDX-KET
                   ADD     1               TO  IDX-STR
               ELSE
                   IF      WRK-HENKEIJYO(IDX-STR:1)    >=  X"A1"
                       MOVE    WRK-HENKEIJYO(IDX-STR:2)
                           TO  WRK-YKJ-KEIJYO(IDX IDY)(IDX-KET:2)
                       ADD     2               TO  IDX-STR
                       ADD     2               TO  IDX-KET
                   ELSE
                       MOVE    WRK-HENKEIJYO(IDX-STR:1)
                           TO  WRK-YKJ-KEIJYO(IDX IDY)(IDX-KET:1)
                       ADD     1               TO  IDX-STR
                       ADD     1               TO  IDX-KET
                   END-IF
               END-IF
      *
      *        改行、最大文字で改行
               IF         (IDX-KET         >=  KOU-MAX)
                   OR    ((IDX-STR         <=  180)
                   AND    (WRK-HENKEIJYO(IDX-STR:) =   SPACE))
                   ADD     1               TO  IDY
                   MOVE    1               TO  IDX-KET
                   IF      WRK-HENKEIJYO(IDX-STR:1)    =   X"0A"
                       COMPUTE IDX-STR =   IDX-STR     +   1
                   END-IF
               END-IF
      *
           END-PERFORM
      *
           .
       215-HENKEIJYO-SET-EXT.
           EXIT.
      *
     *****************************************************************
      *   帳票全角編集処理
      *****************************************************************
       216-HENSYU-SYORI-SEC        SECTION.
      *
           MOVE    1               TO  IDY
           MOVE    1               TO  IDX-STR
           MOVE    1               TO  IDX-KET
      *
           PERFORM UNTIL  (IDX-STR     >   600 )
                   OR     (IDY         >   GYO-MAX )
                   OR     (WRK-NAIYOU(IDX-STR:)  =   SPACE)
      *        改行は対象外
               IF      (WRK-NAIYOU(IDX-STR:1)  =   X"0A")
                   IF      IDX-STR     >   1
                       COMPUTE IDX-STR1    =   IDX-STR   -  1
                   END-IF
      *            行の最後が改行の時
                   IF     (IDX-KET     =   1)  AND
                          (IDX-STR     >   1)  AND
                          (WRK-NAIYOU(IDX-STR1:1)  >=  X"A1")
                       ADD     1               TO  IDX-STR
                   ELSE
                       MOVE    KOU-MAX         TO  IDX-KET
                       ADD     1               TO  IDX-STR
                   END-IF
               ELSE
                   IF      WRK-NAIYOU(IDX-STR:1)   >=  X"A1"
                       MOVE    WRK-NAIYOU(IDX-STR:2)
                                       TO  WRK-HENSYU(IDY)(IDX-KET:2)
                       ADD     2               TO  IDX-STR
                       ADD     2               TO  IDX-KET
                   ELSE
                       ADD     1               TO  IDX-STR
                   END-IF
               END-IF
      *
      *        改行、最大文字で改行
               IF     (IDX-KET         >=  KOU-MAX)
                   ADD     1               TO  IDY
                   MOVE    1               TO  IDX-KET
               END-IF
      *
           END-PERFORM
      *
           .
       216-HENSYU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票出力処理
      *****************************************************************
       220-PRT-SET-SEC            SECTION.
      *
           INITIALIZE                  HCM47
      *
      *    ページセット
           COMPUTE CNT-PAGE    =   CNT-PAGE    +   1
           MOVE    CNT-PAGE        TO  WRK-ZZZ9
           MOVE    WRK-ZZZ9        TO  HCM47-PAGE
      *
      *    日付セット
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG     TO  HCM47-SYORIBI
      *
      *    明細セット
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       5
      *
               MOVE    WRK-YKJ-NUM(IDX)    TO  HCM47-NUM(IDX)
      *
               MOVE    WRK-YKJ-SRYCD(IDX)  TO  HCM47-SRYCD(IDX)
               MOVE    WRK-YKJ-GAZO(IDX)   TO  HCM47-GAZO(IDX)
      *
               PERFORM VARYING IDY     FROM    1   BY  1
                       UNTIL   IDY     >       3
                   MOVE    WRK-YKJ-YKZNAME(IDX IDY)
                                       TO  HCM47-YKZNAME(IDX IDY)
               END-PERFORM
      *
               PERFORM VARYING IDY     FROM    1   BY  1
                       UNTIL   IDY     >       6
                   MOVE    WRK-YKJ-KONOKOKA(IDX IDY)
                                       TO  HCM47-KONOKOKA(IDX IDY)
               END-PERFORM
      *
               PERFORM VARYING IDY     FROM    1   BY  1
                       UNTIL   IDY     >       10
                   MOVE    WRK-YKJ-KEIJYO(IDX IDY)
                                       TO  HCM47-KEIJYO(IDX IDY)
               END-PERFORM
      *
               PERFORM VARYING IDY     FROM    1   BY  1
                       UNTIL   IDY     >       10
                   MOVE    WRK-YKJ-CYUJKO(IDX IDY)
                                       TO  HCM47-CYUJKO(IDX IDY)
               END-PERFORM
           END-PERFORM
      *
           .
       220-PRT-BODY-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       230-PRT-PRINT-SEC           SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                       TO  SPRT-TBL-GROUP
           MOVE    LNK-PRTKANRI-SRYYM  TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID 
                                       TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                       TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                       TO  SPRT-PRIORITY
           MOVE    "HCM47.red"         TO  SPRT-PRTID
           MOVE    "薬剤情報マスタ一覧"
                                       TO  SPRT-TITLE
           MOVE    HCM47               TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                          TO  WRK-YKJMERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       230-PRT-PRINT-EXT.
           EXIT.
      *
     *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT           YKJMERR-FILE
           IF        ( STS-YKJMERR =   ZERO )
               CONTINUE
           ELSE
               OPEN    OUTPUT      YKJMERR-FILE
      *
               MOVE    WRK-YKJMERR     TO  YKJMERR-REC
               WRITE   YKJMERR-REC
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-YKJMERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           END-IF
      *
           CLOSE   YKJMERR-FILE
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
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       31012-SEIWA-HEN-SEC         SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD        TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING
                                       STS-AREA-DAY
                                       LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           INSPECT WRK-HENYMDG     REPLACING  ALL "  "  BY  "　"
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスタ読み込み
      *****************************************************************
       900-TENSU-READ-SEC          SECTION.
      *
           INITIALIZE                  TNS-TENSU-REC
           MOVE    YAKUJYO-SRYCD   TO  TNS-SRYCD
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  TNS-YUKOSTYMD
                                       TNS-YUKOEDYMD
           MOVE    TNS-TENSU-REC   TO  MCPDATA-REC
      *
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF  MCP-RC  =  ZERO
               MOVE    "tbl_tensu"     TO  MCP-TABLE
               MOVE    "key"           TO  MCP-PATHNAME
               MOVE    "DBFETCH"       TO  MCP-FUNC
               CALL    "MONFUNC"           USING
                                           MCPAREA
                                           MCPDATA-REC
               IF  MCP-RC  =  ZERO
                   MOVE    ZERO            TO  FLG-TENSU
                   MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
               ELSE
                   MOVE    1               TO  FLG-TENSU
                   INITIALIZE                  TNS-TENSU-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           MOVE    "tbl_tensu"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           .
       900-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    薬剤情報読み込み処理
      *****************************************************************
       900-YAKUJYO-SELECT-SEC      SECTION.
      *
           INITIALIZE                  YAKUJYO-REC
      *
           MOVE    "tbl_yakujyo"   TO  WRK-TABLE
           EVALUATE    WRK-PARA-JYO
               WHEN    "1"
                   EVALUATE    WRK-PARA-SYU
                       WHEN    "1"
                           MOVE    "key5s"         TO  WRK-PATHNAME
                       WHEN    "2"
                           MOVE    "key5k"         TO  WRK-PATHNAME
                   END-EVALUATE
               WHEN    "2"
                   EVALUATE    WRK-PARA-KBN
                       WHEN    "1"
                           STRING  "%"             DELIMITED  BY  SIZE
                                   WRK-PARA-NAME   DELIMITED  BY  SPACE
                                   "%"             DELIMITED  BY  SIZE
                                   INTO    YAKUJYO-NAME
                           END-STRING
                           EVALUATE    WRK-PARA-SYU
                               WHEN    "1"
                                   MOVE    "key2s" TO  WRK-PATHNAME
                               WHEN    "2"
                                   MOVE    "key2k" TO  WRK-PATHNAME
                           END-EVALUATE
                       WHEN    "2"
                           STRING  WRK-PARA-SRYCD  DELIMITED  BY  SPACE
                                   "%"             DELIMITED  BY  SIZE
                                   INTO    YAKUJYO-SRYCD
                           END-STRING
                           EVALUATE    WRK-PARA-SYU
                               WHEN    "1"
                                   MOVE    "key3s" TO  WRK-PATHNAME
                               WHEN    "2"
                                   MOVE    "key3k" TO  WRK-PATHNAME
                           END-EVALUATE
                       WHEN    "3"
                           IF      WRK-PARA-IYK    =   '0'
                               EVALUATE    WRK-PARA-SYU
                                   WHEN    "1"
                                       MOVE    "key5s" TO  WRK-PATHNAME
                                   WHEN    "2"
                                       MOVE    "key5k" TO  WRK-PATHNAME
                               END-EVALUATE
                           ELSE
                               MOVE    WRK-PARA-IYK
                                                   TO  YAKUJYO-TEKNUM
                               EVALUATE    WRK-PARA-SYU
                                   WHEN    "1"
                                       MOVE    "key4s" TO  WRK-PATHNAME
                                   WHEN    "2"
                                       MOVE    "key4k" TO  WRK-PATHNAME
                               END-EVALUATE
                           END-IF
                   END-EVALUATE
           END-EVALUATE
      *
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  YAKUJYO-CREYMD
           MOVE    YAKUJYO-REC     TO  MCPDATA-REC
      *
           MOVE    WRK-TABLE       TO  MCP-TABLE
           MOVE    WRK-PATHNAME    TO  MCP-PATHNAME
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          =   ZERO
               PERFORM 900-YAKUJYO-FETCH-SEC
           ELSE
               MOVE    1               TO  FLG-YAKUJYO
           END-IF
      *
           .
       900-YAKUJYO-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    薬剤情報読み込み処理
      *****************************************************************
       900-YAKUJYO-FETCH-SEC       SECTION.
      *
           MOVE    WRK-TABLE       TO  MCP-TABLE
           MOVE    WRK-PATHNAME    TO  MCP-PATHNAME
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC           =  ZERO
               MOVE    ZERO            TO  FLG-YAKUJYO
               MOVE    MCPDATA-REC     TO  YAKUJYO-REC
           ELSE
               MOVE    1               TO  FLG-YAKUJYO
           END-IF
      *
           .
      *
       900-YAKUJYO-FETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    薬剤情報クロース処理
      *****************************************************************
       900-YAKUJYO-CLOSE-SEC       SECTION.
      *
           MOVE    WRK-TABLE       TO  MCP-TABLE
           MOVE    WRK-PATHNAME    TO  MCP-PATHNAME
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
       900-YAKUJYO-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBOPEN"        TO  MCP-FUNC.
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC.
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBSTART"       TO  MCP-FUNC.
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
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBCOMMIT"      TO  MCP-FUNC.
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC.
      *
           MOVE    LOW-VALUE       TO  MCP-TABLE
                                       MCP-PATHNAME
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           CALL    "MONFUNC"           USING
                                       MCPAREA
                                       MCPDATA-REC.
           .
       900-DBDISCONNECT-EXT.
           EXIT.
