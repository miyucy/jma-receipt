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
       PROGRAM-ID.             ORCT0010.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 定期請求
      *  コンポーネント名  : 収納データ作成
      *  管理者            :
      *  作成日付    作業者        記述
      *  02/01/07    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-太田    03.04.02  負担金計算サブ引数修正
      *  01.00.02    NACL-太田    03.12.19  負担金計算サブ引数修正
      *                                     （日別収納マスタ）
      *  01.00.03    NACL-太田    04.03.03  患者請求履歴ファイルの編集
      *                                     をORCT0040に移す
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
      *
      *    定期請求収納ファイル(初期化用)
           SELECT  TEIKI01CL-FILE  ASSIGN   TEIKI01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  TEIKI01CL-KEY
                                   FILE    STATUS  IS  STS-TEIKI01CL.
      *
      *    定期請求収納ファイル(OT)
           SELECT  TEIKI01-FILE    ASSIGN   TEIKI01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  TEIKI01-KEY
                                   FILE    STATUS  IS  STS-TEIKI01.
      *
      *    定期請求期間情報ファイル(OT)
           SELECT  TEIKI03-FILE    ASSIGN  TEIKI03PARA
                   ORGANIZATION    LINE SEQUENTIAL
                                   FILE    STATUS  IS  STS-TEIKI03.
      *
      *    エラーファイル
           SELECT  TEIKIERR-FILE   ASSIGN  TEIKIERR
                                   FILE    STATUS  IS  STS-TEIKIERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
      *    定期請求収納ファイル（初期化用）
       FD  TEIKI01CL-FILE.
       01  TEIKI01CL-REC.
           COPY "CPTEIKI01.INC"    REPLACING   //TEIKI01-//
                                   BY          //TEIKI01CL-//.
      *
      *    定期請求収納ファイル
       FD  TEIKI01-FILE.
       01  TEIKI01-REC.
           COPY    "CPTEIKI01.INC".
      *
      *    定期請求期間情報
       FD  TEIKI03-FILE.
           COPY "CPTEIKI03.INC".
      *
      *    エラーファイル
       FD  TEIKIERR-FILE.
       01  TEIKIERR-REC                    PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    定期請求収納ファイル名称領域 
           COPY    "CPCOMMONDAT5.INC".
      *
      *    定期請求期間情報名称領域 
           COPY    "CPCOMMONDAT5.INC"      REPLACING  //TEIKI01//
                                           BY         //TEIKI03//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT5.INC"      REPLACING  //TEIKI01PARA//
                                           BY         //TEIKIERR//.
           03  FILLER                      PIC X(04)   VALUE   ".dat".
      *
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-TEIKIERR                PIC X(02).
           03  STS-TEIKI01                 PIC X(02).
           03  STS-TEIKI01CL               PIC X(02).
           03  STS-TEIKI03                 PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                     PIC 9(01).
           03  FLG-ERR                     PIC 9(01).
           03  FLG-PTNYUINRRK              PIC 9(01).
           03  FLG-PTNYUINRRK2             PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-SYS5012                 PIC 9(01).
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-ORCSDAY                 PIC 9(01).
           03  FLG-NYUINKA                 PIC 9(01).
           03  FLG-PTTEIKIRRK              PIC 9(01).
           03  FLG-GETUMATUSITEI           PIC 9(01).
           03  FLG-TAISYO                  PIC 9(01).
           03  FLG-PTNUM                   PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-OUT1                    PIC 9(06).
           03  CNT-OUT2                    PIC 9(06).
           03  CNT-OUT3                    PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDX1                        PIC 9(04). 
           03  IDX2                        PIC 9(04). 
           03  IDX3                        PIC 9(04). 
           03  IDX10                       PIC 9(04). 
           03  IDX11                       PIC 9(04). 
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-TEIKIERR                PIC X(200).
      *
           03  WRK-STYMD                   PIC X(08).
           03  WRK-EDYMD                   PIC X(08).
           03  WRK-KIKAN-TBL.
               05  WRK-KIKAN-MAX           PIC 9(04).
               05  WRK-KIKAN-OCC           OCCURS 3.
                   07  WRK-KIKANST         PIC X(08).
                   07  WRK-KIKANED         PIC X(08).
                   07  WRK-KIKANSAKKBN     PIC 9(01).
      *
           03  WRK-TEIKISTYMD              PIC X(08).
           03  WRK-TEIKIEDYMD              PIC X(08).
           03  WRK-TEIKISAKKBN             PIC X(01).
           03  WRK-TEIKIGETUMATU           PIC X(01).
      *
           03  WRK-YMD.
               05  WRK-YY                  PIC X(04).
               05  WRK-MM                  PIC X(02).
               05  WRK-DD                  PIC X(02).
           03  WRK-NISSU1                  PIC 9(05).
           03  WRK-NISSU2                  PIC 9(05).
           03  WRK-NYUINKA                 PIC X(02).
           03  WRK-BTUNUM                  PIC X(02).
           03  WRK-BRMNUM                  PIC X(08).
           03  WRK-DRCD                    PIC X(04).
           03  WRK-SEIKYUSTYMD             PIC X(08).
           03  WRK-SEIKYUEDYMD             PIC X(08).
           03  WRK-CNT                     PIC 9(05).
           03  WRK-SAKKBN                  PIC X(01).
           03  WRK-STR                     PIC X(200).
           03  WRK-LEN                     PIC 9(05).
           03  WRK-SHO                     PIC 9(05).
           03  WRK-AMARI                   PIC 9(05).
           03  WRK-KUGIRI                  PIC X(02).
           03  WRK-PTID                    PIC 9(10).
      *
       01  ERR-EDIT-AREA.
           03  ERR-PTID                    PIC 9(10).
           03  ERR-PTNUM                   PIC X(20).
           03  ERR-ERRMSG                  PIC X(80).
           03  ERR-HEN-ERRMSG              PIC X(80).
      *
       01  ERR-MES-AREA.
           03  ERR-MES01                   PIC X(100)    VALUE
               "入院履歴の取得に失敗しました".
           03  ERR-MES02                   PIC X(100)    VALUE
               "定期請求管理情報の取得に失敗しました".
           03  ERR-MES03                   PIC X(100)    VALUE
               "患者情報の取得に失敗しました".
           03  ERR-MES04                   PIC X(100)    VALUE
               "通算日数の取得に失敗しました".
           03  ERR-MES05                   PIC X(100)    VALUE
               "会計情報の取得に失敗しました".
           03  ERR-MES06                   PIC X(100)    VALUE
               "収納データの取得に失敗しました".
           03  ERR-MES07                   PIC X(100)    VALUE
               "入院履歴の取得に失敗しました".
           03  ERR-MES08                   PIC X(100)    VALUE
               "定期期間の取得に失敗しました".
           03  ERR-MES09                   PIC X(100)    VALUE
               "処理対象のデータがありませんでした".
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
      *
      *    定期請求一括処理パラメータ
           COPY    "CPTEIKI1PARA.INC".
      *
      *    ワーク患者入院履歴
       01  WKPTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC"  REPLACING   //PTNYUINRRK-//
                                       BY          //WKPTNYUINRR-//.
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
      *    請求管理
           COPY    "CPSK5010.INC".
      *    定期請求作成指示コード
           COPY    "CPSK5011.INC".
      *    定期請求作成指示（個別指示）コード
           COPY    "CPSK5012.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    日別収納マスタ
       01  SYUDAY-REC.
           COPY    "CPSYUDAY.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    患者定期請求履歴
       01  PTTEIKIRRK-REC.
           COPY    "CPPTTEIKIRRK.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *    同日入院チェックサブ
           COPY    "CPORCSDNTCHK.INC".
      *
       01  LNKNRRK-REC.
           COPY    "CPPTNYUINRRK.INC"  REPLACING  //PTNYUINRRK-// 
                                       BY         //LNKNRRK-//.
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    定期請求用収納作成サブ
       01  LNK-ORCS02-REC.
           COPY  "CPORCS02.INC".
       01  LNK-SYUNOU-REC-T.
         02 LNK-SYUNOU-REC     OCCURS 10.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //LNK-SYU-//.
       01  LNK-SYUDAY-REC-T.
         02 LNK-SYUDAY-REC     OCCURS 10.
           COPY  "CPSYUDAY.INC"  REPLACING  //SDAY-// BY //LNK-SDAY-//.
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
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
           INITIALIZE                  INDEX-AREA
                                       CNT-AREA
                                       WRK-AREA
                                       SPA-AREA
                                       TEIKI1PARA-AREA
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    TEIKI1P-ARG1
                                               TEIKI1P-SYOKBN
                                               TEIKI1P-KIKAN-OCC (1)
                                               TEIKI1P-KIKAN-OCC (2)
                                               TEIKI1P-KIKAN-OCC (3)
                                               TEIKI1P-JOBID
                                               TEIKI1P-SHELLID
                                               TEIKI1P-HOSPID
                                               TEIKI1P-ERRFILE
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    TEIKI1P-JOBID   TO  JOB-JOBID
           MOVE    TEIKI1P-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCT0010"      TO  JOB-PGID
           MOVE    "収納データ作成"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA
                                   JOBKANRI-REC
      *
           MOVE    ZERO            TO  FLG-END
                                       FLG-ERR
      *
           MOVE    "TEIKI001"      TO  TEIKI01PARA-FILE-ID
           MOVE    TEIKI1P-TERMID  TO  TEIKI01PARA-TERMID
      *
           MOVE    "TEIKI003"      TO  TEIKI03PARA-FILE-ID
           MOVE    TEIKI1P-TERMID  TO  TEIKI03PARA-TERMID
      *
           MOVE    TEIKI1P-ERRFILE TO  TEIKIERR
      *
      *    定期請求収納ファイル初期化
           OPEN    OUTPUT              TEIKI01CL-FILE
           CLOSE   TEIKI01CL-FILE
      *
           OPEN    OUTPUT              TEIKI01-FILE
           OPEN    OUTPUT              TEIKI03-FILE
      *
      *    定期請求管理情報
           INITIALIZE                  SYS-5010-REC
           MOVE    "5010"          TO  SYS-5010-KANRICD
           MOVE    "*"             TO  SYS-5010-KBNCD
           MOVE    TEIKI1P-SYSYMD  TO  ORC-DBYMD
           MOVE    SYS-5010-REC    TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY-SEL-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC TO  SYS-5010-REC
           ELSE
               MOVE    ERR-MES02   TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                    SECTION.
      *
           EVALUATE    TEIKI1P-SYOKBN
           WHEN    "1"
               PERFORM 2001-IKKATU-SYORI-SEC
           WHEN    "2"
               PERFORM 2002-KOBETU-SYORI-SEC
           END-EVALUATE
      *
           MOVE    1               TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    一括処理
      *****************************************************************
       2001-IKKATU-SYORI-SEC           SECTION.
      *
           INITIALIZE    WRK-KIKAN-TBL
           MOVE    ZERO            TO  WRK-CNT
           PERFORM VARYING IDX10   FROM    1   BY  1
                   UNTIL ( IDX10   >   3 )
               IF    ( TEIKI1P-KIKAN-KBN (IDX10)  =   "1" )
      *
                   COMPUTE WRK-CNT =   WRK-CNT +   1
                   MOVE    WRK-CNT TO  WRK-KIKAN-MAX
      *
                   MOVE    TEIKI1P-KIKAN-ST (IDX10)
                                   TO  WRK-KIKANST (WRK-CNT)
                   MOVE    TEIKI1P-KIKAN-ED (IDX10)
                                   TO  WRK-KIKANED (WRK-CNT)
                   MOVE    IDX10   TO  WRK-KIKANSAKKBN (WRK-CNT)
               END-IF
      *
           END-PERFORM
      *
           PERFORM VARYING IDX10   FROM    1   BY  1
                   UNTIL ( IDX10   >   WRK-KIKAN-MAX )
      *
               MOVE    WRK-KIKANST (IDX10)
                                   TO  WRK-TEIKISTYMD
               MOVE    WRK-KIKANED (IDX10)
                                   TO  WRK-TEIKIEDYMD
               MOVE    WRK-KIKANSAKKBN (IDX10)
                                   TO  WRK-TEIKISAKKBN
      *
      *        一括処理（メイン）
               PERFORM 20011-IKKATU-SYORI-MAIN-SEC
      *
           END-PERFORM
           .
       2001-IKKATU-SYORI-EXT.
           EXIT. 
      *
      *****************************************************************
      *    一括処理（メイン）
      *****************************************************************
       20011-IKKATU-SYORI-MAIN-SEC     SECTION.
      *
      *    入院履歴読み込み
           MOVE    ZERO            TO  FLG-PTNYUINRRK
           INITIALIZE                  PTNYUINRRK-REC
           MOVE    TEIKI1P-HOSPID  TO  PTNYUINRRK-HOSPID
           MOVE    WRK-TEIKIEDYMD  TO  PTNYUINRRK-NYUINYMD
           MOVE    WRK-TEIKIEDYMD  TO  PTNYUINRRK-TAIINYMD
           MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY14"  TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  PTNYUINRRK-REC
           ELSE
               INITIALIZE              PTNYUINRRK-REC
               MOVE    1           TO  FLG-PTNYUINRRK
           END-IF
      *
           PERFORM UNTIL ( FLG-PTNYUINRRK  =   1 )
      *
      *        歴番号の最新の入院歴に読み直す
               PERFORM 900-PTNYUINRRK-KEY4-SEL-SEC
               IF    ( FLG-PTNYUINRRK2     NOT =   ZERO )
                   MOVE    PTNYUINRRK-PTID TO  ERR-PTID
                   MOVE    ERR-MES01       TO  ERR-ERRMSG
                   PERFORM 800-ERRMSG-EDIT-SEC
               END-IF
      *
      *        処理対象チェック処理
               PERFORM 20011-TAISYO-CHK-SEC
               IF    ( FLG-TAISYO  =   1 )
                   PERFORM 800-ORCSDNTCHK-SEC
                   IF    ( SDNTCHK-STYMD   NOT =   ZERO )
                       PERFORM 20011-HENSYU-SEC
                   END-IF
               END-IF
      *
               MOVE    "PTNYUINRRK-KEY14"  TO  ORC-DBPATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  PTNYUINRRK-REC
               ELSE
                   INITIALIZE              PTNYUINRRK-REC
                   MOVE    1           TO  FLG-PTNYUINRRK
               END-IF
      *
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    "PTNYUINRRK-KEY14"  TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       20011-IKKATU-SYORI-MAIN-EXT.
           EXIT. 
      *****************************************************************
      *   処理対象チェック処理
      *****************************************************************
       20011-TAISYO-CHK-SEC            SECTION.
      *
           MOVE    ZERO            TO  FLG-TAISYO
           MOVE    SPACE           TO  WRK-SAKKBN
           MOVE    ZERO            TO  FLG-GETUMATUSITEI
      *
      *    既に退院している患者は対象外とする
           IF    ( PTNYUINRRK-TAIINYMD
                               NOT =   "99999999" )
               GO  TO  20011-TAISYO-CHK-EXT
           END-IF
      *
      *    患者定期請求履歴読み込み処理
           PERFORM 900-PTTEIKIRRK-KEY2-SEL-SEC
           IF    ( FLG-PTTEIKIRRK  =   ZERO )
               IF    ( PTTEIKIRRK-SAKKBN   =   "9" )
                   MOVE    1       TO  FLG-GETUMATUSITEI
               END-IF
           END-IF
      *
           IF    ( PTNYUINRRK-TEIKI-SEIKYUKBN
                                           =   "2" )
               MOVE    1           TO  FLG-GETUMATUSITEI
           END-IF
      *
           IF    ( FLG-GETUMATUSITEI       =   1 )
      *
      *        今回処理が月末日を含む場合は処理対象とする
               MOVE    TEIKI1P-SRYYM  TO  WRK-YMD
               PERFORM 20021-GETUMATU-GET-SEC
               IF    ( WRK-YMD             =   WRK-TEIKIEDYMD )
                   MOVE    1           TO  FLG-TAISYO
               END-IF
           ELSE
               MOVE    1               TO  FLG-TAISYO
           END-IF
      *
           IF    ( FLG-TAISYO              =   ZERO )
               GO  TO  20011-TAISYO-CHK-EXT
           END-IF
      *
           IF    ( FLG-GETUMATUSITEI       =   ZERO )
               MOVE    WRK-TEIKISAKKBN TO  WRK-SAKKBN
           ELSE
               MOVE    "9"             TO  WRK-SAKKBN
           END-IF
      *
           .
       20011-TAISYO-CHK-EXT.
           EXIT. 
      *****************************************************************
      *   編集処理
      *****************************************************************
       20011-HENSYU-SEC                SECTION.
      *
      *    患者情報読み込み
           MOVE    TEIKI1P-HOSPID      TO  PTINF-HOSPID
           MOVE    PTNYUINRRK-PTID     TO  PTINF-PTID
           PERFORM 900-PTINF-KEY-SEL-SEC
           IF    ( FLG-PTINF       NOT =   ZERO )
               MOVE    PTNYUINRRK-PTID TO  ERR-PTID
               MOVE    ERR-MES03       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
           END-IF
      *
      *    テスト患者のときは読み飛ばす
           IF    ( PTINF-TSTPTNUMKBN   =   "1" )
               GO  TO  20011-HENSYU-EXT
           END-IF
      *
      *    収納データ取得処理
           PERFORM 20011-SYUNOU-GET-SEC
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >    10 )
                   OR    ( LNK-SYU-SKYSTYMD (IDX1) =   SPACE )
      *
      *        収納データを定期収納ファイルに出力
               PERFORM 20011-TEIKI01-OUTPUT-SEC
      *
           END-PERFORM
      *
      *    患者請求期間情報を患者請求期間情報ファイルに出力
           PERFORM 20011-TEIKI03-OUTPUT-SEC
      *
           .
       20011-HENSYU-EXT.
           EXIT. 
      *
      *****************************************************************
      *    収納データ取得処理
      *****************************************************************
       20011-SYUNOU-GET-SEC            SECTION.
      *
      * ----   請求開始日を取得 -----
           MOVE    SPACE           TO  WRK-SEIKYUSTYMD
           IF    ( WRK-SAKKBN      =   "9" )
               IF    ( TEIKI1P-SYOKBN =   "1" )
                   MOVE    TEIKI1P-SRYYM (1 : 6)
                                   TO  WRK-YMD (1 : 6)
                   MOVE    "01"    TO  WRK-YMD (7 : 2)
               ELSE
                   MOVE    SYS-5012-SRYYM
                                   TO  WRK-YMD (1 : 6)
                   MOVE    "01"    TO  WRK-YMD (7 : 2)
               END-IF
           ELSE
               MOVE    WRK-TEIKISTYMD
                                   TO  WRK-YMD
           END-IF
      *
      *
           IF  ( SDNTCHK-STYMD     >   WRK-YMD )
               MOVE    SDNTCHK-STYMD
                                   TO  WRK-SEIKYUSTYMD
           ELSE
               MOVE    WRK-YMD     TO  WRK-SEIKYUSTYMD
           END-IF
      * ------------------------------
           MOVE    WRK-TEIKIEDYMD  TO  WRK-SEIKYUEDYMD
      *
      *    通算日数を求める
           MOVE    PTNYUINRRK-NYUINYMD
                                   TO  WRK-STYMD
      *    請求開始日を設定
           MOVE    WRK-SEIKYUSTYMD
                                   TO  WRK-EDYMD
           PERFORM 800-KIKAN-CALC-SEC
           IF    ( FLG-ORCSDAY     NOT =   ZERO )
               MOVE    PTNYUINRRK-PTID TO  ERR-PTID
               MOVE    ERR-MES04       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
           END-IF
      *
           MOVE    SPACE           TO  LNK-ORCS02-REC
                                       LNK-SYUNOU-REC-T
                                       LNK-SYUDAY-REC-T
      *
           INITIALIZE                  LNK-ORCS02-REC
                                       LNK-SYUNOU-REC-T
                                       LNK-SYUDAY-REC-T
      *
           MOVE    TEIKI1P-HOSPID  TO  LNK-S02-HOSPID
           MOVE    "1"             TO  LNK-S02-NYUGAIKBN
           MOVE    PTNYUINRRK-PTID TO  LNK-S02-PTID
           MOVE    WRK-NISSU1      TO  LNK-S02-NYUIN-TSUSAN-NISSU
      *    請求開始日を設定
           MOVE    WRK-SEIKYUSTYMD
                                   TO  LNK-S02-SKYSTYMD
           MOVE    WRK-SEIKYUEDYMD
                                   TO  LNK-S02-SKYEDYMD
           MOVE    "A"             TO  LNK-S02-TEIKI-KBN
           MOVE    TEIKI1P-SYSYMD TO  LNK-S02-SYSYMD
           MOVE    "2"             TO  LNK-S02-SYORI-KBN
           CALL    "ORCSNYUFTN"    USING
                                   SPA-AREA
                                   LNK-ORCS02-REC
                                   LNK-SYUNOU-REC-T
                                   LNK-SYUDAY-REC-T
           IF    ( LNK-S02-RC      NOT = ZERO )
               MOVE    PTNYUINRRK-PTID TO  ERR-PTID
               EVALUATE LNK-S02-RC
               WHEN    13
                   MOVE    ERR-MES05   TO  ERR-ERRMSG
               WHEN    OTHER
                   MOVE    ERR-MES06   TO  ERR-ERRMSG
               END-EVALUATE
               PERFORM 800-ERRMSG-EDIT-SEC
           END-IF
      *
           PERFORM VARYING IDX1   FROM    1   BY  1
                   UNTIL ( IDX1   >   10 )
      *
               DISPLAY "LNK-SYU-SKYMONEY (" IDX1 " ) = "
                        LNK-SYU-SKYMONEY ( IDX1 )
      *
           END-PERFORM
      *
           .
       20011-SYUNOU-GET-EXT.
           EXIT. 
      *****************************************************************
      *    定期収納ファイル出力処理
      *****************************************************************
       20011-TEIKI01-OUTPUT-SEC      SECTION.
      *
           INITIALIZE                  TEIKI01-REC
      *
      *    収納情報編集処理
           PERFORM 20011-TEIKI01-SYUNOU-HEN-SEC
      *
      *    日別収納情報編集処理
           PERFORM 20011-TEIKI01-SYUDAY-HEN-SEC
      *
           MOVE    SYU-HOSPID          TO  TEIKI01-HOSPID
           MOVE    SYU-PTID            TO  TEIKI01-PTID
           MOVE    WRK-SAKKBN          TO  TEIKI01-SAKKBN
           MOVE    WRK-SEIKYUSTYMD     TO  TEIKI01-SKYSTYMD
           MOVE    WRK-SEIKYUEDYMD     TO  TEIKI01-SKYEDYMD
           MOVE    SYU-HKNCOMBINUM     TO  TEIKI01-HKNCOMBINUM
      *
           WRITE   TEIKI01-REC
      *
           COMPUTE CNT-OUT1    =   CNT-OUT1    +   1
      *
           .
       20011-TEIKI01-OUTPUT-EXT.
           EXIT. 
      *****************************************************************
      *    収納情報編集処理
      *****************************************************************
       20011-TEIKI01-SYUNOU-HEN-SEC    SECTION.
      *
           MOVE    LNK-SYUNOU-REC (IDX1)
                                       TO  SYUNOU-REC
      *
           MOVE    WRK-SEIKYUSTYMD     TO  SYU-SKYSTYMD
           MOVE    WRK-SEIKYUEDYMD     TO  SYU-SKYEDYMD
      *
           MOVE    PTNYUINRRK-REC      TO  WKPTNYUINRRK-REC
      *    請求時最終履歴取得処理
           PERFORM 20011-SEILASTRRK-SET-SEC
           MOVE    WKPTNYUINRRK-REC    TO  PTNYUINRRK-REC
      *
           MOVE    WRK-NYUINKA         TO  SYU-SRYKA
           MOVE    WRK-BRMNUM          TO  SYU-ROOMNUM
           MOVE    WRK-BTUNUM          TO  SYU-BYOTONUM
           MOVE    WRK-DRCD            TO  SYU-DRCD
      *
           IF    ( SYS-5010-NYUKINKBN  =   "2" )
      *
               MOVE    SYU-SKYMONEY    TO  SYU-NYUKIN-TOTAL
           END-IF
      *
           IF    ( SYU-NYUKIN-TOTAL    >   ZERO )
               MOVE    1               TO  SYU-NYUKIN-KAISU
           END-IF
      *
           IF    ( SYU-SKYMONEY        =   ZERO )
               MOVE    SPACE           TO  SYU-DENPJTIKBN
           ELSE
               IF    ( SYU-SKYMONEY   <=  SYU-NYUKIN-TOTAL )
                   MOVE    "1"         TO  SYU-DENPJTIKBN
               ELSE
                   MOVE    "2"         TO  SYU-DENPJTIKBN
               END-IF
           END-IF
      *
           MOVE    PTNYUINRRK-RRKNUM   TO  SYU-NYUIN-RRKNUM
      *
           MOVE    TEIKI1P-TERMID      TO  SYU-TERMID
      *
           MOVE    SYUNOU-REC          TO  TEIKI01-SYU-DAT
      *
           .
       20011-TEIKI01-SYUNOU-HEN-EXT.
           EXIT. 
      *****************************************************************
      *    日別収納情報編集処理
      *****************************************************************
       20011-TEIKI01-SYUDAY-HEN-SEC    SECTION.
      *
           MOVE    LNK-SYUDAY-REC (IDX1)
                                       TO  SYUDAY-REC
      *
           MOVE    TEIKI1P-TERMID      TO  SDAY-TERMID
      *
           IF    ( SDAY-DAYINFFLG      =   "1" )
               MOVE    1               TO  TEIKI01-SYUDAY-EXIST-FLG
               MOVE    SYUDAY-REC      TO  TEIKI01-SYUDAY-DAT
           ELSE
               MOVE    ZERO            TO  TEIKI01-SYUDAY-EXIST-FLG
               MOVE    SPACE           TO  TEIKI01-SYUDAY-DAT
           END-IF
      *
           .
       20011-TEIKI01-SYUDAY-HEN-EXT.
           EXIT. 
      *****************************************************************
      *    患者請求期間情報ファイル出力処理
      *****************************************************************
       20011-TEIKI03-OUTPUT-SEC        SECTION.
      *
           INITIALIZE                  TEIKI03-REC
           MOVE    PTNYUINRRK-HOSPID   TO  TEIKI03-HOSPID
           MOVE    PTNYUINRRK-PTID     TO  TEIKI03-PTID
           MOVE    WRK-SEIKYUSTYMD     TO  TEIKI03-SKYSTYMD
           MOVE    WRK-SEIKYUEDYMD     TO  TEIKI03-SKYEDYMD
      *
           WRITE   TEIKI03-REC
      *
           COMPUTE CNT-OUT3    =   CNT-OUT3    +   1
      *
           .
       20011-TEIKI03-OUTPUT-EXT.
           EXIT. 
      *****************************************************************
      *    請求時最終履歴取得処理
      *****************************************************************
       20011-SEILASTRRK-SET-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-NYUINKA
           MOVE    SPACE               TO  WRK-NYUINKA
                                           WRK-BTUNUM
                                           WRK-BRMNUM
                                           WRK-DRCD
      *
      *    入院履歴マスタ検索
           MOVE    ZERO                TO  FLG-PTNYUINRRK2
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY4"   TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               INITIALIZE                  PTNYUINRRK-REC
               MOVE    1               TO  FLG-PTNYUINRRK2
           END-IF
      *
           PERFORM UNTIL ( FLG-PTNYUINRRK2 NOT =   ZERO )
                    OR   ( FLG-NYUINKA =   1 )
      *
               IF    ( PTNYUINRRK-TENNYUYMD
                                       <=  SYU-SKYEDYMD )
                AND  ( PTNYUINRRK-TENSTUYMD
                                       >=  SYU-SKYEDYMD )
                   MOVE    1           TO  FLG-NYUINKA
                   MOVE    PTNYUINRRK-NYUINKA
                                       TO  WRK-NYUINKA
                   MOVE    PTNYUINRRK-BTUNUM
                                       TO  WRK-BTUNUM
                   MOVE    PTNYUINRRK-BRMNUM
                                       TO  WRK-BRMNUM
                   MOVE    PTNYUINRRK-DRCD1 (2 : 4)
                                       TO  WRK-DRCD
               END-IF
      *
               MOVE    "PTNYUINRRK-KEY4"   TO  ORC-DBPATH
               PERFORM 910-DBFETCH-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
               ELSE
                   INITIALIZE                  PTNYUINRRK-REC
                   MOVE    1               TO  FLG-PTNYUINRRK2
               END-IF
      *
           END-PERFORM
      *
           MOVE    "PTNYUINRRK-KEY4"   TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           IF    ( FLG-NYUINKA         =   ZERO )
               MOVE    PTNYUINRRK-PTID TO  ERR-PTID
               MOVE    ERR-MES07       TO  ERR-ERRMSG
               PERFORM 800-ERRMSG-EDIT-SEC
           END-IF
      *
           .
       20011-SEILASTRRK-SET-EXT.
           EXIT.
      *****************************************************************
      *    個別処理
      *****************************************************************
       2002-KOBETU-SYORI-SEC               SECTION.
      *
           MOVE    ZERO                TO  FLG-SYS5012
      *
      *    定期請求指示（個別指示）コード読み込み
           INITIALIZE                      SYS-5012-REC
           MOVE    "5012"              TO  SYS-5012-KANRICD
           MOVE    ZERO                TO  ORC-DBYMD
           MOVE    SYS-5012-REC        TO  MCPDATA-REC
           MOVE    "SYSKANRI-KEY7"     TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-5012-REC
           ELSE
               MOVE    1               TO  FLG-SYS5012
           END-IF
      *
           PERFORM UNTIL ( FLG-SYS5012     =   1 )
      *
               PERFORM 20021-KOBETU-HENSYU-SEC
      *
           END-PERFORM
      *
      *    カーソルクロース
           MOVE    "SYSKANRI-KEY7"     TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
           .
      *
       2002-KOBETU-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    個別編集処理
      *****************************************************************
       20021-KOBETU-HENSYU-SEC              SECTION.
      *
      *    請求期間取得処理
           PERFORM 20021-SEIKYU-KIKAN-GET-SEC
      *
           PERFORM VARYING IDX10   FROM    1   BY  1
                   UNTIL ( IDX10   >   WRK-KIKAN-MAX )
      *
               MOVE    WRK-KIKANST (IDX10)
                                       TO  WRK-TEIKISTYMD
               MOVE    WRK-KIKANED (IDX10)
                                       TO  WRK-TEIKIEDYMD
               MOVE    WRK-KIKANSAKKBN (IDX10)
                                       TO  WRK-SAKKBN
      *        入院履歴読み込み
      *
               MOVE    ZERO            TO  FLG-PTNYUINRRK
      *
               INITIALIZE              PTNYUINRRK-REC
               MOVE    TEIKI1P-HOSPID  TO  PTNYUINRRK-HOSPID
               MOVE    SYS-5012-PTID   TO  PTNYUINRRK-PTID
               MOVE    WRK-TEIKIEDYMD  TO  PTNYUINRRK-NYUINYMD
               MOVE    WRK-TEIKIEDYMD  TO  PTNYUINRRK-TAIINYMD
               MOVE    "PTNYUINRRK-KEY10"  TO  ORC-DBPATH
               MOVE    PTNYUINRRK-REC  TO  MCPDATA-REC
               PERFORM 910-DBSELECT-SEC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    MCPDATA-REC TO  PTNYUINRRK-REC
               ELSE
                   INITIALIZE              PTNYUINRRK-REC
                   MOVE    1           TO  FLG-PTNYUINRRK
               END-IF
      *
      *        カーソルクロース
               MOVE    "PTNYUINRRK-KEY10"  TO  ORC-DBPATH
               PERFORM 910-DBCLOSE-SEC
      *
               IF    ( FLG-PTNYUINRRK  =   ZERO )
                   PERFORM 800-ORCSDNTCHK-SEC
                   IF    ( SDNTCHK-STYMD   NOT =   ZERO )
                       PERFORM 20011-HENSYU-SEC
                   END-IF
               END-IF
           END-PERFORM
      *
           MOVE    "SYSKANRI-KEY7"     TO  ORC-DBPATH
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-5012-REC
           ELSE
               MOVE    1               TO  FLG-SYS5012
           END-IF
      *
           .
       20021-KOBETU-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求期間取得処理
      *****************************************************************
       20021-SEIKYU-KIKAN-GET-SEC      SECTION.
      *
           INITIALIZE  WRK-KIKAN-TBL
           MOVE        ZERO            TO  WRK-CNT
      *
      *    作成区分が“９”の場合、月末時のみ指定
           IF    ( SYS-5012-SAKKBN     =   "9" )
               MOVE    1               TO  WRK-KIKAN-MAX
               MOVE    SYS-5012-SRYYM  (1 : 6)
                                       TO  WRK-KIKANST (1)(1 : 6)
               MOVE    "01"            TO  WRK-KIKANST (1)(7 : 2)
               MOVE    SYS-5012-SRYYM      TO  WRK-YMD
               PERFORM 20021-GETUMATU-GET-SEC
               MOVE    WRK-YMD     TO  WRK-KIKANED (1)
               MOVE    9               TO  WRK-KIKANSAKKBN (1)
               GO  TO  20021-SEIKYU-KIKAN-GET-EXT
           END-IF
      *
      *    請求期間編集
           INITIALIZE                      SYS-5010-REC
           MOVE    "5010"              TO  SYS-5010-KANRICD
           MOVE    "*"                 TO  SYS-5010-KBNCD
           MOVE    SYS-5012-SRYYM      TO  ORC-DBYMD (1 : 6)
           MOVE    "01"                TO  ORC-DBYMD (7 : 2)
      *
           MOVE    SYS-5010-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-KEY-SEL-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC         TO  SYS-5010-REC
           ELSE
               MOVE    ERR-MES02           TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           IF    ( SYS-5012-SAKKBN =   "0" OR  "1" )
               COMPUTE WRK-CNT =   WRK-CNT +   1
               MOVE    WRK-CNT TO  WRK-KIKAN-MAX
               MOVE    SYS-5012-SRYYM  (1 : 6)
                                       TO  WRK-KIKANST (WRK-CNT)(1 : 6)
               MOVE    "01"            TO  WRK-KIKANST (WRK-CNT)(7 : 2)
               IF    ( SYS-5010-SEIKYU-DAY1    =   99 )
                   MOVE    SYS-5012-SRYYM      TO  WRK-YMD
                   PERFORM 20021-GETUMATU-GET-SEC
                   MOVE    WRK-YMD     TO  WRK-KIKANED (WRK-CNT)
               ELSE
                   MOVE    SYS-5012-SRYYM (1 : 6)
                                       TO  WRK-KIKANED (WRK-CNT)(1 : 6)
                   MOVE    SYS-5010-SEIKYU-DAY1
                                       TO  WRK-KIKANED (WRK-CNT)(7 : 2)
               END-IF
               MOVE    1               TO  WRK-KIKANSAKKBN (WRK-CNT)
           END-IF
      *
           IF    ( SYS-5012-SAKKBN =   "0" OR  "2" )
               COMPUTE WRK-CNT =   WRK-CNT +   1
               MOVE    WRK-CNT TO  WRK-KIKAN-MAX
               MOVE    SYS-5012-SRYYM (1 : 6)  TO  WRK-YMD (1 : 6)
               MOVE    SYS-5010-SEIKYU-DAY1    TO  WRK-YMD (7 : 2)
               PERFORM 20021-YOKUZITU-GET-SEC
               MOVE    WRK-YMD         TO  WRK-KIKANST (WRK-CNT)
      *
               IF    ( SYS-5010-SEIKYU-DAY2    =   99 )
                   MOVE    SYS-5012-SRYYM      TO  WRK-YMD
                   PERFORM 20021-GETUMATU-GET-SEC
                   MOVE    WRK-YMD     TO  WRK-KIKANED (WRK-CNT)
               ELSE
                   MOVE    SYS-5012-SRYYM (1 : 6)
                                       TO  WRK-KIKANED (WRK-CNT)(1 : 6)
                   MOVE    SYS-5010-SEIKYU-DAY2
                                       TO  WRK-KIKANED (WRK-CNT)(7 : 2)
               END-IF
               MOVE    2               TO  WRK-KIKANSAKKBN (WRK-CNT)
           END-IF
      *
           IF    ( SYS-5012-SAKKBN =   "0" OR  "3" )
               COMPUTE WRK-CNT =   WRK-CNT +   1
               MOVE    WRK-CNT TO  WRK-KIKAN-MAX
               MOVE    SYS-5012-SRYYM (1 : 6)  TO  WRK-YMD (1 : 6)
               MOVE    SYS-5010-SEIKYU-DAY2    TO  WRK-YMD (7 : 2)
               PERFORM 20021-YOKUZITU-GET-SEC
               MOVE    WRK-YMD         TO  WRK-KIKANST (WRK-CNT)
      *
               IF    ( SYS-5010-SEIKYU-DAY3    =   99 )
                   MOVE    SYS-5012-SRYYM      TO  WRK-YMD
                   PERFORM 20021-GETUMATU-GET-SEC
                   MOVE    WRK-YMD     TO  WRK-KIKANED (WRK-CNT)
               ELSE
                   MOVE    SYS-5012-SRYYM (1 : 6)
                                       TO  WRK-KIKANED (WRK-CNT)(1 : 6)
                   MOVE    SYS-5010-SEIKYU-DAY3
                                       TO  WRK-KIKANED (WRK-CNT)(7 : 2)
               END-IF
               MOVE    3               TO  WRK-KIKANSAKKBN (WRK-CNT)
           END-IF
      *
           IF    ( WRK-KIKAN-MAX   <=  ZERO )
               MOVE    ERR-MES08       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       20021-SEIKYU-KIKAN-GET-EXT.
            EXIT.
      *****************************************************************
      *    月末日取得処理
      *****************************************************************
       20021-GETUMATU-GET-SEC      SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY1-AREA
           MOVE    "71"                TO  LNK-DAY7-IRAI
           MOVE    WRK-YMD (1 : 6)     TO  LNK-DAY7-YM
           CALL    "ORCSDAY"               USING
                                           STS-AREA-DAY
                                           LNK-DAY7-AREA
           MOVE    LNK-DAY7-KOYOMI     TO  WRK-YMD
      *
           .
       20021-GETUMATU-GET-EXT.
            EXIT.
      *****************************************************************
      *    翌日取得処理
      *****************************************************************
       20021-YOKUZITU-GET-SEC      SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY6-AREA
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    WRK-YMD             TO  LNK-DAY6-KIJUN
           MOVE    "1"                 TO  LNK-DAY6-ZOGENPTN
           MOVE    1                   TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"               USING
                                           STS-AREA-DAY
                                           LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN     TO  WRK-YMD
      *
           .
       20021-YOKUZITU-GET-EXT.
            EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    OUTPUT              TEIKIERR-FILE
      *
           MOVE    WRK-TEIKIERR    TO  TEIKIERR-REC
           WRITE   TEIKIERR-REC
           CLOSE   TEIKIERR-FILE
      *
      *    ジョブ管理終了処理
           MOVE    "JBE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    TEIKI1P-JOBID   TO  JOB-JOBID
           MOVE    TEIKI1P-SHELLID
                                   TO  JOB-SHELLID
           MOVE    WRK-TEIKIERR    TO  JOB-YOBI
           MOVE    "9999"          TO  JOB-ERRCD
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
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   TEIKI01-FILE
                   TEIKI03-FILE
      *
           IF    ( CNT-OUT1            =   ZERO )
               MOVE    ERR-MES09       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    TEIKI1P-JOBID  TO  JOB-JOBID
           MOVE    TEIKI1P-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *     
           DISPLAY "TEIKI01 (ORCT0010) CNT " CNT-OUT1 
           DISPLAY "*** ORCT0010 END ***"
      ***  ACCEPT  WRK-IN FROM CONSOLE 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    期間算出処理
      *****************************************************************
       800-KIKAN-CALC-SEC             SECTION.
      *
           MOVE    ZERO                TO  FLG-ORCSDAY
                                           WRK-NISSU1
                                           WRK-NISSU2
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY5-AREA
           MOVE    "51"                TO  LNK-DAY5-IRAI
           MOVE    WRK-STYMD           TO  LNK-DAY5-START
           MOVE    WRK-EDYMD           TO  LNK-DAY5-END
           CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                           LNK-DAY5-AREA
           IF      ( STS-DAY-RC1   NOT =   ZERO )
               MOVE    1           TO  FLG-ORCSDAY
               GO  TO              800-KIKAN-CALC-EXT
           END-IF
      *
           MOVE    LNK-DAY5-NISSU1     TO  WRK-NISSU1
           MOVE    LNK-DAY5-NISSU2     TO  WRK-NISSU2
      *
           .
       800-KIKAN-CALC-EXT.
           EXIT.
      *****************************************************************
      *    エラーメッセージ編集処理
      *****************************************************************
       800-ERRMSG-EDIT-SEC             SECTION.
      *
           MOVE    SPACE               TO  ERR-HEN-ERRMSG
	                                   ERR-PTNUM
      *
      *    患者番号を取得
           MOVE    ERR-PTID            TO  WRK-PTID
           PERFORM 900-PTNUM-KEY-SEL-SEC
           IF    ( FLG-PTNUM           =   ZERO )
               MOVE    PTNUM-PTNUM     TO  ERR-PTNUM
           ELSE
               STRING "?(ID:"          DELIMITED   BY  SIZE
                      ERR-PTID         DELIMITED   BY  SIZE
                      ")"              DELIMITED   BY  SIZE
               INTO   ERR-PTNUM
               END-STRING
           END-IF
      *
           MOVE    1                   TO  WRK-LEN
           MOVE    SPACE               TO  WRK-STR
           STRING  ERR-PTNUM           DELIMITED   BY  SPACE
           INTO    WRK-STR
           WITH  POINTER WRK-LEN
           END-STRING
      *
           COMPUTE WRK-LEN =   WRK-LEN -   1
      *
           MOVE    ZERO                TO  WRK-SHO
                                           WRK-AMARI
           MOVE    SPACE               TO  WRK-KUGIRI
      *
           DIVIDE  2   INTO    WRK-LEN GIVING  WRK-SHO
           REMAINDER WRK-AMARI
           END-DIVIDE
      *
           IF    ( WRK-AMARI   =   ZERO )
               MOVE    "："            TO  WRK-KUGIRI
           ELSE
               MOVE    ":"             TO  WRK-KUGIRI
           END-IF
      *
           STRING  ERR-ERRMSG          DELIMITED   BY  SPACE
                   "［患者番号"        DELIMITED   BY  SIZE
                   WRK-KUGIRI          DELIMITED   BY  SPACE
                   ERR-PTNUM           DELIMITED   BY  SPACE
                   "］"                DELIMITED   BY  SIZE
           INTO    ERR-HEN-ERRMSG
           END-STRING
      *
           MOVE    ERR-HEN-ERRMSG      TO  WRK-TEIKIERR
           PERFORM 500-ERR-HENSYU-SEC
      *
           .
       800-ERRMSG-EDIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    同日再入院チェックサブ
      *****************************************************************
       800-ORCSDNTCHK-SEC              SECTION.
      *
           INITIALIZE                  SDNTCHK-AREA
           MOVE    PTNYUINRRK-REC      TO      LNKNRRK-REC
           MOVE    WRK-TEIKIEDYMD      TO      SDNTCHK-KJNYMD
           CALL    "ORCSDNTCHK"        USING   SDNTCHK-AREA
                                               LNKNRRK-REC
      *
           .
       800-ORCSDNTCHK-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       900-SYSKANRI-KEY-SEL-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-SYSKANRI-KEY-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者定期請求履歴マスタ　ＲＥＡＤ
      *****************************************************************
       900-PTTEIKIRRK-KEY2-SEL-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-PTTEIKIRRK
           INITIALIZE                  PTTEIKIRRK-REC
      *
           MOVE    PTNYUINRRK-HOSPID   TO  PTTEIKIRRK-HOSPID
           MOVE    PTNYUINRRK-PTID     TO  PTTEIKIRRK-PTID
           MOVE    TEIKI1P-SRYYM       TO  PTTEIKIRRK-SRYYM
           MOVE    PTTEIKIRRK-REC      TO  MCPDATA-REC
           MOVE    "PTTEIKIRRK-KEY2"   TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTTEIKIRRK-REC
           ELSE
               INITIALIZE                  PTTEIKIRRK-REC
               MOVE    1               TO  FLG-PTTEIKIRRK
           END-IF
      *
      *    カーソルクロース
           MOVE    "PTTEIKIRRK-KEY2"   TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-PTTEIKIRRK-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    入院履歴マスター読込
      *****************************************************************
       900-PTNYUINRRK-KEY4-SEL-SEC     SECTION.
      *
           MOVE    ZERO                TO  FLG-PTNYUINRRK2
      *
           MOVE    "PTNYUINRRK-KEY4"   TO  ORC-DBPATH
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               INITIALIZE                  PTNYUINRRK-REC
               MOVE    1               TO  FLG-PTNYUINRRK2
           END-IF
      *
      *    カーソルクロース
           MOVE    "PTNYUINRRK-KEY4"   TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-PTNYUINRRK-KEY4-SEL-EXT.
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
      *    患者番号マスター読込（主キー）
      *****************************************************************
       900-PTNUM-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-PTNUM
      *
           INITIALIZE                  PTNUM-REC
           MOVE    TEIKI1P-HOSPID      TO  PTNUM-HOSPID
           MOVE    WRK-PTID            TO  PTNUM-PTID
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  PTNUM-REC
           ELSE
               MOVE    1               TO  FLG-PTNUM
               INITIALIZE                  PTNUM-REC
           END-IF
      *
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-PTNUM-KEY-SEL-EXT.
           EXIT.
      *
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
