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
      *
           03  FLG-OK              PIC 9(01).
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
           03  WRK-EDANUM          PIC 9(04).
      *
           03  WRK-N-IDX          PIC 9(04).
      *    半角全角変換
       01  WRK-HENKAN-AREA.
           03  WRK-MAE-INPUT       PIC X(100).
           03  WRK-ATO-INPUT       PIC X(100).
           03  WRK-MAX             PIC 9(04).
      *    入力項目名
           03  WRK-MCP-WIDGET          PIC X(64).
      *
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
      *    システム管理（損傷区分）
           COPY    "CPSK4002.INC".
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
      *    ＤＢ検索
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
           COPY    "P02.INC".
           COPY    "P02A.INC".
           COPY    "P02D.INC".
           COPY    "P02E.INC".
           COPY    "P02F.INC".
           COPY    "P014.INC".
           COPY    "P98.INC".
           COPY    "P981.INC".
           COPY    "P99.INC".
           COPY    "P0201.INC".
           COPY    "P982.INC".
           COPY    "P100.INC".
           COPY    "P02X.INC".
           COPY    "PERR.INC".
           COPY    "PID1.INC".
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
      *
           IF      SPA-GMN-HKNNUM      =   SPACE
      *        [新規入力]
      *        保険情報
      *********MOVE    "971"               TO  SPA-GMN-HKNNUM
      *        労災保険情報
               MOVE    SPACE               TO  SPA-P02D-AREA
               INITIALIZE                      SPA-P02D-AREA
      *        保険番号
      *******  MOVE    "971"               TO  SPA-NAI2D-HKNNUM
               MOVE    ZERO                TO  SPA-NAI2D-GMNIDX
               MOVE    SPA-GMN-NAME        TO  SPA-GMN2D-HIHKNJANAME
           ELSE
      *
      *        労災保険情報
               MOVE    SPACE               TO  SPA-P02D-AREA
               INITIALIZE                      SPA-P02D-AREA
      *        労災分
               PERFORM 3001-RSHKN-SET-SEC
           END-IF
      *
      *    コンボボクスの編集
           PERFORM 3002-COMBBOX-HEX-SEC
      *
           .
       300-SCREEN-EXT.
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
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "PTRSIINF"          TO  PARA-FILEMEI
           MOVE    SPA-NAI-RSHKN-EDANUM
                                       TO  PARA-EDANUM
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           IF      FLG-PARA           =   1
               INITIALIZE                      PTRSIINF-REC
           ELSE
               MOVE    PARA-DATA-REC       TO  PTRSIINF-REC
           END-IF
      *
      *    労災保険区分
           MOVE    PTRSI-HKNKBN        TO  SPA-GMN2D-HKNKBN
           MOVE    PTRSI-HKNKBN        TO  SPA-NAI2D-HKNKBN-MAE
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
           .
       3001-RSHKN-SET-EXT.
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
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-HKNKBN-MAX
               IF      SPA-GMN2D-HKNKBN-LST(IDX) (1:1)
                                           =   SPA-GMN2D-HKNKBN
                   MOVE    SPA-GMN2D-HKNKBN-LST (IDX)
                                           TO  SPA-GMN2D-HKNKBN-G
               END-IF
           END-PERFORM
      *
      *    災害区分
           MOVE    "1 業務中の災害"    TO  SPA-GMN2D-SAIGAI-LST (01)
           MOVE    "2 通勤途上の災害"  TO  SPA-GMN2D-SAIGAI-LST (02)
           MOVE    2                   TO  SPA-GMN2D-SAIGAI-MAX
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
           PERFORM 41012-SINKEI-SET-SEC
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
           MOVE    "1 治癒"            TO  SPA-GMN2D-TENKI-LST (01)
           MOVE    "3 継続"            TO  SPA-GMN2D-TENKI-LST (02)
           MOVE    "5 転医"            TO  SPA-GMN2D-TENKI-LST (03)
           MOVE    "7 中止"            TO  SPA-GMN2D-TENKI-LST (04)
           MOVE    "9 死亡"            TO  SPA-GMN2D-TENKI-LST (05)
           MOVE    5                   TO  SPA-GMN2D-TENKI-MAX
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
           MOVE    "0 なし"            TO  SPA-GMN2D-SISIKBN-LST (01)
           MOVE    "1 四肢"            TO  SPA-GMN2D-SISIKBN-LST (02)
           MOVE    "2 手指"            TO  SPA-GMN2D-SISIKBN-LST (03)
           MOVE    3                   TO  SPA-GMN2D-SISIKBN-MAX
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-SISIKBN-MAX
               IF      SPA-GMN2D-SISIKBN-LST(IDX) (1:1)
                                           =   SPA-GMN2D-SISIKBN
                   MOVE    SPA-GMN2D-SISIKBN-LST (IDX)
                                           TO  SPA-GMN2D-SISIKBN-G
               END-IF
           END-PERFORM
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
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-PREFKBN-MAX
               IF      SPA-GMN2D-PREFKBN-LST(IDX) (1:1)
                                           =   SPA-GMN2D-PREFKBN
                   MOVE    SPA-GMN2D-PREFKBN-LST (IDX)
                                           TO  SPA-GMN2D-PREFKBN-G
               END-IF
           END-PERFORM
      *
           MOVE    "1 郡"              TO  SPA-GMN2D-CITYKBN-LST (01)
           MOVE    "2 市"              TO  SPA-GMN2D-CITYKBN-LST (02)
           MOVE    "3 区"              TO  SPA-GMN2D-CITYKBN-LST (03)
           MOVE    3                   TO  SPA-GMN2D-CITYKBN-MAX
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN2D-CITYKBN-MAX
               IF      SPA-GMN2D-CITYKBN-LST(IDX) (1:1)
                                           =   SPA-GMN2D-CITYKBN
                   MOVE    SPA-GMN2D-CITYKBN-LST (IDX)
                                           TO  SPA-GMN2D-CITYKBN-G
               END-IF
           END-PERFORM
      *
      *    損傷区分
           MOVE    SPACE               TO  SYS-4002-REC
           INITIALIZE                  SYS-4002-REC
           MOVE    "4002"              TO  SYS-4002-KANRICD
      *    システム管理検索
           MOVE    SYS-4002-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           ELSE
               INITIALIZE                  SYS-4002-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    ZERO                TO  IDX
           PERFORM
                   UNTIL      (FLG-SYSKANRI    =   1 )  OR
                              (IDX             >=  30)
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
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-KANRIMST-READ-SEC
           END-PERFORM
      *
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
           .
       3002-COMBBOX-HEX-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           MOVE    SPACE               TO  P02D
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
      *
      *****MOVE    SPA-GMN2D-KENSAYMD      TO  P02D-KENSAYMD
      *
      *    リスト
      *****PERFORM VARYING     IDX     FROM    1   BY  1
      *            UNTIL       IDX     >   SPA-GMN2D-SISI-MAX
      *        MOVE    SPA-GMN2D-TSINSATUYMD (IDX)
      *                                TO  P02D-TSINSATUYMD (IDX)
      *        MOVE    SPA-GMN2D-TKENSAYMD   (IDX)
      *                                TO  P02D-TKENSAYMD (IDX)
      *        MOVE    SPA-GMN2D-TSONSHOUKBN (IDX)
      *                                TO  P02D-TSONSHOUKBN (IDX)
      *    END-PERFORM
      *****MOVE    SPA-GMN2D-SISI-MAX   TO  P02D-SISIKBNLST-COUNT
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
               WHEN    16
                   MOVE    "KOHNUM3"           TO  MCP-WIDGET
               WHEN    17
                   MOVE    "SONSHOUKBN"        TO  MCP-WIDGET
               WHEN    18
                   MOVE    "SINSATUYMD"        TO  MCP-WIDGET
               WHEN    19
                   MOVE    "SINSATUEND"        TO  MCP-WIDGET
      *********WHEN    19
      **********   MOVE    "KENSAYMD"          TO  MCP-WIDGET
               WHEN    20
                   MOVE    "B12"               TO  MCP-WIDGET
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
               WHEN    "SISIKBN"
                   MOVE    08              TO  SPA-GMN2D-CUR
               WHEN    "SHOBYOYMD"
                   MOVE    09              TO  SPA-GMN2D-CUR
               WHEN    "RYOSTYMD"
                   MOVE    10              TO  SPA-GMN2D-CUR
               WHEN    "RYOEDYMD"
                   MOVE    11              TO  SPA-GMN2D-CUR
               WHEN    "JIGYOUNAME"
                   MOVE    12              TO  SPA-GMN2D-CUR
               WHEN    "PREFNAME"
                   MOVE    13              TO  SPA-GMN2D-CUR
               WHEN    "PREFKBN"
                   MOVE    14              TO  SPA-GMN2D-CUR
               WHEN    "CITYNAME"
                   MOVE    15              TO  SPA-GMN2D-CUR
               WHEN    "CITYKBN"
                   MOVE    20              TO  SPA-GMN2D-CUR
               WHEN    "KOHNUM3"
                   MOVE    17              TO  SPA-GMN2D-CUR
               WHEN    "SONSHOUKBN"
                   MOVE    18              TO  SPA-GMN2D-CUR
               WHEN    "SINSATUYMD"
                   MOVE    19              TO  SPA-GMN2D-CUR
               WHEN    "SINSATUEND"
                   MOVE    20              TO  SPA-GMN2D-CUR
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
      *    入力チェック処理
           PERFORM 410-INPUT-CHK-SEC
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
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      410-INPUT-CHK-EXT
           END-IF
      *
      *    登録時、必須入力チェック
           IF      FLG-TOUROKU         =   1
               PERFORM 4109-TOUROKU-CHK-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   GO      TO      410-INPUT-CHK-EXT
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
           MOVE    P02D-HIHKNJANAME    TO  SPA-GMN2D-HIHKNJANAME
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
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-COMMENT-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-KOFUNUM-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-KOHNUM2-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-SAIGAI-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-SINKEI-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-TENKI-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-SISIKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-SHOBYOYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-RYOSTYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-RYOEDYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-JIGYOUNAME-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-PREFNAME-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-PREFKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-CITYNAME-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-CITYKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-KOHNUM3-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-SONSHOUKBN-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-SINSATUYMD-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
      *
           PERFORM 4101-SINSATUEND-CHK-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO      TO      4102-KIHON-CHK-EXT
           END-IF
           .
      *
       4102-KIHON-CHK-EXT.
           EXIT.
      *
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
           IF      SPA-NAI-RSHKN-EDANUM    =   ZERO
               PERFORM 41011-SYOKI-SET-SEC
           END-IF
      *
          .
       4101-HKNKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    被保険名初期表示　処理
      *****************************************************************
       41011-SYOKI-SET-SEC           SECTION.
      *
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
               WHEN    "2"
      *            新継再別編集
                   PERFORM 41012-SINKEI-SET-SEC
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
      *************IF      SPA-GMN2D-CITYKBN   =   SPACE
      *                 MOVE    SPA-GMN2D-CITYKBN-LST (01)
      *                                        TO  SPA-GMN2D-CITYKBN-G
      *************END-IF
      *
               WHEN    "3"
                   IF      SPA-GMN2D-SONSHOUKBN   =   SPACE
                       MOVE    SPA-GMN2D-SONSHOUKBN-LST (01)
                                           TO  SPA-GMN2D-SONSHOUKBN-G
                   END-IF
               WHEN    "4"
      *            自賠責
                   PERFORM 41012-SINKEI-SET-SEC
                   MOVE    SPACE           TO  SPA-GMN2D-SINKEI-G
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
      *            災害区分
                   MOVE   SPACE                TO  SPA-GMN2D-SAIGAI-G
           END-EVALUATE
      *
          .
       41011-SYOKI-SET-EXT.
           EXIT.
      *****************************************************************
      *    新継再別編集処理
      *****************************************************************
       41012-SINKEI-SET-SEC           SECTION.
      *
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
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN2D-COMMENT   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
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
               GO      TO      4101-KOFUNUM-CHK-EXT
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
               GO      TO      4101-KOHNUM2-CHK-EXT
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
                   GO      TO                  4101-SHOBYOYMD-CHK-EXT
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
                   GO      TO      4101-RYOSTYMD-CHK-EXT
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
                   GO      TO                  4101-RYOSTYMD-CHK-EXT
               END-IF
           END-IF
      *
      *    傷病年月日＞療養開始日はエラーとする
           IF      SPA-NAI2D-SHOBYOYMD >   SPA-NAI2D-RYOSTYMD
               MOVE    "0030"              TO  SPA-ERRCD
               MOVE    9                   TO  SPA-GMN2D-CUR
               GO      TO                  4101-RYOSTYMD-CHK-EXT
           END-IF
      *
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
      *    半角空白→全角空白
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN2D-JIGYOUNAME
                                       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
               MOVE    "0029"              TO  SPA-ERRCD
               MOVE    11                  TO  SPA-GMN2D-CUR
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
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    SPA-GMN2D-CITYNAME
                                       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF     (KANACHK-RC      NOT =   ZERO  )  OR
                  (KANACHK-SYUBETU     =   1     )
               MOVE    "0030"              TO  SPA-ERRCD
               MOVE    14                  TO  SPA-GMN2D-CUR
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
               GO      TO      4101-KOHNUM3-CHK-EXT
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
                   GO      TO      4101-SINSATUYMD-CHK-EXT
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
                   GO      TO                  4101-SINSATUYMD-CHK-EXT
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
                   GO      TO                  4101-SINSATUEND-CHK-EXT
               END-IF
           END-IF
      *
           IF      SPA-NAI2D-SINSATUYMD    >   SPA-NAI2D-SINSATUEND
               MOVE    "0011"              TO  SPA-ERRCD
               MOVE    19                  TO  SPA-GMN2D-CUR
           END-IF
      *
           .
       4101-SINSATUEND-CHK-EXT.
           EXIT.
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
           MOVE    "1"                 TO  SPA-NAI-SAKJOKBN
      *
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "PTRSIINF"          TO  PARA-FILEMEI
           MOVE    SPA-NAI-RSHKN-EDANUM
                                       TO  PARA-EDANUM
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           IF      FLG-PARA           =    ZERO
               MOVE    PARA-DATA-REC       TO  PTRSIINF-REC
               MOVE    "1"                 TO  PTRSI-SAKUJOKBN
               MOVE    PTRSIINF-REC        TO  PARA-DATA-REC
      *
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                           ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P02D PARA UPD ERR:"  MCP-RC
               END-IF
           END-IF
      *
      *
           MOVE    1                   TO  FLG-END
      *
      *    終了へ
           PERFORM 210-BACK
      *
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
           IF  SPA-ERRCD         NOT =   SPACE
               GO  TO                490-TOROKU-EXT
           END-IF
      *
      *    保険期間重複チェック
           PERFORM 49011-KANREN-HKN-CHECK-SEC
           IF  SPA-ERRCD         NOT =   SPACE
               GO  TO                490-TOROKU-EXT
           END-IF
      *
      *    患者保険処理
           PERFORM 49012-PTHKNINF-HEN-SEC
      *
      *    労災保険編集処理
           PERFORM 4905-PTRSIINF-HEN-SEC
      *
           MOVE    SPACE               TO  SPA-RSPAR-FLG
      *
           MOVE    1                   TO  FLG-END
      *
      *    終了へ
           PERFORM 210-BACK
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
                       MOVE    "0022"              TO  SPA-ERRCD
                       MOVE    3                   TO  SPA-GMN2D-CUR
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF
                   IF      SPA-GMN2D-SAIGAI        =   SPACE
                       MOVE    "0027"              TO  SPA-ERRCD
                       MOVE    21                  TO  SPA-GMN2D-CUR
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF
                   IF      SPA-GMN2D-SHOBYOYMD     =   SPACE
                       MOVE    "0025"              TO  SPA-ERRCD
                       MOVE    8                   TO  SPA-GMN2D-CUR
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF
                   IF      SPA-GMN2D-RYOSTYMD =   SPACE
                       MOVE    "0012"              TO  SPA-ERRCD
                       MOVE    9                   TO  SPA-GMN2D-CUR
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF
      *        傷病
               WHEN    "2"
                   IF      SPA-GMN2D-KOHNUM2   =   SPACE
                       MOVE    "0023"              TO  SPA-ERRCD
                       MOVE    4                   TO  SPA-GMN2D-CUR
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF
                   IF      SPA-GMN2D-SAIGAI        =   SPACE
                       MOVE    "0027"              TO  SPA-ERRCD
                       MOVE    21                  TO  SPA-GMN2D-CUR
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF
                   IF      SPA-GMN2D-SHOBYOYMD     =   SPACE
                       MOVE    "0025"              TO  SPA-ERRCD
                       MOVE    8                   TO  SPA-GMN2D-CUR
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF
                   IF      SPA-GMN2D-RYOSTYMD      =   SPACE
                       MOVE    "0012"              TO  SPA-ERRCD
                       MOVE    9                   TO  SPA-GMN2D-CUR
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF
               WHEN    "3"
                   IF      SPA-GMN2D-KOHNUM3   =   SPACE
                       MOVE    "0024"              TO  SPA-ERRCD
                       MOVE    16                  TO  SPA-GMN2D-CUR
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF
                   IF      SPA-GMN2D-SINSATUYMD    =   SPACE
                       MOVE    "0019"              TO  SPA-ERRCD
                       MOVE    18                  TO  SPA-GMN2D-CUR
                   END-IF
      *        自賠責
               WHEN    "4"
                   IF      SPA-GMN2D-SHOBYOYMD     =   SPACE
                       MOVE    "0025"              TO  SPA-ERRCD
                       MOVE    8                   TO  SPA-GMN2D-CUR
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF
                   IF      SPA-GMN2D-RYOSTYMD      =   SPACE
                       MOVE    "0012"              TO  SPA-ERRCD
                       MOVE    9                   TO  SPA-GMN2D-CUR
                       GO      TO      4109-TOUROKU-CHK-EXT
                   END-IF
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
      *    新規の時、保険ＩＤ計算
           IF      SPA-NAI-HKNID       =   ZERO
               ADD     1                   TO  SPA-PTNUM-HKNID
               MOVE    SPA-PTNUM-HKNID     TO  SPA-NAI-HKNID
           END-IF
      *
           EVALUATE    SPA-GMN2D-HKNKBN
               WHEN    "1"
               WHEN    "2"
               WHEN    "3"
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
           MOVE    SPA-HOSPID          TO  PTRSI-HOSPID
           MOVE    SPA-GMN-PTID        TO  PTRSI-PTID
           MOVE    SPA-GMN2D-HKNKBN    TO  PTRSI-HKNKBN
           MOVE    SPA-NAI2D-HKNNUM    TO  PTRSI-HKNNUM
           MOVE    SPA-NAI-HKNID       TO  PTRSI-HKNID
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
      *        短期・傷病・自賠責
                   MOVE    SPA-GMN2D-TENKI     TO  PTRSI-TENKI
                   MOVE    SPA-NAI2D-SHOBYOYMD TO  PTRSI-SHOBYOYMD
                   MOVE    SPA-GMN2D-SISIKBN   TO  PTRSI-SISIKBN
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
      *    確認年月日
           MOVE    SPA-NAI2D-KAKUNINYMD
                                       TO  PTRSI-KAKUNINYMD
      *
      *****MOVE    PTRSIINF-REC        TO  RSPAR-REC
      *
      *
           IF      SPA-NAI-RSHKN-EDANUM    =   ZERO
               ADD     1                   TO  SPA-P02-RSHKNMAX
               MOVE    SPA-P02-RSHKNMAX    TO  SPA-NAI-RSHKN-EDANUM
           END-IF
      *
      *
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
           MOVE    "PTRSIINF"          TO  PARA-FILEMEI
           MOVE    SPA-NAI-RSHKN-EDANUM
                                       TO  PARA-EDANUM
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY"          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           IF      FLG-PARA           =   1
      *        追加
               INITIALIZE                      PARA-REC
               MOVE    "P02"               TO  PARA-GYOUMUID
               MOVE    SPA-TERMID          TO  PARA-TERMID
               MOVE    "PTRSIINF"          TO  PARA-FILEMEI
               MOVE    SPA-NAI-RSHKN-EDANUM
                                           TO  PARA-EDANUM
               MOVE    PTRSIINF-REC        TO  PARA-DATA-REC
      *
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                           ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P02D PARA INS ERR:"  MCP-RC
               END-IF
           ELSE
               MOVE    PTRSIINF-REC        TO  PARA-DATA-REC
      *
               MOVE    PARA-REC            TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PARA-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                           ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P02D PARA UPD ERR:"  MCP-RC
               END-IF
           END-IF
      *
           .
       4905-PTRSIINF-HEN-EXT.
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
                   MOVE    "労働保険番号は半角１４桁か１１桁で"
                                               TO  SPA-ERRMSG
                   MOVE    "入力して下さい。"
                                               TO  SPA-ERRMSG(35:)
               WHEN    "0004"
                   MOVE    "年金証書番号は半角９桁で入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "新継再区分入力エラー"
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
               WHEN    "0018"
                   MOVE    "検査年月日の暦日エラーです"
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
               WHEN    "0022"
                   MOVE    "労働保険番号を入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0023"
                   MOVE    "年金証書番号を入力して下さい"
                                               TO  SPA-ERRMSG
               WHEN    "0024"
                   MOVE    "健康管理手帳番号を入力して下さい"
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
                   MOVE    "健康管理手帳番号は半角１３桁か１０桁で"
                                               TO  SPA-ERRMSG
                   MOVE    "入力して下さい。"
                                               TO  SPA-ERRMSG(35:)
               WHEN    "0029"
                   MOVE    "事業の名称は全角で入力して下さい。"
                                               TO  SPA-ERRMSG
               WHEN    "0030"
                   MOVE    "傷病年月日＞療養開始日は入力できません"
                                               TO  SPA-ERRMSG
               WHEN    "0031"
                   MOVE    "傷病の部位は全角で入力して下さい。"
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
           END-EVALUATE
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
      *    パラメタ情報読み込み
      *****************************************************************
       990-PARA-READ-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
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
      *    パラメタデータ順読み
      *****************************************************************
      *990-PARA-NEXT-SEC           SECTION.
      *
      *    READ    PARA-FILE       NEXT
      *        AT  END
      *            MOVE    1           TO  FLG-PARA
      *        NOT AT  END
      *            MOVE    ZERO        TO  FLG-PARA
      *    END-READ
      *
      *    .
      *990-PARA-NEXT-EXT.
      *    EXIT.
      *
      *****************************************************************
      *    保険番号マスタ次検索処理
      *****************************************************************
       921-HKNMST-NEXT-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE              HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
           .
       921-HKNMST-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者番号マスタ次検索処理
      *****************************************************************
       900-HKNJAINF-READ-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNJAINF-REC
               MOVE    ZERO            TO  FLG-HKNJAINF
           ELSE
               INITIALIZE              HKNJAINF-REC
               MOVE    1               TO  FLG-HKNJAINF
           END-IF
           .
       900-HKNJAINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ読み込み処理
      *****************************************************************
       900-KANRIMST-READ-SEC         SECTION.
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
       900-KANRIMST-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL   "ORCMCPSUB"   USING
                                MCPAREA
                                ORCMCPAREA
                                MCPDATA-REC.
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *
