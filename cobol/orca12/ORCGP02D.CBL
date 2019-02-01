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
       PROGRAM-ID.             ORCGP02D.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 労災保険入力画面（Ｐ０２Ｄ）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/04/05    MCC-多々納    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-多々納   02/06/18  災害区分追加
      *  02.00.01    NACL-多々納  02/07/31  パラメタファイルをＤＢへ
      *  02.00.02    NACL-多々納  02/08/21  アフターケアの療養期間追加
      *  02.00.03    NACL-多々納  02/09/10  自賠責の追加
      *  02.00.04    NACL-多々納  02/09/27  コンボのチェック追加
      *  02.00.05    NACL-多々納  03/05/12  自費請求区分追加
      *  02.00.06    NACL-多々納  05/01/11  自賠責担当医、保険会社名追加
      *  02.00.05    NACL-多々納  05/11/11  MONFUNC 対応 他
      *  02.00.06    NACL-多々納  05/12/07  労災レセ回数記載追加 他
      *  03.05.00    NACL-多々納  07/05/XX  グループ診療対応
      *  04.01.00    NACL-多々納  07/10/19  公務災害追加
      *  04.05.00    NACL-多々納  09/06/26  自賠責請求区分初期設定対応
      *  04.07.00    NACL-多々納  11/09/06  労働基準監督署コード対応
      *  04.07.00    NACL-多々納  13/07/XX  労災選択対応
      *                                     第三者行為対応
      *  04.07.00    NACL-多々納  14/10/XX  第三者現物支給対象等対応
      *  04.08.00    NACL-多々納  15/11/XX  APIV3(HAORI)対応
      *  04.08.00    NACL-多々納  17/05/XX  自賠責点数算定区分対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    患者登録スパ領域
           COPY    "P02COMMON-SPA".
      *    患者画面スパ領域
           COPY    "P02SCR-SPA".
      *
      *    ステータス領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-HKNJAINF        PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-LABOR-SIO       PIC 9(01).
      *
           03  FLG-OK              PIC 9(01).
           03  FLG-CHK             PIC 9(01).
           03  FLG-TOUROKU         PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX2                PIC 9(02).
           03  IDX3                PIC 9(02).
      *
           03  IDR                 PIC 9(04).
           03  IDR2                PIC 9(04).
           03  IDX-R               PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
      *
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-SYSYMD          PIC X(08).
      *
           03  WRK-EDANUM          PIC 9(04).
      *
           03  WRK-N-IDX           PIC 9(04).
      *    入力項目名
           03  WRK-MCP-WIDGET          PIC X(64).
      *TEST
           03  WRK-ZZZ                 PIC ZZZ.
           03  WRK-SELNUM              PIC 9(03).
      *
      *    降順表示
           03  WRK-KEY-SYMD            PIC X(08).
           03  WRK-KEY-EYMD            PIC X(08).
           03  WRK-IN-SYMD             PIC X(08).
           03  WRK-IN-EYMD             PIC X(08).
           03  WRK-IDR                 PIC 9(03).
      *
      *APIV3
           03  WRK-PARA-GYOUMUID       PIC X(04).
      *
      *    半角全角変換
      *01  WRK-HENKAN-AREA.
      *    03  WRK-MAE-INPUT       PIC X(100).
      *    03  WRK-ATO-INPUT       PIC X(100).
      *    03  WRK-MAX             PIC 9(04).
      *
      *    公費件数
       01  TBL-MAX-KOH             PIC 9(02)  VALUE    60.
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC Z9.
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC Z9.
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
      *    システム管理（労災医療機関情報）
           COPY    "CPSK4001.INC".
      *    システム管理（損傷区分）
           COPY    "CPSK4002.INC".
      *
      *    職員情報
           COPY    "CPSK1010.INC".
      *
      *    患者保険情報
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *    組合せ作成時使用項目
           03  PTHKN-SBT          PIC X(01).
           03  PTHKN-SEIDO        PIC X(10).
      *
      *    患者公費情報
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *    組合せ作成時使用項目
           03  PTKOH-SBT          PIC X(01).
           03  PTKOH-SEIDO        PIC X(10).
           03  PTKOH-HKNKOHKBN    PIC X(01).
           03  PTKOH-GENHKNNUM1   PIC X(03).
           03  PTKOH-GENHKNNUM2   PIC X(03).
           03  PTKOH-GENHKNNUM3   PIC X(03).
      *
      *    保険番号マスタ
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    保険者号マスタ
       01  HKNJAINF-REC.
           COPY    "CPHKNJAINF.INC".
      *
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *    パラメタテーブル
       01  PARA-REC.
           COPY    "CPPARA.INC".
      *
      *    労働基準監督署マスタ
       01  LABOR-SIO-REC.
           COPY    "CPLABOR-SIO.INC".
      *
      *
      *    患者労災保険情報
       01  TBL-PTRSIINF-AREA.
           02  TBL-PTRSIINF-REC        OCCURS   50.
           COPY    "CPPTRSIINF.INC"    REPLACING
                                   //PTRSI-// BY //TBL-PTRSI-//.
           03  TBL-PARA-EDANUM     PIC 9(04).
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
      *   チェックデジット
           COPY    "CPORCCHKDGT.INC".
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ドクター編集変換サブ
           COPY    "CPORCSDRSET.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
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
           COPY    "ORCA12SCRAREA.INC".
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
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA.
           MOVE    SPA-FREE        TO  SPA-P02SCRAREA
           MOVE    SPA-WORK        TO  SPA-P02KYOUTU
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
      *    画面編集後、表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-P02KYOUTU     TO  SPA-WORK
           MOVE    SPA-AREA          TO  SPA-COMMON
           MOVE    SPA-P02SCRAREA    TO  SPA-FREE
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
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "PERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
               PERFORM 300-SCREEN-SEC
      *
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "P02D"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      *    労災保険情報
           MOVE    SPACE               TO  SPA-P02D-AREA
           INITIALIZE                      SPA-P02D-AREA
      *
           MOVE    SPA-NAI-RSHKN-EDANUM    TO  SPA-NAI2D-RSHKN-EDANUM
      *
      *    コンボボクスの編集
           PERFORM 3002-COMBBOX-HEX-SEC
      *
      *    保険一覧
           PERFORM 3001-RSILIST-HEN-SEC
      *
           IF      SPA-NAI2D-RSHKN-EDANUM  =   ZERO
      *        [新規入力]
               MOVE    SPA-GMN-NAME        TO  SPA-GMN2D-HIHKNJANAME
           ELSE
      *        労災内容編集
               PERFORM 3001-RSHKN-SET-SEC
           END-IF
      *
      *    区分毎コンボボクス編集
           PERFORM 41012-SINKEI-SET-SEC
      *    コンボボクスの編集
           PERFORM 3003-COMBBOX-SET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災保険一覧編集処理
      *****************************************************************
       3001-RSILIST-HEN-SEC             SECTION.
      *
      *
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "PTRSIINF"          TO  PARA-FILEMEI
      *
           MOVE    SPA-HOSPNUM         TO  PARA-HOSPNUM
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key5"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_para"          TO  MCP-TABLE
               MOVE    "key5"              TO  MCP-PATHNAME
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           MOVE    ZERO                TO  IDR
           MOVE    SPACE               TO  TBL-PTRSIINF-AREA
           PERFORM UNTIL   (FLG-PARA       =   1 )
                       OR  (IDR            >=  50)
               MOVE    PARA-DATA-REC       TO  PTRSIINF-REC
               IF      PTRSI-SAKUJOKBN     =   SPACE
                   ADD     1                   TO  IDR
                   MOVE    PARA-DATA-REC       TO  TBL-PTRSIINF-REC(IDR)
                   MOVE    PARA-EDANUM         TO  TBL-PARA-EDANUM (IDR)
               END-IF
               MOVE    "tbl_para"          TO  MCP-TABLE
               MOVE    "key5"              TO  MCP-PATHNAME
               PERFORM 990-PARA-READ-SEC
           END-PERFORM
      *
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key5"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           PERFORM VARYING    IDR      FROM    1   BY  1
                   UNTIL      IDR      >   50
               MOVE    SPACE               TO  WRK-KEY-SYMD
               MOVE    SPACE               TO  WRK-KEY-EYMD
               MOVE    ZERO                TO  WRK-IDR
               PERFORM VARYING    IDR2     FROM    1   BY  1
                       UNTIL      IDR2     >   50
               IF      TBL-PTRSIINF-REC (IDR2) NOT =   SPACE
                   MOVE    TBL-PTRSIINF-REC (IDR2) TO  PTRSIINF-REC
      *            療養開始年月日
                   IF      PTRSI-HKNKBN        =   "3"
      *                アフターケア
                       MOVE    PTRSI-SINSATUYMD    TO  WRK-IN-SYMD
                       MOVE    PTRSI-SINSATUEND    TO  WRK-IN-EYMD
                   ELSE
                       MOVE    PTRSI-RYOSTYMD      TO  WRK-IN-SYMD
                       MOVE    PTRSI-RYOEDYMD      TO  WRK-IN-EYMD
                   END-IF
                   IF     (WRK-KEY-SYMD        =   SPACE)
                       MOVE    WRK-IN-SYMD         TO  WRK-KEY-SYMD
                       MOVE    WRK-IN-EYMD         TO  WRK-KEY-EYMD
                       MOVE    IDR2                TO  WRK-IDR
                   ELSE
      *                降順に表示
                       IF     (WRK-KEY-SYMD        <   WRK-IN-SYMD )
                         AND  (WRK-KEY-EYMD        <=  WRK-IN-EYMD )
                           MOVE    WRK-IN-SYMD         TO  WRK-KEY-SYMD
                           MOVE    WRK-IN-EYMD         TO  WRK-KEY-EYMD
                           MOVE    IDR2                TO  WRK-IDR
                       END-IF
                   END-IF
               END-IF
               END-PERFORM
               IF      WRK-IDR             >   ZERO
                   PERFORM 30011-RSIINF-HEN-SEC
                   MOVE    SPACE           TO  TBL-PTRSIINF-REC(WRK-IDR)
               ELSE
                   MOVE    50              TO  IDR
               END-IF
           END-PERFORM
      *    選択がない時、１件目
           IF      SPA-NAI2D-RSHKN-EDANUM  =   ZERO
               IF      SPA-GMN2D-TRYOEDYMD (1) =   "99999999"
                   MOVE    SPA-GMN2D-TPARANUM (1)
                                           TO  SPA-NAI2D-RSHKN-EDANUM
                   MOVE    1                   TO  SPA-GMN2D-SELNUM
                   MOVE    SPA-GMN2D-SELNUM    TO  SPA-GMN2D-MAE-SELNUM
               END-IF
           END-IF
           .
       3001-RSILIST-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災保険者の編集処理
      *****************************************************************
       30011-RSIINF-HEN-SEC             SECTION.
      *
           MOVE    TBL-PTRSIINF-REC (WRK-IDR) TO  PTRSIINF-REC
      *
           MOVE    IDR                 TO  SPA-GMN2D-TRENNUM (IDR)
           MOVE    TBL-PARA-EDANUM (WRK-IDR)
                                       TO  SPA-GMN2D-TPARANUM (IDR)
           IF      SPA-NAI2D-RSHKN-EDANUM
                                       =   TBL-PARA-EDANUM (WRK-IDR)
               MOVE    IDR                 TO  SPA-GMN2D-SELNUM
               MOVE    SPA-GMN2D-SELNUM    TO  SPA-GMN2D-MAE-SELNUM
           END-IF
      *
           MOVE    PTRSI-HKNKBN        TO  SPA-GMN2D-THKNKBN (IDR)
           MOVE    PTRSI-HKNID         TO  SPA-GMN2D-THKNID (IDR)
           MOVE    PTRSI-KOHID         TO  SPA-GMN2D-TKOHID (IDR)
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-HKNKBN-MAX
               IF      SPA-GMN2D-HKNKBN-LST(IDX) (1:1)
                                           =   PTRSI-HKNKBN
                   MOVE    SPA-GMN2D-HKNKBN-LST (IDX)(3:)
                                           TO  SPA-GMN2D-THKNKBNMEI(IDR)
               END-IF
           END-PERFORM
      *    療養開始年月日
           IF      PTRSI-HKNKBN        =   "3"
      *        アフターケア
               MOVE    PTRSI-SINSATUYMD    TO  WRK-SYMD
               PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
               MOVE    WRK-HENYMD          TO  SPA-GMN2D-TRSIKIKAN
                                                          (IDR) (1:9)
               MOVE    "-"                 TO  SPA-GMN2D-TRSIKIKAN
                                                          (IDR) (10:1)
               MOVE    PTRSI-SINSATUEND    TO  WRK-SYMD
               PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
               MOVE    WRK-HENYMD          TO  SPA-GMN2D-TRSIKIKAN
                                                          (IDR) (11:9)
               MOVE    PTRSI-SINSATUYMD    TO  SPA-GMN2D-TRYOSTYMD(IDR)
               MOVE    PTRSI-SINSATUEND    TO  SPA-GMN2D-TRYOEDYMD(IDR)
           ELSE
               MOVE    PTRSI-RYOSTYMD      TO  WRK-SYMD
               PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
               MOVE    WRK-HENYMD          TO  SPA-GMN2D-TRSIKIKAN
                                                          (IDR) (1:9)
               MOVE    "-"                 TO  SPA-GMN2D-TRSIKIKAN
                                                          (IDR) (10:1)
               MOVE    PTRSI-RYOEDYMD      TO  WRK-SYMD
               PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
               MOVE    WRK-HENYMD          TO  SPA-GMN2D-TRSIKIKAN
                                                       (IDR) (11:9)
               MOVE    PTRSI-RYOSTYMD      TO  SPA-GMN2D-TRYOSTYMD(IDR)
               MOVE    PTRSI-RYOEDYMD      TO  SPA-GMN2D-TRYOEDYMD(IDR)
           END-IF
      *
           MOVE    IDR             TO  SPA-GMN2D-RSIMAX
           .
       30011-RSIINF-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災保険者の編集処理
      *****************************************************************
       3001-RSHKN-SET-SEC             SECTION.
      *
      *
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
      *APIV3
           IF      WRK-PARA-GYOUMUID   NOT =   SPACE
               MOVE    WRK-PARA-GYOUMUID   TO  PARA-GYOUMUID
           END-IF
      *
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "PTRSIINF"          TO  PARA-FILEMEI
           MOVE    SPA-NAI2D-RSHKN-EDANUM
                                       TO  PARA-EDANUM
      *
           MOVE    SPA-HOSPNUM         TO  PARA-HOSPNUM
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_para"          TO  MCP-TABLE
               MOVE    "key4"              TO  MCP-PATHNAME
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           IF      FLG-PARA           =   1
               INITIALIZE                      PTRSIINF-REC
           ELSE
               MOVE    PARA-DATA-REC       TO  PTRSIINF-REC
           END-IF
      *H25.7
           MOVE    PTRSI-HKNID         TO  SPA-NAI2D-HKNID
           MOVE    PTRSI-KOHID         TO  SPA-NAI2D-KOHID
      *    労災保険区分
           MOVE    PTRSI-HKNKBN        TO  SPA-GMN2D-HKNKBN
           MOVE    PTRSI-HKNKBN        TO  SPA-NAI2D-HKNKBN-MAE
      *APIV3
           IF      WRK-PARA-GYOUMUID   NOT =   SPACE
      *        ＩＤ未設定を新規分とする
               IF     (PTRSI-HKNID         =   ZERO )
                  AND (PTRSI-KOHID         =   ZERO )
                   MOVE    SPACE           TO  SPA-NAI2D-HKNKBN-MAE
               END-IF
           END-IF
      *    保険番号
           MOVE    PTRSI-HKNNUM        TO  SPA-NAI2D-HKNNUM
      *    患者交付番号
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
                   MOVE    PTRSI-KOFUNUM       TO  SPA-GMN2D-KOHNUM1
               WHEN    "2"
                   MOVE    PTRSI-KOFUNUM       TO  SPA-GMN2D-KOHNUM2
               WHEN    "3"
                   MOVE    PTRSI-KOFUNUM       TO  SPA-GMN2D-KOHNUM3
           END-EVALUATE
      *
      *被保険者名
           MOVE    SPA-GMN-NAME        TO  SPA-GMN2D-HIHKNJANAME
      *****MOVE    PTRSI-HIHKNJANAME   TO  SPA-GMN2D-HIHKNJANAME
      *事業所名称
           MOVE    PTRSI-JIGYOUNAME    TO  SPA-GMN2D-JIGYOUNAME
      *所在地都道府県名
           MOVE    PTRSI-PREFNAME      TO  SPA-GMN2D-PREFNAME
      *所在地都道府県区分
           MOVE    PTRSI-PREFKBN       TO  SPA-GMN2D-PREFKBN
      *所在地郡市区名
           MOVE    PTRSI-CITYNAME      TO  SPA-GMN2D-CITYNAME
      *所在地郡市区区分
           MOVE    PTRSI-CITYKBN       TO  SPA-GMN2D-CITYKBN
      *災害区分
           MOVE    PTRSI-SAIGAIKBN     TO  SPA-GMN2D-SAIGAI
      *新継再別
           MOVE    PTRSI-SINKEI        TO  SPA-GMN2D-SINKEI
      *転帰事由
           MOVE    PTRSI-TENKI         TO  SPA-GMN2D-TENKI
      *傷病年月日
           MOVE    PTRSI-SHOBYOYMD     TO  SPA-NAI2D-SHOBYOYMD
           MOVE    PTRSI-SHOBYOYMD     TO  WRK-SYMD
           PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
           MOVE    WRK-HENYMD          TO  SPA-GMN2D-SHOBYOYMD
      *四肢特例区分
           MOVE    PTRSI-SISIKBN       TO  SPA-GMN2D-SISIKBN
      *療養開始年月日
           MOVE    PTRSI-RYOSTYMD      TO  SPA-NAI2D-RYOSTYMD
           MOVE    PTRSI-RYOSTYMD      TO  WRK-SYMD
           PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
           MOVE    WRK-HENYMD          TO  SPA-GMN2D-RYOSTYMD
      *療養終了年月日
           MOVE    PTRSI-RYOEDYMD      TO  SPA-NAI2D-RYOEDYMD
           MOVE    PTRSI-RYOEDYMD      TO  WRK-SYMD
           PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
           MOVE    WRK-HENYMD          TO  SPA-GMN2D-RYOEDYMD
      *損傷区分
           MOVE    PTRSI-SONSHOUKBN    TO  SPA-GMN2D-SONSHOUKBN
      *損傷区分−枝番
           MOVE    PTRSI-SONSHOUKBN-EDANUM
                                       TO  SPA-GMN2D-SONSHOUKBNEDA
      *アフターケア療養開始年月日
           MOVE    PTRSI-SINSATUYMD    TO  SPA-NAI2D-SINSATUYMD
           MOVE    PTRSI-SINSATUYMD    TO  WRK-SYMD
           PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
           MOVE    WRK-HENYMD          TO  SPA-GMN2D-SINSATUYMD
      *アフターケア療養終了年月日
           MOVE    PTRSI-SINSATUEND    TO  SPA-NAI2D-SINSATUEND
           MOVE    PTRSI-SINSATUEND    TO  WRK-SYMD
           PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
           MOVE    WRK-HENYMD          TO  SPA-GMN2D-SINSATUEND
      *確認年月日
           MOVE    PTRSI-KAKUNINYMD    TO  SPA-NAI2D-KAKUNINYMD
           MOVE    PTRSI-KAKUNINYMD    TO  WRK-SYMD
           PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
           MOVE    WRK-HENYMD          TO  SPA-GMN2D-KAKUNINYMD
      *
      *コメント
           MOVE    PTRSI-COMMENT       TO  SPA-GMN2D-COMMENT
      *
      *自賠責患者請求区分
           MOVE    PTRSI-JIBAISEIKBN   TO  SPA-GMN2D-JIBAISEIKBN
      *
      *自賠責担当医コード
           MOVE    PTRSI-DRCD(2:4)     TO  SPA-GMN2D-DRCD
      *自賠責保険会社名
           MOVE    PTRSI-HOKENNAME     TO  SPA-GMN2D-HOKENNAME
      *
      *労災レセ回数記載
      *    短期給付・傷病年金の時、初期設定
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
               WHEN    "2"
      *            基準年月
                   IF      PTRSI-KIJYUNYM      =    SPACE
                       MOVE    PTRSI-RYOSTYMD(1:6)  TO  PTRSI-KIJYUNYM
                   END-IF
                   MOVE    PTRSI-KIJYUNYM      TO  SPA-NAI2D-KIJYUNYM
                   MOVE    PTRSI-KIJYUNYM      TO  WRK-SYMD(1:6)
                   MOVE    "01"                TO  WRK-SYMD(7:2)
                   PERFORM 410112-SE-WAFORMAT-YMDEDIT-SEC
                   MOVE    WRK-HENYMD(1:6)     TO  SPA-GMN2D-KIJYUNYM
      *            回数
                   IF      PTRSI-KAISU         =   ZERO
                       MOVE    1                   TO  SPA-GMN2D-KAISU
                   ELSE
                       MOVE    PTRSI-KAISU         TO  SPA-GMN2D-KAISU
                   END-IF
      *            労働基準監督署コード
                   MOVE    PTRSI-SYOCD         TO  SPA-GMN2D-SYOCD
                   MOVE    PTRSI-SYOCD         TO  SPA-NAI2D-MAE-SYOCD
      *H29.2       初期設定廃止
      *            IF      PTRSI-SYOCD         =   SPACE
      *                労働基準監督署コード初期設定
      *                PERFORM 30011-SYOCD-INITSET-SEC
      *****        END-IF
                   IF      SPA-GMN2D-SYOCD     NOT =   SPACE
      *                労働基準監督署名称編集
                       PERFORM 30012-SYOCD-HEN-SEC
                   END-IF
      *H29.5
      *       自賠責
               WHEN    "4"
      *            自賠責点数区分
                   IF      PTRSI-JIBAIKBN      =   SPACE
                       MOVE    "0"             TO  PTRSI-JIBAIKBN
                   END-IF
                   MOVE    PTRSI-JIBAIKBN      TO  SPA-GMN2D-JIBAIKBN
                   MOVE    PTRSI-JIBAIKBN      TO
                                               SPA-NAI2D-MAE-JIBAIKBN
      *H26.10
      *        第三者
               WHEN    "6"
                   PERFORM 30013-DAISAN-HEN-SEC
      *        アフターケア
               WHEN    "3"
      *            損傷区分
                   MOVE    PTRSI-SINSATUYMD    TO  WRK-SYSYMD
                   PERFORM 30021-SONSHOUKBN-SET-SEC
           END-EVALUATE
      *
           .
       3001-RSHKN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    労働基準監督署コード初期設定処理
      *****************************************************************
       30011-SYOCD-INITSET-SEC             SECTION.
      *
           EVALUATE    SPA-GMN2D-HKNKBN
      *        短期給付
               WHEN    "1"
      *            労働保険番号
                   MOVE    SPA-GMN2D-KOHNUM1(1:5)  TO  SPA-GMN2D-SYOCD
      *        傷病年金
               WHEN    "2"
      *            短期給付の登録チェック
                   PERFORM 30012-SYOCD-DATACHK-SEC
           END-EVALUATE
      *
           .
       30011-SYOCD-INITSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    労働基準監督署名称編集処理
      *****************************************************************
       30012-SYOCD-DATACHK-SEC         SECTION.
      *
           INITIALIZE                      PARA-REC
           MOVE    SPA-HOSPNUM         TO  PARA-HOSPNUM
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "PTRSIINF"          TO  PARA-FILEMEI
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key5"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_para"          TO  MCP-TABLE
               MOVE    "key5"              TO  MCP-PATHNAME
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
           PERFORM UNTIL       FLG-PARA    =   1
               MOVE    PARA-DATA-REC       TO  PTRSIINF-REC
               IF     (PTRSI-HKNKBN        =   "1"  )
                  AND (PTRSI-SHOBYOYMD     =   SPA-NAI2D-SHOBYOYMD)
                  AND (PTRSI-SAKUJOKBN     =   SPACE )
      *            傷病年月日が同じ短期給付の労働保険番号とする
                   IF      PTRSI-SYOCD         =   SPACE
                       MOVE    PTRSI-KOFUNUM(1:5)  TO  SPA-GMN2D-SYOCD
                   ELSE
                       MOVE    PTRSI-SYOCD         TO  SPA-GMN2D-SYOCD
                   END-IF
                   MOVE    1                   TO  FLG-PARA
               ELSE
                   MOVE    "tbl_para"          TO  MCP-TABLE
                   MOVE    "key5"              TO  MCP-PATHNAME
                   PERFORM 990-PARA-READ-SEC
               END-IF
           END-PERFORM
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key5"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           .
       30011-SYOCD-INITSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    労働基準監督署名称編集処理
      *****************************************************************
       30012-SYOCD-HEN-SEC             SECTION.
      *
           INITIALIZE                      LABOR-SIO-REC
           MOVE    SPA-GMN2D-SYOCD     TO  LABOR-SIO-SYOCD
           MOVE    SPA-NAI2D-RYOSTYMD  TO  LABOR-SIO-YUKOSTYMD
           MOVE    SPA-NAI2D-RYOSTYMD  TO  LABOR-SIO-YUKOEDYMD
      *
           MOVE    LABOR-SIO-REC       TO  MCPDATA-REC
           MOVE    "tbl_labor_sio"     TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_labor_sio"     TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 900-LABOR-SIO-READ-SEC
           ELSE
               INITIALIZE                  LABOR-SIO-REC
               MOVE    1               TO  FLG-LABOR-SIO
           END-IF
           MOVE    "tbl_labor_sio"     TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           IF      FLG-LABOR-SIO       =   ZERO
               MOVE    LABOR-SIO-NAME      TO  SPA-GMN2D-SYOCDNAME
           ELSE
               MOVE    SPACE               TO  SPA-GMN2D-SYOCDNAME
           END-IF
           .
       30012-SYOCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    第三者行為　編集処理
      *****************************************************************
       30013-DAISAN-HEN-SEC             SECTION.
      *
      *    現物給付計算区分
           MOVE    PTRSI-DAISAN-GENBTKBN   TO  SPA-GMN2D-D3-GENBTKBN
           IF      PTRSI-DAISAN-GENBTKBN   =   SPACE
               MOVE    "1"                     TO  SPA-GMN2D-D3-GENBTKBN
           END-IF
      *    特記事項区分
           MOVE    PTRSI-DAISAN-TOKKIKBN   TO  SPA-GMN2D-D3-TOKKIKBN
           IF      PTRSI-DAISAN-TOKKIKBN   =   SPACE
               MOVE    "1"                     TO  SPA-GMN2D-D3-TOKKIKBN
           END-IF
           .
       30013-DAISAN-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    コンボボクスの編集処理
      *****************************************************************
       3002-COMBBOX-HEX-SEC             SECTION.
      *
      *    労災保険区分
           MOVE    ZERO                TO  SPA-GMN2D-HKNKBN-MAX
           IF      SPA-ROSAI-FLG       =   1
               MOVE    "1 短期給付"        TO  SPA-GMN2D-HKNKBN-LST (01)
               MOVE    "2 傷病年金"        TO  SPA-GMN2D-HKNKBN-LST (02)
               MOVE    "3 アフターケア"    TO  SPA-GMN2D-HKNKBN-LST (03)
               MOVE    3                   TO  SPA-GMN2D-HKNKBN-MAX
           END-IF
           IF      SPA-JIBAI-FLG       =   1
               ADD     1                   TO  SPA-GMN2D-HKNKBN-MAX
               MOVE    "4 自賠責保険"      TO  SPA-GMN2D-HKNKBN-LST
                                                 (SPA-GMN2D-HKNKBN-MAX)
           END-IF
           IF      SPA-ROSAI-FLG       =   1
               ADD     1                   TO  SPA-GMN2D-HKNKBN-MAX
               MOVE    "5 公務災害"        TO  SPA-GMN2D-HKNKBN-LST
                                                 (SPA-GMN2D-HKNKBN-MAX)
           END-IF
      *
           IF      SPA-DAISAN-FLG      =   1
               ADD     1                   TO  SPA-GMN2D-HKNKBN-MAX
               MOVE    "6 第三者行為"      TO  SPA-GMN2D-HKNKBN-LST
                                                 (SPA-GMN2D-HKNKBN-MAX)
           END-IF
      *
      *    見出し修正
      *    EVALUATE    SPA-GMN2D-HKNKBN
      *        WHEN    "5"
      *            MOVE    "請求区分"          TO  SPA-GMN2D-SEIKBNMEI
      *            MOVE    "担当医"            TO  SPA-GMN2D-TANTOIMEI
      *        WHEN    OTHER
      *            MOVE    "自賠責請求区分"    TO  SPA-GMN2D-SEIKBNMEI
      *            MOVE    "自賠責担当医"      TO  SPA-GMN2D-TANTOIMEI
      *    END-EVALUATE
      *    自賠責患者請求区分
      *    MOVE    "1 患者請求する(100%)"
      *                                TO  SPA-GMN2D-JIBAISEIKBN-LST(01)
      *    MOVE    "2 患者請求しない(0%)"
      *                                TO  SPA-GMN2D-JIBAISEIKBN-LST(02)
      *!   第三者
      *    IF      SPA-GMN2D-HKNKBN    =   "6"
      *        MOVE    "1 患者請求する"
      *                                TO  SPA-GMN2D-JIBAISEIKBN-LST(01)
      *    END-IF
      *
      *    IF      SPA-GMN2D-HKNKBN    =   "4"
      *                                OR  "5"
      *                                OR  "6"
      *        MOVE    2                   TO  SPA-GMN2D-JIBAISEIKBN-MAX
      *    ELSE
      *        MOVE    ZERO                TO  SPA-GMN2D-JIBAISEIKBN-MAX
      **** END-IF
      *
      *    災害区分
           MOVE    "1 業務中の災害"    TO  SPA-GMN2D-SAIGAI-LST (01)
           MOVE    "2 通勤途上の災害"  TO  SPA-GMN2D-SAIGAI-LST (02)
           MOVE    2                   TO  SPA-GMN2D-SAIGAI-MAX
      *
      *    自賠責・公務災害の初期表示
           IF     (SPA-JIBAI-FLG       =   1  )  OR
                  (SPA-ROSAI-FLG       =   1  )
               PERFORM 30022-JIBAISEIKBN-SET-SEC
           END-IF
      *
      *    転帰区分
           MOVE    "1 治癒"            TO  SPA-GMN2D-TENKI-LST (01)
           MOVE    "3 継続"            TO  SPA-GMN2D-TENKI-LST (02)
           MOVE    "5 転医"            TO  SPA-GMN2D-TENKI-LST (03)
           MOVE    "7 中止"            TO  SPA-GMN2D-TENKI-LST (04)
           MOVE    "9 死亡"            TO  SPA-GMN2D-TENKI-LST (05)
           MOVE    5                   TO  SPA-GMN2D-TENKI-MAX
      *
      *    四肢特例
           MOVE    "0 なし"            TO  SPA-GMN2D-SISIKBN-LST (01)
           MOVE    "1 四肢"            TO  SPA-GMN2D-SISIKBN-LST (02)
           MOVE    "2 手指"            TO  SPA-GMN2D-SISIKBN-LST (03)
           MOVE    3                   TO  SPA-GMN2D-SISIKBN-MAX
      *
      *    都道府県
           MOVE    "北海道"            TO  SPA-GMN2D-PREFNAME-LST(1)
           MOVE    "青森"              TO  SPA-GMN2D-PREFNAME-LST(2)
           MOVE    "岩手"              TO  SPA-GMN2D-PREFNAME-LST(3) 
           MOVE    "宮城"              TO  SPA-GMN2D-PREFNAME-LST(4)
           MOVE    "秋田"              TO  SPA-GMN2D-PREFNAME-LST(5)
           MOVE    "山形"              TO  SPA-GMN2D-PREFNAME-LST(6)
           MOVE    "福島"              TO  SPA-GMN2D-PREFNAME-LST(7)
           MOVE    "茨城"              TO  SPA-GMN2D-PREFNAME-LST(8)
           MOVE    "栃木"              TO  SPA-GMN2D-PREFNAME-LST(9)
           MOVE    "群馬"              TO  SPA-GMN2D-PREFNAME-LST(10)
           MOVE    "埼玉"              TO  SPA-GMN2D-PREFNAME-LST(11)
           MOVE    "千葉"              TO  SPA-GMN2D-PREFNAME-LST(12)
           MOVE    "東京"              TO  SPA-GMN2D-PREFNAME-LST(13)
           MOVE    "神奈川"            TO  SPA-GMN2D-PREFNAME-LST(14)
           MOVE    "新潟"              TO  SPA-GMN2D-PREFNAME-LST(15)
           MOVE    "富山"              TO  SPA-GMN2D-PREFNAME-LST(16)
           MOVE    "石川"              TO  SPA-GMN2D-PREFNAME-LST(17)
           MOVE    "福井"              TO  SPA-GMN2D-PREFNAME-LST(18)
           MOVE    "山梨"              TO  SPA-GMN2D-PREFNAME-LST(19)
           MOVE    "長野"              TO  SPA-GMN2D-PREFNAME-LST(20)
           MOVE    "岐阜"              TO  SPA-GMN2D-PREFNAME-LST(21)
           MOVE    "静岡"              TO  SPA-GMN2D-PREFNAME-LST(22)
           MOVE    "愛知"              TO  SPA-GMN2D-PREFNAME-LST(23)
           MOVE    "三重"              TO  SPA-GMN2D-PREFNAME-LST(24)
           MOVE    "滋賀"              TO  SPA-GMN2D-PREFNAME-LST(25)
           MOVE    "京都"              TO  SPA-GMN2D-PREFNAME-LST(26)
           MOVE    "大阪"              TO  SPA-GMN2D-PREFNAME-LST(27)
           MOVE    "兵庫"              TO  SPA-GMN2D-PREFNAME-LST(28)
           MOVE    "奈良"              TO  SPA-GMN2D-PREFNAME-LST(29)
           MOVE    "和歌山"            TO  SPA-GMN2D-PREFNAME-LST(30)
           MOVE    "鳥取"              TO  SPA-GMN2D-PREFNAME-LST(31)
           MOVE    "島根"              TO  SPA-GMN2D-PREFNAME-LST(32)
           MOVE    "岡山"              TO  SPA-GMN2D-PREFNAME-LST(33)
           MOVE    "広島"              TO  SPA-GMN2D-PREFNAME-LST(34)
           MOVE    "山口"              TO  SPA-GMN2D-PREFNAME-LST(35)
           MOVE    "徳島"              TO  SPA-GMN2D-PREFNAME-LST(36)
           MOVE    "香川"              TO  SPA-GMN2D-PREFNAME-LST(37)
           MOVE    "愛媛"              TO  SPA-GMN2D-PREFNAME-LST(38)
           MOVE    "高知"              TO  SPA-GMN2D-PREFNAME-LST(39)
           MOVE    "福岡"              TO  SPA-GMN2D-PREFNAME-LST(40)
           MOVE    "佐賀"              TO  SPA-GMN2D-PREFNAME-LST(41)
           MOVE    "長崎"              TO  SPA-GMN2D-PREFNAME-LST(42)
           MOVE    "熊本"              TO  SPA-GMN2D-PREFNAME-LST(43)
           MOVE    "大分"              TO  SPA-GMN2D-PREFNAME-LST(44)
           MOVE    "宮崎"              TO  SPA-GMN2D-PREFNAME-LST(45)
           MOVE    "鹿児島"            TO  SPA-GMN2D-PREFNAME-LST(46)
           MOVE    "沖縄"              TO  SPA-GMN2D-PREFNAME-LST(47)
           MOVE    47                  TO  SPA-GMN2D-PREFNAME-MAX
      *
      *    県区分
           MOVE    "1 都"              TO  SPA-GMN2D-PREFKBN-LST (01)
           MOVE    "2 道"              TO  SPA-GMN2D-PREFKBN-LST (02)
           MOVE    "3 府"              TO  SPA-GMN2D-PREFKBN-LST (03)
           MOVE    "4 県"              TO  SPA-GMN2D-PREFKBN-LST (04)
           MOVE    4                   TO  SPA-GMN2D-PREFKBN-MAX
      *
           MOVE    "1 郡"              TO  SPA-GMN2D-CITYKBN-LST (01)
           MOVE    "2 市"              TO  SPA-GMN2D-CITYKBN-LST (02)
           MOVE    "3 区"              TO  SPA-GMN2D-CITYKBN-LST (03)
           MOVE    3                   TO  SPA-GMN2D-CITYKBN-MAX
      *H26.10
      *    第三者 現物給付計算区分
           MOVE    "1 対象外"          TO  SPA-GMN2D-D3-GENBTKBNLST (01)
           MOVE    "2 対象"            TO  SPA-GMN2D-D3-GENBTKBNLST (02)
           MOVE    2                   TO  SPA-GMN2D-D3-GENBTKBN-MAX
      *    第三者 特記事項区分
           MOVE    "1 「１０第三」記載有"
                                       TO  SPA-GMN2D-D3-TOKKIKBNLST (01)
           MOVE    "2 「１０第三」記載無"
                                       TO  SPA-GMN2D-D3-TOKKIKBNLST(02)
           MOVE    2                   TO  SPA-GMN2D-D3-TOKKIKBN-MAX
      *
      *    損傷区分
           MOVE    SPA-SYSYMD          TO  WRK-SYSYMD
           PERFORM 30021-SONSHOUKBN-SET-SEC
      *
      *H29.5
           MOVE    "0 労災自賠医療機関情報に準拠"
                                       TO  SPA-GMN2D-JIBAIKBN-LST(01)
           MOVE    "1 労災準拠"        TO  SPA-GMN2D-JIBAIKBN-LST(02)
           MOVE    "2 健保準拠"        TO  SPA-GMN2D-JIBAIKBN-LST(03)
           MOVE    3                   TO  SPA-GMN2D-JIBAIKBN-MAX
      *
           .
       3002-COMBBOX-HEX-EXT.
           EXIT.
      *
      *H27.11
      *****************************************************************
      *    損傷区分編集処理
      *****************************************************************
       30021-SONSHOUKBN-SET-SEC             SECTION.
      *
           MOVE    ZERO                TO  SPA-GMN2D-SONSHOUKBN-MAX
      *
           MOVE    SPACE               TO  SYS-4002-REC
           INITIALIZE                  SYS-4002-REC
           MOVE    "4002"              TO  SYS-4002-KANRICD
           MOVE    WRK-SYSYMD          TO  SYS-4002-STYUKYMD
           MOVE    WRK-SYSYMD          TO  SYS-4002-EDYUKYMD
      *    システム管理検索
           MOVE    SPA-HOSPNUM         TO  SYS-4002-HOSPNUM
           MOVE    SYS-4002-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-4002-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    ZERO                TO  IDX
           PERFORM
                   UNTIL      (FLG-SYSKANRI    =   1 )  OR
                              (IDX             >=  50)
               MOVE    MCPDATA-REC         TO  SYS-4002-REC
               ADD     1                   TO  IDX
               MOVE    IDX                 TO  SPA-GMN2D-SONSHOUKBN-MAX
               MOVE    SYS-4002-KBNCD(1:2) TO
                                       SPA-GMN2D-SONSHOUKBN-LST (IDX)
               IF      SYS-4002-KBNCD(3:1) NOT =   SPACE
                   MOVE    "-"                 TO
                                       SPA-GMN2D-SONSHOUKBN-LST (IDX)
                                                               (3:1)
                   MOVE    SYS-4002-KBNCD(3:1) TO
                                       SPA-GMN2D-SONSHOUKBN-LST (IDX)
                                                               (4:1)
               END-IF
               MOVE    SYS-4002-SONSHOUNAME    TO
                                       SPA-GMN2D-SONSHOUKBN-LST (IDX)
                                                               (5:)
      *
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-KANRIMST-READ-SEC
           END-PERFORM
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           .
       30021-SONSHOUKBNHEX-EXT.
           EXIT.
      *
      *!!!
      *****************************************************************
      *    コンボボクスの設定編集処理
      *****************************************************************
       3003-COMBBOX-SET-SEC             SECTION.
      *
      *    労災保険区分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-HKNKBN-MAX
               IF      SPA-GMN2D-HKNKBN-LST(IDX) (1:1)
                                           =   SPA-GMN2D-HKNKBN
                   MOVE    SPA-GMN2D-HKNKBN-LST (IDX)
                                           TO  SPA-GMN2D-HKNKBN-G
               END-IF
           END-PERFORM
      *
      *    自賠責患者請求区分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-JIBAISEIKBN-MAX
               IF      SPA-GMN2D-JIBAISEIKBN-LST(IDX) (1:1)
                                           =   SPA-GMN2D-JIBAISEIKBN
                   MOVE    SPA-GMN2D-JIBAISEIKBN-LST (IDX)
                                           TO  SPA-GMN2D-JIBAISEIKBN-G
               END-IF
           END-PERFORM
      *
      *    災害区分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SAIGAI-MAX
               IF      SPA-GMN2D-SAIGAI-LST(IDX) (1:1)
                                           =   SPA-GMN2D-SAIGAI
                   MOVE    SPA-GMN2D-SAIGAI-LST (IDX)
                                           TO  SPA-GMN2D-SAIGAI-G
               END-IF
           END-PERFORM
      *
      *    新継区分
      *****PERFORM 41012-SINKEI-SET-SEC
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SINKEI-MAX
               IF      SPA-GMN2D-SINKEI-LST(IDX) (1:1)
                                           =   SPA-GMN2D-SINKEI
                   MOVE    SPA-GMN2D-SINKEI-LST (IDX)
                                           TO  SPA-GMN2D-SINKEI-G
               END-IF
           END-PERFORM
      *
      *    転帰区分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-TENKI-MAX
               IF      SPA-GMN2D-TENKI-LST(IDX) (1:1)
                                           =   SPA-GMN2D-TENKI
                   MOVE    SPA-GMN2D-TENKI-LST (IDX)
                                           TO  SPA-GMN2D-TENKI-G
               END-IF
           END-PERFORM
      *
      *    四肢特例
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SISIKBN-MAX
               IF      SPA-GMN2D-SISIKBN-LST(IDX) (1:1)
                                           =   SPA-GMN2D-SISIKBN
                   MOVE    SPA-GMN2D-SISIKBN-LST (IDX)
                                           TO  SPA-GMN2D-SISIKBN-G
               END-IF
           END-PERFORM
      *    県区分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-PREFKBN-MAX
               IF      SPA-GMN2D-PREFKBN-LST(IDX) (1:1)
                                           =   SPA-GMN2D-PREFKBN
                   MOVE    SPA-GMN2D-PREFKBN-LST (IDX)
                                           TO  SPA-GMN2D-PREFKBN-G
               END-IF
           END-PERFORM
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-CITYKBN-MAX
               IF      SPA-GMN2D-CITYKBN-LST(IDX) (1:1)
                                           =   SPA-GMN2D-CITYKBN
                   MOVE    SPA-GMN2D-CITYKBN-LST (IDX)
                                           TO  SPA-GMN2D-CITYKBN-G
               END-IF
           END-PERFORM
      *    損傷区分
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SONSHOUKBN-MAX
               IF     (SPA-GMN2D-SONSHOUKBN-LST(IDX) (1:2)
                                           =   SPA-GMN2D-SONSHOUKBN) AND
                      (SPA-GMN2D-SONSHOUKBN-LST(IDX) (4:1)
                                           =   SPA-GMN2D-SONSHOUKBNEDA)
                   MOVE    SPA-GMN2D-SONSHOUKBN-LST (IDX)
                                           TO  SPA-GMN2D-SONSHOUKBN-G
               END-IF
           END-PERFORM
      *
      *    ドクター
           IF      SPA-GMN2D-DRCD  NOT =   SPACE
               PERFORM 30021-DRCD-HEN-SEC
           END-IF
      *H26.10
      *    第三者　現物給付計算区分
           IF      SPA-GMN2D-D3-GENBTKBN   =   SPACE
               MOVE    SPACE               TO  SPA-GMN2D-D3-GENBTKBN-G
           ELSE
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL       IDX     >   SPA-GMN2D-D3-GENBTKBN-MAX
                   IF     (SPA-GMN2D-D3-GENBTKBN-CD(IDX)
                                           =   SPA-GMN2D-D3-GENBTKBN)
                       MOVE    SPA-GMN2D-D3-GENBTKBNLST (IDX)
                                           TO  SPA-GMN2D-D3-GENBTKBN-G
                   END-IF
               END-PERFORM
           END-IF
      *    第三者　特記事項区分
           IF      SPA-GMN2D-D3-TOKKIKBN   =   SPACE
               MOVE    SPACE               TO  SPA-GMN2D-D3-TOKKIKBN-G
           ELSE
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL       IDX     >   SPA-GMN2D-D3-TOKKIKBN-MAX
                   IF     (SPA-GMN2D-D3-TOKKIKBN-CD(IDX)
                                           =   SPA-GMN2D-D3-TOKKIKBN)
                       MOVE    SPA-GMN2D-D3-TOKKIKBNLST (IDX)
                                           TO  SPA-GMN2D-D3-TOKKIKBN-G
                   END-IF
               END-PERFORM
           END-IF
      *
      *    自賠責点数区分
           IF      SPA-GMN2D-JIBAIKBN  =   SPACE
               MOVE    SPACE           TO  SPA-GMN2D-JIBAIKBN-G
           ELSE
               PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   SPA-GMN2D-JIBAIKBN-MAX)
                          OR  (FLG-OK  =   1    )
                   IF      SPA-GMN2D-JIBAIKBN
                                       =   SPA-GMN2D-JIBAIKBN-LST
                                                          (IDX)(1:1)
                       MOVE    SPA-GMN2D-JIBAIKBN-LST (IDX)
                                           TO  SPA-GMN2D-JIBAIKBN-G
                       MOVE    1           TO  FLG-OK
                   END-IF
               END-PERFORM
           END-IF
           .
       3003-COMBBOX-SET-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    自賠責・公務災害の初期表示編集処理
      *****************************************************************
       30022-JIBAISEIKBN-SET-SEC            SECTION.
      *
           MOVE    SPACE               TO  SYS-4001-REC
           INITIALIZE                  SYS-4001-REC
           MOVE    "4001"              TO  SYS-4001-KANRICD
           MOVE    "*"                 TO  SYS-4001-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-4001-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-4001-EDYUKYMD
           MOVE    SPA-HOSPNUM         TO  SYS-4001-HOSPNUM
      *    システム管理検索
           MOVE    SYS-4001-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key10"             TO  MCP-PATHNAME
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-4001-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           MOVE    SPACE               TO  SPA-JIBAI-SEI
           MOVE    SPACE               TO  SPA-KOMU-SEI
           MOVE    SPACE               TO  SPA-DAISAN-GEN
           IF      (FLG-SYSKANRI       =   0  )
               MOVE    MCPDATA-REC         TO  SYS-4001-REC
      *        自賠責請求区分
               MOVE    SYS-4001-JIBAI-SEIKYUKBN    TO  SPA-JIBAI-SEI
      *        公務災害責請求区分
               MOVE    SYS-4001-KOMU-SEIKYUKBN     TO  SPA-KOMU-SEI
      *H28.1   第三者行為現物給付区分
               MOVE    SYS-4001-DAISAN-GENBTKBN    TO  SPA-DAISAN-GEN
           END-IF
           .
       30022-JIBAISEIKBN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    ドクター名称編集処理
      *****************************************************************
       30021-DRCD-HEN-SEC            SECTION.
      *
      *    職員情報（ドクター）
           MOVE    SPACE               TO  SYS-1010-REC
           INITIALIZE                  SYS-1010-REC
           MOVE    "1010"              TO  SYS-1010-KANRICD
           MOVE    "1"                 TO  SYS-1010-KBNCD(1:1)
           MOVE    SPA-GMN2D-DRCD      TO  SYS-1010-KBNCD(2:4)
           MOVE    SPA-SYSYMD          TO  SYS-1010-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-1010-EDYUKYMD
      *
      *    システム管理検索
           MOVE    SPA-HOSPNUM         TO  SYS-1010-HOSPNUM
           MOVE    SYS-1010-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key10"             TO  MCP-PATHNAME
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-1010-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1010-REC
               MOVE    SYS-1010-NAME       TO  SPA-GMN2D-DRCDMEI
      *
               ADD     1                   TO  SPA-GMN2D-DRCD-MAX
               IF      SPA-GMN2D-DRCD-MAX  >   20
                   MOVE    20                  TO  SPA-GMN2D-DRCD-MAX
               END-IF
               MOVE    SPA-GMN2D-DRCD-G    TO  SPA-GMN2D-DRCDLST
                                                   (SPA-GMN2D-DRCD-MAX)
           END-IF
           .
       30021-DRCD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE               TO  P02D
           INITIALIZE                      P02D
      *
      *    保険区分
           MOVE    SPA-GMN2D-HKNKBN-G  TO  P02D-HKNKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-HKNKBN-MAX
               MOVE    SPA-GMN2D-HKNKBN-LST (IDX)
                                       TO  P02D-HKNKBN-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-HKNKBN-MAX    TO  P02D-HKNKBN-COUNT
      *
      *
      *    自賠責患者請求区分
           MOVE    SPA-GMN2D-JIBAISEIKBN-G     TO  P02D-JIBAISEIKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-JIBAISEIKBN-MAX
               MOVE    SPA-GMN2D-JIBAISEIKBN-LST (IDX)
                                       TO  P02D-JIBAISEIKBN-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-JIBAISEIKBN-MAX 
                                           TO  P02D-JIBAISEIKBN-COUNT
      *
           MOVE    SPA-GMN2D-HIHKNJANAME   TO  P02D-HIHKNJANAME
           MOVE    SPA-GMN2D-KOHNUM1       TO  P02D-KOHNUM1
           MOVE    SPA-GMN2D-KOHNUM2       TO  P02D-KOHNUM2
      *    コメント
           MOVE    SPA-GMN2D-COMMENT       TO  P02D-COMMENT
      *    災害区分
           MOVE    SPA-GMN2D-SAIGAI-G  TO  P02D-SAIGAI
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SAIGAI-MAX
               MOVE    SPA-GMN2D-SAIGAI-LST (IDX)
                                       TO  P02D-SAIGAI-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-SAIGAI-MAX    TO  P02D-SAIGAI-COUNT
      *
           MOVE    SPA-GMN2D-SINKEI-G  TO  P02D-SINKEI
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SINKEI-MAX
               MOVE    SPA-GMN2D-SINKEI-LST (IDX)
                                       TO  P02D-SINKEI-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-SINKEI-MAX    TO  P02D-SINKEI-COUNT
      *
           MOVE    SPA-GMN2D-TENKI-G   TO  P02D-TENKI
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-TENKI-MAX
               MOVE    SPA-GMN2D-TENKI-LST (IDX)
                                       TO  P02D-TENKI-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-TENKI-MAX     TO  P02D-TENKI-COUNT
      *
           MOVE    SPA-GMN2D-SISIKBN-G     TO  P02D-SISIKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SISIKBN-MAX
               MOVE    SPA-GMN2D-SISIKBN-LST (IDX)
                                       TO  P02D-SISIKBN-ITEM(IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-SISIKBN-MAX   TO  P02D-SISIKBN-COUNT
      *
           MOVE    SPA-GMN2D-SHOBYOYMD     TO  P02D-SHOBYOYMD
           MOVE    SPA-GMN2D-RYOSTYMD      TO  P02D-RYOSTYMD
           MOVE    SPA-GMN2D-RYOEDYMD      TO  P02D-RYOEDYMD
           MOVE    SPA-GMN2D-JIGYOUNAME    TO  P02D-JIGYOUNAME
      *
      *    都道府県
           MOVE    SPA-GMN2D-PREFNAME-G     TO  P02D-PREFNAME
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-PREFNAME-MAX
               MOVE    SPA-GMN2D-PREFNAME-LST (IDX)
                                       TO  P02D-PREFNAME-ITEM(IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-PREFNAME-MAX  TO  P02D-PREFNAME-COUNT
      *
           MOVE    SPA-GMN2D-PREFKBN-G     TO  P02D-PREFKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-PREFKBN-MAX
               MOVE    SPA-GMN2D-PREFKBN-LST (IDX)
                                       TO  P02D-PREFKBN-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-PREFKBN-MAX   TO  P02D-PREFKBN-COUNT
      *
           MOVE    SPA-GMN2D-CITYNAME      TO  P02D-CITYNAME
      *
      *    市区
           MOVE    SPA-GMN2D-CITYKBN-G     TO  P02D-CITYKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-CITYKBN-MAX
               MOVE    SPA-GMN2D-CITYKBN-LST (IDX)
                                       TO  P02D-CITYKBN-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-CITYKBN-MAX   TO  P02D-CITYKBN-COUNT
      *
           MOVE    SPA-GMN2D-KOHNUM3       TO  P02D-KOHNUM3
      *    損傷
           MOVE    SPA-GMN2D-SONSHOUKBN-G  TO  P02D-SONSHOUKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SONSHOUKBN-MAX
               MOVE    SPA-GMN2D-SONSHOUKBN-LST (IDX)
                                       TO  P02D-SONSHOUKBN-ITEM(IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-SONSHOUKBN-MAX   TO  P02D-SONSHOUKBN-COUNT
      *
           MOVE    SPA-GMN2D-SINSATUYMD    TO  P02D-SINSATUYMD
      *
           MOVE    SPA-GMN2D-SINSATUEND    TO  P02D-SINSATUEND
      *H29.5
      *    自賠責点数区分
           MOVE    SPA-GMN2D-JIBAIKBN-G   TO  P02D-JIBAIKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-JIBAIKBN-MAX
               MOVE    SPA-GMN2D-JIBAIKBN-LST (IDX)
                                       TO  P02D-JIBAIKBN-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-JIBAIKBN-MAX  TO  P02D-JIBAIKBN-COUNT
      *
      *    自賠責担当医
           MOVE    SPA-GMN2D-SRYKA-G   TO  P02D-SRYKA
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-SRYKA-MAX
               MOVE    SPA-GMN-SRYKA-LST (IDX)
                                       TO  P02D-SRYKA-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-SRYKA-MAX       TO  P02D-SRYKA-COUNT
      *
           MOVE    SPA-GMN2D-DRCD-G    TO  P02D-DRCD
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-DRCD-MAX
               MOVE    SPA-GMN2D-DRCDLST (IDX)
                                       TO  P02D-DRCD-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-DRCD-MAX  TO  P02D-DRCD-COUNT
      *
           MOVE    SPA-GMN2D-HOKENNAME TO  P02D-HOKENNAME
      *    労災レセ回数記載
           MOVE    SPA-GMN2D-KIJYUNYM  TO  P02D-KIJYUNYM
           MOVE    SPA-GMN2D-KAISU     TO  P02D-KAISU
      *    労働基準監督署コード
           MOVE    SPA-GMN2D-SYOCD     TO  P02D-SYOCD
           MOVE    SPA-GMN2D-SYOCDNAME TO  P02D-SYOCDNAME
      *
           MOVE    SPA-GMN2D-SEIKBNMEI    TO  P02D-SEIKBNMEI
           MOVE    SPA-GMN2D-TANTOIMEI    TO  P02D-TANTOIMEI
      *
      *H26.10
           MOVE    SPA-GMN2D-D3-GENBTKBN-G TO  P02D-DAI3-GENBTKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-D3-GENBTKBN-MAX
               MOVE    SPA-GMN2D-D3-GENBTKBNLST (IDX)
                                       TO  P02D-DAI3-GENBTKBN-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-D3-GENBTKBN-MAX
                                       TO  P02D-DAI3-GENBTKBN-COUNT
      *
           MOVE    SPA-GMN2D-D3-TOKKIKBN-G TO  P02D-DAI3-TOKKIKBN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-D3-TOKKIKBN-MAX
               MOVE    SPA-GMN2D-D3-TOKKIKBNLST (IDX)
                                       TO  P02D-DAI3-TOKKIKBN-ITEM (IDX)
           END-PERFORM
           MOVE    SPA-GMN2D-D3-TOKKIKBN-MAX
                                       TO  P02D-DAI3-TOKKIKBN-COUNT
      *
      *H25.7
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-RSIMAX
               MOVE    SPA-GMN2D-TRENNUM (IDX)
                                       TO  WRK-ZZZ
               MOVE    WRK-ZZZ         TO  P02D-RSINUM (IDX)
               MOVE    SPA-GMN2D-THKNKBNMEI (IDX)
                                       TO  P02D-RSINAME(IDX)
               MOVE    SPA-GMN2D-TRSIKIKAN (IDX)
                                       TO  P02D-RSIKIKAN(IDX)
               IF      IDX             =   SPA-GMN2D-SELNUM
                   MOVE    "T"         TO  P02D-RSILIST-SELECT
                                                         (IDX)
               ELSE
                   MOVE    "F"         TO  P02D-RSILIST-SELECT
                                                         (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN2D-RSIMAX    TO  P02D-RSILIST-COUNT
           MOVE    SPA-GMN2D-SELNUM    TO  P02D-SELNUM
      *!!!
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
      *    カーソル指定のない時、入力した項目の次ぎへ
           IF      SPA-GMN2D-CUR       =   ZERO
               PERFORM 50011-INPUT-CUR-SEC
           END-IF
      *
           EVALUATE    SPA-GMN2D-CUR
               WHEN    01
                   MOVE    "HKNKBN"           TO  MCP-WIDGET
               WHEN    02
                   MOVE    "COMMENT"          TO  MCP-WIDGET
               WHEN    03
                   MOVE    "KOHNUM1"          TO  MCP-WIDGET
               WHEN    04
                   MOVE    "KOHNUM2"          TO  MCP-WIDGET
               WHEN    21
                   MOVE    "SAIGAI"           TO  MCP-WIDGET
               WHEN    05
                   MOVE    "SINKEI"           TO  MCP-WIDGET
               WHEN    06
                   MOVE    "TENKI"            TO  MCP-WIDGET
               WHEN    07
                   MOVE    "SISIKBN"          TO  MCP-WIDGET
               WHEN    08
                   MOVE    "SHOBYOYMD"        TO  MCP-WIDGET
               WHEN    09
                   MOVE    "RYOSTYMD"         TO  MCP-WIDGET
               WHEN    10
                   MOVE    "RYOEDYMD"         TO  MCP-WIDGET
               WHEN    11
                   MOVE    "JIGYOUNAME"        TO  MCP-WIDGET
               WHEN    12
                   MOVE    "PREFNAME"          TO  MCP-WIDGET
               WHEN    13
                   MOVE    "PREFKBN"           TO  MCP-WIDGET
               WHEN    14
                   MOVE    "CITYNAME"          TO  MCP-WIDGET
               WHEN    15
                   MOVE    "CITYKBN"           TO  MCP-WIDGET
      *H29.5
               WHEN    33
                   MOVE    "JIBAIKBN"          TO  MCP-WIDGET
      *
               WHEN    25
                   MOVE    "SRYKA"             TO  MCP-WIDGET
               WHEN    26
                   MOVE    "DRCD"              TO  MCP-WIDGET
               WHEN    27
                   MOVE    "HOKENNAME"         TO  MCP-WIDGET
               WHEN    28
                   MOVE    "KIJYUNYM"          TO  MCP-WIDGET
               WHEN    29
                   MOVE    "KAISU"             TO  MCP-WIDGET
               WHEN    30
                   MOVE    "SYOCD"             TO  MCP-WIDGET
      *
               WHEN    16
                   MOVE    "KOHNUM3"           TO  MCP-WIDGET
               WHEN    17
                   MOVE    "SONSHOUKBN"        TO  MCP-WIDGET
               WHEN    18
                   MOVE    "SINSATUYMD"        TO  MCP-WIDGET
               WHEN    19
                   MOVE    "SINSATUEND"        TO  MCP-WIDGET
               WHEN    22
                   MOVE    "JIBAISEIKBN"       TO  MCP-WIDGET
      *
               WHEN    35
                   MOVE    "DAI3_GENBTKBN"     TO  MCP-WIDGET
               WHEN    36
                   MOVE    "DAI3_TOKKIKBN"     TO  MCP-WIDGET
      *
               WHEN    31
                   MOVE    "SELNUM"            TO  MCP-WIDGET
               WHEN    90
                   MOVE    "B12"               TO  MCP-WIDGET
               WHEN    91
                   MOVE    "B01"               TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力個所のセット処理
      *****************************************************************
       50011-INPUT-CUR-SEC          SECTION.
      *
      *
           EVALUATE    WRK-MCP-WIDGET
               WHEN    "HKNKBN"
                   MOVE    2               TO  SPA-GMN2D-CUR
                   EVALUATE    SPA-GMN2D-HKNKBN
                       WHEN    "4"
                       WHEN    "5"
                       WHEN    "6"
                           MOVE    22              TO  SPA-GMN2D-CUR
                   END-EVALUATE
      *        自賠責請求区分
               WHEN    "JIBAISEIKBN"
                   MOVE    2               TO  SPA-GMN2D-CUR
               WHEN    "COMMENT"
      *            コメント
                   EVALUATE    SPA-GMN2D-HKNKBN
                       WHEN    "1"
                           MOVE    3               TO  SPA-GMN2D-CUR
                       WHEN    "2"
                           MOVE    4               TO  SPA-GMN2D-CUR
                       WHEN    "3"
                           MOVE    16              TO  SPA-GMN2D-CUR
                       WHEN    "4"
                       WHEN    "5"
                           MOVE    6               TO  SPA-GMN2D-CUR
      *                第三者行為
                       WHEN    "6"
                           MOVE    6               TO  SPA-GMN2D-CUR
                   END-EVALUATE
               WHEN    "KOHNUM1"
                   MOVE    21              TO  SPA-GMN2D-CUR
               WHEN    "KOHNUM2"
                   MOVE    21              TO  SPA-GMN2D-CUR
               WHEN    "SAIGAI"
                   MOVE    05              TO  SPA-GMN2D-CUR
               WHEN    "SINKEI"
                   MOVE    06              TO  SPA-GMN2D-CUR
               WHEN    "TENKI"
                   MOVE    07              TO  SPA-GMN2D-CUR
                   EVALUATE    SPA-GMN2D-HKNKBN
      *                第三者行為
                       WHEN    "6"
                           MOVE    08              TO  SPA-GMN2D-CUR
                   END-EVALUATE
               WHEN    "SISIKBN"
                   MOVE    08              TO  SPA-GMN2D-CUR
               WHEN    "SHOBYOYMD"
                   MOVE    09              TO  SPA-GMN2D-CUR
               WHEN    "RYOSTYMD"
                   MOVE    10              TO  SPA-GMN2D-CUR
               WHEN    "RYOEDYMD"
                   EVALUATE    SPA-GMN2D-HKNKBN
                       WHEN    "4"
      *H29.5               自賠責　自賠責点数区分へ
                           MOVE    33              TO  SPA-GMN2D-CUR
                       WHEN    "5"
      *                    公務災害　担当医へ
                           MOVE    25              TO  SPA-GMN2D-CUR
                       WHEN    "1"
      *                    事業所へ
                           MOVE    11              TO  SPA-GMN2D-CUR
                       WHEN    "2"
      *                    労災レセ回数記載へ
                           MOVE    28              TO  SPA-GMN2D-CUR
      *                第三者行為
                       WHEN    "6"
      *                    自賠責担当医へ
                           MOVE    25              TO  SPA-GMN2D-CUR
                   END-EVALUATE
               WHEN    "JIGYOUNAME"
                   MOVE    12              TO  SPA-GMN2D-CUR
               WHEN    "PREFNAME"
                   MOVE    13              TO  SPA-GMN2D-CUR
               WHEN    "PREFKBN"
                   MOVE    14              TO  SPA-GMN2D-CUR
               WHEN    "CITYNAME"
                   MOVE    15              TO  SPA-GMN2D-CUR
               WHEN    "CITYKBN"
                   EVALUATE    SPA-GMN2D-HKNKBN
                       WHEN    "4"
                       WHEN    "5"
                           MOVE    25              TO  SPA-GMN2D-CUR
                       WHEN    "1"
                       WHEN    "2"
      *********************MOVE    90              TO  SPA-GMN2D-CUR
                           MOVE    28              TO  SPA-GMN2D-CUR
                   END-EVALUATE
               WHEN    "SRYKA"
                   MOVE    26              TO  SPA-GMN2D-CUR
      *H29.5
               WHEN    "JIBAIKBN"
                   MOVE    25              TO  SPA-GMN2D-CUR
               WHEN    "DRCD"
                   EVALUATE    SPA-GMN2D-HKNKBN
                       WHEN    "5"
                           MOVE    90              TO  SPA-GMN2D-CUR
                       WHEN    OTHER
                           MOVE    27              TO  SPA-GMN2D-CUR
                   END-EVALUATE
               WHEN    "HOKENNAME"
                   MOVE    90              TO  SPA-GMN2D-CUR
                   EVALUATE    SPA-GMN2D-HKNKBN
      *                第三者　現物支給対象へ
                       WHEN    "6"
                           MOVE    35              TO  SPA-GMN2D-CUR
                   END-EVALUATE
      *
               WHEN    "KIJYUNYM"
                   MOVE    29              TO  SPA-GMN2D-CUR
               WHEN    "KAISU"
                   MOVE    30              TO  SPA-GMN2D-CUR
               WHEN    "SYOCD"
                   MOVE    90              TO  SPA-GMN2D-CUR
      *
               WHEN    "KOHNUM3"
                   MOVE    17              TO  SPA-GMN2D-CUR
               WHEN    "SONSHOUKBN"
                   MOVE    18              TO  SPA-GMN2D-CUR
               WHEN    "SINSATUYMD"
                   MOVE    19              TO  SPA-GMN2D-CUR
               WHEN    "SINSATUEND"
                   MOVE    90              TO  SPA-GMN2D-CUR
      *
               WHEN    "DAI3_GENBTKBN"
                   MOVE    36              TO  SPA-GMN2D-CUR
               WHEN    "DAI3_TOKKIKBN"
                   MOVE    90              TO  SPA-GMN2D-CUR
      *        選択
               WHEN    "SELNUM"
                   MOVE    2               TO  SPA-GMN2D-CUR
                   EVALUATE    SPA-GMN2D-HKNKBN
                       WHEN    "4"
                       WHEN    "5"
                           MOVE    22              TO  SPA-GMN2D-CUR
                   END-EVALUATE
           END-EVALUATE
      *
           .
       50011-INPUT-CUR-EXT.
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
                   PERFORM 420-MODORU-SEC
                   PERFORM 210-BACK
      *    削除
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 430-SAKUJYO-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 490-TOROKU-SEC
      *
      *H25.7
      *    クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 420-CLERA-SEC
      *    次
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 460-NEXT-TBL-SEC
      *
      *H27.11
      *   API 処理
               WHEN    "CLICKED"       ALSO    "APIV3"
                   PERFORM 4199-API-SYORI-SEC
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
      *    入力個所のセット
           MOVE    MCP-WIDGET          TO  WRK-MCP-WIDGET
           MOVE    ZERO                TO  SPA-GMN2D-CUR
      *
           MOVE    ZERO                TO  FLG-TOUROKU
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        労災リスト選択
               WHEN    ANY             ALSO    "RSILIST"
                   PERFORM 4001-RSILIST-SEL-SEC
      *        労災選択
               WHEN    ANY             ALSO    "SELNUM"
                   PERFORM 4002-SELNUM-CHK-SEC
               WHEN    OTHER
      *    入力チェック処理
                   PERFORM 410-INPUT-CHK-SEC
           END-EVALUATE
      *
           .
      *
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力チェック処理
      *****************************************************************
       410-INPUT-CHK-SEC          SECTION.
      *
      *    画面をＳＰＡセット
           PERFORM 4101-GMN-SPA-SET-SEC
      *    基本チェックと別画面処理
           PERFORM 4102-KIHON-CHK-SEC
      *
      *    登録時、必須入力チェック
           IF      FLG-TOUROKU         =   1
               IF      SPA-ERRCD           =   SPACE
                   PERFORM 4109-TOUROKU-CHK-SEC
               END-IF
           END-IF
      *
           .
      *
       410-INPUT-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面ＳＰＡ編集処理
      *****************************************************************
       4101-GMN-SPA-SET-SEC          SECTION.
      *
      *    保険区分
           MOVE    P02D-HKNKBN         TO  SPA-GMN2D-HKNKBN-G
      *    自賠責患者請求区分
           MOVE    P02D-JIBAISEIKBN    TO  SPA-GMN2D-JIBAISEIKBN-G
      *
      *****MOVE    P02D-HIHKNJANAME    TO  SPA-GMN2D-HIHKNJANAME
           MOVE    P02D-KOHNUM1        TO  SPA-GMN2D-KOHNUM1
           MOVE    P02D-KOHNUM2        TO  SPA-GMN2D-KOHNUM2
      *    コメント
           MOVE    P02D-COMMENT        TO  SPA-GMN2D-COMMENT
      *    災害区分
           MOVE    P02D-SAIGAI         TO  SPA-GMN2D-SAIGAI-G
           MOVE    P02D-SINKEI         TO  SPA-GMN2D-SINKEI-G
           MOVE    P02D-TENKI          TO  SPA-GMN2D-TENKI-G
           MOVE    P02D-SISIKBN        TO  SPA-GMN2D-SISIKBN-G
           MOVE    P02D-SHOBYOYMD      TO  SPA-GMN2D-SHOBYOYMD
           MOVE    P02D-RYOSTYMD       TO  SPA-GMN2D-RYOSTYMD
           MOVE    P02D-RYOEDYMD       TO  SPA-GMN2D-RYOEDYMD
           MOVE    P02D-JIGYOUNAME     TO  SPA-GMN2D-JIGYOUNAME
      *    都道府県
           MOVE    P02D-PREFNAME      TO  SPA-GMN2D-PREFNAME-G
           MOVE    P02D-PREFKBN       TO  SPA-GMN2D-PREFKBN-G
           MOVE    P02D-CITYNAME      TO  SPA-GMN2D-CITYNAME
           MOVE    P02D-CITYKBN       TO  SPA-GMN2D-CITYKBN-G
           MOVE    P02D-KOHNUM3       TO  SPA-GMN2D-KOHNUM3
           MOVE    P02D-SONSHOUKBN    TO  SPA-GMN2D-SONSHOUKBN-G
           MOVE    P02D-SINSATUYMD    TO  SPA-GMN2D-SINSATUYMD
           MOVE    P02D-SINSATUEND    TO  SPA-GMN2D-SINSATUEND
      *    自賠責点数区分
           MOVE    P02D-JIBAIKBN      TO  SPA-GMN2D-JIBAIKBN-G
      *    自賠責担当医他
           MOVE    P02D-SRYKA         TO  SPA-GMN2D-SRYKA-G
           MOVE    P02D-DRCD          TO  SPA-GMN2D-DRCD-G
           MOVE    P02D-HOKENNAME     TO  SPA-GMN2D-HOKENNAME
      *    労災レセ回数記載
           MOVE    P02D-KIJYUNYM      TO  SPA-GMN2D-KIJYUNYM
           MOVE    P02D-KAISU         TO  SPA-GMN2D-KAISU
      *    労働基準監督署コード
           IF      P02D-SYOCD      NOT =   SPA-GMN2D-SYOCD
               MOVE    ZERO                TO  SPA-NAI2D-KEIFLG2
               MOVE    SPACE               TO  SPA-NAI2D-SYOCDCHK
           END-IF
           MOVE    P02D-SYOCD         TO  SPA-GMN2D-SYOCD
      *
      *    第三者　現物支給対象区分
           MOVE    P02D-DAI3-GENBTKBN  TO  SPA-GMN2D-D3-GENBTKBN-G
           MOVE    P02D-DAI3-TOKKIKBN  TO  SPA-GMN2D-D3-TOKKIKBN-G
           .
      *
       4101-GMN-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本チェックと別画面処理
      *****************************************************************
       4102-KIHON-CHK-SEC          SECTION.
      *
           PERFORM 4101-HKNKBN-CHK-SEC
      *    自賠責患者請求区分
           IF      SPA-ERRCD           =   SPACE
               PERFORM 41011-JIBAISEIKBN-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-COMMENT-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-KOFUNUM-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-KOHNUM2-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-SAIGAI-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-SINKEI-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-TENKI-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-SISIKBN-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-SHOBYOYMD-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-RYOSTYMD-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-RYOEDYMD-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-JIGYOUNAME-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-PREFNAME-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-PREFKBN-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-CITYNAME-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-CITYKBN-CHK-SEC
           END-IF
      *H29.5
      *    自賠責点数区分
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-JIBAIKBN-CHK-SEC
           END-IF
      *    自賠責診療科
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-SRYKA-CHK-SEC
           END-IF
      *    自賠責担当医
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-DRCD-CHK-SEC
           END-IF
      *    自賠責保険会社名
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-HOKENNAME-CHK-SEC
           END-IF
      *    労災レセ回数記載
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-KIJYUNYM-CHK-SEC
           END-IF
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-KAISU-CHK-SEC
           END-IF
      *    労働基準監督署コード
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-SYOCD-CHK-SEC
           END-IF
      *
      *    第三者　現物給付計算区分
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-DAI3-GENBTKBN-CHK-SEC
           END-IF
      *    第三者　特記事項区分
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-DAI3-TOKKIKBN-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-KOHNUM3-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-SONSHOUKBN-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-SINSATUYMD-CHK-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4101-SINSATUEND-CHK-SEC
           END-IF
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号チェック処理
      *****************************************************************
       4101-HKNKBN-CHK-SEC         SECTION.
      *
      *    修正の時、変更はできないこととする
           IF      SPA-NAI2D-HKNKBN-MAE    NOT =   SPACE
               IF      SPA-GMN2D-HKNKBN-G(1:1)
                                       NOT =   SPA-NAI2D-HKNKBN-MAE
                   MOVE    "0021"              TO  SPA-ERRCD
                   MOVE    1                   TO  SPA-GMN2D-CUR
                   GO      TO      4101-HKNKBN-CHK-EXT
               END-IF
           END-IF
      *
           IF      SPA-GMN2D-HKNKBN-G  =   SPACE
               MOVE    1                   TO  SPA-GMN2D-CUR
               MOVE    SPA-GMN2D-HKNKBN    TO  SPA-NAI2D-HKNKBN-HZN
               GO      TO      4101-HKNKBN-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-HKNKBN-MAX
               IF      SPA-GMN2D-HKNKBN    =
                                       SPA-GMN2D-HKNKBN-LST (IDX)(1:1)
                   MOVE    SPA-GMN2D-HKNKBN-LST (IDX)
                                               TO  SPA-GMN2D-HKNKBN-G
                   MOVE    1                   TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0001"              TO  SPA-ERRCD
               MOVE    1                   TO  SPA-GMN2D-CUR
           END-IF
      *
      *    新規の時、初期表示
           IF      SPA-ERRCD           =   SPACE
               IF     (SPA-NAI2D-RSHKN-EDANUM  =   ZERO )  AND
                      (SPA-GMN2D-HKNKBN    NOT =   SPA-NAI2D-HKNKBN-HZN)
                   PERFORM 41011-SYOKI-SET-SEC
                   MOVE    ZERO            TO  SPA-NAI2D-KEIFLG
               END-IF
               MOVE    SPA-GMN2D-HKNKBN    TO  SPA-NAI2D-HKNKBN-HZN
           END-IF
      *
          .
       4101-HKNKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    自賠責患者請求区分　処理
      *****************************************************************
       41011-JIBAISEIKBN-CHK-SEC           SECTION.
      *
      *    自賠責・公務災害以外は入力なしとする
           IF      SPA-GMN2D-HKNKBN    =   "4"
                                       OR  "5"
                                       OR  "6"
               CONTINUE
           ELSE
               MOVE    SPACE               TO  SPA-GMN2D-JIBAISEIKBN-G
               GO      TO      41011-JIBAISEIKBN-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-JIBAISEIKBN-MAX
               IF      SPA-GMN2D-JIBAISEIKBN    =
                                           SPA-GMN2D-JIBAISEIKBN-LST
                                                          (IDX)(1:1)
                   MOVE    SPA-GMN2D-JIBAISEIKBN-LST (IDX)
                                           TO  SPA-GMN2D-JIBAISEIKBN-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0035"              TO  SPA-ERRCD
               MOVE    22                  TO  SPA-GMN2D-CUR
           END-IF
      *
          .
       41011-JIBAISEIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    被保険名初期表示　処理
      *****************************************************************
       41011-SYOKI-SET-SEC           SECTION.
      *
      *    共通編集
           PERFORM 41012-SINKEI-SET-SEC
      *  クリア
      *    自賠責患者請求区分
           MOVE    SPACE           TO  SPA-GMN2D-JIBAISEIKBN-G
      *    災害区分
           MOVE    SPACE           TO  SPA-GMN2D-SAIGAI-G
      *    新継再別編集
           MOVE    SPACE           TO  SPA-GMN2D-SINKEI-G
           MOVE    ZERO            TO  SPA-GMN2D-KAISU
      *    転帰
           MOVE    SPACE           TO  SPA-GMN2D-TENKI-G
           MOVE    SPACE           TO  SPA-GMN2D-SISIKBN-G
      *    損傷区分
           MOVE    SPACE           TO  SPA-GMN2D-SONSHOUKBN-G
      *
           EVALUATE    SPA-GMN2D-HKNKBN
      *        短期・傷病
               WHEN    "1"
               WHEN    "2"
      *            新継再別編集
                   IF      SPA-GMN2D-SINKEIMEI =   SPACE
                       MOVE    SPA-GMN2D-SINKEI-LST (01)
                                               TO  SPA-GMN2D-SINKEI-G
                   END-IF
      *            転帰
                   IF      SPA-GMN2D-TENKI     =   SPACE
                       MOVE    SPA-GMN2D-TENKI-LST (02)
                                               TO  SPA-GMN2D-TENKI-G
                   END-IF
      *
                   IF      SPA-GMN2D-SISIKBN   =   SPACE
                       MOVE    SPA-GMN2D-SISIKBN-LST (01)
                                               TO  SPA-GMN2D-SISIKBN-G
                   END-IF
      *            所在地都道府県名
                   IF      SPA-GMN2D-HKNKBN    =   "1"
                     IF      SPA-GMN2D-PREFNAME  =   SPACE
                       IF      SPA-NAI-PREFNUM     NOT =   ZERO
                           MOVE    SPA-GMN2D-PREFNAME-LST
                                                (SPA-NAI-PREFNUM)
                                               TO  SPA-GMN2D-PREFNAME
                           EVALUATE    SPA-NAI-PREFNUM
                               WHEN    01
                                   MOVE    2       TO  IDX
                               WHEN    13
                                   MOVE    1       TO  IDX
                               WHEN    26
                               WHEN    27
                                   MOVE    3       TO  IDX
                               WHEN    OTHER
                                   MOVE    4       TO  IDX
                           END-EVALUATE
                           MOVE    SPA-GMN2D-PREFKBN-LST (IDX)
                                               TO  SPA-GMN2D-PREFKBN-G
                       END-IF
                     END-IF
                     IF      SPA-GMN2D-PREFKBN   =   SPACE
                        MOVE    SPA-GMN2D-PREFKBN-LST (01)
                                               TO  SPA-GMN2D-PREFKBN-G
                     END-IF
                   END-IF
      *************IF      SPA-GMN2D-CITYKBN   =   SPACE
      *                 MOVE    SPA-GMN2D-CITYKBN-LST (01)
      *                                        TO  SPA-GMN2D-CITYKBN-G
      *************END-IF
      *            労災レセ回数記載：回数
                   MOVE    1               TO  SPA-GMN2D-KAISU
      *        アフターケア
               WHEN    "3"
      *
                   IF      SPA-GMN2D-SONSHOUKBN   =   SPACE
                       MOVE    SPA-GMN2D-SONSHOUKBN-LST (01)
                                           TO  SPA-GMN2D-SONSHOUKBN-G
                   END-IF
      *        自賠責
               WHEN    "4"
      *            自賠責患者請求区分
      *            システム管理設定により、初期表示変更
                   IF      SPA-JIBAI-SEI       =   "2"
                       MOVE    SPA-GMN2D-JIBAISEIKBN-LST (2)
                                           TO  SPA-GMN2D-JIBAISEIKBN-G
                   ELSE
                       MOVE    SPA-GMN2D-JIBAISEIKBN-LST (1)
                                           TO  SPA-GMN2D-JIBAISEIKBN-G
                   END-IF
      *            転帰
                   IF      SPA-GMN2D-TENKI     =   SPACE
                       MOVE    SPA-GMN2D-TENKI-LST (02)
                                               TO  SPA-GMN2D-TENKI-G
                   END-IF
      *
                   IF      SPA-GMN2D-SISIKBN   =   SPACE
                       MOVE    SPA-GMN2D-SISIKBN-LST (01)
                                               TO  SPA-GMN2D-SISIKBN-G
                   END-IF
      *H29.5
      *            自賠責点数区分
                   IF      SPA-GMN2D-JIBAIKBN  =   SPACE
                       MOVE    SPA-GMN2D-JIBAIKBN-LST (01)
                                               TO  SPA-GMN2D-JIBAIKBN-G
                   END-IF
      *        公務災害
               WHEN    "5"
      *            自賠責患者請求区分
      ***          IF      SPA-GMN2D-JIBAISEIKBN   =   SPACE
      *                システム管理設定により、初期表示変更
                       IF      SPA-KOMU-SEI        =   "2"
                           MOVE    SPA-GMN2D-JIBAISEIKBN-LST (2)
                                           TO  SPA-GMN2D-JIBAISEIKBN-G
                       ELSE
                           MOVE    SPA-GMN2D-JIBAISEIKBN-LST (1)
                                           TO  SPA-GMN2D-JIBAISEIKBN-G
                       END-IF
      **           END-IF
      *            転帰
                   IF      SPA-GMN2D-TENKI     =   SPACE
                       MOVE    SPA-GMN2D-TENKI-LST (02)
                                               TO  SPA-GMN2D-TENKI-G
                   END-IF
      *
                   IF      SPA-GMN2D-SISIKBN   =   SPACE
                       MOVE    SPA-GMN2D-SISIKBN-LST (01)
                                               TO  SPA-GMN2D-SISIKBN-G
                   END-IF
      *!!!!
      *        第三者行為
               WHEN    "6"
      *            自賠責患者請求区分
                   MOVE    SPA-GMN2D-JIBAISEIKBN-LST (2)
                                           TO  SPA-GMN2D-JIBAISEIKBN-G
      *            転帰
                   IF      SPA-GMN2D-TENKI     =   SPACE
                       MOVE    SPA-GMN2D-TENKI-LST (02)
                                               TO  SPA-GMN2D-TENKI-G
                   END-IF
           END-EVALUATE
      *
          .
       41011-SYOKI-SET-EXT.
           EXIT.
      *****************************************************************
      *    初期編集処理
      *****************************************************************
       41012-SINKEI-SET-SEC           SECTION.
      *
      *    新継再別編集
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
      *            短期給付
                   MOVE    "1 初診"        TO  SPA-GMN2D-SINKEI-LST (01)
                   MOVE    "3 転医始診"    TO  SPA-GMN2D-SINKEI-LST (02)
                   MOVE    "5 継続"        TO  SPA-GMN2D-SINKEI-LST (03)
                   MOVE    "7 再発"        TO  SPA-GMN2D-SINKEI-LST (04)
                   MOVE    4               TO  SPA-GMN2D-SINKEI-MAX
               WHEN    "2"
      *            傷病年金
                   MOVE    "1 初診"        TO  SPA-GMN2D-SINKEI-LST (01)
                   MOVE    "5 継続"        TO  SPA-GMN2D-SINKEI-LST (02)
                   MOVE    "7 再発"        TO  SPA-GMN2D-SINKEI-LST (03)
                   MOVE    3               TO  SPA-GMN2D-SINKEI-MAX
               WHEN    OTHER
                   INITIALIZE                  SPA-GMN2D-SINKEI-COMB
                   MOVE    ZERO            TO  SPA-GMN2D-SINKEI-MAX
           END-EVALUATE
      *
      *    見出し修正
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "5"
                   MOVE    "請求区分"          TO  SPA-GMN2D-SEIKBNMEI
                   MOVE    "担当医"            TO  SPA-GMN2D-TANTOIMEI
               WHEN    OTHER
                   MOVE    "自賠責請求区分"    TO  SPA-GMN2D-SEIKBNMEI
                   MOVE    "自賠責担当医"      TO  SPA-GMN2D-TANTOIMEI
           END-EVALUATE
      *
      *    自賠責患者請求区分
           MOVE    "1 患者請求する(100%)"
                                       TO  SPA-GMN2D-JIBAISEIKBN-LST(01)
           MOVE    "2 患者請求しない(0%)"
                                       TO  SPA-GMN2D-JIBAISEIKBN-LST(02)
           IF      SPA-GMN2D-HKNKBN    =   "6"
               MOVE    "1 患者請求する"
                                       TO  SPA-GMN2D-JIBAISEIKBN-LST(01)
           END-IF
      *    自賠責患者請求区分
           IF      SPA-GMN2D-HKNKBN    =   "4"
                                       OR  "5"
                                       OR  "6"
               MOVE    2                   TO  SPA-GMN2D-JIBAISEIKBN-MAX
           ELSE
               MOVE    ZERO                TO  SPA-GMN2D-JIBAISEIKBN-MAX
           END-IF
      *
          .
       41012-SINKEI-SET-EXT.
           EXIT.
      *****************************************************************
      *    コメント    入力　処理
      *****************************************************************
       4101-COMMENT-CHK-SEC           SECTION.
      *
      *    全角チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN2D-COMMENT   TO  KANACHK-MAE-INPUT
           MOVE    100                 TO  KANACHK-MAX-CNT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
               MOVE    KANACHK-MAE-INPUT   TO  SPA-GMN2D-COMMENT
               MOVE    "0031"              TO  SPA-ERRCD
               MOVE    02                  TO  SPA-GMN2D-CUR
           ELSE
               MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN2D-COMMENT
           END-IF
      *
           .
       4101-COMMENT-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    労働保険番号入力　処理
      *****************************************************************
       4101-KOFUNUM-CHK-SEC            SECTION.
      *
           IF      SPA-GMN2D-KOHNUM1   =   SPACE
               GO      TO     4101-KOFUNUM-CHK-EXT
           END-IF
      *
      *    桁数チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN2D-KOHNUM1   TO  KANACHK-MAE-INPUT
           MOVE    14                  TO  KANACHK-MAX-CNT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC          =   ZERO  )  AND
                  (KANACHK-SYUBETU     =   1     )  AND
                  (KANACHK-MAX         =   14  OR  11 )
      *        半角で、１４、１１桁であること
               CONTINUE
           ELSE
               MOVE    "0003"              TO  SPA-ERRCD
               MOVE    3                   TO  SPA-GMN2D-CUR
           END-IF
      *
      ***  IF      KANACHK-MAX         =   11
      *        MOVE    ZERO            TO  SPA-GMN2D-KOHNUM1(12:)
      **** END-IF
      *
           .
       4101-KOFUNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    年金証書番号入力　処理
      *****************************************************************
       4101-KOHNUM2-CHK-SEC            SECTION.
      *
           IF      SPA-GMN2D-KOHNUM2   =   SPACE
               GO      TO     4101-KOHNUM2-CHK-EXT
           END-IF
      *
      *    桁数チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN2D-KOHNUM2   TO  KANACHK-MAE-INPUT
           MOVE    9                   TO  KANACHK-MAX-CNT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC          =   ZERO  )  AND
                  (KANACHK-SYUBETU     =   1     )  AND
                  (KANACHK-MAX         =   9     )
      *        半角で、９桁であること
               CONTINUE
           ELSE
               MOVE    "0004"              TO  SPA-ERRCD
               MOVE    4                   TO  SPA-GMN2D-CUR
           END-IF
      *
           .
       4101-KOHNUM2-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    災害区分  入力　処理
      *****************************************************************
       4101-SAIGAI-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-SAIGAI    =   SPACE
               GO      TO      4101-SAIGAI-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SAIGAI-MAX
               IF      SPA-GMN2D-SAIGAI    =
                                       SPA-GMN2D-SAIGAI-LST (IDX)(1:1)
                   MOVE    SPA-GMN2D-SAIGAI-LST (IDX)
                                               TO  SPA-GMN2D-SAIGAI-G
                   MOVE    1                   TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0026"              TO  SPA-ERRCD
               MOVE    21                  TO  SPA-GMN2D-CUR
           END-IF
      *
           .
       4101-SAIGAI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    新継再別  入力　処理
      *****************************************************************
       4101-SINKEI-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-SINKEI-G  =   SPACE
               GO      TO      4101-SINKEI-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SINKEI-MAX
               IF      SPA-GMN2D-SINKEI    =
                                       SPA-GMN2D-SINKEI-LST (IDX)(1:1)
                   MOVE    SPA-GMN2D-SINKEI-LST (IDX)
                                               TO  SPA-GMN2D-SINKEI-G
                   MOVE    1                   TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0005"              TO  SPA-ERRCD
               MOVE    5                   TO  SPA-GMN2D-CUR
           END-IF
      *
           .
       4101-SINKEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    転帰区分  入力　処理
      *****************************************************************
       4101-TENKI-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-TENKI-G  =   SPACE
               GO      TO      4101-TENKI-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-TENKI-MAX
               IF      SPA-GMN2D-TENKI    =
                                       SPA-GMN2D-TENKI-LST (IDX)(1:1)
                   MOVE    SPA-GMN2D-TENKI-LST (IDX)
                                               TO  SPA-GMN2D-TENKI-G
                   MOVE    1                   TO  FLG-OK
               END-IF
           END-PERFORM
           IF     (SPA-GMN2D-TENKI NOT =   SPACE )  AND
                  (FLG-OK              =   ZERO  )
               MOVE    "0006"              TO  SPA-ERRCD
               MOVE    6                   TO  SPA-GMN2D-CUR
           END-IF
      *
           .
       4101-TENKI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    四肢特例区分  入力　処理
      *****************************************************************
       4101-SISIKBN-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-SISIKBN-G  =   SPACE
               GO      TO      4101-SISIKBN-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SISIKBN-MAX
               IF      SPA-GMN2D-SISIKBN    =
                                       SPA-GMN2D-SISIKBN-LST (IDX)(1:1)
                   MOVE    SPA-GMN2D-SISIKBN-LST (IDX)
                                               TO  SPA-GMN2D-SISIKBN-G
                   MOVE    1                   TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0007"              TO  SPA-ERRCD
               MOVE    7                   TO  SPA-GMN2D-CUR
           END-IF
      *
           .
       4101-SISIKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    傷病年月日    入力　処理
      *****************************************************************
       4101-SHOBYOYMD-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-SHOBYOYMD =   SPACE
               GO      TO      4101-SHOBYOYMD-CHK-EXT
           END-IF
      *
           IF      SPA-GMN2D-SHOBYOYMD =   SPACE
               IF      SPA-GMN2D-HKNKBN    =   "1" OR  "2"
                   MOVE    "0025"              TO  SPA-ERRCD
                   MOVE    8                   TO  SPA-GMN2D-CUR
                   GO      TO                  4101-SHOBYOYMD-CHK-EXT
               ELSE
                   MOVE    SPACE               TO  SPA-NAI2D-SHOBYOYMD
               END-IF
           ELSE
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN2D-SHOBYOYMD     TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN2D-SHOBYOYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI2D-SHOBYOYMD
               ELSE
                   MOVE    SPACE               TO  SPA-NAI2D-SHOBYOYMD
                   MOVE    "0008"              TO  SPA-ERRCD
                   MOVE    8                   TO  SPA-GMN2D-CUR
               END-IF
           END-IF
      *
           .
       4101-SHOBYOYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    療養開始年月日    入力　処理
      *****************************************************************
       4101-RYOSTYMD-CHK-SEC           SECTION.
      *
      *
           IF      SPA-GMN2D-RYOSTYMD =   SPACE
               GO      TO      4101-RYOSTYMD-CHK-EXT
           END-IF
      *
           IF      SPA-GMN2D-RYOSTYMD      =   SPACE  OR  ZERO
               MOVE    SPACE               TO  SPA-NAI2D-RYOSTYMD
               IF      SPA-GMN2D-HKNKBN    =   "1"  OR  "2"
                   MOVE    "0012"              TO  SPA-ERRCD
                   MOVE    9                   TO  SPA-GMN2D-CUR
               END-IF
           ELSE
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN2D-RYOSTYMD     TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN2D-RYOSTYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI2D-RYOSTYMD
               ELSE
                   MOVE    SPACE               TO  SPA-NAI2D-RYOSTYMD
                   MOVE    "0009"              TO  SPA-ERRCD
                   MOVE    9                   TO  SPA-GMN2D-CUR
               END-IF
           END-IF
      *
           IF     (SPA-ERRCD           =   SPACE ) AND
                  (SPA-NAI2D-RYOSTYMD  NOT =    SPACE )
      *        傷病年月日＞療養開始日はエラーとする
               IF      SPA-NAI2D-SHOBYOYMD >   SPA-NAI2D-RYOSTYMD
                   MOVE    "0030"              TO  SPA-ERRCD
                   MOVE    9                   TO  SPA-GMN2D-CUR
               END-IF
           END-IF
      *
      *    労災レセ回数記載：基準年月
           IF     (SPA-ERRCD           =   SPACE ) AND
                  (SPA-NAI2D-RYOSTYMD  NOT =    SPACE )
               IF     (SPA-GMN2D-HKNKBN    =   "1"  OR  "2" ) AND
                      (SPA-NAI2D-KIJYUNYM  =   SPACE   )
                   MOVE    SPA-NAI2D-RYOSTYMD(1:6)
                                           TO  SPA-NAI2D-KIJYUNYM
                   MOVE    SPA-GMN2D-RYOSTYMD(1:6)
                                           TO  SPA-GMN2D-KIJYUNYM
               END-IF
           END-IF
      *
      *!!
      *    公務災害はＨ１８．４からとする
           IF     (SPA-ERRCD           =   SPACE ) AND
                  (SPA-NAI2D-RYOSTYMD  NOT =    SPACE )
               IF     (SPA-GMN2D-HKNKBN    =   "5" ) AND
                      (SPA-NAI2D-RYOSTYMD  <   "20060401" )
                   MOVE    "0044"              TO  SPA-ERRCD
                   MOVE    9                   TO  SPA-GMN2D-CUR
               END-IF
           END-IF
      *!
      *
      *!!
      *    第三者行為はH25.4.1からとする
      *    IF     (SPA-ERRCD           =   SPACE ) AND
      *           (SPA-NAI2D-RYOSTYMD  NOT =    SPACE )
      *        IF     (SPA-GMN2D-HKNKBN    =   "6" ) AND
      *               (SPA-NAI2D-RYOSTYMD  <   "20130401" )
      *            MOVE    "0045"              TO  SPA-ERRCD
      *            MOVE    9                   TO  SPA-GMN2D-CUR
      *        END-IF
      *****END-IF
      *!
           .
       4101-RYOSTYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    療養終了年月日    入力　処理
      *****************************************************************
       4101-RYOEDYMD-CHK-SEC           SECTION.
      *
           IF     (SPA-GMN2D-RYOSTYMD      =   SPACE ) AND
                  (SPA-GMN2D-RYOEDYMD      =   SPACE )
               GO      TO     4101-RYOEDYMD-CHK-EXT
           END-IF
      *
           IF      SPA-GMN2D-RYOEDYMD      =   SPACE
               MOVE    ALL "9"             TO  SPA-NAI2D-RYOEDYMD
               MOVE    "9999999  "         TO  SPA-GMN2D-RYOEDYMD
           END-IF
           IF      SPA-GMN2D-RYOEDYMD(1:7) =   "9999999"
               MOVE    ALL "9"             TO  SPA-NAI2D-RYOEDYMD
               MOVE    "9999999"           TO  SPA-GMN2D-RYOEDYMD
           ELSE
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN2D-RYOEDYMD       TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN2D-RYOEDYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI2D-RYOEDYMD
               ELSE
                   MOVE    SPACE               TO  SPA-NAI2D-RYOEDYMD
                   MOVE    "0010"              TO  SPA-ERRCD
                   MOVE    10                  TO  SPA-GMN2D-CUR
                   GO      TO                  4101-RYOEDYMD-CHK-EXT
               END-IF
           END-IF
      *
           IF      SPA-NAI2D-RYOSTYMD  >   SPA-NAI2D-RYOEDYMD
               MOVE    "0011"              TO  SPA-ERRCD
               MOVE    10                  TO  SPA-GMN2D-CUR
           END-IF
      *
           .
       4101-RYOEDYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    事業の名称入力処理
      *****************************************************************
       4101-JIGYOUNAME-CHK-SEC           SECTION.
      *
      *
           IF      SPA-GMN2D-JIGYOUNAME    =   SPACE
                GO      TO      4101-JIGYOUNAME-CHK-EXT
           END-IF
      *
      *    半角→全角
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN2D-JIGYOUNAME
                                       TO  KANACHK-MAE-INPUT
           MOVE    100                 TO  KANACHK-MAX-CNT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
               MOVE    "0029"              TO  SPA-ERRCD
               MOVE    11                  TO  SPA-GMN2D-CUR
               MOVE    KANACHK-MAE-INPUT   TO  SPA-GMN2D-JIGYOUNAME
           ELSE
               MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN2D-JIGYOUNAME
           END-IF
      *
           .
       4101-JIGYOUNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    都道府県入力処理
      *****************************************************************
       4101-PREFNAME-CHK-SEC           SECTION.
      *
      *    MOVE    12                  TO  SPA-GMN2D-CUR
      *
      *    MOVE    P02D-PREFNAME       TO  SPA-GMN2D-PREFNAME-G
      *
      *    MOVE    13                  TO  SPA-GMN2D-CUR
      *
           .
       4101-PREFNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    都道府県入力処理
      *****************************************************************
       4101-PREFKBN-CHK-SEC           SECTION.
      *
      *    MOVE    13                  TO  SPA-GMN2D-CUR
      *
      *    MOVE    P02D-PREFKBN        TO  SPA-GMN2D-PREFKBN-G
           IF      SPA-GMN2D-PREFKBN-G =   SPACE
               GO      TO      4101-PREFKBN-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-PREFKBN-MAX
               IF      SPA-GMN2D-PREFKBN-LST(IDX) (1:1)
                                           =   SPA-GMN2D-PREFKBN
                   MOVE    SPA-GMN2D-PREFKBN-LST (IDX)
                                           TO  SPA-GMN2D-PREFKBN-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
      *
           IF      FLG-OK              =   ZERO
               MOVE    "0033"              TO  SPA-ERRCD
               MOVE    13                  TO  SPA-GMN2D-CUR
           END-IF
      *
      *
           .
       4101-PREFKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    郡市区入力処理
      *****************************************************************
       4101-CITYNAME-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-CITYNAME    =   SPACE
                GO      TO      4101-CITYNAME-CHK-EXT
           END-IF
      *
      *    半角空白→全角空白
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN2D-CITYNAME
                                       TO  KANACHK-MAE-INPUT
           MOVE    20                  TO  KANACHK-MAX-CNT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
               MOVE    "0036"              TO  SPA-ERRCD
               MOVE    14                  TO  SPA-GMN2D-CUR
               MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN2D-CITYNAME
           ELSE
               MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN2D-CITYNAME
           END-IF
      *
           .
       4101-CITYNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    郡市区入力処理
      *****************************************************************
       4101-CITYKBN-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-CITYKBN-G     =   SPACE
               GO      TO      4101-CITYKBN-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-CITYKBN-MAX
               IF      SPA-GMN2D-CITYKBN-LST(IDX) (1:1)
                                           =   SPA-GMN2D-CITYKBN
                   MOVE    SPA-GMN2D-CITYKBN-LST (IDX)
                                           TO  SPA-GMN2D-CITYKBN-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
      *
           IF      FLG-OK              =   ZERO
               MOVE    "0032"              TO  SPA-ERRCD
               MOVE    15                  TO  SPA-GMN2D-CUR
           END-IF
      *
           .
       4101-CITYKBN-CHK-EXT.
           EXIT.
      *
      *H29.5
      *****************************************************************
      *    自賠責点数区分　処理
      *****************************************************************
       4101-JIBAIKBN-CHK-SEC           SECTION.
      *
      *    自賠責以外は入力なしとする
           IF      SPA-GMN2D-HKNKBN    =   "4"
               CONTINUE
           ELSE
               MOVE    SPACE           TO  SPA-GMN2D-JIBAIKBN-G
               GO      TO  4101-JIBAIKBN-CHK-EXT
           END-IF
      *
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   SPA-GMN2D-JIBAIKBN-MAX)
                          OR  (FLG-OK  =   1    )
               IF      SPA-GMN2D-JIBAIKBN  =   SPA-GMN2D-JIBAIKBN-LST
                                                          (IDX)(1:1)
                   MOVE    SPA-GMN2D-JIBAIKBN-LST (IDX)
                                           TO  SPA-GMN2D-JIBAIKBN-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
      *    Ｈ２９年７月から適応
           IF      SPA-NAI2D-RYOSTYMD  <   "20170701"
               IF      SPA-GMN2D-JIBAIKBN  NOT =   "0"
                   MOVE    "0057"              TO  SPA-ERRCD
               END-IF
               MOVE    SPA-GMN2D-JIBAIKBN-LST (01)
                                           TO  SPA-GMN2D-JIBAIKBN-G
           END-IF
           IF      FLG-OK              =   ZERO
               MOVE    "0055"              TO  SPA-ERRCD
               MOVE    33                  TO  SPA-GMN2D-CUR
           ELSE
      *        訂正時の変更は警告
               IF     (SPA-NAI2D-HKNKBN-MAE    NOT =   SPACE )
                 AND  (SPA-NAI2D-MAE-JIBAIKBN
                                           NOT =  SPA-GMN2D-JIBAIKBN)
                   IF      SPA-NAI2D-KEIFLG3   =   ZERO
                       MOVE    "K056"          TO  SPA-ERRCD
                       MOVE    33              TO  SPA-GMN2D-CUR
                       MOVE    1               TO  SPA-NAI2D-KEIFLG3
                   END-IF
               END-IF
           END-IF
      *
           .
       4101-JIBAIKBN-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    自賠責診療科　処理
      *****************************************************************
       4101-SRYKA-CHK-SEC           SECTION.
      *
      *    自賠責・公務災害以外は入力なしとする
           IF      SPA-GMN2D-HKNKBN    =   "4"
                                       OR  "5"
                                       OR  "6"
               CONTINUE
           ELSE
               MOVE    SPACE               TO  SPA-GMN2D-SRYKA-G
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-SRYKA-MAX
               IF      SPA-GMN2D-SRYKA     =   SPA-GMN-SRYKA-LST
                                                          (IDX)(1:2)
                   MOVE    SPA-GMN-SRYKA-LST (IDX)
                                           TO  SPA-GMN2D-SRYKA-G
                   MOVE    1               TO  FLG-OK
               END-IF
           END-PERFORM
           IF      SPA-GMN2D-SRYKA     =   SPACE
               CONTINUE
           ELSE
               IF      FLG-OK              =   ZERO
                   MOVE    "0036"              TO  SPA-ERRCD
                   MOVE    25                  TO  SPA-GMN2D-CUR
               ELSE
                   IF      SPA-GMN2D-SRYKA NOT =   SPA-NAI2D-MAE-SRYKA
                       PERFORM 41011-DRCD-LIST-SEC
                   END-IF
                   MOVE    SPA-GMN2D-SRYKA     TO  SPA-NAI2D-MAE-SRYKA
               END-IF
           END-IF
      *
          .
       4101-SRYKA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ドクター一覧編集処理
      *****************************************************************
       41011-DRCD-LIST-SEC           SECTION.
      *
           INITIALIZE                  ORCSDRSETAREA
           MOVE    SPA-SYSYMD          TO  ORCSDR-SYSYMD
           MOVE    "1"                 TO  ORCSDR-KBN
           MOVE    SPA-GMN2D-SRYKA     TO  ORCSDR-SRYKA
           CALL    "ORCSDRSET"         USING
                                       SPA-AREA
                                       ORCSDRSETAREA
           MOVE    ORCSDR-DRCD-TBL-G   TO  SPA-GMN2D-DRCDLST-G
           MOVE    ORCSDR-DRCD-MAX     TO  SPA-GMN2D-DRCD-MAX
      *
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING   IDX       FROM    1   BY  1
                   UNTIL     IDX           >   SPA-GMN2D-DRCD-MAX
               IF      SPA-GMN2D-DRCD      =   SPA-GMN2D-DRCD-CD(IDX)
                   MOVE    SPA-GMN2D-DRCDLST(IDX)
                                               TO  SPA-GMN2D-DRCD-G
                   MOVE    1                   TO  FLG-CHK
                   MOVE    SPA-GMN2D-DRCD-MAX  TO  IDX
               END-IF
           END-PERFORM
           IF      FLG-CHK             =   ZERO
               MOVE    SPA-GMN2D-DRCDLST(1)
                                           TO  SPA-GMN2D-DRCD-G
           END-IF
          .
       41011-DRCD-LIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    自賠責担当医　処理
      *****************************************************************
       4101-DRCD-CHK-SEC           SECTION.
      *
      *    自賠責・公務災害以外は入力なしとする
           IF      SPA-GMN2D-HKNKBN    =   "4"
                                       OR  "5"
                                       OR  "6"
               CONTINUE
           ELSE
               MOVE    SPACE               TO  SPA-GMN2D-DRCD-G
           END-IF
      *
           IF      SPA-GMN2D-DRCD      =   SPACE
               GO      TO      4101-DRCD-CHK-EXT
           END-IF
      *
           INITIALIZE                  ORCSDRSETAREA
           MOVE    SPA-SYSYMD          TO  ORCSDR-SYSYMD
           MOVE    "2"                 TO  ORCSDR-KBN
           MOVE    SPA-GMN2D-SRYKA     TO  ORCSDR-SRYKA
           MOVE    SPA-GMN2D-DRCDLST-G TO  ORCSDR-DRCD-TBL-G
           MOVE    SPA-GMN2D-DRCD-MAX  TO  ORCSDR-DRCD-MAX
           MOVE    SPA-GMN2D-DRCD-G    TO  ORCSDR-IN-DRCD-G
           CALL    "ORCSDRSET"         USING
                                       SPA-AREA
                                       ORCSDRSETAREA
           MOVE    ORCSDR-DRCD-TBL-G   TO  SPA-GMN2D-DRCDLST-G
           MOVE    ORCSDR-DRCD-MAX     TO  SPA-GMN2D-DRCD-MAX
           MOVE    ORCSDR-IN-DRCD-G    TO  SPA-GMN2D-DRCD-G
           IF      ORCSDR-ERRCD    NOT =   ZERO
               MOVE    "0037"              TO  SPA-ERRCD
               MOVE    26                  TO  SPA-GMN2D-CUR
           END-IF
      *
          .
       4101-DRCD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    自賠責保険会社名　処理
      *****************************************************************
       4101-HOKENNAME-CHK-SEC           SECTION.
      *
      *    自賠責以外は入力なしとする
           IF      SPA-GMN2D-HKNKBN    =   "4"
                                       OR  "6"
               CONTINUE
           ELSE
               MOVE    SPACE               TO  SPA-GMN2D-HOKENNAME
           END-IF
      *
           IF      SPA-GMN2D-HOKENNAME NOT =   SPACE
      *        半角空白→全角空白
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "2"                 TO  KANACHK-SYORI
               MOVE    SPA-GMN2D-HOKENNAME
                                           TO  KANACHK-MAE-INPUT
               MOVE    80                  TO  KANACHK-MAX-CNT
               CALL    "ORCSKANACHK"       USING
                                           ORCSKANACHKAREA
               IF     (KANACHK-RC      NOT =   ZERO  )  OR
                      (KANACHK-SYUBETU     =   1     )
                   MOVE    "0038"              TO  SPA-ERRCD
                   MOVE    27                  TO  SPA-GMN2D-CUR
                   MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN2D-HOKENNAME
               ELSE
                   MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN2D-HOKENNAME
               END-IF
           END-IF
      *
          .
       4101-HOKENNAME-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災レセ回数記載 基準年月入力処理
      *****************************************************************
       4101-KIJYUNYM-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-RYOSTYMD  =   SPACE
               GO      TO      4101-KIJYUNYM-CHK-EXT
           END-IF
      *
           IF      SPA-GMN2D-KIJYUNYM      =   SPACE  OR  ZERO
               MOVE    SPACE               TO  SPA-NAI2D-KIJYUNYM
               IF      SPA-GMN2D-HKNKBN    =   "1"  OR  "2"
                   MOVE    "0040"              TO  SPA-ERRCD
                   MOVE    28                  TO  SPA-GMN2D-CUR
               END-IF
           ELSE
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN2D-KIJYUNYM      TO  SGDAY-INDAY
               MOVE    "1"                     TO  SGDAY-INTYPE
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY(1:6)    TO  SPA-GMN2D-KIJYUNYM
                   MOVE    SGDAY-SDAY (1:6)    TO  SPA-NAI2D-KIJYUNYM
               ELSE
                   MOVE    SPACE               TO  SPA-NAI2D-KIJYUNYM
                   MOVE    "0041"              TO  SPA-ERRCD
                   MOVE    28                  TO  SPA-GMN2D-CUR
               END-IF
           END-IF
      *
           IF     (SPA-ERRCD           =   SPACE ) AND
                  (SPA-NAI2D-KIJYUNYM  NOT =   SPACE )  AND
                  (SPA-GMN2D-HKNKBN    =   "1"  OR  "2")
      *        基準年月＜療養開始日はエラーとする
               IF      SPA-NAI2D-KIJYUNYM  <   SPA-NAI2D-RYOSTYMD(1:6)
                   MOVE    "0042"              TO  SPA-ERRCD
                   MOVE    28                  TO  SPA-GMN2D-CUR
               END-IF
           END-IF
      *
          .
       4101-KIJYUNYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災レセ回数記載 回数入力処理
      *****************************************************************
       4101-KAISU-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-KAISU     =   ZERO
               IF      SPA-GMN2D-HKNKBN    =   "1"  OR  "2"
                   MOVE    "0043"              TO  SPA-ERRCD
                   MOVE    29                  TO  SPA-GMN2D-CUR
               END-IF
           END-IF
      *
          .
       4101-KAISU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    労働基準監督署コード入力処理
      *****************************************************************
       4101-SYOCD-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-SYOCD     =   SPACE
               MOVE    SPACE               TO  SPA-GMN2D-SYOCDNAME
      *        初期設定
               IF     (SPA-NAI2D-SHOBYOYMD NOT =   SPACE )
                  AND (SPA-NAI2D-RYOSTYMD  NOT =   SPACE )
      *            傷病年月日・療養開始日の設定がある時
                   PERFORM 30011-SYOCD-INITSET-SEC
      *H29.2
      *            労働基準監督署コードが存在しないとき、複写中止
                   IF      SPA-GMN2D-SYOCD     NOT =   SPACE
                       PERFORM 30012-SYOCD-HEN-SEC
                       IF     (FLG-LABOR-SIO       =   1   )
                         AND  (SPA-NAI2D-RYOSTYMD  >=  "20080401" )
                           MOVE    SPACE           TO  SPA-GMN2D-SYOCD
                       END-IF
                   END-IF
               END-IF
           END-IF
      *
           IF     (SPA-GMN2D-SYOCD NOT =   SPACE )
             AND  (SPA-NAI2D-SYOCDCHK  =   SPACE )
               MOVE    "1"                 TO  SPA-NAI2D-SYOCDCHK
               PERFORM 30012-SYOCD-HEN-SEC
               IF     (FLG-LABOR-SIO       =   1   )
                 AND  (SPA-NAI2D-RYOSTYMD  >=  "20080401" )
                   MOVE    SPACE               TO  SPA-NAI2D-SYOCDCHK
                   IF     (SPA-NAI2D-KEIFLG2   =   ZERO )
                     AND ((FLG-TOUROKU         =   1      ) OR
                          (WRK-MCP-WIDGET      =   "SYOCD"))
                       MOVE    1                   TO  SPA-NAI2D-KEIFLG2
      *H29.2           MOVE    "K049"              TO  SPA-ERRCD
                       MOVE    "K052"              TO  SPA-ERRCD
                       MOVE    30                  TO  SPA-GMN2D-CUR
      *H25.7
      ****             職業安定所判定
      *                IF      SPA-GMN2D-SYOCD(3:1)    =   "3"
      *                     MOVE    "K052"              TO  SPA-ERRCD
      *****            END-IF
                   END-IF
               END-IF
           END-IF
      *
          .
       4101-SYOCD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    第三者　現物給付計算区分 入力処理
      *****************************************************************
       4101-DAI3-GENBTKBN-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-HKNKBN    =   "6"
      *        第三者行為
               IF      SPA-GMN2D-D3-GENBTKBN   =   SPACE
                   MOVE    "1"             TO  SPA-GMN2D-D3-GENBTKBN
      *H28.1       初期設定
                   IF      SPA-DAISAN-GEN  NOT =   SPACE
                       MOVE    SPA-DAISAN-GEN
                                               TO  SPA-GMN2D-D3-GENBTKBN
                   END-IF
               END-IF
           ELSE
               MOVE    SPACE           TO  SPA-GMN2D-D3-GENBTKBN-G
               GO      TO      4101-DAI3-GENBTKBN-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-D3-GENBTKBN-MAX
               IF     (SPA-GMN2D-D3-GENBTKBN-CD(IDX)
                                           =   SPA-GMN2D-D3-GENBTKBN)
                   MOVE    SPA-GMN2D-D3-GENBTKBNLST (IDX)
                                           TO  SPA-GMN2D-D3-GENBTKBN-G
                   MOVE    1               TO  FLG-CHK
               END-IF
           END-PERFORM
           IF      FLG-CHK             =   ZERO
               MOVE    "0053"              TO  SPA-ERRCD
               MOVE    35                  TO  SPA-GMN2D-CUR
           END-IF
      *
          .
       4101-DAI3-GENBTKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    第三者　特記事項区分 入力処理
      *****************************************************************
       4101-DAI3-TOKKIKBN-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-HKNKBN    =   "6"
      *        第三者行為
               IF      SPA-GMN2D-D3-TOKKIKBN   =   SPACE
                   MOVE    "1"             TO  SPA-GMN2D-D3-TOKKIKBN
               END-IF
           ELSE
               MOVE    SPACE           TO  SPA-GMN2D-D3-TOKKIKBN-G
               GO      TO      4101-DAI3-TOKKIKBN-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-CHK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-D3-TOKKIKBN-MAX
               IF     (SPA-GMN2D-D3-TOKKIKBN-CD(IDX)
                                           =   SPA-GMN2D-D3-TOKKIKBN)
                   MOVE    SPA-GMN2D-D3-TOKKIKBNLST (IDX)
                                           TO  SPA-GMN2D-D3-TOKKIKBN-G
                   MOVE    1               TO  FLG-CHK
               END-IF
           END-PERFORM
           IF      FLG-CHK             =   ZERO
               MOVE    "0054"              TO  SPA-ERRCD
               MOVE    36                  TO  SPA-GMN2D-CUR
           END-IF
      *
      *
          .
       4101-DAI3-TOKKIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    健康管理手帳番号 入力処理
      *****************************************************************
       4101-KOHNUM3-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-KOHNUM3   =   SPACE
               GO      TO     4101-KOHNUM3-CHK-EXT
           END-IF
      *
      *    桁数チェック
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN2D-KOHNUM3   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC          =   ZERO  )  AND
                  (KANACHK-SYUBETU     =   1     )  AND
                  (KANACHK-MAX         =   13  OR  10 )
      *        半角で、１０，１３桁であること
               CONTINUE
           ELSE
               MOVE    "0028"              TO  SPA-ERRCD
               MOVE    16                  TO  SPA-GMN2D-CUR
           END-IF
      *
      **** IF      KANACHK-MAX         =   10
      *        MOVE    ZERO            TO  SPA-GMN2D-KOHNUM3(11:)
      *****END-IF
      *
      *
           .
       4101-KOHNUM3-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    損傷区分 入力処理
      *****************************************************************
       4101-SONSHOUKBN-CHK-SEC           SECTION.
      *
      *    MOVE    17                  TO  SPA-GMN2D-CUR
      *
      *    MOVE    P02D-SONSHOUKBN     TO  SPA-GMN2D-SONSHOUKBN-G
      *
      *    MOVE    18                  TO  SPA-GMN2D-CUR
           IF      SPA-GMN2D-SONSHOUKBN-G  =   SPACE
               GO      TO      4101-SONSHOUKBN-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   SPA-GMN2D-SONSHOUKBN-MAX) OR
                              (FLG-OK  =   1    )
               IF     (SPA-GMN2D-SONSHOUKBN-LST(IDX) (1:2)
                                           =   SPA-GMN2D-SONSHOUKBN) AND
                      (SPA-GMN2D-SONSHOUKBN-LST(IDX) (4:1)
                                           =   SPA-GMN2D-SONSHOUKBNEDA)
                   MOVE    SPA-GMN2D-SONSHOUKBN-LST (IDX)
                                           TO  SPA-GMN2D-SONSHOUKBN-G
                   MOVE    1                   TO  FLG-OK
               END-IF
           END-PERFORM
           IF      FLG-OK              =   ZERO
               MOVE    "0034"              TO  SPA-ERRCD
               MOVE    17                  TO  SPA-GMN2D-CUR
           END-IF
      *
           .
       4101-SONSHOUKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    アフターケア療養開始年月日    入力　処理
      *****************************************************************
       4101-SINSATUYMD-CHK-SEC           SECTION.
      *
           IF      SPA-GMN2D-SINSATUYMD     =   SPACE
               GO      TO      4101-SINSATUYMD-CHK-EXT
           END-IF
      *
           IF      SPA-GMN2D-SINSATUYMD     =   SPACE  OR  ZERO
               IF      SPA-GMN2D-HKNKBN    =   "3"
                   MOVE    "0019"              TO  SPA-ERRCD
               ELSE
                   MOVE    SPACE               TO  SPA-NAI2D-SINSATUYMD
               END-IF
           ELSE
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN2D-SINSATUYMD    TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN2D-SINSATUYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI2D-SINSATUYMD
               ELSE
                   MOVE    SPACE               TO  SPA-NAI2D-SINSATUYMD
                   MOVE    "0017"              TO  SPA-ERRCD
                   MOVE    18                  TO  SPA-GMN2D-CUR
               END-IF
           END-IF
      *
           .
       4101-SINSATUYMD-CHK-EXT.
           EXIT.
      *****************************************************************
      *    アフターケア療養終了年月日    入力　処理
      *****************************************************************
       4101-SINSATUEND-CHK-SEC           SECTION.
      *
           IF     (SPA-GMN2D-SINSATUYMD    =   SPACE ) AND
                  (SPA-GMN2D-SINSATUEND    =   SPACE )
               GO      TO      4101-SINSATUEND-CHK-EXT
           END-IF
      *
           IF      SPA-GMN2D-SINSATUEND    =   SPACE
               MOVE    ALL "9"             TO  SPA-NAI2D-SINSATUEND
               MOVE    "9999999  "         TO  SPA-GMN2D-SINSATUEND
           END-IF
           IF      SPA-GMN2D-SINSATUEND(1:7)   =   "9999999"
               MOVE    ALL "9"             TO  SPA-NAI2D-SINSATUEND
               MOVE    "9999999"           TO  SPA-GMN2D-SINSATUEND
           ELSE
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN2D-SINSATUEND    TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN2D-SINSATUEND
                   MOVE    SGDAY-SDAY          TO  SPA-NAI2D-SINSATUEND
               ELSE
                   MOVE    SPACE               TO  SPA-NAI2D-SINSATUEND
                   MOVE    "0010"              TO  SPA-ERRCD
                   MOVE    19                  TO  SPA-GMN2D-CUR
               END-IF
           END-IF
      *
           IF      SPA-NAI2D-SINSATUYMD    >   SPA-NAI2D-SINSATUEND
               IF      SPA-ERRCD           =   SPACE
                   MOVE    "0011"              TO  SPA-ERRCD
                   MOVE    19                  TO  SPA-GMN2D-CUR
               END-IF
           END-IF
      *
           .
       4101-SINSATUEND-CHK-EXT.
           EXIT.
      *
      *!!!!!!!!!!!!!!!!!!!!!!!!!!
      *****************************************************************
      *    クリア処理
      *****************************************************************
       420-CLERA-SEC       SECTION.
      *
      *    クリア
           PERFORM 4201-CLERA-SYORI-SEC
      *
           MOVE    ZERO                TO  SPA-NAI2D-GMNIDX
           MOVE    SPA-GMN-NAME        TO  SPA-GMN2D-HIHKNJANAME
      *
           MOVE    ZERO                TO  SPA-GMN2D-SELNUM
           MOVE    ZERO                TO  SPA-GMN2D-MAE-SELNUM
           MOVE    1                   TO  SPA-GMN2D-CUR
           .
       420-CLERA-EXT.
           EXIT.
      *****************************************************************
      *    クリア共通処理
      *****************************************************************
       4201-CLERA-SYORI-SEC       SECTION.
      *
           INITIALIZE                  SPA-GMN2D-AREA
           INITIALIZE                  SPA-NAI2D-AREA
           MOVE    ZERO                TO  SPA-NAI2D-HKNID
           MOVE    ZERO                TO  SPA-NAI2D-KOHID
      *
           MOVE    ZERO                TO  SPA-NAI2D-RSHKN-EDANUM
      *
      *    コンボボクスの編集
           PERFORM 3002-COMBBOX-HEX-SEC
      *    区分毎コンボボクス編集
           PERFORM 41012-SINKEI-SET-SEC
      *
           .
       4201-CLERA-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    労災一覧選択処理
      *****************************************************************
       4001-RSILIST-SEL-SEC       SECTION.
      *
           MOVE    ZERO                TO  WRK-SELNUM
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-RSIMAX
               IF      P02D-RSILIST-SELECT (IDX)   =   "T"
                   MOVE    IDX                 TO  WRK-SELNUM
                   MOVE    SPA-GMN2D-RSIMAX    TO  IDX
               END-IF
           END-PERFORM
      *
           IF      WRK-SELNUM      NOT =   ZERO
               MOVE    WRK-SELNUM      TO  P02D-SELNUM
               PERFORM 4002-SELNUM-CHK-SEC
           END-IF
      *
           .
       4001-RSILIST-SEL-EXT.
           EXIT.
      *****************************************************************
      *    労災選択処理
      *****************************************************************
       4002-SELNUM-CHK-SEC       SECTION.
      *
           MOVE    P02D-SELNUM         TO  SPA-GMN2D-SELNUM
      *
           IF      SPA-GMN2D-SELNUM    >   SPA-GMN2D-RSIMAX
               MOVE    "0051"              TO  SPA-ERRCD
               MOVE    31                  TO  SPA-GMN2D-CUR
               GO      TO      4002-SELNUM-CHK-EXT
           END-IF
      *
           IF      SPA-GMN2D-SELNUM    =   ZERO
      *         選択なし
                IF      SPA-GMN2D-MAE-SELNUM   NOT =   ZERO
      *             クリア
                    PERFORM 420-CLERA-SEC
               END-IF
           ELSE
      *        労災リスト選択
               PERFORM 40021-RISSEL-HEN-SEC
           END-IF
           .
       4002-SELNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    クリア処理
      *****************************************************************
       40021-RISSEL-HEN-SEC       SECTION.
      *
      *    クリア
           PERFORM 4201-CLERA-SYORI-SEC
      *
      *    パラメタ連番
           MOVE    SPA-GMN2D-TPARANUM (SPA-GMN2D-SELNUM)
                                       TO  SPA-NAI2D-RSHKN-EDANUM
      *    労災詳細編集
           PERFORM 3001-RSHKN-SET-SEC
      *    区分毎コンボボクス編集
           PERFORM 41012-SINKEI-SET-SEC
      *    コンボボクスの編集
           PERFORM 3003-COMBBOX-SET-SEC
      *
           MOVE    SPA-GMN2D-SELNUM    TO  SPA-GMN2D-MAE-SELNUM
      *
      *    部位の次へ
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
                   MOVE    3               TO  SPA-GMN2D-CUR
               WHEN    "2"
                   MOVE    4               TO  SPA-GMN2D-CUR
               WHEN    "3"
                   MOVE    16              TO  SPA-GMN2D-CUR
               WHEN    "4"
               WHEN    "5"
               WHEN    "6"
                   MOVE    6               TO  SPA-GMN2D-CUR
           END-EVALUATE
      *
           .
       40021-RISSEL-HEN-EXT.
           EXIT.
      *****************************************************************
      *    クリア処理
      *****************************************************************
       460-NEXT-TBL-SEC       SECTION.
      *
           IF      SPA-GMN2D-RSIMAX    >   ZERO
               ADD     1               TO  SPA-GMN2D-SELNUM
               IF      SPA-GMN2D-SELNUM    >   SPA-GMN2D-RSIMAX
                   MOVE    1               TO  SPA-GMN2D-SELNUM
               END-IF
      *        労災リスト選択
               PERFORM 40021-RISSEL-HEN-SEC
           END-IF
           .
       460-NEXT-TBL-EXT.
           EXIT.
      *!!!!!!!!!!!!!!!!!!!!!!!!!!
      *
      *****************************************************************
      *    取り消し処理
      *****************************************************************
       420-MODORU-SEC             SECTION.
      *
      *    MOVE    SPACE               TO  HPARA-REC
      *    MOVE    "01"                TO  HPAR-FLG
      *
      *    MOVE    SPACE               TO  RSPARA-REC
      *    MOVE    "01"                TO  RSPAR-FLG
           MOVE    "1"                 TO  SPA-RSPAR-FLG
      *
           MOVE    1                   TO  FLG-END
      *
          .
       420-MODORU-EXT.
           EXIT.
      *****************************************************************
      *    削除処理
      *****************************************************************
       430-SAKUJYO-SEC             SECTION.
      *
           MOVE    SPACE               TO  SPA-RSPAR-FLG
      *
           IF    SPA-NAI2D-HKNKBN-MAE  =   SPACE
               MOVE    "0020"          TO  SPA-ERRCD
               GO  TO                  430-SAKUJYO-EXT
           END-IF
      *
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "PTRSIINF"          TO  PARA-FILEMEI
           MOVE    SPA-NAI2D-RSHKN-EDANUM
                                       TO  PARA-EDANUM
      *
           MOVE    SPA-HOSPNUM         TO  PARA-HOSPNUM
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_para"          TO  MCP-TABLE
               MOVE    "key4"              TO  MCP-PATHNAME
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           IF      FLG-PARA           =    ZERO
               MOVE    PARA-DATA-REC       TO  PTRSIINF-REC
               MOVE    "1"                 TO  PTRSI-SAKUJOKBN
      *
               MOVE    PTRSIINF-REC        TO  PARA-DATA-REC
      *
               MOVE    SPA-HOSPNUM         TO  PARA-HOSPNUM
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "tbl_para"          TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
grpsys         CALL    "ORCDBMAIN"         USING   MCPAREA
                                                   MCPDATA-REC
                                                   SPA-AREA
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P02D PARA UPD ERR:"  MCP-RC
               END-IF
           END-IF
      *
      *    患者保険処理
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-GMN2D-HKNKBN    =   "6"
      *            第三者行為
                   PERFORM 49013-PTKOHINF-HEN-SEC
               ELSE
                   PERFORM 49012-PTHKNINF-HEN-SEC
               END-IF
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    "1"                 TO  SPA-NAI-SAKJOKBN
      *
               MOVE    1                   TO  FLG-END
      *
      *        終了へ
               PERFORM 210-BACK
           END-IF
           .
       430-SAKUJYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録処理
      *****************************************************************
       490-TOROKU-SEC             SECTION.
      *
           MOVE    1                   TO  FLG-TOUROKU
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
      *
      *    保険期間重複チェック
           IF      SPA-ERRCD           =   SPACE
               PERFORM 49011-KANREN-HKN-CHECK-SEC
           END-IF
      *
      *    患者保険処理
           IF      SPA-ERRCD           =   SPACE
      *!!!!!!!!!!!!!!!!
               IF      SPA-GMN2D-HKNKBN    =   "6"
      *            第三者行為
                   PERFORM 49013-PTKOHINF-HEN-SEC
               ELSE
                   PERFORM 49012-PTHKNINF-HEN-SEC
               END-IF
           END-IF
      *
      *    労災保険編集処理
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4905-PTRSIINF-HEN-SEC
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    SPACE               TO  SPA-RSPAR-FLG
               MOVE    1                   TO  FLG-END
      *        終了へ
               PERFORM 210-BACK
           END-IF
           .
       490-TOROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *   必須入力チェック処理
      *****************************************************************
       4109-TOUROKU-CHK-SEC             SECTION.
      *
      *    患者交付番号
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
                   IF      SPA-GMN2D-KOHNUM1   =   SPACE
                       IF      SPA-NAI2D-KEIFLG    =   ZERO
                           MOVE    1               TO  SPA-NAI2D-KEIFLG
                           MOVE    "K022"              TO  SPA-ERRCD
                           MOVE    3                   TO  SPA-GMN2D-CUR
                       END-IF
                   END-IF
                   IF      SPA-GMN2D-SAIGAI        =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0027"              TO  SPA-ERRCD
                       MOVE    21                  TO  SPA-GMN2D-CUR
                   END-IF
      *            新継区分
                   IF     (SPA-GMN2D-SINKEI        =   SPACE )
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0005"              TO  SPA-ERRCD
                       MOVE    5                   TO  SPA-GMN2D-CUR
                   END-IF
      *            転帰事由
                   IF     (SPA-GMN2D-TENKI         =   SPACE )
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0006"              TO  SPA-ERRCD
                       MOVE    6                   TO  SPA-GMN2D-CUR
                   END-IF
                   IF      SPA-GMN2D-SHOBYOYMD     =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0025"              TO  SPA-ERRCD
                       MOVE    8                   TO  SPA-GMN2D-CUR
                   END-IF
                   IF      SPA-GMN2D-RYOSTYMD =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0012"              TO  SPA-ERRCD
                       MOVE    9                   TO  SPA-GMN2D-CUR
                   END-IF
      *            労働基準監督署コード
                   IF     (SPA-GMN2D-SYOCD     =   SPACE )
                     AND  (SPA-ERRCD           =   SPACE )
                       IF      SPA-NAI2D-KEIFLG2   =   ZERO
                           MOVE    1               TO  SPA-NAI2D-KEIFLG2
                           MOVE    "K050"              TO  SPA-ERRCD
                           MOVE    30                  TO  SPA-GMN2D-CUR
                       END-IF
                   END-IF
      *        傷病
               WHEN    "2"
                   IF      SPA-GMN2D-KOHNUM2   =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       IF      SPA-NAI2D-KEIFLG    =   ZERO
                           MOVE    1               TO  SPA-NAI2D-KEIFLG
                           MOVE    "K023"              TO  SPA-ERRCD
                           MOVE    4                   TO  SPA-GMN2D-CUR
                       END-IF
                   END-IF
                   IF      SPA-GMN2D-SAIGAI        =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0027"              TO  SPA-ERRCD
                       MOVE    21                  TO  SPA-GMN2D-CUR
                   END-IF
      *            新継区分
                   IF     (SPA-GMN2D-SINKEI        =   SPACE )
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0005"              TO  SPA-ERRCD
                       MOVE    5                   TO  SPA-GMN2D-CUR
                   END-IF
      *            転帰事由
                   IF     (SPA-GMN2D-TENKI         =   SPACE )
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0006"              TO  SPA-ERRCD
                       MOVE    6                   TO  SPA-GMN2D-CUR
                   END-IF
                   IF      SPA-GMN2D-SHOBYOYMD     =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0025"              TO  SPA-ERRCD
                       MOVE    8                   TO  SPA-GMN2D-CUR
                   END-IF
                   IF      SPA-GMN2D-RYOSTYMD      =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0012"              TO  SPA-ERRCD
                       MOVE    9                   TO  SPA-GMN2D-CUR
                   END-IF
      *            労働基準監督署コード
                   IF     (SPA-GMN2D-SYOCD     =   SPACE )
                     AND  (SPA-ERRCD           =   SPACE )
                       IF      SPA-NAI2D-KEIFLG2   =   ZERO
                           MOVE    1               TO  SPA-NAI2D-KEIFLG2
                           MOVE    "K050"              TO  SPA-ERRCD
                           MOVE    30                  TO  SPA-GMN2D-CUR
                       END-IF
                   END-IF
               WHEN    "3"
                   IF      SPA-GMN2D-KOHNUM3   =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       IF      SPA-NAI2D-KEIFLG    =   ZERO
                           MOVE    1               TO  SPA-NAI2D-KEIFLG
                           MOVE    "K024"          TO  SPA-ERRCD
                           MOVE    16              TO  SPA-GMN2D-CUR
                       END-IF
                   END-IF
                   IF      SPA-GMN2D-SINSATUYMD    =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0019"              TO  SPA-ERRCD
                       MOVE    18                  TO  SPA-GMN2D-CUR
                   END-IF
      *        自賠責
               WHEN    "4"
      *            転帰事由
                   IF     (SPA-GMN2D-TENKI         =   SPACE )
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0006"              TO  SPA-ERRCD
                       MOVE    6                   TO  SPA-GMN2D-CUR
                   END-IF
                   IF      SPA-GMN2D-SHOBYOYMD     =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0025"              TO  SPA-ERRCD
                       MOVE    8                   TO  SPA-GMN2D-CUR
                   END-IF
                   IF      SPA-GMN2D-RYOSTYMD      =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0012"              TO  SPA-ERRCD
                       MOVE    9                   TO  SPA-GMN2D-CUR
                   END-IF
      *        公務災害
               WHEN    "5"
      *            転帰事由
                   IF     (SPA-GMN2D-TENKI         =   SPACE )
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0006"              TO  SPA-ERRCD
                       MOVE    6                   TO  SPA-GMN2D-CUR
                   END-IF
                   IF      SPA-GMN2D-SHOBYOYMD     =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0025"              TO  SPA-ERRCD
                       MOVE    8                   TO  SPA-GMN2D-CUR
                   END-IF
                   IF      SPA-GMN2D-RYOSTYMD      =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0012"              TO  SPA-ERRCD
                       MOVE    9                   TO  SPA-GMN2D-CUR
                   END-IF
      *        第三者行為
               WHEN    "6"
      *            転帰事由
                   IF     (SPA-GMN2D-TENKI         =   SPACE )
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0006"              TO  SPA-ERRCD
                       MOVE    6                   TO  SPA-GMN2D-CUR
                   END-IF
                   IF      SPA-GMN2D-SHOBYOYMD     =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0025"              TO  SPA-ERRCD
                       MOVE    8                   TO  SPA-GMN2D-CUR
                   END-IF
                   IF      SPA-GMN2D-RYOSTYMD      =   SPACE
                     AND  (SPA-ERRCD               =   SPACE )
                       MOVE    "0012"              TO  SPA-ERRCD
                       MOVE    9                   TO  SPA-GMN2D-CUR
                   END-IF
               WHEN    OTHER
                   MOVE    "0052"              TO  SPA-ERRCD
                   MOVE    1                   TO  SPA-GMN2D-CUR
           END-EVALUATE
      *
           .
       4109-TOUROKU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険期間重複チェック処理
      *****************************************************************
       49011-KANREN-HKN-CHECK-SEC    SECTION.
      *
      *？？    中身を修正してね？？
      *
      *
           .
       49011-KANREN-HKN-CHECK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    患者保険編集処理
      *****************************************************************
       49012-PTHKNINF-HEN-SEC         SECTION.
      *
           MOVE    ZERO                TO  SPA-NAI2D-KOHID
      *
           INITIALIZE                  SPA-GMN-HKN-AREA
      *    新規の時、保険ＩＤ計算
           IF      SPA-NAI2D-HKNID     =   ZERO
               ADD     1                   TO  SPA-PTNUM-HKNID
               MOVE    SPA-PTNUM-HKNID     TO  SPA-NAI-HKNID
               MOVE    SPA-PTNUM-HKNID     TO  SPA-NAI2D-HKNID
               MOVE    ZERO                TO  SPA-NAI-HKNSTR
           ELSE
      *        基本画面設定用
               PERFORM VARYING IDX-R       FROM    1   BY  1
                       UNTIL   IDX-R       >   SPA-PTHKN-MAX
                  IF      (SPA-PTHKN-HKNNUM (IDX-R)  =   "971"  OR
                                                         "973" )  AND
                          (SPA-PTHKN-SAKJOKBN(IDX-R) =   SPACE )
                     AND  (SPA-PTHKN-HKNID  (IDX-R)
                                               =   SPA-NAI2D-HKNID)
                      MOVE    IDX-R            TO  SPA-NAI-HKNSTR
                      MOVE    SPA-PTHKN-HKNID  (IDX-R)
                                               TO  SPA-NAI-HKNID
                   END-IF
               END-PERFORM
           END-IF
      *
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
               WHEN    "2"
               WHEN    "3"
               WHEN    "5"
                   MOVE    "971"               TO  SPA-GMN-HKNNUM
                   MOVE    "971"               TO  SPA-NAI2D-HKNNUM
               WHEN    "4"
                   MOVE    "973"               TO  SPA-GMN-HKNNUM
                   MOVE    "973"               TO  SPA-NAI2D-HKNNUM
           END-EVALUATE
      *
      *    適用期間
           IF      SPA-GMN2D-HKNKBN    =   "3" 
      *        アフターケア
      ******** MOVE    "0000000"         TO  SPA-GMN-HTEKSTYMD
      *        MOVE    ZERO              TO  SPA-NAI-HTEKSTYMD
      *        MOVE    "9999999"         TO  SPA-GMN-HTEKEDYMD
      *********MOVE    "99999999"        TO  SPA-NAI-HTEKEDYMD
               MOVE    SPA-GMN2D-SINSATUYMD
                                             TO  SPA-GMN-HTEKSTYMD
               MOVE    SPA-NAI2D-SINSATUYMD
                                             TO  SPA-NAI-HTEKSTYMD
               MOVE    SPA-GMN2D-SINSATUEND
                                             TO  SPA-GMN-HTEKEDYMD
               MOVE    SPA-NAI2D-SINSATUEND
                                             TO  SPA-NAI-HTEKEDYMD
           ELSE
      *        以外の時、療養開始年月日
               IF      SPA-GMN2D-RYOSTYMD    =   SPACE
                   MOVE    "0000000"         TO  SPA-GMN-HTEKSTYMD
                   MOVE    ZERO              TO  SPA-NAI-HTEKSTYMD
               ELSE
                   MOVE    SPA-GMN2D-RYOSTYMD
                                             TO  SPA-GMN-HTEKSTYMD
                   MOVE    SPA-NAI2D-RYOSTYMD
                                             TO  SPA-NAI-HTEKSTYMD
               END-IF
               IF      SPA-GMN2D-RYOEDYMD    =   SPACE
                   MOVE    "9999999"         TO  SPA-GMN-HTEKEDYMD
                   MOVE    "99999999"        TO  SPA-NAI-HTEKEDYMD
               ELSE
                   MOVE    SPA-GMN2D-RYOEDYMD
                                             TO  SPA-GMN-HTEKEDYMD
                   MOVE    SPA-NAI2D-RYOEDYMD
                                             TO  SPA-NAI-HTEKEDYMD
               END-IF
           END-IF
      *
      *    記号・番号へコメント等の編集
           MOVE    SPA-GMN2D-HKNKBNMEI   TO  SPA-GMN-KIGO
           MOVE    SPA-GMN2D-COMMENT     TO  SPA-GMN-NUM
      *
           .
       49012-PTHKNINF-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災保険編集処理
      *****************************************************************
       4905-PTRSIINF-HEN-SEC         SECTION.
      *
      *    患者保険処理
      *
           INITIALIZE                      PTRSIINF-REC
      *
           MOVE    SPA-HOSPNUM         TO  PTRSI-HOSPNUM
           MOVE    SPA-GMN-PTID        TO  PTRSI-PTID
           MOVE    SPA-GMN2D-HKNKBN    TO  PTRSI-HKNKBN
           MOVE    SPA-NAI2D-HKNNUM    TO  PTRSI-HKNNUM
           MOVE    SPA-NAI2D-HKNID     TO  PTRSI-HKNID
           MOVE    SPA-NAI2D-KOHID     TO  PTRSI-KOHID
      *
      *    患者交付番号
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
                   MOVE    SPA-GMN2D-KOHNUM1   TO  PTRSI-KOFUNUM
               WHEN    "2"
                   MOVE    SPA-GMN2D-KOHNUM2   TO  PTRSI-KOFUNUM
               WHEN    "3"
                   MOVE    SPA-GMN2D-KOHNUM3   TO  PTRSI-KOFUNUM
           END-EVALUATE
      *
      *    自賠責患者請求区分
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "4"
                   MOVE    SPA-GMN2D-JIBAISEIKBN
                                               TO  PTRSI-JIBAISEIKBN
      *H29.5
                   MOVE    SPA-GMN2D-JIBAIKBN  TO  PTRSI-JIBAIKBN
      *
      *    自賠責担当医
                   IF      SPA-GMN2D-DRCD      =   SPACE
                       MOVE    SPACE               TO  PTRSI-DRCD
                   ELSE
                       MOVE    "1"                 TO  PTRSI-DRCD(1:1)
                       MOVE    SPA-GMN2D-DRCD      TO  PTRSI-DRCD(2:4)
                   END-IF
      *    自賠責保険会社名
                   MOVE    SPA-GMN2D-HOKENNAME TO  PTRSI-HOKENNAME
               WHEN    "5"
      *    公務災害
                   MOVE    SPA-GMN2D-JIBAISEIKBN
                                               TO  PTRSI-JIBAISEIKBN
      *            担当医
                   IF      SPA-GMN2D-DRCD      =   SPACE
                       MOVE    SPACE               TO  PTRSI-DRCD
                   ELSE
                       MOVE    "1"                 TO  PTRSI-DRCD(1:1)
                       MOVE    SPA-GMN2D-DRCD      TO  PTRSI-DRCD(2:4)
                   END-IF
      *
               WHEN    "6"
      *    第三者行為
                   MOVE    SPA-GMN2D-JIBAISEIKBN
                                               TO  PTRSI-JIBAISEIKBN
                   IF      SPA-GMN2D-DRCD      =   SPACE
                       MOVE    SPACE               TO  PTRSI-DRCD
                   ELSE
                       MOVE    "1"                 TO  PTRSI-DRCD(1:1)
                       MOVE    SPA-GMN2D-DRCD      TO  PTRSI-DRCD(2:4)
                   END-IF
      *            自賠責保険会社名
                   MOVE    SPA-GMN2D-HOKENNAME TO  PTRSI-HOKENNAME
      *H26.10
                   MOVE    SPA-GMN2D-D3-GENBTKBN
                                               TO  PTRSI-DAISAN-GENBTKBN
                   MOVE    SPA-GMN2D-D3-TOKKIKBN
                                               TO  PTRSI-DAISAN-TOKKIKBN
           END-EVALUATE
      *
           MOVE    SPA-GMN2D-HIHKNJANAME
                                       TO  PTRSI-HIHKNJANAME
           MOVE    SPA-GMN2D-COMMENT   TO  PTRSI-COMMENT
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
      *        短期のみ
      *            事業所名称
                   MOVE    SPA-GMN2D-JIGYOUNAME
                                               TO  PTRSI-JIGYOUNAME
                   MOVE    SPA-GMN2D-PREFNAME  TO  PTRSI-PREFNAME
                   MOVE    SPA-GMN2D-PREFKBN   TO  PTRSI-PREFKBN
                   MOVE    SPA-GMN2D-CITYNAME  TO  PTRSI-CITYNAME
                   MOVE    SPA-GMN2D-CITYKBN   TO  PTRSI-CITYKBN
           END-EVALUATE
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
               WHEN    "2"
      *        短期・傷病
                   MOVE    SPA-GMN2D-SINKEI    TO  PTRSI-SINKEI
      *            災害区分
                   MOVE    SPA-GMN2D-SAIGAI    TO  PTRSI-SAIGAIKBN
      *
           END-EVALUATE
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
               WHEN    "2"
               WHEN    "4"
               WHEN    "5"
      *        短期・傷病・自賠責・公務災害
                   MOVE    SPA-GMN2D-TENKI     TO  PTRSI-TENKI
                   MOVE    SPA-NAI2D-SHOBYOYMD TO  PTRSI-SHOBYOYMD
                   MOVE    SPA-GMN2D-SISIKBN   TO  PTRSI-SISIKBN
                   MOVE    SPA-NAI2D-RYOSTYMD  TO  PTRSI-RYOSTYMD
                   MOVE    SPA-NAI2D-RYOEDYMD  TO  PTRSI-RYOEDYMD
               WHEN    "6"
      *        第三者行為
                   MOVE    SPA-GMN2D-TENKI     TO  PTRSI-TENKI
                   MOVE    SPA-NAI2D-SHOBYOYMD TO  PTRSI-SHOBYOYMD
                   MOVE    SPA-NAI2D-RYOSTYMD  TO  PTRSI-RYOSTYMD
                   MOVE    SPA-NAI2D-RYOEDYMD  TO  PTRSI-RYOEDYMD
           END-EVALUATE
           EVALUATE    SPA-GMN2D-HKNKBN
      *        アフターケア
               WHEN    "3"
                   MOVE    SPA-GMN2D-SONSHOUKBN
                                               TO  PTRSI-SONSHOUKBN
                   MOVE    SPA-GMN2D-SONSHOUKBNEDA
                                           TO  PTRSI-SONSHOUKBN-EDANUM
                   MOVE    SPA-NAI2D-SINSATUYMD
                                               TO  PTRSI-SINSATUYMD
                   MOVE    SPA-NAI2D-SINSATUEND
                                               TO  PTRSI-SINSATUEND
           END-EVALUATE
      *    労災レセ回数記載
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
               WHEN    "2"
      *        短期・傷病
                   MOVE    SPA-NAI2D-KIJYUNYM  TO  PTRSI-KIJYUNYM
                   MOVE    SPA-GMN2D-KAISU     TO  PTRSI-KAISU
                   MOVE    SPA-GMN2D-SYOCD     TO  PTRSI-SYOCD
           END-EVALUATE
      *    確認年月日
           MOVE    SPA-NAI2D-KAKUNINYMD
                                       TO  PTRSI-KAKUNINYMD
      *
      *****MOVE    PTRSIINF-REC        TO  RSPAR-REC
      *
      *
           IF      SPA-NAI2D-RSHKN-EDANUM  =   ZERO
               ADD     1                   TO  SPA-P02-RSHKNMAX
               MOVE    SPA-P02-RSHKNMAX    TO  SPA-NAI2D-RSHKN-EDANUM
           END-IF
      *
           MOVE    SPA-NAI2D-RSHKN-EDANUM  TO  SPA-NAI-RSHKN-EDANUM
      *
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
      *APIV3
           IF      WRK-PARA-GYOUMUID   NOT =   SPACE
               MOVE    WRK-PARA-GYOUMUID   TO  PARA-GYOUMUID
           END-IF
      *
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "PTRSIINF"          TO  PARA-FILEMEI
           MOVE    SPA-NAI2D-RSHKN-EDANUM
                                       TO  PARA-EDANUM
      *
           MOVE    SPA-HOSPNUM         TO  PARA-HOSPNUM
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_para"          TO  MCP-TABLE
               MOVE    "key4"              TO  MCP-PATHNAME
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
           MOVE    "tbl_para"          TO  MCP-TABLE
           MOVE    "key4"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           IF      FLG-PARA           =   1
      *        追加
               INITIALIZE                      PARA-REC
               MOVE    "P02"               TO  PARA-GYOUMUID
      *APIV3
               IF      WRK-PARA-GYOUMUID   NOT =   SPACE
                   MOVE    WRK-PARA-GYOUMUID   TO  PARA-GYOUMUID
               END-IF
               MOVE    SPA-TERMID          TO  PARA-TERMID
               MOVE    "PTRSIINF"          TO  PARA-FILEMEI
               MOVE    SPA-NAI2D-RSHKN-EDANUM
                                           TO  PARA-EDANUM
               MOVE    PTRSIINF-REC        TO  PARA-DATA-REC
      *
               MOVE    SPA-HOSPNUM         TO  PARA-HOSPNUM
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "tbl_para"          TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
grpsys         CALL    "ORCDBMAIN"         USING   MCPAREA
                                                   MCPDATA-REC
                                                   SPA-AREA
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P02D PARA INS ERR:"  MCP-RC
               END-IF
           ELSE
               MOVE    PTRSIINF-REC        TO  PARA-DATA-REC
      *
               MOVE    SPA-HOSPNUM         TO  PARA-HOSPNUM
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "tbl_para"          TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
grpsys         CALL    "ORCDBMAIN"         USING   MCPAREA
                                                   MCPDATA-REC
                                                   SPA-AREA
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P02D PARA UPD ERR:"  MCP-RC
               END-IF
           END-IF
      *
           .
       4905-PTRSIINF-HEN-EXT.
           EXIT.
      *
      *H25.7
      *****************************************************************
      *    患者公費編集処理
      *****************************************************************
       49013-PTKOHINF-HEN-SEC         SECTION.
      *
           MOVE    ZERO                TO  SPA-NAI2D-HKNID
           MOVE    "970"               TO  SPA-NAI2D-HKNNUM
      *
           IF      SPA-NAI2D-KOHID     =   ZERO
      *        新規
      *        公費の上限６０件以上になる時は、エラー
               IF      SPA-PTKOH-MAX       >=  TBL-MAX-KOH
                   MOVE    "0106"          TO  SPA-ERRCD
                   MOVE    91              TO  SPA-GMN2D-CUR
                   GO      TO   49013-PTKOHINF-HEN-EXT
               END-IF
      *
               ADD     1                   TO  SPA-PTNUM-KOHID
               MOVE    SPA-PTNUM-KOHID     TO  SPA-NAI2D-KOHID
               MOVE    ZERO                TO  SPA-NAI2D-KOHIDX
               MOVE    1                   TO  SPA-NAI2D-KOHIADD
           ELSE
               MOVE    ZERO                TO  SPA-NAI2D-KOHIADD
               MOVE    ZERO                TO  SPA-NAI2D-KOHIDX
      *        公費表示中
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL      (IDX         >   SPA-KOH-MAX )
                             OR   (SPA-NAI2D-KOHIDX    NOT =   ZERO)
                   IF      SPA-NAI-PTKOH-KOHID (IDX)
                                              =   SPA-NAI2D-KOHID
                       MOVE    IDX                 TO  SPA-NAI2D-KOHIDX
                   END-IF
               END-PERFORM
           END-IF
      *
           .
       49013-PTKOHINF-HEN-EXT.
           EXIT.
      *
      *H27.11
      *!APIV3
      *****************************************************************
      *    ＡＰＩ編集処理
      *****************************************************************
       4199-API-SYORI-SEC         SECTION.
      *
      *    API継続
           IF      SPA-RSIAPI-FLG      =   "1"
               MOVE    "AP12"             TO  WRK-PARA-GYOUMUID
               MOVE    1                  TO  SPA-NAI2D-RSHKN-EDANUM
           ELSE
      *
      *    労災保険情報
           MOVE    SPACE               TO  SPA-P02D-AREA
           INITIALIZE                      SPA-P02D-AREA
      *    コンボボクスの編集
           PERFORM 3002-COMBBOX-HEX-SEC
      *    労災内容編集
           MOVE    "AP12"             TO  WRK-PARA-GYOUMUID
           MOVE    1                  TO  SPA-NAI2D-RSHKN-EDANUM
           PERFORM 3001-RSHKN-SET-SEC
      *
      *    区分毎コンボボクス編集
           PERFORM 41012-SINKEI-SET-SEC
      *    コンボボクスの編集
           PERFORM 3003-COMBBOX-SET-SEC
      *
           END-IF
      *
      *    内容チェック
      *    基本チェックと別画面処理
           PERFORM 4102-KIHON-CHK-SEC
      *    登録時、必須入力チェック
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4109-TOUROKU-CHK-SEC
           END-IF
      *
      *
      *    患者保険処理
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-GMN2D-HKNKBN    =   "6"
      *            第三者行為
                   PERFORM 49013-PTKOHINF-HEN-SEC
               ELSE
                   PERFORM 49012-PTHKNINF-HEN-SEC
               END-IF
           END-IF
      *
      *    労災保険編集処理
           IF      SPA-ERRCD           =   SPACE
               PERFORM 4905-PTRSIINF-HEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  SPA-ERRMSG
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRMSG-SET-SEC
           END-IF
      *
           .
       4199-API-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "P02D"              TO  SPA-MOTOPG
           MOVE    "P02"               TO  SPA-SAKIPG
      *
           MOVE    SPACE               TO  LNK-KYOUTU
      *
           MOVE    "JOIN"              TO  MCP-PUTTYPE.
           MOVE    "P02"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           MOVE    ZERO                TO  SPA-FLG-END
           MOVE    "P02"               TO  SPA-P02-GAMEN
      *
           .
       210-BACK-EXT.
           EXIT.
      *****************************************************************
      *    西暦→和暦FORMAT日付編集
      *****************************************************************
       410112-SE-WAFORMAT-YMDEDIT-SEC  SECTION.
      *
           EVALUATE    WRK-SYMD
               WHEN    SPACE
                   MOVE    SPACE               TO  WRK-HENYMD
               WHEN    ZERO
                   MOVE    "0000000  "         TO  WRK-HENYMD
               WHEN    "99999999"
                   MOVE    "9999999  "         TO  WRK-HENYMD
               WHEN    OTHER
                   MOVE    SPACE               TO  STS-AREA-DAY
                   INITIALIZE                      STS-AREA-DAY
                   MOVE    SPACE               TO  LNK-DAY2-AREA
                   MOVE    "21"                TO  LNK-DAY2-IRAI
                   MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
                   CALL    "ORCSDAY"           USING
                                               STS-AREA-DAY
                                               LNK-DAY2-AREA
                   IF      STS-DAY-RC1             =   ZERO
                       MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMD
                   ELSE
                       MOVE    SPACE               TO  WRK-HENYMD
                   END-IF
           END-EVALUATE
           .
       410112-SE-WAFORMAT-YMDEDIT-EXT.
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
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "P02D"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
      *
      *    エラーメッセージ編集
           PERFORM 510-ERRMSG-SET-SEC
      *
           MOVE    SPACE               TO  PERR
           MOVE    SPA-ERRCD           TO  PERR-ERRCODE
           MOVE    SPA-ERRMSG          TO  PERR-ERRMSG
           MOVE    "B01"               TO  MCP-WIDGET
      *
           MOVE    "P02D"              TO  SPA-MOTOPG
           MOVE    "PERR"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "PERR"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ編集
      *****************************************************************
       510-ERRMSG-SET-SEC        SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "労災自賠保険区分が違います。"
                                               TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "被保険者名入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0003"
                   STRING  "労働保険番号は半角１４桁か１１桁で"
                           "入力して下さい。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0004"
                   MOVE    "年金証書番号は半角９桁で入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "新継再別入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "転帰事由入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "四肢特例区分入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "傷病年月日の暦日エラーです"
                                               TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "療養開始日の暦日エラーです"
                                               TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "療養終了日の暦日エラーです"
                                               TO  SPA-ERRMSG
               WHEN    "0011"
                   MOVE    "療養開始日＞療養終了日は入力できません"
                                               TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE    "療養開始日は必須入力です。入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0017"
                   MOVE    "療養開始日の暦日エラーです"
                                               TO  SPA-ERRMSG
               WHEN    "0019"
                   MOVE    "療養開始日は必須入力です。入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0020"
                   MOVE    "新規入力時、削除はできません"
                                               TO  SPA-ERRMSG
               WHEN    "0021"
                   MOVE    "労災自賠保険区分は変更できません"
                                               TO  SPA-ERRMSG
               WHEN    "K022"
                   MOVE    "警告！！労働保険番号が未入力です。"
                                               TO  SPA-ERRMSG
               WHEN    "K023"
                   MOVE    "警告！！年金証書番号が未入力です。"
                                               TO  SPA-ERRMSG
               WHEN    "K024"
                   MOVE    "警告！！健康管理手帳番号が未入力です。"
                                               TO  SPA-ERRMSG
               WHEN    "0025"
                   MOVE    "傷病年月日は必須入力です。入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0026"
                   MOVE    "災害区分入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0027"
                   MOVE    "災害区分は必須入力です。入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0028"
                   STRING  "健康管理手帳番号は半角１３桁か１０桁で"
                           "入力して下さい。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0029"
                   MOVE    "事業の名称は全角で入力して下さい。"
                                               TO  SPA-ERRMSG
               WHEN    "0030"
                   MOVE    "傷病年月日＞療養開始日は入力できません"
                                               TO  SPA-ERRMSG
               WHEN    "0031"
                   MOVE    "傷病の部位は全角で入力して下さい。"
                                               TO  SPA-ERRMSG
               WHEN    "0036"
                   MOVE    "郡市区は全角で入力して下さい。"
                                               TO  SPA-ERRMSG
               WHEN    "0032"
                   MOVE    "郡市区がありません。"
                                               TO  SPA-ERRMSG
               WHEN    "0033"
                   MOVE    "都道府県がありません。"
                                               TO  SPA-ERRMSG
               WHEN    "0034"
                   MOVE    "損傷区分がありません。"
                                               TO  SPA-ERRMSG
               WHEN    "0035"
                   MOVE    "自賠責請求区分がありません。"
                                               TO  SPA-ERRMSG
               WHEN    "0036"
                   MOVE    "自賠責担当医の診療科がありません。"
                                               TO  SPA-ERRMSG
               WHEN    "0037"
                   MOVE    "自賠責担当医コードがありません。"
                                               TO  SPA-ERRMSG
               WHEN    "0038"
                   MOVE    "自賠責保険会社名は全角で入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0040"
                   MOVE    "基準年月は必須入力です。入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0041"
                   MOVE    "基準年月の暦日エラーです"
                                               TO  SPA-ERRMSG
               WHEN    "0042"
                   MOVE    "療養開始日＞基準年月は入力できません"
                                               TO  SPA-ERRMSG
               WHEN    "0043"
                   MOVE    "回数は必須入力です。入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0044"
                   STRING  "公務災害は平成１８年４月からの"
                           "対応です。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0045"
                   STRING  "第三者行為は平成２５年４月からの"
                           "対応です。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "K049"
                   STRING  "警告！！"
                           "労働基準監督署コードが存在しません。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "K050"
                   STRING  "警告！"
      *H29.2               "労働基準監督署コードが未入力です。"
                                               DELIMITED  BY  SIZE
                           "管轄の労働基準監督署を確認し、該当する"
                           "労働基準監督署コードを入力して下さい"
                                               INTO  SPA-ERRMSG
                   END-STRING
      *H25.7 
               WHEN    "K052"
                   STRING  "警告！"
      *H29.2               "労働基準監督署コードで再入力して下さい。"
                           "管轄の労働基準監督署を確認し、該当する"
                           "労働基準監督署コードを入力して下さい"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0051"
                   STRING  "選択番号エラーです。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0052"
                   STRING  "労災・自賠責保険区分の設定がありません。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
      *H26.10
               WHEN    "0053"
                   STRING  "第三者行為　現物給付計算がありません"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0054"
                   STRING  "第三者行為　特記事項がありません"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
      *H29.5
               WHEN    "0055"
                   STRING  "自賠責点数算定区分がありません"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "0057"
                   STRING  "自賠責点数算定区分は療養開始日が"
                           "平成２９年７月１日以降で設定可能です。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
               WHEN    "K056"
                   STRING  "警告！"
                           "自賠責点数算定区分が変更されました。"
                           "登録済みの診療行為を確認して下さい。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
      *
               WHEN    "0106"
                   STRING   "公費の登録は６０件までです。"
                            "これ以上追加できません。"
                                               DELIMITED  BY  SIZE
                                               INTO  SPA-ERRMSG
                   END-STRING
           END-EVALUATE
           .
       510-ERRMSG-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ情報読み込み
      *****************************************************************
       990-PARA-READ-SEC        SECTION.
      *
           MOVE    "tbl_para"         TO  MCP-TABLE
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PARA-REC
               MOVE    ZERO            TO  FLG-PARA
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           .
       990-PARA-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    労働基準監督署マスタ読み込み
      *****************************************************************
       900-LABOR-SIO-READ-SEC        SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  LABOR-SIO-REC
               MOVE    ZERO            TO  FLG-LABOR-SIO
           ELSE
               INITIALIZE                  LABOR-SIO-REC
               MOVE    1               TO  FLG-LABOR-SIO
           END-IF
      *
           .
       900-LABOR-SIO-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-KANRIMST-READ-SEC         SECTION.
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-KANRIMST-READ-EXT.
           EXIT.
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
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
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
      *
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       990-DBCLOSE-SEC         SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       990-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *
