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
       PROGRAM-ID.             ORCBMHKN.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : Ｈ１５／４改正対応、保険一括変更
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/03/12    NACL-多々納   新規作成
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
      *    出力更新ファイル
           SELECT  OUT-FILE        ASSIGN
                                   ASS-OUT
                                   ORGANIZATION    IS  LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-OUT.
      *    エラーファイル
           SELECT  RECEERR-FILE        ASSIGN  RECEERR
                                       FILE    STATUS  IS  STS-RECEERR.
      *
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    出力更新ファイル
       FD  OUT-FILE.
       01  OUT-REC                     PIC X(250).
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC                 PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *    ファイル指定領域
       01  ASS-OUT.
           03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
           03  FILLER              PIC X(30)   VALUE   "ORCBMHKN.TXT".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"  REPLACING  //RECE01PARA//
                                       BY         //RECEERR//.
           03  FILLER                  PIC X(04)   VALUE   ".dat".
      *
      *    一覧
           COPY    "HCMSL80.INC".
      *
           COPY    "HCMSL55.INC".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-OUT                 PIC X(02).
           03  STS-ERR                 PIC X(02).
           03  STS-RECLST              PIC X(02).
           03  STS-RECEERR             PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-PTNUM               PIC 9(01).
           03  FLG-PTHKNINF            PIC 9(01).
           03  FLG-PTINF               PIC 9(01).
           03  FLG-HKNNUM              PIC 9(01).
           03  FLG-SYSKANRI            PIC 9(01).
      *
           03  FLG-SYORI               PIC 9(01).
           03  FLG-KOUSIN              PIC 9(01).
           03  FLG-CHK                 PIC 9(01).
           03  FLG-ERR                 PIC 9(01).
           03  FLG-ERR3                PIC 9(01).
           03  FLG-HOJOKBN             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-PTHKNINF            PIC 9(06).
           03  CNT-UPD                 PIC 9(06).
           03  CNT-IN                  PIC 9(06).
           03  CNT-IN-SEL              PIC 9(06).
           03  CNT-COMMIT              PIC 9(06).
           03  CNT-HEN                 PIC 9(06).
      *
           03  CNT-OUT                 PIC 9(06).
           03  CNT-ERR                 PIC 9(06).
           03  CNT-ERR2                PIC 9(06).
           03  CNT-OK                  PIC 9(06).
           03  CNT-PTINF               PIC 9(06).
      *
           03  CNT-LCNT1               PIC 9(02).
           03  CNT-LCNT2               PIC 9(02).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY              PIC 9(02).
               05  SYS-MM              PIC 9(02).
               05  SYS-DD              PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                     PIC 9(04).
           03  IDY                     PIC 9(04).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID          PIC 9(07).
           03  WRK-PARA-SHELLID        PIC X(08).
           03  WRK-PARA-HOSPID         PIC X(24).
      *
      *    一時領域
       01  WRK-AREA.
      *
           03  WRK-RECEERR             PIC X(200).
      *
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
           03  WRK-SYMD2.
               05  WRK-SYY2            PIC 9(02).
               05  WRK-SMM2            PIC 9(02).
               05  WRK-SDD2            PIC 9(02).
           03  WRK-MAE-TEKSTYMD        PIC X(08).
           03  WRK-MAE-TEKEDYMD        PIC X(08).
           03  WRK-MAE-HKNNUM          PIC X(03).
           03  WRK-MAE-HKNID           PIC 9(10).
      *
           03  WRK-PTID                PIC 9(10).
           03  WRK-PAYKBN              PIC X(02).
           03  WRK-HKNNUM              PIC X(03).
      *
           03  WRK-Z3                  PIC ZZ9.
      *
           03  WRK-BYMD-70.
               05  WRK-BYY             PIC 9(04).
               05  WRK-BMM             PIC 9(02).
               05  WRK-BDD             PIC 9(02).
      *
       01  OUTLST-AREA.
           03  WRK-OUT-REC.
               05  OUT-PTID            PIC 9(10).
               05  OUT-H1              PIC X(01).
               05  OUT-PTNUM           PIC X(05).
               05  OUT-H2              PIC X(01).
               05  OUT-MAE-TEKSTYMD    PIC X(08).
               05  OUT-H3              PIC X(01).
               05  OUT-MAE-TEKEDYMD    PIC X(08).
               05  OUT-H4              PIC X(03).
               05  OUT-ATO-TEKSTYMD    PIC X(08).
               05  OUT-H5              PIC X(01).
               05  OUT-ATO-TEKEDYMD    PIC X(08).
               05  OUT-H6              PIC X(01).
               05  OUT-HKNJANUM        PIC X(08).
               05  OUT-H7              PIC X(01).
               05  OUT-MAE-HKNNUM      PIC X(03).
               05  OUT-H8              PIC X(01).
               05  OUT-MAE-HKNID       PIC 9(10).
               05  OUT-H9              PIC X(01).
               05  OUT-ATO-HKNID       PIC 9(10).
               05  OUT-H10             PIC X(01).
               05  OUT-ERRMSG          PIC X(10).
      *
      *    帳票出力領域
       01  ERRMES-AREA.
           03  ERRMES-TITLE1.
               05  FILLER              PIC X(02)   VALUE  SPACE.
               05  FILLER              PIC X(60)   VALUE
               "＜＜　平成１５年４月改正保険一括変更エラー　＞＞".
               05  ERRMES-TITLE1-YY    PIC X(04).
               05  FILLER              PIC X(01) VALUE ".".
               05  ERRMES-TITLE1-MM    PIC X(02).
               05  FILLER              PIC X(01) VALUE ".".
               05  ERRMES-TITLE1-DD    PIC X(02).
           03  ERRMES-TITLE3.
               05  FILLER              PIC X(04) VALUE
                                                 "NO".
               05  FILLER              PIC X(38) VALUE
                                                 "ERR-MESSAGE".
               05  FILLER              PIC X(20) VALUE
                   "患者番号".
               05  FILLER              PIC X(01) VALUE SPACE.
               05  FILLER              PIC X(10) VALUE
                   "患者ＩＤ".
               05  FILLER              PIC X(01) VALUE SPACE.
               05  FILLER              PIC X(10) VALUE
                   "保険番号".
               05  FILLER              PIC X(03) VALUE SPACE.
               05  FILLER              PIC X(12) VALUE
                   "保険ＩＤ".
      *
      *    出力エラーファイル
       01  ERR-REC.
               05  ERR-NO              PIC X(05).
               05  FILLER              PIC X(01).
               05  ERR-MES             PIC X(40).
               05  FILLER              PIC X(01).
               05  ERR-PTNUM           PIC X(20).
               05  FILLER              PIC X(01).
               05  ERR-PTID            PIC X(10).
               05  FILLER              PIC X(03).
               05  ERR-HKNNUM          PIC X(03).
               05  FILLER              PIC X(05).
               05  ERR-HKNID           PIC X(12).
               05  ERR-ERRMSG          PIC X(30).
      *
      *    変換明細
       01  MEISAI-HEAD.
           03  FILLER                  PIC X(02)   VALUE   SPACE.
           03  FILLER                  PIC X(60)   VALUE
               "＜＜　平成１５年４月改正保険一括変更　任継分一覧　＞＞".
           03  MEISAI-HEAD-YY         PIC X(04).
           03  FILLER                 PIC X(01) VALUE ".".
           03  MEISAI-HEAD-MM         PIC X(02).
           03  FILLER                 PIC X(01) VALUE ".".
           03  MEISAI-HEAD-DD         PIC X(02).
      *
       01  MEISAI-HEAD2.
           03  FILLER                  PIC X(20)   VALUE
               "患者番号".
           03  FILLER                  PIC X(02)   VALUE   SPACE.
           03  FILLER                  PIC X(10)   VALUE
               "患者ＩＤ".
           03  FILLER                  PIC X(01)   VALUE   SPACE.
           03  FILLER                  PIC X(08)   VALUE
               "保険種類".
           03  FILLER                  PIC X(02)   VALUE   SPACE.
           03  FILLER                  PIC X(08)   VALUE
               "継続".
           03  FILLER                  PIC X(02)   VALUE   SPACE.
           03  FILLER                  PIC X(16)   VALUE
               "有効期限".
      *
       01  MEISAI-BODY1.
           03  MEISAI-PTNUM            PIC X(20).
           03  FILLER                  PIC X(01)   VALUE   SPACE.
           03  MEISAI-PTID             PIC X(10).
           03  FILLER                  PIC X(01)   VALUE   SPACE.
           03  MEISAI-HKNNUM           PIC X(03).
           03  FILLER                  PIC X(05)   VALUE   SPACE.
           03  MEISAI-CONTKBN          PIC X(01).
           03  FILLER                  PIC X(06)   VALUE   SPACE.
           03  MEISAI-TEKSTYMD         PIC X(08).
           03  MEISAI-H1               PIC X(03).
           03  MEISAI-TEKEDYMD         PIC X(08).
           03  FILLER                  PIC X(01).
           03  MEISAI-MSG              PIC X(20).
      *
       01  TBL-HKNNUM-AREA.
           03  TBL-HKNNUM-OCC          OCCURS   20
                                       INDEXED  IDX-HKN.
               05  TBL-HKNNUM          PIC X(03).
      *
      *****************************************************************
      *    その他連絡領域
      *****************************************************************
       01  LNK-AREA.
           03  LNK-CNT-HKNCOMBI        PIC 9(06).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    システム管理（医療機関情報基本情報）
           COPY    "CPSK1001.INC".
      *
      *    患者番号変換マスタ
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    保険マスタ
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *
      *    公費マスタ
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
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
           COPY    "CPSHELLTBL.INC".
      *
           COPY    "ORCA-DBPATH".
      *
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
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
       01  COMMAND-PARAM.
           02  FILLER                  PIC X(256).
      *
      ******************************************************************
      *
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
           IF      FLG-END             =   ZERO
               PERFORM 200-MAIN-SEC
           END-IF
      *
           PERFORM 300-END-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
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
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCBMHKN"      TO  JOB-PGID
           MOVE    "Ｈ１５．４改正保険一括変更"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
      *
           INITIALIZE                  SPA-AREA
           INITIALIZE                  LNK-AREA
      *
      *    システム日付を２００３０４０１とする
           MOVE    "20030401"      TO  SPA-SYSYMD
      *    作成日
           ACCEPT  WRK-SYMD2       FROM    DATE
           COMPUTE WRK-SYY         =   WRK-SYY2    +   2000
           MOVE    WRK-SMM2        TO  WRK-SMM
           MOVE    WRK-SDD2        TO  WRK-SDD
      *
           MOVE    WRK-SYY         TO  ERRMES-TITLE1-YY
           MOVE    WRK-SMM         TO  ERRMES-TITLE1-MM
           MOVE    WRK-SDD         TO  ERRMES-TITLE1-DD
      *
           MOVE    WRK-SYY         TO  MEISAI-HEAD-YY
           MOVE    WRK-SMM         TO  MEISAI-HEAD-MM
           MOVE    WRK-SDD         TO  MEISAI-HEAD-DD
      *
      *    システム管理情報　検索処理
           PERFORM 2200-CP1001-KENSAKU-SEC
      *
      *    端末ＩＤ固定
           MOVE    "ORCATERM"          TO  SPA-TERMID
      *
           MOVE    WRK-PARA-HOSPID     TO  SPA-HOSPID
      *
      *    置換対象テーブル保存
           PERFORM 1002-HKNNUM-TBL-SEC
           IF      IDX                 =   ZERO
      *        保険置換処理なし
               MOVE    "処理対象の保険がありませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
               GO  TO              100-INIT-EXT
           END-IF
      *
      *    帳票出力　初期処理
           PERFORM 2710-OUTLST-INIT-SEC
           IF      FLG-END             =   1
               GO  TO              100-INIT-EXT
           END-IF
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
      *
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       1002-HKNNUM-TBL-SEC         SECTION.
      *
      *
           INITIALIZE                  TBL-HKNNUM-AREA
           MOVE    ZERO                TO  IDX
           SET     IDX-HKN             TO  ZERO
      *    保険番号　全件編集（適用範囲分）
           INITIALIZE                  HKNNUM-REC
           MOVE    WRK-PARA-HOSPID     TO  HKN-HOSPID
      *
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY6"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY6"       TO  ORC-DBPATH
               PERFORM 950-HKNNUM-NEXT-SEC
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           MOVE    SPACE           TO  WRK-HKNNUM
           MOVE    SPACE           TO  WRK-PAYKBN
           PERFORM
               UNTIL       FLG-HKNNUM  =   1
      *        Ｈ１５．４．１で改正のあったものを対象とする
               IF      HKN-TEKSTYMD        =   "20030401"
                   IF     (FLG-CHK         =   1   )  AND
                          (HKN-HKNNUM      =   WRK-HKNNUM)  AND
                          (HKN-PAYKBN      =   WRK-PAYKBN)
      *                変更
                       ADD     1               TO  IDX
                       IF      IDX             >   20
                           DISPLAY "TBL-HKNNUM 20 OVER" HKN-HKNNUM
                       ELSE
                           SET     IDX-HKN         TO  IDX
                           MOVE    HKN-HKNNUM      TO  TBL-HKNNUM
                                                          (IDX-HKN)
                       END-IF
                   END-IF
                   MOVE    SPACE           TO  WRK-HKNNUM
                   MOVE    SPACE           TO  WRK-PAYKBN
               END-IF
               IF      HKN-TEKEDYMD        =   "20030331"
                   MOVE    1               TO  FLG-CHK
                   MOVE    HKN-PAYKBN      TO  WRK-PAYKBN
                   MOVE    HKN-HKNNUM      TO  WRK-HKNNUM
               ELSE
                   MOVE    SPACE           TO  WRK-HKNNUM
                   MOVE    SPACE           TO  WRK-PAYKBN
               END-IF
      *
               MOVE    "HKNNUM-KEY6"       TO  ORC-DBPATH
               PERFORM 950-HKNNUM-NEXT-SEC
           END-PERFORM
      *
      *
           .
       1002-HKNNUM-TBL-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    患者保険情報検索
           INITIALIZE                  PTHKNINF-REC
           MOVE    WRK-PARA-HOSPID     TO  PTHKN-HOSPID
           MOVE    SPA-SYSYMD          TO  PTHKN-TEKSTYMD
           MOVE    SPA-SYSYMD          TO  PTHKN-TEKEDYMD
      *
           MOVE    PTHKNINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY5"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTHKNINF-KEY5"     TO  ORC-DBPATH
               PERFORM 900-PTHKNINF-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTHKNINF
           END-IF
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  WRK-PTID
           MOVE    ZERO                TO  FLG-KOUSIN
           PERFORM
               UNTIL  (FLG-PTHKNINF    =   1   )
               OR     (FLG-ERR         =   1   )
      *
               ADD     1               TO  CNT-IN
               IF      CNT-IN (4:3)         =   ZERO
                   DISPLAY "***(ORCBMHKN)*** CNT-IN [" CNT-IN "]"
               END-IF
      *
               IF     (WRK-PTID    NOT =   ZERO )  AND
                      (PTHKN-PTID  NOT =   WRK-PTID)
                   IF      FLG-KOUSIN      =   1
      *                 保険組み合わせ更新処理
                        PERFORM 2201-HKNCOMBI-UPD-SEC
                   END-IF
                   MOVE    ZERO            TO  FLG-KOUSIN
               END-IF
      *
      *        国保、労災、自賠責、自費以外
               IF     (PTHKN-SAKJOKBN          =   "1"   )  OR
                      (PTHKN-HKNNUM            =   "060"    OR
                                                   "971"    OR
                                                   "973"    OR
                                                   "980"  )
              OR      (PTHKN-PTID              =   ZERO  )
              OR      (PTHKN-TEKSTYMD          >=  "20030401")
              OR      (PTHKN-TEKEDYMD          <   "20030401")
                   CONTINUE
               ELSE
      *            保険置換対象チェック
                   PERFORM 210-PTHKNINF-CHK-SEC
                   IF      FLG-SYORI           =   1
      *                保険置換処理
                       PERFORM 2101-PTHKNINF-KOUSIN-SEC
                   END-IF
               END-IF
               MOVE    PTHKN-PTID          TO  WRK-PTID
      *
               MOVE    "PTHKNINF-KEY5"   TO  ORC-DBPATH
               PERFORM 900-PTHKNINF-READ-SEC
           END-PERFORM
      *
           IF      FLG-KOUSIN          =   1
      *         保険組み合わせ更新処理
                PERFORM 2201-HKNCOMBI-UPD-SEC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY5"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           CLOSE                       OUT-FILE
      *
           IF      FLG-ERR         NOT =   ZERO
               MOVE    "ＤＢ更新でエラーがありました。"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険情報チェック処理
      *****************************************************************
       210-PTHKNINF-CHK-SEC          SECTION.
      *
           SET     IDX-HKN              TO  1
           SEARCH  TBL-HKNNUM-OCC       VARYING   IDX-HKN
                   AT   END
                       MOVE    ZERO            TO  FLG-SYORI
                   WHEN    PTHKN-HKNNUM    =   TBL-HKNNUM (IDX-HKN)
                       MOVE    1               TO  FLG-SYORI
           END-SEARCH
      *
           .
       210-PTHKNINF-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険情報更新処理
      *****************************************************************
       2101-PTHKNINF-KOUSIN-SEC          SECTION.
      *
      *    患者情報検索
           MOVE    ZERO                TO  FLG-ERR3
           PERFORM 220-PTNUM-KEN-SEC
           IF      FLG-ERR3            =   1
      *        エラーリスト
               PERFORM 2220-ERRLST-OUT-SEC
               MOVE    ZERO                TO  FLG-ERR3
               GO      TO      2101-PTHKNINF-KOUSIN-EXT
           END-IF
      *
      *****任継は、変換しない
      *    IF      PTHKN-CONTKBN       =   "2"
      *        任継患者情報出力
      *        MOVE    ZERO            TO  FLG-HOJOKBN
      *        PERFORM 2101-CONTI2-SYORI-SEC
      *        GO      TO      2101-PTHKNINF-KOUSIN-EXT
      *****END-IF
      *    Ｈ１４．１０時点で７０歳未満の時
           MOVE    PTHKN-HOSPID        TO  PTINF-HOSPID
           MOVE    PTHKN-PTID          TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
      *    ７０歳到達日
      *    生年月日から基準日を求める
      *    １日ならば生年月日、１日以外ならば生年月日の翌月１日
           MOVE    PTINF-BIRTHDAY      TO  WRK-BYMD-70
           IF      WRK-BDD         NOT =   01
               COMPUTE WRK-BMM         =   WRK-BMM     +   1
               IF      WRK-BMM         >   12
                   COMPUTE WRK-BYY     =   WRK-BYY     +   1
                   MOVE    01              TO  WRK-BMM
               END-IF
               MOVE    01                  TO  WRK-BDD
           END-IF
      *    ７０歳を迎える日
           COMPUTE WRK-BYY             =   WRK-BYY     +   70
      *
           MOVE    1                   TO  FLG-KOUSIN
           ADD     1                   TO  CNT-PTHKNINF
      *
      *    適用期間変更
           MOVE    PTHKN-TEKSTYMD      TO  WRK-MAE-TEKSTYMD
           MOVE    PTHKN-TEKEDYMD      TO  WRK-MAE-TEKEDYMD
           MOVE    PTHKN-HKNID         TO  WRK-MAE-HKNID
           MOVE    PTHKN-HKNNUM        TO  WRK-MAE-HKNNUM
      *
           MOVE    "20030331"          TO  PTHKN-TEKEDYMD
      *
           MOVE    PTHKNINF-REC        TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
            IF      MCP-RC          NOT =   ZERO
               DISPLAY "[ORCBMHKN PTHKNINF UPD ERR:" MCP-RC
                       ",PTID:"  PTHKN-PTID
                       ",KEY:"  PTHKN-KEY
               MOVE    1               TO  FLG-ERR
               GO      TO      2101-PTHKNINF-KOUSIN-EXT
           END-IF
      *
      *    継続は、Ｈ１５．３．３１までとする
           IF      PTHKN-CONTKBN       =   "1"
      *        患者情報出力
               PERFORM 230-OUT-SYORI-SEC
               GO      TO      2101-PTHKNINF-KOUSIN-EXT
           END-IF
      *
      *   公費ＩＤ設定
           PERFORM 220-PTNUM-HEN-SEC
           IF      FLG-ERR             =   1
               GO      TO      2101-PTHKNINF-KOUSIN-EXT
           END-IF
      *
      *    新規追加
           MOVE    PTNUM-HKNID         TO  PTHKN-HKNID
           MOVE    "20030401"          TO  PTHKN-TEKSTYMD
           MOVE    WRK-MAE-TEKEDYMD    TO  PTHKN-TEKEDYMD
      *    老人で補助区分がない時、９をセットしておく
           IF     (PTINF-BIRTHDAY      >=  "19321001" )  AND
                  (WRK-BYMD-70         <=   PTHKN-TEKSTYMD)
               IF      PTHKN-HOJOKBN       =   SPACE
                   MOVE    "9"             TO  PTHKN-HOJOKBN
      *            患者情報出力
                   MOVE    1               TO  FLG-HOJOKBN
                   PERFORM 2101-CONTI2-SYORI-SEC
               END-IF
           END-IF
      *
           MOVE    PTHKNINF-REC        TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO
               DISPLAY "[ORCBMHKN PTKHNINF INS ERR:" MCP-RC
                       ",PTID:"  PTHKN-PTID
                       ",KEY:"  PTHKN-KEY
               MOVE    1               TO  FLG-ERR
               GO      TO      2101-PTHKNINF-KOUSIN-EXT
           END-IF
      *
      *    患者情報出力
           PERFORM 230-OUT-SYORI-SEC
      *
           .
       2101-PTHKNINF-KOUSIN-EXT.
           EXIT.
      *
      *****************************************************************
      *     保険ＩＤ設定変更処理
      *****************************************************************
       220-PTNUM-KEN-SEC            SECTION.
      *
      *    患者番号変換
           MOVE    SPACE               TO  PTNUM-REC
           INITIALIZE                      PTNUM-REC
           MOVE    PTHKN-HOSPID        TO  PTNUM-HOSPID
           MOVE    PTHKN-PTID          TO  PTNUM-PTID
      *
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTNUM-REC
                   MOVE    ZERO                TO  FLG-PTNUM
               ELSE
                   MOVE    1                   TO  FLG-PTNUM
                   INITIALIZE                  PTNUM-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTNUM
               INITIALIZE                  PTNUM-REC
           END-IF
           IF     (FLG-PTNUM           =   1     )  OR
                  (PTNUM-PTNUM         =   SPACE )  OR
                  (PTNUM-HKNID         =   ZERO  )
               DISPLAY "[ORCBMHKN PTNUM INV:" PTHKN-PTID
                       ",PTNUM:"  PTNUM-PTNUM 
                       ",HKNID:"  PTNUM-HKNID 
               MOVE    1               TO  FLG-ERR3
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       220-PTNUM-KEN-EXT.
           EXIT.
      *
      *****************************************************************
      *     保険ＩＤ設定変更処理
      *****************************************************************
       220-PTNUM-HEN-SEC            SECTION.
      *
      *    保険ＩＤ追加
           IF      PTNUM-HKNID         =   ALL "9"
               MOVE    ZERO            TO  PTNUM-HKNID
           END-IF
           ADD     1                   TO  PTNUM-HKNID
      *
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING   MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
           IF      MCP-RC      NOT =   ZERO
               DISPLAY "[ORCBMHKN PTNUM UPD ERR:" MCP-RC
                       ",PTID:"   PTNUM-PTID
                       ",PTNUM:"  PTNUM-PTNUM 
                       ",HKNID:"  PTNUM-HKNID 
               MOVE    1               TO  FLG-ERR
               GO      TO      220-PTNUM-HEN-EXT
           END-IF
           .
       220-PTNUM-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *     患者情報出力処理
      *****************************************************************
       230-OUT-SYORI-SEC            SECTION.
      *
      *    患者情報出力
           ADD     1                   TO  CNT-OUT
      *
           MOVE    SPACE               TO  WRK-OUT-REC
           MOVE    PTHKN-PTID          TO  OUT-PTID
           MOVE    PTNUM-PTNUM         TO  OUT-PTNUM
           MOVE    WRK-MAE-TEKSTYMD    TO  OUT-MAE-TEKSTYMD
           MOVE    WRK-MAE-TEKEDYMD    TO  OUT-MAE-TEKEDYMD
           MOVE    PTHKN-TEKSTYMD      TO  OUT-ATO-TEKSTYMD
           MOVE    PTHKN-TEKEDYMD      TO  OUT-ATO-TEKEDYMD
           MOVE    PTHKN-HKNJANUM      TO  OUT-HKNJANUM
           MOVE    WRK-MAE-HKNNUM      TO  OUT-MAE-HKNNUM
           MOVE    WRK-MAE-HKNID       TO  OUT-MAE-HKNID
           MOVE    PTHKN-HKNID         TO  OUT-ATO-HKNID
           MOVE    "("                 TO  OUT-H2
           MOVE    "-"                 TO  OUT-H3
           MOVE    ")-("               TO  OUT-H4
           MOVE    "-"                 TO  OUT-H5
           MOVE    ")"                 TO  OUT-H6
      *
           MOVE    WRK-OUT-REC         TO  OUT-REC
           WRITE   OUT-REC
      *
           .
       230-OUT-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票出力　初期処理
      *****************************************************************
       2710-OUTLST-INIT-SEC            SECTION.
      *
           OPEN    OUTPUT              OUT-FILE
           IF      STS-OUT             NOT =   ZERO
               MOVE    1               TO  FLG-END
               DISPLAY "*(ORCBMHKN)* OUTFILE OPN STS[" STS-OUT "]"
               GO      TO              2710-OUTLST-INIT-EXT
           END-IF
      *
           .
       2710-OUTLST-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理情報　検索処理
      *****************************************************************
       2200-CP1001-KENSAKU-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
           MOVE    SPACE               TO  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    WRK-SYMD            TO  ORC-DBYMD
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSTEM-NEXT-SEC
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
           IF  FLG-SYSKANRI            =   1
               MOVE    1                   TO  FLG-END
           ELSE
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
               MOVE    SYS-1001-HOSPID     TO  SPA-HOSPID
               MOVE    SYS-1001-HOSPSBT    TO  SPA-HOSPSBT
               MOVE    SYS-1001-ROUPAYKBN  TO  SPA-ROUPAYKBN
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           .
       2200-CP1001-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組み合わせ再セット処理
      *****************************************************************
       2201-HKNCOMBI-UPD-SEC           SECTION.
      *
           MOVE    WRK-PTID            TO  SPA-PTID
           CALL    "ORCBMCOMB"         USING
                                       SPA-AREA
                                       LNK-AREA
      *
           IF      SPA-ERRCD          =   SPACE
               ADD     1                  TO  CNT-UPD
           ELSE
      *        ＤＢ更新エラー
               IF      SPA-ERRCD           =   "9999"
                   MOVE    1               TO  FLG-ERR
               ELSE
      *            エラーリスト出力処理
                   PERFORM 2220-ERRLST-OUT-SEC
               END-IF
           END-IF
      *    ５０件毎にコミットする
           ADD     1               TO  CNT-IN-SEL
           IF     CNT-IN-SEL       =   50
      *     ステップ管理終了処理
                MOVE    "STE"           TO  SJOBKANRI-MODE
                INITIALIZE                  JOBKANRI-REC
                MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
                MOVE    WRK-PARA-SHELLID
                                            TO  JOB-SHELLID
                MOVE    50              TO  JOB-UPDCNT
                CALL    "ORCSJOB"       USING
                                        ORCSJOBKANRIAREA
                                        JOBKANRI-REC
      *
               PERFORM 9001-DBDBCOMMIT-SEC
               PERFORM 1001-DBSTART-SEC
               ADD     1                   TO  CNT-COMMIT
               MOVE    1                   TO  CNT-IN-SEL
           END-IF
      *
           .
       2201-HKNCOMBI-UPD-EXT.
           EXIT.
      *
      *****************************************************************
      *    任継続中一覧帳票出力　初期処理
      *****************************************************************
       2101-CONTI2-SYORI-SEC                SECTION.
      *
           ADD     1                   TO  CNT-LCNT1
           IF      CNT-LCNT1           >   80
      *        帳票印刷処理
               PERFORM 400-PRINT-OUT-SEC
               MOVE    1                   TO  CNT-LCNT1
           END-IF
      *
           IF      CNT-LCNT1           =   1
               INITIALIZE                  HCMSL80
               MOVE    MEISAI-HEAD         TO  HCMSL80-MOJI (CNT-LCNT1)
               ADD     1                   TO  CNT-LCNT1
               MOVE    MEISAI-HEAD2        TO  HCMSL80-MOJI (CNT-LCNT1)
               ADD     1                   TO  CNT-LCNT1
               ADD     1                   TO  CNT-LCNT1
           END-IF
           MOVE    SPACE               TO  MEISAI-BODY1
           MOVE    PTHKN-PTID          TO  MEISAI-PTID
           MOVE    PTNUM-PTNUM         TO  MEISAI-PTNUM
           MOVE    PTHKN-TEKSTYMD      TO  MEISAI-TEKSTYMD
           MOVE    PTHKN-TEKEDYMD      TO  MEISAI-TEKEDYMD
           MOVE    PTHKN-HKNNUM        TO  MEISAI-HKNNUM
           MOVE    PTHKN-CONTKBN       TO  MEISAI-CONTKBN
           MOVE    " - "               TO  MEISAI-H1
           IF      FLG-HOJOKBN         =   1
               MOVE    "老人割合設定"      TO  MEISAI-MSG
           END-IF
      *
           MOVE    MEISAI-BODY1        TO  HCMSL80-MOJI (CNT-LCNT1)
      *
           .
       2101-CONTI2-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       400-PRINT-OUT-SEC                SECTION.
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
           MOVE   "HCMSL80.red"        TO  SPRT-PRTID
           MOVE    "Ｈ１５．４改正変換任継分"
                                       TO  SPRT-TITLE
           MOVE    HCMSL80             TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
           .
       400-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーリスト出力処理
      *****************************************************************
       2220-ERRLST-OUT-SEC                SECTION.
      *
           ADD     1                   TO  CNT-ERR
           ADD     1                   TO  CNT-LCNT2
           IF      CNT-LCNT2           >   55
      *        帳票印刷処理
               PERFORM 400-PRINT-OUT2-SEC
               MOVE    1                   TO  CNT-LCNT2
           END-IF
      *
           IF      CNT-LCNT2           =   1
               INITIALIZE                  HCMSL55
               MOVE    ERRMES-TITLE1       TO  HCMSL55-MOJI (CNT-LCNT2)
               ADD     1                   TO  CNT-LCNT2
               MOVE    ERRMES-TITLE3       TO  HCMSL55-MOJI (CNT-LCNT2)
               ADD     1                   TO  CNT-LCNT2
           END-IF
      *
           MOVE    SPACE               TO  ERR-REC
           MOVE    CNT-ERR             TO  WRK-Z3
           MOVE    WRK-Z3              TO  ERR-NO  (1:3)
           MOVE    ":"                 TO  ERR-NO  (5:1)
           IF      FLG-ERR3            =   ZERO
               MOVE    SPA-ERRMSG          TO  ERR-MES
           ELSE
               MOVE    "患者番号変換ＤＢエラー　　　　　　　　　　　"
                                           TO  ERR-MES
           END-IF
           MOVE    PTNUM-PTNUM         TO  ERR-PTNUM
           MOVE    PTHKN-HKNNUM        TO  ERR-HKNNUM
           MOVE    PTHKN-PTID          TO  ERR-PTID
           IF      FLG-ERR3            =   ZERO
               MOVE    "保険組合せ未設定"  TO  ERR-ERRMSG
           ELSE
               MOVE    PTNUM-HKNID         TO  ERR-HKNID
           END-IF
      *
           MOVE    ERR-REC             TO  HCMSL55-MOJI (CNT-LCNT2)
      *
           MOVE    SPACE               TO  SPA-ERRCD
      *
           .
       2220-ERRLST-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理（エラー）
      *****************************************************************
       400-PRINT-OUT2-SEC                SECTION.
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
           MOVE   "HCMSL55.red"        TO  SPRT-PRTID
           MOVE    "Ｈ１５．４改正変換エラー"
                                       TO  SPRT-TITLE
           MOVE    HCMSL55             TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
           .
       400-PRINT-OUT2-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           IF      CNT-LCNT1           >   ZERO
      *        帳票印刷処理
               PERFORM 400-PRINT-OUT-SEC
           END-IF
      *
           IF      CNT-LCNT2           >   ZERO
      *        帳票印刷処理
               PERFORM 400-PRINT-OUT2-SEC
           END-IF
      *
           DISPLAY "*** ORCBMHKN PTHKNINF:"       CNT-IN
           DISPLAY "*** ORCBMHKN PTHKNINF OUT:"   CNT-OUT
           DISPLAY "*** ORCBMHKN PTHKNINF UPD:"   CNT-UPD
           DISPLAY "*** ORCBMHKN HKNCOMBI UPD:"   LNK-CNT-HKNCOMBI
           DISPLAY "*** ORCBMHKN          ERR:"   CNT-ERR
           DISPLAY "*** ORCBMHKN END ***"
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           IF      CNT-COMMIT      =   ZERO
               MOVE    CNT-UPD         TO  CNT-HEN
           ELSE
               COMPUTE CNT-HEN         =   CNT-UPD
                                       -  (CNT-COMMIT   *   50 )
           END-IF
      *****MOVE    CNT-UPD         TO  JOB-UPDCNT
           MOVE    CNT-HEN         TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT               RECEERR-FILE
           IF        ( STS-RECEERR     =   ZERO )
               CONTINUE
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
      *    患者番号変換マスタＦＥＴＣＨ処理
      *****************************************************************
       940-PTNUM-NEXT-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"      USING   MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTNUM-REC
               MOVE    ZERO            TO  FLG-PTNUM
           ELSE
               INITIALIZE                  PTNUM-REC
               MOVE    1               TO  FLG-PTNUM
           END-IF
      *
           .
       940-PTNUM-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険情報読み込み
      *****************************************************************
       900-PTHKNINF-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTHKNINF-REC
               MOVE    ZERO            TO  FLG-PTHKNINF
           ELSE
               INITIALIZE                  PTHKNINF-REC
               MOVE    1               TO  FLG-PTHKNINF
           END-IF
      *
           .
       900-PTHKNINF-READ-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    システム管理マスタＦＥＴＣＨ処理
      *****************************************************************
       900-SYSTEM-NEXT-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSTEM-NEXT-EXT.
           EXIT.
      *****************************************************************
      *    保険番号マスタ次検索処理
      *****************************************************************
       950-HKNNUM-NEXT-SEC             SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
           .
       950-HKNNUM-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込（主キー）
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
                   MOVE    MCPDATA-REC         TO  PTINF-REC
                   MOVE    ZERO                TO  FLG-PTINF
               ELSE
                   MOVE    1                   TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
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
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           PERFORM 1001-DBSTART-SEC
           .
       100-DBOPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＴＡＲＴ処理
      *****************************************************************
       1001-DBSTART-SEC        SECTION.
      *
           MOVE    "DBSTART"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       1001-DBSTART-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＴＡＲＴ処理
      *****************************************************************
       9001-DBDBCOMMIT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       9001-DBDBCOMMIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-DBDISCONNECT-SEC        SECTION.
      *
           IF      FLG-ERR         =   ZERO
               MOVE    "DBCOMMIT"      TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           END-IF
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
