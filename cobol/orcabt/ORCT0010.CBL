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
      *  02/12/11    NACL−小豆沢  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
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
       01  TEIKIERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT5.INC"
                                   REPLACING  //TEIKI01PARA//
                                   BY         //TEIKIERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-TEIKIERR                            PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-PTNYUINRRK                          PIC 9(01).
           03  FLG-PTNYUINRRK2                         PIC 9(01).
           03  FLG-SYSKANRI                            PIC 9(01).
           03  FLG-SYS5012                            PIC 9(01).
           03  FLG-PTINF                               PIC 9(01).
           03  FLG-ORCSDAY                             PIC 9(01).
           03  FLG-SYUNOU                              PIC 9(01).
           03  FLG-SYUMEI                              PIC 9(01).
           03  FLG-NYUINKA                             PIC 9(01).
           03  FLG-TEIKIKANRI                          PIC 9(01).
           03  FLG-TEIKIPRT                            PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-OUT1                                PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDX1                                    PIC 9(04). 
           03  IDX2                                    PIC 9(04). 
           03  IDX3                                    PIC 9(04). 
           03  IDX10                                   PIC 9(04). 
           03  IDX11                                   PIC 9(04). 
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME.
               05  SYS-THH         PIC 9(02).
               05  SYS-TMM         PIC 9(02).
               05  SYS-TSS         PIC 9(02).
               05  SYS-TDD         PIC 9(02).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-DBPATH                          PIC  X(100).
           03  WRK-PARA.
               05  WRK-PARA-ARG1.
                   07   WRK-PARA-SRYYM             PIC  X(06).
                   07   WRK-PARA-TERMID            PIC  X(32).
                   07   WRK-PARA-SYSYMD            PIC  X(08).
               05  WRK-PARA-SYOKBN                 PIC  X(01).
               05  WRK-PARA-KIKAN-OCC  OCCURS 3.
                   07  WRK-PARA-KIKAN-ST       PIC  X(08).
                   07  WRK-PARA-KIKAN-ED       PIC  X(08).
                   07  WRK-PARA-KIKAN-KBN      PIC  X(01).
               05  WRK-PARA-JOBID              PIC  9(07).
               05  WRK-PARA-SHELLID            PIC  X(08).
      *
           03  WRK-TEIKIERR            PIC X(200).
      *
           03  WRK-STYMD               PIC X(08).
           03  WRK-EDYMD               PIC X(08).
           03  WRK-KIKAN-TBL.
               05  WRK-KIKAN-MAX       PIC 9(04).
               05  WRK-KIKAN-OCC       OCCURS 3.
                   07  WRK-KIKANST     PIC X(08).
                   07  WRK-KIKANED     PIC X(08).
      *
           03  WRK-TEIKISTYMD          PIC X(08).
           03  WRK-TEIKIEDYMD          PIC X(08).
      *
           03  WRK-YMD.
               05  WRK-YY              PIC 9(04).
               05  WRK-MM              PIC 9(02).
               05  WRK-DD              PIC 9(02).
           03  WRK-NISSU1              PIC 9(05).
           03  WRK-NISSU2              PIC 9(05).
           03  WRK-DENPNUM             PIC 9(07).
           03  WRK-DENPNUM-X           PIC X(08).
           03  WRK-NYUINKA             PIC X(02).
           03  WRK-BTUNUM              PIC X(02).
           03  WRK-BRMNUM              PIC X(08).
           03  WRK-DRCD                PIC X(04).
           03  WRK-SEIKYUSTYMD         PIC X(08).
           03  WRK-CREYMD              PIC X(08).
           03  WRK-CREHMS              PIC X(06).
           03  WRK-CNT                 PIC 9(05).
      *
      *        病棟別収納データ集計テーブル
           03  WRK-BTUCNT-TBL.
               05  WRK-BTUCNT-TBL-MAX  PIC 9(05).
               05  WRK-BTUCNT-OCC      OCCURS  50.
                   07  WRK-BTUCNT-BTUNUM
                                       PIC X(02).
                   07  WRK-BTUCNT-CNT  PIC 9(05).
      *    患者情報エリア
           03  WRK-PTINF-AREA.
               05  WRK-PTINF-HOSPID    PIC X(24).
               05  WRK-PTINF-PTID      PIC 9(10).
               05  WRK-PTINF-PTNUM     PIC X(20).
               05  WRK-PTINF-RRKNUM    PIC 9(03).
               05  WRK-PTINF-RRKEDANUM PIC 9(03).
               05  WRK-PTINF-NAME      PIC X(100).
           03  WRK-TEIKI-BTUNUM        PIC X(02).
           03  WRK-TEIKI-DENPNUM       PIC 9(07).
      *
      *    入院履歴ワーク
       01  WKPTNYUINRRK-REC. 
           COPY    "CPPTNYUINRRK.INC"  REPLACING  //PTNYUINRRK//
                                   BY         //WKPTNYUINRRK//.
      *
      *    収納ワーク
       01  WKSYUNOU-REC.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-//
                                           BY //WKSYU-//.
      *
      *    収納明細ワーク
       01  WKSYUMEI-REC.
           COPY  "CPSYUMEI.INC"    REPLACING  //SMEI-//
                                           BY //WKSMEI-//.
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
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
      *    伝票番号
           COPY    "CPSK0041.INC".
      *    医療機関情報
           COPY    "CPSK1001.INC".
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
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    収納明細マスター
       01  SYUMEI-REC.
           COPY    "CPSYUMEI.INC".
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    定期請求管理
       01  TEIKIKANRI-REC.
           COPY    "CPTEIKIKANRI.INC".
      *
      *    定期請求印刷
       01  TEIKIPRT-REC.
           COPY    "CPTEIKIPRT.INC".
      *
      *    患者番号構成管理情報
           COPY  "CPSK1009.INC".
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
      *    定期請求用収納作成サブ
       01  LNK-ORCS02-REC.
           COPY  "CPORCS02.INC".
       01  LNK-SYUNOU-REC-T.
         02 LNK-SYUNOU-REC     OCCURS 10.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //LNK-SYU-//.
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(2000).
      ****************************************************************
       PROCEDURE           DIVISION
               USING
           COMMAND-PARAM.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL   FLG-END =   1 
      *
           PERFORM 300-TERM-SEC
      *
           STOP    RUN
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
                                       SYS-AREA
                                       SPA-AREA
      *
           ACCEPT  SYS-TIME    FROM    TIME
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    WRK-PARA-ARG1
                                               WRK-PARA-SYOKBN
                                               WRK-PARA-KIKAN-OCC (1)
                                               WRK-PARA-KIKAN-OCC (2)
                                               WRK-PARA-KIKAN-OCC (3)
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
      *
           DISPLAY "WRK-PARA-ARG1          = " WRK-PARA-ARG1
           DISPLAY "WRK-PARA-SYOKBN        = " WRK-PARA-SYOKBN
           DISPLAY "WRK-PARA-KIKAN-OCC (1) = " WRK-PARA-KIKAN-OCC (1)
           DISPLAY "WRK-PARA-KIKAN-OCC (2) = " WRK-PARA-KIKAN-OCC (2)
           DISPLAY "WRK-PARA-KIKAN-OCC (3) = " WRK-PARA-KIKAN-OCC (3)
           DISPLAY "WRK-PARA-JOBID         = " WRK-PARA-JOBID
           DISPLAY "WRK-PARA-SHELLID       = " WRK-PARA-SHELLID
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCT0010"      TO  JOB-PGID
           MOVE    "収納データ作成"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    ZERO                TO  FLG-END
      *
           MOVE    "TEIKIERR"          TO  TEIKIERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  TEIKIERR-TERMID
      *
      *    医療機関ＩＤ編集
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    ZERO                TO  ORC-DBYMD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
           ELSE
               MOVE    "医療機関情報が取得できませんでした。"
                                           TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    患者番号構成管理情報編集
           INITIALIZE                  SYS-1009-REC
           MOVE    "1009"              TO  SYS-1009-KANRICD
           MOVE    "*"                 TO  SYS-1009-KBNCD
           MOVE    WRK-PARA-SRYYM      TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1009-REC
               MOVE    SYS-1009-PTNUMKSIKBN
                                           TO  SPA-1009-PTNUMKSIKBN
               MOVE    SYS-1009-HJNKSIKBN  TO  SPA-1009-HJNKSIKBN
               MOVE    SYS-1009-HJNKSINENKBN 
                                           TO  SPA-1009-HJNKSINENKBN
               MOVE    SYS-1009-HJNKSIRENNUMKBN
                                           TO  SPA-1009-HJNKSIRENNUMKBN
               MOVE    SYS-1009-HJNKSIRENNUMKETA
                                           TO  SPA-1009-HJNKSIRENNUMKETA
           ELSE
               MOVE    "患者番号構成管理情報が取得できませんでした"
                                           TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
           END-IF
      *
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *    定期請求管理情報削除処理
           PERFORM 2003-TEIKIKANRI-DEL-SEC
           IF    ( FLG-END     =   1 )
               GO  TO  200-MAIN-EXT
           END-IF
      *
      *    定期請求印刷情報削除処理
           PERFORM 2003-TEIKIPRT-DEL-SEC
           IF    ( FLG-END     =   1 )
               GO  TO  200-MAIN-EXT
           END-IF
      *
           EVALUATE    WRK-PARA-SYOKBN
           WHEN    "1"
               PERFORM 2001-IKKATU-SYORI-SEC
               IF    ( FLG-END     =   1 )
                   GO  TO  200-MAIN-EXT
               END-IF
           WHEN    "2"
               PERFORM 2002-KOBETU-SYORI-SEC
               IF    ( FLG-END     =   1 )
                   GO  TO  200-MAIN-EXT
               END-IF
           END-EVALUATE
      *
      *    定期請求管理作成処理
           PERFORM 2003-TEIKIKANRI-INS-SEC
           IF    ( FLG-END     =   1 )
               GO  TO  200-MAIN-EXT
           END-IF
      *
           MOVE    1                   TO  FLG-END
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    一括処理
      *****************************************************************
       2001-IKKATU-SYORI-SEC               SECTION.
      *
           INITIALIZE    WRK-KIKAN-TBL
           MOVE    ZERO            TO  WRK-CNT
           PERFORM VARYING IDX10   FROM    1   BY  1
                   UNTIL ( IDX10   >   3 )
               IF    ( WRK-PARA-KIKAN-KBN (IDX10)  =   "1" )
      *
                   COMPUTE WRK-CNT =   WRK-CNT +   1
                   MOVE    WRK-CNT TO  WRK-KIKAN-MAX
      *
                   MOVE    WRK-PARA-KIKAN-ST (IDX10)
                                       TO  WRK-KIKANST (WRK-CNT)
                   MOVE    WRK-PARA-KIKAN-ED (IDX10)
                                       TO  WRK-KIKANED (WRK-CNT)
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
      *
      *        ダミー収納削除処理
               INITIALIZE                  SYUNOU-REC
               MOVE    SYS-1001-HOSPID     TO  SYU-HOSPID
               MOVE    "1"                 TO  SYU-NYUGAIKBN
               MOVE    "X"                 TO  SYU-DENPJTIKBN
               MOVE    SYUNOU-REC          TO  MCPDATA-REC
               MOVE    "SYUNOU-DEL2"       TO  ORC-DBPATH
               MOVE    "DBDELETE"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"             USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
               IF  (   MCP-RC          NOT =   ZERO )
                   MOVE  "仮収納データの削除処理に失敗しました"
                                   TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  2001-IKKATU-SYORI-EXT
               END-IF
      *
      *        同一期間で定期請求処理された収納明細を削除（暫定）
               INITIALIZE                  SYUNOU-REC
               MOVE    SYS-1001-HOSPID     TO  SYU-HOSPID
               MOVE    "1"                 TO  SYU-NYUGAIKBN
               MOVE    "A"                 TO  SYU-DENPJTIKBN
               MOVE    WRK-TEIKISTYMD      TO  SYU-SKYSTYMD
               MOVE    WRK-TEIKIEDYMD      TO  SYU-SKYEDYMD
               MOVE    "SYUNOU-KEY7"       TO  WRK-DBPATH
               PERFORM 2003-TEIKISYUMEI-DEL-SEC
               IF    ( FLG-END =   1 )
                   GO  TO  2001-IKKATU-SYORI-EXT
               END-IF
      *
               INITIALIZE                  SYUNOU-REC
               MOVE    SYS-1001-HOSPID     TO  SYU-HOSPID
               MOVE    "1"                 TO  SYU-NYUGAIKBN
               MOVE    "A"                 TO  SYU-DENPJTIKBN
               MOVE    WRK-TEIKISTYMD      TO  SYU-SKYSTYMD
               MOVE    WRK-TEIKIEDYMD      TO  SYU-SKYEDYMD
               MOVE    SYUNOU-REC          TO  MCPDATA-REC
               MOVE    "SYUNOU-DEL3"       TO  ORC-DBPATH
               MOVE    "DBDELETE"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"             USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
               IF  (   MCP-RC          NOT =   ZERO )
                   MOVE  "収納データの更新処理に失敗しました"
                                   TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  2001-IKKATU-SYORI-EXT
               END-IF
      *
      *        入院履歴読み込み
               INITIALIZE              PTNYUINRRK-REC
               MOVE    SYS-1001-HOSPID     TO  PTNYUINRRK-HOSPID
               MOVE    WRK-TEIKIEDYMD      TO  PTNYUINRRK-NYUINYMD
               MOVE    WRK-TEIKIEDYMD      TO  PTNYUINRRK-TAIINYMD
               MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "PTNYUINRRK-KEY14"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    "PTNYUINRRK-KEY14"  TO  ORC-DBPATH
                   PERFORM 900-PTNYUINRRK-READ-SEC
               ELSE
                   INITIALIZE          PTNYUINRRK-REC
                   MOVE    1           TO  FLG-PTNYUINRRK
               END-IF
      *
               PERFORM UNTIL ( FLG-PTNYUINRRK  =   1 )
                   PERFORM 20011-HENSYU-SEC
                   IF    ( FLG-END     =   1 )
                       GO  TO  2001-IKKATU-SYORI-EXT
                   END-IF
      *
                   MOVE    "PTNYUINRRK-KEY14"  TO  ORC-DBPATH
                   PERFORM 900-PTNYUINRRK-READ-SEC
      *
               END-PERFORM
      *
      *        カーソルクロース
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "PTNYUINRRK-KEY14"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           END-PERFORM
           .
       2001-IKKATU-SYORI-EXT.
           EXIT. 
      *
      *****************************************************************
      *   編集処理
      *****************************************************************
       20011-HENSYU-SEC              SECTION.
      *
           INITIALIZE  WRK-PTINF-AREA
      *
      *    患者情報読み込み
           MOVE    SYS-1001-HOSPID         TO  PTINF-HOSPID
           MOVE    PTNYUINRRK-PTID         TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
           IF    ( FLG-PTINF       NOT =   ZERO )
               MOVE    "患者情報の取得に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20011-HENSYU-EXT
           END-IF
      *
      *    テスト患者のときは読み飛ばす
           IF    ( PTINF-TSTPTNUMKBN   =   "1" )
               GO  TO  20011-HENSYU-EXT
           END-IF
      *
           MOVE    PTINF-HOSPID    TO  WRK-PTINF-HOSPID
           MOVE    PTINF-PTID      TO  WRK-PTINF-PTID
           MOVE    PTINF-NAME      TO  WRK-PTINF-NAME
           MOVE    PTINF-RRKNUM    TO  WRK-PTINF-RRKNUM
           MOVE    PTINF-RRKEDANUM TO  WRK-PTINF-RRKEDANUM
      *
      *    患者番号を取得
           INITIALIZE                      ORCSPTIDAREA
           MOVE    PTINF-HOSPID    TO  SPTID-HOSPID
           MOVE    PTINF-PTID      TO  SPTID-PTID
           CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                               SPA-1009-TBL
           IF    ( SPTID-RC        NOT =   ZERO )
               MOVE    "患者番号の取得に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20011-HENSYU-EXT
           END-IF
      *
           MOVE    SPTID-PTNUM     TO  WRK-PTINF-PTNUM
      *
      *    収納データ取得処理
           PERFORM 20011-SYUNOU-GET-SEC
           IF (  FLG-END   =   1 )
               GO  TO  20011-HENSYU-EXT
           END-IF
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >    10 )
                   OR    ( LNK-SYU-SKYSTYMD (IDX1) =   SPACE )
      *
      *        収納データ更新処理
               PERFORM 20011-SYUNOU-KOUSIN-SEC
               IF (  FLG-END   =   1 )
                   GO  TO  20011-HENSYU-EXT
               END-IF
      *
      *        最新病棟番号別集計処理
               PERFORM 20011-NOW-BTUNUM-CNT-SEC
               IF (  FLG-END   =   1 )
                   GO  TO  20011-HENSYU-EXT
               END-IF
      *
      *        定期請求印刷情報作成
               PERFORM 2003-TEIKIPRT-INS-SEC
               IF (  FLG-END   =   1 )
                   GO  TO  20011-HENSYU-EXT
               END-IF
           END-PERFORM
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
      *    （暫定的に月初め又は入院日を設定（実際は請求開始日））
           MOVE    SPACE           TO  WRK-SEIKYUSTYMD
           IF    ( WRK-PARA-SYOKBN =   "1" )
               MOVE    WRK-PARA-SRYYM (1 : 6)
                                   TO  WRK-YMD (1 : 6)
               MOVE    "01"        TO  WRK-YMD (7 : 2)
           ELSE
               MOVE    SYS-5012-SRYYM
                                   TO  WRK-YMD (1 : 6)
               MOVE    "01"        TO  WRK-YMD (7 : 2)
           END-IF
      *
           IF  ( PTNYUINRRK-NYUINYMD   >   WRK-YMD )
               MOVE    PTNYUINRRK-NYUINYMD
                                   TO  WRK-SEIKYUSTYMD
           ELSE
               MOVE    WRK-YMD     TO  WRK-SEIKYUSTYMD
           END-IF
      * ------------------------------
      *
      *    通算日数を求める
           MOVE    PTNYUINRRK-NYUINYMD
                                   TO  WRK-STYMD
      *    暫定的に月初め又は入院日を設定（実際は請求開始日）
           MOVE    WRK-SEIKYUSTYMD
                                   TO  WRK-EDYMD
           PERFORM 5002-KIKAN-CALC-SEC
           IF    ( FLG-ORCSDAY     NOT =   ZERO )
               MOVE    "通算日数の取得に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20011-SYUNOU-GET-EXT
           END-IF
      *
           MOVE    SPACE           TO  LNK-ORCS02-REC
                                       LNK-SYUNOU-REC-T
      *
           INITIALIZE                  LNK-ORCS02-REC
                                       LNK-SYUNOU-REC-T
      *
           MOVE    SYS-1001-HOSPID TO  LNK-S02-HOSPID
           MOVE    "1"             TO  LNK-S02-NYUGAIKBN
           MOVE    PTNYUINRRK-PTID TO  LNK-S02-PTID
           MOVE    WRK-NISSU1      TO  LNK-S02-NYUIN-TSUSAN-NISSU
      *    暫定的に月初め又は入院日を設定（実際は請求開始日）
           MOVE    WRK-SEIKYUSTYMD
                                   TO  LNK-S02-SKYSTYMD
           MOVE    WRK-TEIKIEDYMD
                                   TO  LNK-S02-SKYEDYMD
           MOVE    "A"             TO  LNK-S02-TEIKI-KBN
           CALL    "ORCSTEIKI"     USING
                                   MCPAREA
                                   LNK-ORCS02-REC
                                   LNK-SYUNOU-REC-T
           IF    ( LNK-S02-RC      NOT =   ZERO )
               MOVE    "収納データの取得に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20011-SYUNOU-GET-EXT
           END-IF
      *
           PERFORM VARYING IDX1   FROM    1   BY  1
                   UNTIL ( IDX1   >   10 )
      *
               DISPLAY "LNK-SYU-SKYMONEY (" IDX1" ) = "
                        LNK-SYU-SKYMONEY ( IDX1 )
      *
           END-PERFORM
      *
           .
       20011-SYUNOU-GET-EXT.
           EXIT. 
      *****************************************************************
      *    収納データ更新処理
      *****************************************************************
       20011-SYUNOU-KOUSIN-SEC           SECTION.
      *
           MOVE    LNK-SYUNOU-REC (IDX1)
                                       TO  SYUNOU-REC
      *
      *    伝票番号取得処理
           PERFORM 20011-DENPNUM-GET-SEC
           IF (  FLG-END   =   1 )
               GO  TO  20011-SYUNOU-KOUSIN-EXT
           END-IF
           MOVE    WRK-DENPNUM         TO  SYU-DENPNUM
      *
           MOVE    PTNYUINRRK-REC      TO  WKPTNYUINRRK-REC
      *    請求時最終履歴取得処理
           PERFORM 20011-SEILASTRRK-SET-SEC
           IF (  FLG-END   =   1 )
               GO  TO  20011-SYUNOU-KOUSIN-EXT
           END-IF
           MOVE    WKPTNYUINRRK-REC    TO  PTNYUINRRK-REC
      *
           MOVE    WRK-NYUINKA     TO  SYU-SRYKA
           MOVE    WRK-BTUNUM      TO  SYU-ROOMNUM
           MOVE    WRK-BRMNUM      TO  SYU-BYOTONUM
           MOVE    WRK-DRCD        TO  SYU-DRCD
      *
           MOVE    SYUNOU-REC      TO  WKSYUNOU-REC
      *
      *    更新前チェック（既に重複するデータがある場合はエラー）
           MOVE   ZERO             TO  FLG-SYUNOU
           PERFORM 900-SYUNOU-READ-SEC
           IF    ( FLG-SYUNOU          =   ZERO )
               MOVE    "収納データの更新に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20011-SYUNOU-KOUSIN-EXT
           END-IF
      *
           MOVE    WKSYUNOU-REC    TO  SYUNOU-REC
           MOVE    SYUNOU-REC      TO  MCPDATA-REC
           MOVE    "SYUNOU-KEY"    TO  ORC-DBPATH
           MOVE    "DBINSERT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "収納データの更新に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20011-SYUNOU-KOUSIN-EXT
           END-IF
      *
      *    収納明細マスタ更新処理
           PERFORM 20011-SYUMEI-KOUSIN-SEC
           IF (  FLG-END   =   1 )
               GO  TO  20011-SYUNOU-KOUSIN-EXT
           END-IF
      *
           COMPUTE CNT-OUT1    =   CNT-OUT1    +   1
      *
           MOVE    SYU-DENPNUM TO  WRK-TEIKI-DENPNUM
      *
           .
       20011-SYUNOU-KOUSIN-EXT.
           EXIT. 
      *****************************************************************
      *    収納明細マスタ更新処理
      *****************************************************************
       20011-SYUMEI-KOUSIN-SEC     SECTION.
      *
           MOVE    SPACE               TO  SYUMEI-REC
           INITIALIZE                      SYUMEI-REC
           MOVE    SYU-HOSPID          TO  SMEI-HOSPID
           MOVE    SYU-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SYU-PTID            TO  SMEI-PTID
      *
      *    伝票番号
           MOVE    SYU-DENPNUM         TO  SMEI-DENPNUM
      *    伝票番号枝番
           MOVE    01                  TO  SMEI-DENPEDANUM
      *    伝票状態区分
           MOVE    SPACE               TO  SMEI-MEISAIJOUTAIKBN
      *    請求発行日（発行日の西暦）
           MOVE    WRK-PARA-SYSYMD     TO  SMEI-SKYPRINTYMD
      *    請求再発行日
           MOVE    SPACE               TO  SMEI-SKYREPRINTYMD
      *    領収書発行日
           MOVE    SMEI-SKYPRINTYMD    TO  SMEI-RYOSYUPRINTYMD
      *    領収書再発行日
           MOVE    SPACE               TO  SMEI-RYOSYUREPRINTYMD
      *    請求金額
           MOVE    SYU-SKYMONEY        TO  SMEI-SKYMONEY
      *    入返金日
           MOVE    SMEI-SKYPRINTYMD    TO  SMEI-NYUHEN-YMD
      *    入金連番
           MOVE    01                  TO  SMEI-NYUKINRENNUM
      *
      *    状態区分
           IF    ( SYU-SKYMONEY        =   ZERO )
               MOVE    SPACE           TO  SMEI-JOUTAIKBN
           ELSE
               MOVE    "9"             TO  SMEI-JOUTAIKBN
           END-IF
      *
           MOVE    SYUMEI-REC          TO  WKSYUMEI-REC
      *
      *    更新前チェック（既に重複するデータがある場合はエラー）
           MOVE   ZERO                 TO  FLG-SYUMEI
           PERFORM 900-SYUMEI-READ-SEC
           IF    ( FLG-SYUMEI  =   ZERO )
               MOVE    "収納明細データの更新に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20011-SYUMEI-KOUSIN-EXT
           END-IF
      *
           MOVE    WKSYUMEI-REC    TO  SYUMEI-REC
           MOVE    SYUMEI-REC      TO  MCPDATA-REC
           MOVE    "SYUMEI-KEY"    TO  ORC-DBPATH
           MOVE    "DBINSERT"      TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    "収納明細データの更新に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20011-SYUMEI-KOUSIN-EXT
           END-IF
      *
      *
           .
       20011-SYUMEI-KOUSIN-EXT.
           EXIT.
      *****************************************************************
      *    伝票番号取得処理
      *****************************************************************
       20011-DENPNUM-GET-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
                                           WRK-DENPNUM
      *
           INITIALIZE                  SYS-0041-REC.
           MOVE    "0041"              TO  SYS-0041-KANRICD
           MOVE    "*"                 TO  SYS-0041-KBNCD
           MOVE    ZERO                TO  SYS-0041-STYUKYMD
           MOVE    ALL "9"             TO  SYS-0041-EDYUKYMD
      *
           MOVE    WRK-PARA-SYSYMD     TO  ORC-DBYMD
           MOVE    SYS-0041-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    MCPDATA-REC     TO  SYS-0041-REC
           END-IF
      *
           IF    ( FLG-SYSKANRI        =   ZERO )
               MOVE    SYS-0041-DENPNUMMAX-NYU
                                       TO  WRK-DENPNUM-X
               IF    ( WRK-DENPNUM-X   =   SPACE )
                   MOVE    ZERO        TO  SYS-0041-DENPNUMMAX-NYU
               ELSE
                   MOVE    WRK-DENPNUM-X
                                       TO  SYS-0041-DENPNUMMAX-NYU
               END-IF
      *
               COMPUTE SYS-0041-DENPNUMMAX-NYU
                   =   SYS-0041-DENPNUMMAX-NYU +   1
      *
               MOVE    SYS-0041-DENPNUMMAX-NYU
                                           TO  WRK-DENPNUM
      *
               MOVE    SYS-0041-REC        TO  MCPDATA-REC
               MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC          NOT =   ZERO )
                   MOVE    "伝票番号の更新に失敗しました"
                                       TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  20011-DENPNUM-GET-EXT
               END-IF
           ELSE
               MOVE    "伝票番号の取得に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20011-DENPNUM-GET-EXT
           END-IF
      *
           .
       20011-DENPNUM-GET-EXT.
           EXIT.
      *
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
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "PTNYUINRRK-KEY4"   TO  ORC-DBPATH
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               MOVE    "PTNYUINRRK-KEY4"  TO  ORC-DBPATH
               PERFORM 910-PTNYUINRRK-READ-SEC
           ELSE
               INITIALIZE          PTNYUINRRK-REC
               MOVE    1           TO  FLG-PTNYUINRRK2
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
               MOVE    "PTNYUINRRK-KEY4"  TO  ORC-DBPATH
               PERFORM 910-PTNYUINRRK-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "PTNYUINRRK-KEY4"   TO  ORC-DBPATH
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           IF    ( FLG-NYUINKA         =   ZERO )
               MOVE    "入院履歴の取得に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20011-SEILASTRRK-SET-EXT
           END-IF
      *
      *
           .
       20011-SEILASTRRK-SET-EXT.
           EXIT.
      *****************************************************************
      *    最新病棟番号別集計処理
      *****************************************************************
       20011-NOW-BTUNUM-CNT-SEC        SECTION.
      *
      *    最新の入院履歴情報より病棟番号を取得
           MOVE    PTNYUINRRK-REC  TO  WKPTNYUINRRK-REC
           INITIALIZE  PTNYUINRRK-REC
           MOVE    WRK-PTINF-HOSPID    TO  PTNYUINRRK-HOSPID
           MOVE    WRK-PTINF-PTID      TO  PTNYUINRRK-PTID
           MOVE    WRK-PTINF-RRKNUM    TO  PTNYUINRRK-RRKNUM
           MOVE    WRK-PTINF-RRKEDANUM TO  PTNYUINRRK-RRKEDANUM
           PERFORM 920-PTNYUINRRK-READ-SEC
           IF    ( FLG-PTNYUINRRK2     NOT =   ZERO )
               MOVE    "最新入院履歴の取得に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20011-NOW-BTUNUM-CNT-EXT
           END-IF
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   50 )
               EVALUATE WRK-BTUCNT-BTUNUM (IDX2)
               WHEN    SPACE
                   MOVE    PTNYUINRRK-BTUNUM
                                   TO  WRK-BTUCNT-BTUNUM (IDX2)
                   MOVE    1       TO  WRK-BTUCNT-CNT (IDX2)
                   COMPUTE WRK-BTUCNT-TBL-MAX
                       =   WRK-BTUCNT-TBL-MAX  +   1
                   MOVE    50      TO  IDX2
               WHEN    PTNYUINRRK-BTUNUM
                   COMPUTE WRK-BTUCNT-CNT (IDX2)
                       =   WRK-BTUCNT-CNT (IDX2)  +   1
                   MOVE    50      TO  IDX2
               END-EVALUATE
           END-PERFORM
      *
           MOVE    PTNYUINRRK-BTUNUM
                                   TO  WRK-TEIKI-BTUNUM
      *
           MOVE    WKPTNYUINRRK-REC
                                   TO  PTNYUINRRK-REC
      *
           .
       20011-NOW-BTUNUM-CNT-EXT.
           EXIT.
      *****************************************************************
      *    個別処理
      *****************************************************************
       2002-KOBETU-SYORI-SEC               SECTION.
      *
      *    定期請求指示（個別指示）コード読み込み
           INITIALIZE                      SYS-5012-REC
           MOVE    "5012"              TO  SYS-5012-KANRICD
           MOVE    ZERO                TO  ORC-DBYMD
           MOVE    SYS-5012-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               PERFORM 900-SYS5012-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYS5012
           END-IF
      *
           PERFORM 20021-KOBETU-HENSYU-SEC
                              UNTIL       FLG-SYS5012     =   1
                              OR          FLG-END         =   1
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
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
           IF    ( FLG-END         =   1 )
               GO  TO  20021-KOBETU-HENSYU-EXT
           END-IF
      *
           PERFORM VARYING IDX10   FROM    1   BY  1
                   UNTIL ( IDX10   >   WRK-KIKAN-MAX )
      *
               MOVE    WRK-KIKANST (IDX10)
                                       TO  WRK-TEIKISTYMD
               MOVE    WRK-KIKANED (IDX10)
                                       TO  WRK-TEIKIEDYMD
      *
      *        個別ダミー収納削除処理
               INITIALIZE                  SYUNOU-REC
               MOVE    SYS-1001-HOSPID     TO  SYU-HOSPID
               MOVE    "1"                 TO  SYU-NYUGAIKBN
               MOVE    SYS-5012-PTID       TO  SYU-PTID
               MOVE    "X"                 TO  SYU-DENPJTIKBN
               MOVE    SYUNOU-REC          TO  MCPDATA-REC
               MOVE    "SYUNOU-DEL4"       TO  ORC-DBPATH
               MOVE    "DBDELETE"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF  (   MCP-RC          NOT =   ZERO )
                   MOVE  "個別の仮収納データの削除処理に失敗しました"
                                   TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  20021-KOBETU-HENSYU-EXT
               END-IF
      *
      *
      *        同一期間で定期請求処理された収納明細を削除（暫定）
               INITIALIZE                  SYUNOU-REC
               MOVE    SYS-1001-HOSPID     TO  SYU-HOSPID
               MOVE    "1"                 TO  SYU-NYUGAIKBN
               MOVE    SYS-5012-PTID       TO  SYU-PTID
               MOVE    "A"                 TO  SYU-DENPJTIKBN
               MOVE    WRK-TEIKISTYMD      TO  SYU-SKYSTYMD
               MOVE    WRK-TEIKIEDYMD      TO  SYU-SKYEDYMD
               MOVE    "SYUNOU-KEY8"       TO  WRK-DBPATH
               PERFORM 2003-TEIKISYUMEI-DEL-SEC
               IF    ( FLG-END =   1 )
                   GO  TO  20021-KOBETU-HENSYU-EXT
               END-IF
      *
               INITIALIZE                  SYUNOU-REC
               MOVE    SYS-1001-HOSPID     TO  SYU-HOSPID
               MOVE    "1"                 TO  SYU-NYUGAIKBN
               MOVE    SYS-5012-PTID       TO  SYU-PTID
               MOVE    "A"                 TO  SYU-DENPJTIKBN
               MOVE    WRK-TEIKISTYMD      TO  SYU-SKYSTYMD
               MOVE    WRK-TEIKIEDYMD      TO  SYU-SKYEDYMD
               MOVE    SYUNOU-REC          TO  MCPDATA-REC
               MOVE    "SYUNOU-DEL5"       TO  ORC-DBPATH
               MOVE    "DBDELETE"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"             USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
               IF  (   MCP-RC          NOT =   ZERO )
                   MOVE  "収納データの更新処理に失敗しました"
                                   TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  20021-KOBETU-HENSYU-EXT
               END-IF
      *
      *        入院履歴読み込み
               INITIALIZE              PTNYUINRRK-REC
               MOVE    SYS-1001-HOSPID     TO  PTNYUINRRK-HOSPID
               MOVE    SYS-5012-PTID       TO  PTNYUINRRK-PTID
               MOVE    WRK-TEIKIEDYMD      TO  PTNYUINRRK-NYUINYMD
               MOVE    WRK-TEIKIEDYMD      TO  PTNYUINRRK-TAIINYMD
               MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "PTNYUINRRK-KEY10"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC          =   ZERO )
                   MOVE    "PTNYUINRRK-KEY10"  TO  ORC-DBPATH
                   PERFORM 900-PTNYUINRRK-READ-SEC
               ELSE
                   INITIALIZE          PTNYUINRRK-REC
                   MOVE    1           TO  FLG-PTNYUINRRK
               END-IF
      *
      *        カーソルクロース
               MOVE    "DBCLOSE"           TO  MCP-FUNC
               MOVE    "PTNYUINRRK-KEY10"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
               IF    ( FLG-PTNYUINRRK  =   ZERO )
                   PERFORM 20011-HENSYU-SEC
                   IF    ( FLG-END     =   1 )
                       GO  TO  20021-KOBETU-HENSYU-EXT
                   END-IF
               END-IF
           END-PERFORM
      *
           PERFORM 900-SYS5012-READ-SEC
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
      *    請求期間編集
           INITIALIZE                      SYS-5010-REC
           MOVE    "5010"              TO  SYS-5010-KANRICD
           MOVE    "*"                 TO  SYS-5010-KBNCD
           MOVE    SYS-5012-SRYYM      TO  ORC-DBYMD (1 : 6)
           MOVE    "01"                TO  ORC-DBYMD (7 : 2)
      *
           MOVE    SYS-5010-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-5010-REC
           ELSE
               MOVE    "定期請求管理情報の取得に失敗しました"
                                           TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20021-SEIKYU-KIKAN-GET-EXT
           END-IF
      *
           IF    ( SYS-5012-SAKKBN =   "1" OR  "2" )
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
           END-IF
      *
           IF    ( SYS-5012-SAKKBN =   "1" OR  "3" )
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
           END-IF
           IF    ( SYS-5012-SAKKBN =   "1" OR  "4" )
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
           END-IF
      *
           IF    ( WRK-KIKAN-MAX   <=  ZERO )
               MOVE    "定期期間の取得に失敗しました"
                                           TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  20021-SEIKYU-KIKAN-GET-EXT
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
           MOVE    "71"                TO   LNK-DAY7-IRAI
           MOVE    WRK-YMD (1 : 6)     TO   LNK-DAY7-YM
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
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
           CALL  "ORCSDAY"             USING   STS-AREA-DAY
                                           LNK-DAY6-AREA
           MOVE    LNK-DAY6-KEISAN     TO  WRK-YMD
      *
           .
       20021-YOKUZITU-GET-EXT.
            EXIT.
      *****************************************************************
      *    定期請求収納明細データ削除処理
      *****************************************************************
       2003-TEIKISYUMEI-DEL-SEC        SECTION.
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               MOVE    WRK-DBPATH      TO  ORC-DBPATH
               PERFORM 910-SYUNOU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SYUNOU
               INITIALIZE                  SYUNOU-REC
           END-IF
      *
           PERFORM UNTIL ( FLG-SYUNOU  NOT =   ZERO )
      *
               INITIALIZE               SYUMEI-REC
               MOVE    SYU-HOSPID       TO  SMEI-HOSPID
               MOVE    SYU-NYUGAIKBN    TO  SMEI-NYUGAIKBN
               MOVE    SYU-PTID         TO  SMEI-PTID
               MOVE    SYU-DENPNUM      TO  SMEI-DENPNUM
               MOVE    SYUMEI-REC       TO  MCPDATA-REC
               MOVE    "SYUMEI-DEL2"    TO  ORC-DBPATH
               MOVE    "DBDELETE"       TO  MCP-FUNC
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF  (   MCP-RC          NOT =   ZERO )
                   MOVE  "収納明細データの更新に失敗しました"
                                       TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  2003-TEIKISYUNOU-DEL-EXT
               END-IF
      *
               MOVE    WRK-DBPATH      TO  ORC-DBPATH
               PERFORM 910-SYUNOU-READ-SEC
      *
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       2003-TEIKISYUNOU-DEL-EXT.
            EXIT.
      *****************************************************************
      *    定期請求管理情報削除処理
      *****************************************************************
       2003-TEIKIKANRI-DEL-SEC         SECTION.
      *
           MOVE    SPACE               TO  MCPDATA-REC
           MOVE    "TEIKIKANRI-DEL1"   TO  ORC-DBPATH
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF  (   MCP-RC          NOT =   ZERO )
               MOVE  "定期請求管理データの削除に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  2003-TEIKIKANRI-DEL-EXT
           END-IF
      *
           .
       2003-TEIKIKANRI-DEL-EXT.
            EXIT.
      *****************************************************************
      *    定期請求印刷情報削除処理
      *****************************************************************
       2003-TEIKIPRT-DEL-SEC           SECTION.
      *
           MOVE    SPACE               TO  MCPDATA-REC
           MOVE    "TEIKIPRT-DEL1"     TO  ORC-DBPATH
           MOVE    "DBDELETE"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF  (   MCP-RC          NOT =   ZERO )
               MOVE  "定期請求印刷情報データの削除に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  2003-TEIKIPRT-DEL-EXT
           END-IF
      *
           .
       2003-TEIKIPRT-DEL-EXT.
            EXIT.
      *****************************************************************
      *    定期請求管理追加処理
      *****************************************************************
       2003-TEIKIKANRI-INS-SEC         SECTION.
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   WRK-BTUCNT-TBL-MAX )
      *
               INITIALIZE  TEIKIKANRI-REC
      *
               MOVE    WRK-BTUCNT-BTUNUM (IDX2)
                                   TO  TEIKIKANRI-BTUNUM
               MOVE    WRK-PARA-SYOKBN
                                   TO  TEIKIKANRI-SYOKBN
               MOVE    WRK-PARA-SYSYMD
                                   TO  TEIKIKANRI-CREYMD
               MOVE    SYS-TIME    TO  TEIKIKANRI-CREHMS
               IF    ( WRK-PARA-SYOKBN
                                   =   "1" )
                   MOVE    WRK-PARA-SRYYM
                                   TO  TEIKIKANRI-SRYYM
               ELSE
                   MOVE    SPACE   TO  TEIKIKANRI-SRYYM
               END-IF
               MOVE    WRK-BTUCNT-CNT (IDX2)
                                   TO  TEIKIKANRI-PAGE
                                       TEIKIKANRI-KENSU
               MOVE    WRK-PARA-TERMID
                                   TO  TEIKIKANRI-TERMID
      *
      *        更新対象のデータがすでに存在する場合はエラー
               PERFORM 900-TEIKIKANRI-READ-SEC
               IF    ( FLG-TEIKIKANRI  =   ZERO )
                   MOVE  "定期請求管理データの作成に失敗しました"
                                       TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  2003-TEIKIKANRI-INS-EXT
               END-IF
      *
      *        定期請求管理データ作成
               MOVE    TEIKIKANRI-REC      TO  MCPDATA-REC
               MOVE    "TEIKIKANRI-KEY"    TO  ORC-DBPATH
               MOVE    "DBINSERT"          TO  MCP-FUNC
               CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF  (   MCP-RC          NOT =   ZERO )
                   MOVE  "定期請求管理データの作成に失敗しました"
                                           TO  WRK-TEIKIERR
                   PERFORM 500-ERR-HENSYU-SEC
                   GO  TO  2003-TEIKIKANRI-INS-EXT
               END-IF
      *
           END-PERFORM
      *
           .
       2003-TEIKIKANRI-INS-EXT.
            EXIT.
      *****************************************************************
      *    定期請求印刷情報作成
      *****************************************************************
       2003-TEIKIPRT-INS-SEC           SECTION.
      *
           INITIALIZE  TEIKIPRT-REC
           MOVE    WRK-TEIKI-BTUNUM    TO  TEIKIPRT-BTUNUM
           MOVE    WRK-PTINF-PTID      TO  TEIKIPRT-PTID
           MOVE    WRK-PTINF-PTNUM     TO  TEIKIPRT-PTNUM
           MOVE    WRK-PTINF-NAME      TO  TEIKIPRT-NAME
           MOVE    WRK-TEIKI-DENPNUM   TO  TEIKIPRT-DENPNUM
      *
      *    更新対象のデータがすでに存在する場合はエラー
           PERFORM 900-TEIKIPRT-READ-SEC
           IF    ( FLG-TEIKIPRT    =   ZERO )
               MOVE  "定期請求印刷情報データの作成に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  2003-TEIKIPRT-INS-EXT
           END-IF
      *
      *    定期請求管理データ作成
           MOVE    TEIKIPRT-REC        TO  MCPDATA-REC
           MOVE    "TEIKIPRT-KEY"      TO  ORC-DBPATH
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF  (   MCP-RC          NOT =   ZERO )
               MOVE  "定期請求印刷情報データの作成に失敗しました"
                                       TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  2003-TEIKIPRT-INS-EXT
           END-IF
      *
           .
       2003-TEIKIPRT-INS-EXT.
            EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           DISPLAY "WRK-TEIKIERR = " WRK-TEIKIERR
           DISPLAY "TEIKIERR = " TEIKIERR
           OPEN    INPUT   TEIKIERR-FILE
           IF      STS-TEIKIERR         =   ZERO
               CLOSE   TEIKIERR-FILE
           ELSE
               OPEN    OUTPUT              TEIKIERR-FILE
      *
               MOVE    WRK-TEIKIERR         TO  TEIKIERR-REC
               WRITE   TEIKIERR-REC
               CLOSE   TEIKIERR-FILE
      *         
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-TEIKIERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"       USING
                                       ORCSJOBKANRIAREA  
                                       JOBKANRI-REC
           END-IF
      *                             
           MOVE    1                   TO  FLG-END
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           IF      CNT-OUT1            =   ZERO 
               MOVE    "処理対象のデータがありませんでした"
                                           TO  WRK-TEIKIERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *     
           DISPLAY "TEIKI01  CNT " CNT-OUT1 
           DISPLAY "*** ORCT0010 END ***"
      ***  ACCEPT  WRK-IN FROM CONSOLE 
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    期間算出処理
      *****************************************************************
       5002-KIKAN-CALC-SEC             SECTION.
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
               GO  TO              5002-KIKAN-CALC-EXT
           END-IF
      *
           MOVE    LNK-DAY5-NISSU1     TO  WRK-NISSU1
           MOVE    LNK-DAY5-NISSU2     TO  WRK-NISSU2
      *
           .
       5002-KIKAN-CALC-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       900-SYS5012-READ-SEC         SECTION.
      *
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYS5012
               MOVE    MCPDATA-REC     TO  SYS-5012-REC
           ELSE
               MOVE    1               TO  FLG-SYS5012
           END-IF
           .
       900-SYS5012-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       910-SYSKANRI-INV-SEC         SECTION.
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
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
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
       910-SYSKANRI-INV-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    入院履歴マスタ　ＲＥＡＤ
      *****************************************************************
       900-PTNYUINRRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    ZERO            TO  FLG-PTNYUINRRK
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK
               GO  TO  900-PTNYUINRRK-READ-EXT
           END-IF
      *
           .
       900-PTNYUINRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院履歴マスタ　ＲＥＡＤ
      *****************************************************************
       910-PTNYUINRRK-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    ZERO            TO  FLG-PTNYUINRRK2
               MOVE    MCPDATA-REC     TO  PTNYUINRRK-REC
           ELSE
               MOVE    1               TO  FLG-PTNYUINRRK2
               GO  TO  910-PTNYUINRRK-READ-EXT
           END-IF
      *
           .
       910-PTNYUINRRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院履歴マスター読込（主キー）
      *****************************************************************
       920-PTNYUINRRK-READ-SEC     SECTION.
      *
           MOVE    ZERO            TO  FLG-PTNYUINRRK2
      *
           MOVE    PTNYUINRRK-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNYUINRRK-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF    ( MCP-RC              =   ZERO )
               MOVE    "DBFETCH"   TO  MCP-FUNC
               MOVE    "PTNYUINRRK-KEY"
                                   TO  ORC-DBPATH
               CALL    "ORCMCPSUB"     USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF    ( MCP-RC      =   ZERO )
                   MOVE    MCPDATA-REC
                                   TO  PTNYUINRRK-REC
               ELSE
                   MOVE    1       TO  FLG-PTNYUINRRK2
               END-IF
           ELSE
               MOVE    1           TO  FLG-PTNYUINRRK2
           END-IF
      *
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNYUINRRK-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       920-PTNYUINRRK-READ-EXT.
           EXIT.
      *****************************************************************
      *    収納マスター読込（主キー）
      *****************************************************************
       900-SYUNOU-READ-SEC         SECTION.
      *
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  SYUNOU-REC
                   MOVE    ZERO                TO  FLG-SYUNOU
               ELSE
                   MOVE    1                   TO  FLG-SYUNOU
                   INITIALIZE                  SYUNOU-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYUNOU
               INITIALIZE                  SYUNOU-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-SYUNOU-READ-EXT.
           EXIT.
      *****************************************************************
      *    収納マスター読込
      *****************************************************************
       910-SYUNOU-READ-SEC         SECTION.
      *
           DISPLAY "SYUNOU-READ START"
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYUNOU-REC
               MOVE    ZERO                TO  FLG-SYUNOU
           ELSE
               MOVE    1                   TO  FLG-SYUNOU
               INITIALIZE                  SYUNOU-REC
           END-IF
           DISPLAY "SYUNOU-READ END FLG = " FLG-SYUNOU
      *
           .
       910-SYUNOU-READ-EXT.
           EXIT.
      *****************************************************************
      *    収納明細読込（主キー）
      *****************************************************************
       900-SYUMEI-READ-SEC         SECTION.
      *
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  SYUMEI-REC
                   MOVE    ZERO                TO  FLG-SYUMEI
               ELSE
                   MOVE    1                   TO  FLG-SYUMEI
                   INITIALIZE                  SYUMEI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYUMEI
               INITIALIZE                  SYUMEI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUMEI-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-SYUMEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納明細読込
      *****************************************************************
       910-SYUMEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           MOVE    "SYUMEI-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYUMEI-REC
               MOVE    ZERO                TO  FLG-SYUMEI
           ELSE
               MOVE    1                   TO  FLG-SYUMEI
               INITIALIZE                  SYUMEI-REC
           END-IF
      *
           .
       910-SYUMEI-READ-EXT.
           EXIT.
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
               CALL    "ORCMCPSUB"         USING
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
      *
      *****************************************************************
      *    請求管理マスタ読込
      *****************************************************************
       900-TEIKIKANRI-READ-SEC         SECTION.
      *
           MOVE    TEIKIKANRI-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TEIKIKANRI-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TEIKIKANRI-KEY"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-TEIKIKANRI
                   MOVE   MCPDATA-REC      TO  TEIKIKANRI-REC
               ELSE
                   MOVE    1               TO  FLG-TEIKIKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TEIKIKANRI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TEIKIKANRI-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-TEIKIKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求印刷情報読込
      *****************************************************************
       900-TEIKIPRT-READ-SEC         SECTION.
      *
           MOVE    TEIKIPRT-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TEIKIPRT-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TEIKIPRT-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-TEIKIPRT
                   MOVE   MCPDATA-REC      TO  TEIKIPRT-REC
               ELSE
                   MOVE    1               TO  FLG-TEIKIPRT
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TEIKIPRT
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TEIKIPRT-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-TEIKIPRT-READ-EXT.
           EXIT.
      *
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
       900-DBCLOSE-EXT.
           EXIT.
