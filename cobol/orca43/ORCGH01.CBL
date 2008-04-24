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
       PROGRAM-ID.             ORCGH01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 請求管理
      *  コンポーネント名  : 請求管理−手書き訂正（Ｈ０１）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/09/14  クリアボタン追加
      *  01.01.01    MCC-藤原     01/09/21  JOINの修正      
      *  01.01.02    MCC-藤原     01/10/01  請求区分、訂正区分の修正
      *  01.01.03    MCC-藤原     01/10/26  保険種別の記号修正
      *  01.01.04    MCC-藤原     01/11/28  氏名検索への遷移の修正
      *  01.01.05    MCC-藤原     02/02/19  記号番号が長いとき表示する
      *                                     ように修正
      *  01.01.06    MCC-藤原     02/03/28  氏名検索画面から戻ったときの
      *                                     チェックを中止
      *  ２００２．１０改正対応 
      *  01.02.01    NACL-藤原    02/10/7   県内県外区分・県番号・
      *                                     年齢・給付割合の追加
      *  01.02.02    NACL-藤原    02/10/10  レセプト種別の出力の修正
      *                                     在宅寝たきり等の表示の追加       
      *  01.02.03    NACL-藤原    03/02/05  公費請求書ＤＢを追加
      *                                     入院対応
      *                                     科コードの入力の修正
      *  01.02.04    NACL-藤原    03/07/05  患者氏名での検索を追加
      *  01.02.05    NACL-藤原    04/01/26  排他制御処理追加
      *
      *  02.06.01    NACL-藤原    05/04/11  本人家族区分の追加
      *  02.06.02    NACL-藤原    05/09/29  補助区分からの編集の修正
      *
      *  02.07.01    NACL-藤原    05/08/20  特別療養費対応
      *  02.07.02    NACL-藤原    05/10/31  MONFUNC対応
      *
      *  02.08.01    NACL-藤原    06/02/20  主科対応
      *
      *２００６年４月改正対応
      *  02.09.01    NACL-藤原    06/04/14  ２００６年４月改正対応
      *                                     「１３指導」「１３医学管理」
      *                                     「食事日数」「食事回数」
      *                                      の診療年月による表示の変更
      *                                     「在宅寝たきり等」の表示を
      *                                     「在医総等」に変更
      *
      *  03.03.01    NACL-藤原    06/09/27  ２００６年１０月改正対応
      *                                     更新前チェックを追加 
      *
      *  03.05.01    NACL-藤原    07/04/19  グループ診療対応
      *
      *  04.01.01    NACL-藤原    07/11/22  公害レセプト対応
      *
      *  04.02.01    NACL-藤原    08/03/25  平成２０年４月改正対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE             SECTION.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    請求管理スパ領域
           COPY    "H01COMMON-SPA".
      *
      *    画面用ＳＰＡ
           COPY    "H01SCR-SPA".
      *
           COPY    "ENUM-VALUE".
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-SEIKYU          PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-KOHSKY          PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX2                PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MOTOPG          PIC X(08).
           03  WRK-Z9              PIC Z9.
           03  WRK-HIDMSG          PIC X(70).
      *
           03  WRK-SYO             PIC 9(02).
           03  WRK-AMARI           PIC 9(02).
           03  WRK-WIDGET          PIC 9(02).
           03  WRK-WIDGET-X        REDEFINES   WRK-WIDGET
                                   PIC X(02).
           03  WRK-WIDGET1         PIC 9(01).
      *
           03  WRK-NYUGAIKBN       PIC X(06).
           03  WRK-TEISYUTUSAKI    PIC X(10).
           03  WRK-RECESYUBETU     PIC X(10).
           03  WRK-YM              PIC X(07). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
      *
      *    スパ領域（ワーク）
           COPY    "COMMON-SPA"
                                   REPLACING   //SPA-//
                                   BY          //WRK-SPA-//.
      * 
        01  WRK-CONS-SRYYM-200610  PIC 9(06)   VALUE   200610. 
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    医療機関情報
           COPY    "CPSK1001.INC".
      *
           COPY    "CPSK1005.INC".
      *
           COPY    "CPRCF010.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    公費請求書
           COPY    "CPKOHSKY.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTNUM.INC".
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *
      *    排他制御サブパラメタ
           COPY    "CPORCSLOCK.INC".
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
           COPY    "H01.INC".
           COPY    "H99.INC".
           COPY    "HERR.INC".
           COPY    "HID1.INC".
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
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-H01FREE
           MOVE    SPA-WORK        TO  SPA-H01KYOUTU
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
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
           MOVE    SPA-H01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-H01FREE     TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "HERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
               IF      FLG-END             =   1
                   GO  TO  100-INIT-EXT
               END-IF
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE
           MOVE    "H01    "           TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    SPA-MOTOPG          TO  WRK-MOTOPG
      *
      *        元の画面へ戻す
               IF      WRK-MOTOPG(1:3)     =   "Y01"  OR  "U01"  OR
                                               "P97"
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-H01-AREA
                   MOVE    SPA-WORK        TO  SPA-H01KYOUTU
               END-IF
      *        外部より選択がある時
               IF      WRK-MOTOPG(1:3)     =   "U01"  OR
                                               "P97"
                   PERFORM 3101-U01SPASET-SEC
                   GO      TO      300-SCREEN-EXT
               ELSE
                   MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
               END-IF
           END-IF
      *
           EVALUATE    SPA-MOTOPG
      *    検索処理
               WHEN    "H99"
                   PERFORM 320-H99SPASET-SEC
                   GO      TO      300-SCREEN-EXT
      *    更新処理
               WHEN    "HID1"
                   PERFORM 330-HID1-SET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *
           PERFORM 310-SPASET-SEC
      *
           MOVE    1               TO  SPA-H01GMN-PAGE
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＬＤ外の項目入力編集処理
      *****************************************************************
       3101-U01SPASET-SEC              SECTION.
      *
           MOVE    LNK-KYOUTU          TO  WRK-SPA-KYOUTU
      *    患者検索より
           IF      WRK-SPA-PTNUM       =   SPA-H01GMN-PTNUM
               CONTINUE
           ELSE
               IF      WRK-SPA-PTNUM       NOT =   SPACE
                   MOVE    WRK-SPA-PTNUM       TO  H01-PTNUM
                   MOVE    H01-PTNUM           TO  SPA-H01GMN-PTNUM
      *
                   MOVE    SPACE               TO  SPA-UPDFLG
                                                   SPA-HENFLG
      *
                   INITIALIZE                  ORCSPTIDAREA
                   MOVE    SPA-HOSPNUM         TO  SPTID-HOSPNUM
                   MOVE    SPA-H01GMN-PTNUM    TO  SPTID-PTNUM
                   CALL    "ORCSPTID"          USING   ORCSPTIDAREA
                                                       SPA-AREA
                   IF      SPTID-RC        NOT =   ZERO
                       MOVE    "0004"          TO  SPA-ERRCD
                   ELSE
                       INITIALIZE              SPA-H01GMN-TABLE
                                               SPA-H01GMN-KOUMOKU
                       MOVE    SPTID-PTNUM     TO  SPA-H01GMN-PTNUM
                       MOVE    SPTID-PTID      TO  SPA-H01NAI-PTID
      *                患者マスター存在チェック
                       MOVE    SPA-HOSPNUM     TO  PTINF-HOSPNUM
                       MOVE    SPA-H01NAI-PTID TO  PTINF-PTID
                       PERFORM 900-PTINF-READ-SEC
                       IF      FLG-PTINF   NOT =   ZERO
                           MOVE    "0001"      TO  SPA-ERRCD
                       ELSE
      *
      *                    排他制御処理
                           PERFORM 990-LOCK-IN-SEC
                           IF      SPA-ERRCD       =   SPACE
                               MOVE    PTINF-NAME  TO  SPA-H01GMN-NAME
                           END-IF
                       END-IF
                   END-IF     
               END-IF    
               MOVE    2                   TO  SPA-H01GMN-CUR
           END-IF
           .
       3101-U01SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
           INITIALIZE              SPA-H01-AREA
                                   SPA-H01KYOUTU 
      *
      *    医療機関情報取得
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    ZERO                TO  SYS-1001-STYUKYMD
                                           SYS-1001-EDYUKYMD
grpsys     MOVE    SPA-HOSPNUM         TO  SYS-1001-HOSPNUM
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
           END-IF
           MOVE    SYS-1001-HOSPSBT1   TO  SPA-SYS-1001-HOSPSBT1
      *
      *    見出し編集
           MOVE    "2"                 TO  SPA-RECE10-NYUGAIKBN
           MOVE    SPA-SYSYMD (1:6)    TO  SPA-RECE10-SRYYM
           MOVE    1                   TO  SPA-RECE10-TEISYUTUSAKI 
           PERFORM 3101-MIDASI-HENSYU-SEC
           MOVE    SPACE               TO  SPA-RECE10-NYUGAIKBN
           MOVE    ZERO                TO  SPA-RECE10-SRYYM
                                           SPA-RECE10-TEISYUTUSAKI
      *
           MOVE    "0"                 TO  SPA-H01GMN-SKYKBNL    (1)
           MOVE    "請求しない"        TO  SPA-H01GMN-SKYKBNMEIL (1)
           MOVE    "1"                 TO  SPA-H01GMN-SKYKBNL    (2)
           MOVE    "未請求"            TO  SPA-H01GMN-SKYKBNMEIL (2)
           MOVE    "2"                 TO  SPA-H01GMN-SKYKBNL    (3)
           MOVE    "請求済"            TO  SPA-H01GMN-SKYKBNMEIL (3)
      *                                 
           MOVE    1                   TO  SPA-H01GMN-CUR
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    見出し編集処理
      *****************************************************************
       3101-MIDASI-HENSYU-SEC          SECTION.
      *
           MOVE    SPACE               TO  SPA-H01GMN-MIDASI-AREA
      *
           EVALUATE    SPA-RECE10-NYUGAIKBN
                                       ALSO    SPA-RECE10-TEISYUTUSAKI
               WHEN    "1"             ALSO    1
               WHEN    "1"             ALSO    2
               WHEN    "1"             ALSO    6
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       35
                       MOVE    "blue"  TO  SPA-H01GMN-MIDASI-STYLE (IDX)
                   END-PERFORM
                   MOVE  "          初    診"  TO SPA-H01GMN-MIDASI(01)
                   IF      SPA-RECE10-SRYYM    >=  "200604"
                       MOVE  "          医学管理"
                                               TO SPA-H01GMN-MIDASI(02)
                   ELSE 
                       MOVE  "          指    導"
                                               TO SPA-H01GMN-MIDASI(02)
                   END-IF 
                   MOVE  "          在    宅"  TO SPA-H01GMN-MIDASI(03)
                   MOVE  "          内    服"  TO SPA-H01GMN-MIDASI(04)
                   MOVE  "          屯    服"  TO SPA-H01GMN-MIDASI(05)
                   MOVE  "          外    用"  TO SPA-H01GMN-MIDASI(06)
                   MOVE  "          調    剤"  TO SPA-H01GMN-MIDASI(07)
                   MOVE  "          麻    毒"  TO SPA-H01GMN-MIDASI(08)
                   MOVE  "          調    基"  TO SPA-H01GMN-MIDASI(09)
                   MOVE  "        皮下筋肉内"  TO SPA-H01GMN-MIDASI(10)
                   MOVE  "            静脈内"  TO SPA-H01GMN-MIDASI(11)
                   MOVE  "            その他"  TO SPA-H01GMN-MIDASI(12)
                   MOVE  "            処  置"  TO SPA-H01GMN-MIDASI(13)
                   MOVE  "            薬  剤"  TO SPA-H01GMN-MIDASI(14)
                   MOVE  "        手術・麻酔"  TO SPA-H01GMN-MIDASI(15)
                   MOVE  "            薬  剤"  TO SPA-H01GMN-MIDASI(16)
                   IF      SPA-RECE10-SRYYM    >=  "200804"
                       MOVE  "          病理検査"
                                               TO SPA-H01GMN-MIDASI(17)
                   ELSE
                       MOVE  "            検  査"
                                               TO SPA-H01GMN-MIDASI(17)
                   END-IF
                   MOVE  "            薬  剤"  TO SPA-H01GMN-MIDASI(18)
                   MOVE  "          画像診断"  TO SPA-H01GMN-MIDASI(19)
                   MOVE  "            薬  剤"  TO SPA-H01GMN-MIDASI(20)
                   MOVE  "            その他"  TO SPA-H01GMN-MIDASI(21)
                   MOVE  "          薬    剤"  TO SPA-H01GMN-MIDASI(22)
                   MOVE  "  入院基本料・加算"  TO SPA-H01GMN-MIDASI(23)
                   MOVE  "特定入院料・その他"
                                               TO SPA-H01GMN-MIDASI(28)
                   MOVE  "        〃        "  TO SPA-H01GMN-MIDASI(24)
                                                  SPA-H01GMN-MIDASI(25)
                                                  SPA-H01GMN-MIDASI(26)
                                                  SPA-H01GMN-MIDASI(27)
                                                  SPA-H01GMN-MIDASI(29)
                                                  SPA-H01GMN-MIDASI(30)
                                                  SPA-H01GMN-MIDASI(31)
                                                  SPA-H01GMN-MIDASI(32)
                   MOVE  SPACE              TO    SPA-H01GMN-MIDASI(33)
                                                  SPA-H01GMN-MIDASI(34)
                                                  SPA-H01GMN-MIDASI(35)
                   MOVE  "食事療養費"       TO SPA-H01GMN-SHOMIDASI (1)
                   MOVE  "食事標準負担額"   TO SPA-H01GMN-SHOMIDASI (2) 
                   IF      SPA-RECE10-SRYYM    >=  "200604"
                       MOVE  "食事回数"     TO SPA-H01GMN-SHOMIDASI (3)
                   ELSE
                       MOVE  "食事日数"     TO SPA-H01GMN-SHOMIDASI (3)
                   END-IF 
                   MOVE  WIDGET-NORMAL      TO SPA-H01GMN-SHO-STATE 
                   MOVE    "合計点数"       TO SPA-H01GMN-TENMIDASI (1)
                   MOVE    "一部負担金"     TO SPA-H01GMN-TENMIDASI (2)
                   IF      SPA-RECE10-SRYYM    <   "200304"
                       MOVE    "薬剤一部負担金"
                                            TO SPA-H01GMN-TENMIDASI (3)
                   END-IF
                   MOVE    "実日数"         TO SPA-H01GMN-TENMIDASI (4)
               WHEN    "2"             ALSO    1
               WHEN    "2"             ALSO    2
               WHEN    "2"             ALSO    6
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       35
                       MOVE    "blue"  TO  SPA-H01GMN-MIDASI-STYLE (IDX)
                   END-PERFORM
                   MOVE    "        初    診"  TO SPA-H01GMN-MIDASI(01)
                   MOVE    "        再    診"  TO SPA-H01GMN-MIDASI(02)
                   MOVE    "    外来管理加算"  TO SPA-H01GMN-MIDASI(03)
                   MOVE    "          時間外"  TO SPA-H01GMN-MIDASI(04)
                   MOVE    "        休    日"  TO SPA-H01GMN-MIDASI(05)
                   MOVE    "        深    夜"  TO SPA-H01GMN-MIDASI(06)
                   IF      SPA-RECE10-SRYYM    >=  "200604"
                       MOVE  "        医学管理"
                                               TO SPA-H01GMN-MIDASI(07)
                   ELSE 
                       MOVE  "        指    導"
                                               TO SPA-H01GMN-MIDASI(07)
                   END-IF 
                   MOVE    "        往    診"  TO SPA-H01GMN-MIDASI(08)
                   MOVE    "        夜    間"  TO SPA-H01GMN-MIDASI(09)
                   MOVE    "      深夜・緊急"  TO SPA-H01GMN-MIDASI(10)
                   MOVE    "在宅患者訪問診療"  TO SPA-H01GMN-MIDASI(11)
                   MOVE    "          その他"  TO SPA-H01GMN-MIDASI(12)
                   MOVE    "          薬  剤"  TO SPA-H01GMN-MIDASI(13)
                   MOVE    "        内服薬剤"  TO SPA-H01GMN-MIDASI(14)
                   MOVE    "        内服調剤"  TO SPA-H01GMN-MIDASI(15)
                   MOVE    "        屯服薬剤"  TO SPA-H01GMN-MIDASI(16)
                   MOVE    "        外用薬剤"  TO SPA-H01GMN-MIDASI(17)
                   MOVE    "        外用調剤"  TO SPA-H01GMN-MIDASI(18)
                   MOVE    "        処    方"  TO SPA-H01GMN-MIDASI(19)
                   MOVE    "        麻    毒"  TO SPA-H01GMN-MIDASI(20)
                   MOVE    "        調    基"  TO SPA-H01GMN-MIDASI(21)
                   MOVE    "      皮下筋肉内"  TO SPA-H01GMN-MIDASI(22)
                   MOVE    "          静脈内"  TO SPA-H01GMN-MIDASI(23)
                   MOVE    "          その他"  TO SPA-H01GMN-MIDASI(24)
                   MOVE    "          処  置"  TO SPA-H01GMN-MIDASI(25)
                   MOVE    "          薬  剤"  TO SPA-H01GMN-MIDASI(26)
                   MOVE    "      手術・麻酔"  TO SPA-H01GMN-MIDASI(27)
                   MOVE    "          薬  剤"  TO SPA-H01GMN-MIDASI(28)
                   IF      SPA-RECE10-SRYYM    >=  "200804"
                       MOVE  "        病理検査"
                                               TO SPA-H01GMN-MIDASI(29)
                   ELSE
                       MOVE  "          検  査"
                                               TO SPA-H01GMN-MIDASI(29)
                   END-IF
                   MOVE    "          薬  剤"  TO SPA-H01GMN-MIDASI(30)
                   MOVE    "        画像診断"  TO SPA-H01GMN-MIDASI(31)
                   MOVE    "          薬  剤"  TO SPA-H01GMN-MIDASI(32)
                   MOVE    "        処方せん"  TO SPA-H01GMN-MIDASI(33)
                   MOVE    "          その他"  TO SPA-H01GMN-MIDASI(34)
                   MOVE    "        薬    剤"  TO SPA-H01GMN-MIDASI(35)
                   MOVE    SPACE               TO
                                               SPA-H01GMN-SHOMIDASI (1)
                                               SPA-H01GMN-SHOMIDASI (2)
                                               SPA-H01GMN-SHOMIDASI (3)
                   MOVE  WIDGET-INSENSITIVE TO SPA-H01GMN-SHO-STATE 
                   MOVE    "合計点数"       TO SPA-H01GMN-TENMIDASI (1)
                   MOVE    "一部負担金"     TO SPA-H01GMN-TENMIDASI (2)
                   IF      SPA-RECE10-SRYYM    <   "200304"
                       MOVE    "薬剤一部負担金"
                                            TO SPA-H01GMN-TENMIDASI (3)
                   END-IF
                   MOVE    "実日数"         TO SPA-H01GMN-TENMIDASI (4)
               WHEN    "1"             ALSO    5
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       31
                       MOVE    "blue"  TO  SPA-H01GMN-MIDASI-STYLE (IDX)
                   END-PERFORM
                   MOVE  "          初    診"  TO SPA-H01GMN-MIDASI(01)
                   MOVE  "          医学管理"  TO SPA-H01GMN-MIDASI(02)
                   MOVE  "          在    宅"  TO SPA-H01GMN-MIDASI(03)
                   MOVE  "          内    服"  TO SPA-H01GMN-MIDASI(04)
                   MOVE  "          屯    服"  TO SPA-H01GMN-MIDASI(05)
                   MOVE  "          外    用"  TO SPA-H01GMN-MIDASI(06)
                   MOVE  "          調    剤"  TO SPA-H01GMN-MIDASI(07)
                   MOVE  "          麻    毒"  TO SPA-H01GMN-MIDASI(08)
                   MOVE  "          調    基"  TO SPA-H01GMN-MIDASI(09)
                   MOVE  "            注  射"  TO SPA-H01GMN-MIDASI(10)
                   MOVE  "            薬  剤"  TO SPA-H01GMN-MIDASI(11)
                   MOVE  "            処  置"  TO SPA-H01GMN-MIDASI(12)
                   MOVE  "            薬  剤"  TO SPA-H01GMN-MIDASI(13)
                   MOVE  "        手術・麻酔"  TO SPA-H01GMN-MIDASI(14)
                   MOVE  "            薬  剤"  TO SPA-H01GMN-MIDASI(15)
                   MOVE  "            検  査"  TO SPA-H01GMN-MIDASI(16)
                   MOVE  "            薬  剤"  TO SPA-H01GMN-MIDASI(17)
                   MOVE  "          画像診断"  TO SPA-H01GMN-MIDASI(18)
                   MOVE  "        フィルム等"  TO SPA-H01GMN-MIDASI(19)
                   MOVE  "            その他"  TO SPA-H01GMN-MIDASI(20)
                   MOVE  "          薬    剤"  TO SPA-H01GMN-MIDASI(21)
                   MOVE  "  入院基本料・加算"  TO SPA-H01GMN-MIDASI(22)
                   MOVE  "  公害入院療養指導"  TO SPA-H01GMN-MIDASI(27)
                   MOVE  "  清浄空気室管理料"  TO SPA-H01GMN-MIDASI(30)
                   MOVE  "            その他"  TO SPA-H01GMN-MIDASI(31)
                   MOVE  "        〃        "  TO SPA-H01GMN-MIDASI(23)
                                                  SPA-H01GMN-MIDASI(24)
                                                  SPA-H01GMN-MIDASI(25)
                                                  SPA-H01GMN-MIDASI(26)
                                                  SPA-H01GMN-MIDASI(28)
                                                  SPA-H01GMN-MIDASI(29)
                   MOVE  WIDGET-INSENSITIVE TO SPA-H01GMN-SHO-STATE 
                   MOVE    "        小  計" TO SPA-H01GMN-TENMIDASI (1)
                   MOVE    "（食事）小  計" TO SPA-H01GMN-TENMIDASI (2)
                   MOVE    "        合  計" TO SPA-H01GMN-TENMIDASI (3)
                   MOVE    "        実日数" TO SPA-H01GMN-TENMIDASI (4)
               WHEN    "2"             ALSO    5
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       38
                       MOVE    "blue"  TO  SPA-H01GMN-MIDASI-STYLE (IDX)
                   END-PERFORM
                   MOVE    "        初    診"  TO SPA-H01GMN-MIDASI(1)
                   MOVE    "        再    診"  TO SPA-H01GMN-MIDASI(2)
                   MOVE    "    外来管理加算"  TO SPA-H01GMN-MIDASI(3)
                   MOVE    "          時間外"  TO SPA-H01GMN-MIDASI(4)
                   MOVE    "        休    日"  TO SPA-H01GMN-MIDASI(5)
                   MOVE    "        深    夜"  TO SPA-H01GMN-MIDASI(6)
                   MOVE    "        公害相談"  TO SPA-H01GMN-MIDASI(7)
                   MOVE    "公害外来療養指導"  TO SPA-H01GMN-MIDASI(8)
                   MOVE    "          その他"  TO SPA-H01GMN-MIDASI(9)
                   MOVE    "        往    診"  TO SPA-H01GMN-MIDASI(10)
                   MOVE    "        夜    間"  TO SPA-H01GMN-MIDASI(11)
                   MOVE    "      深夜・緊急"  TO SPA-H01GMN-MIDASI(12)
                   MOVE    "在宅患者訪問診療"  TO SPA-H01GMN-MIDASI(13)
                   MOVE    "          その他"  TO SPA-H01GMN-MIDASI(14)
                   MOVE    "          薬  剤"  TO SPA-H01GMN-MIDASI(15)
                   MOVE    "        内服薬剤"  TO SPA-H01GMN-MIDASI(16)
                   MOVE    "        内服調剤"  TO SPA-H01GMN-MIDASI(17)
                   MOVE    "        屯    服"  TO SPA-H01GMN-MIDASI(18)
                   MOVE    "        外用薬剤"  TO SPA-H01GMN-MIDASI(19)
                   MOVE    "        外用調剤"  TO SPA-H01GMN-MIDASI(20)
                   MOVE    "        処    方"  TO SPA-H01GMN-MIDASI(21)
                   MOVE    "        麻    毒"  TO SPA-H01GMN-MIDASI(22)
                   MOVE    "        調    基"  TO SPA-H01GMN-MIDASI(23)
                   MOVE    "      皮下筋肉内"  TO SPA-H01GMN-MIDASI(24)
                   MOVE    "          静脈注"  TO SPA-H01GMN-MIDASI(25)
                   MOVE    "          その他"  TO SPA-H01GMN-MIDASI(26)
                   MOVE    "          薬  剤"  TO SPA-H01GMN-MIDASI(27)
                   MOVE    "          処  置"  TO SPA-H01GMN-MIDASI(28)
                   MOVE    "          薬  剤"  TO SPA-H01GMN-MIDASI(29)
                   MOVE    "      手術・麻酔"  TO SPA-H01GMN-MIDASI(30)
                   MOVE    "          薬  剤"  TO SPA-H01GMN-MIDASI(31)
                   MOVE    "          検  査"  TO SPA-H01GMN-MIDASI(32)
                   MOVE    "          薬  剤"  TO SPA-H01GMN-MIDASI(33)
                   MOVE    "        画像診断"  TO SPA-H01GMN-MIDASI(34)
                   MOVE    "      フィルム等"  TO SPA-H01GMN-MIDASI(35)
                   MOVE    "        処方せん"  TO SPA-H01GMN-MIDASI(36)
                   MOVE    "          その他"  TO SPA-H01GMN-MIDASI(37)
                   MOVE    "          薬  剤"  TO SPA-H01GMN-MIDASI(38)
                   MOVE  WIDGET-INSENSITIVE TO SPA-H01GMN-SHO-STATE 
                   MOVE    "小  計"         TO SPA-H01GMN-TENMIDASI (1)
                   MOVE    SPACE            TO SPA-H01GMN-TENMIDASI (2)
                   MOVE    "合  計"         TO SPA-H01GMN-TENMIDASI (3)
                   MOVE    "実日数"         TO SPA-H01GMN-TENMIDASI (4)
           END-EVALUATE
      *
           .
       3101-MIDASI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    対象レセプトセット処理
      *****************************************************************
       320-H99SPASET-SEC          SECTION.
      *
           IF      SPA-H99-KEY      =   SPACE
               GO  TO  320-H99SPASET-EXT
           END-IF
      *
           MOVE    SPACE           TO  SPA-UPDFLG
                                       SPA-HENFLG
      *
           INITIALIZE              RECE10-REC
           MOVE    SPA-H99-KEY     TO  RECE10-KEY
           PERFORM 900-SEIKYU-INV-SEC
           MOVE    MCPDATA-REC     TO  RECE10-REC
      *
      *    排他制御処理
           PERFORM 990-LOCK-IN-SEC
           IF      SPA-ERRCD       NOT =   SPACE
               GO  TO  320-H99SPASET-EXT
           END-IF
      *
           PERFORM 41021-SEIKYU-HENSYU-SEC
      *
           .
       320-H99SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認画面（ＣＩＤ１）ＯＫ処理
      *****************************************************************
       330-HID1-SET-SEC            SECTION.
      *
           IF      SPA-HID1-FLG    =   "OK"
               IF      SPA-HIDCD       =    "1001"
                   PERFORM 450-KOUSIN-SEC
               ELSE
                   MOVE    SPACE       TO  SPA-UPDFLG
                   MOVE    "JOIN"      TO  MCP-PUTTYPE
                   PERFORM 210-BACK
               END-IF
           ELSE
               MOVE    "1"             TO  SPA-UPDFLG 
           END-IF
      *
           MOVE    SPACE           TO  SPA-HID1-FLG
           MOVE    SPACE           TO  SPA-HIDCD      
           .
       330-HID1-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE    "CHANGE"        TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *        クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 420-CLEAR-SEC
      *    氏名検索
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 480-KENSAKU-SEC
      *     更新
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-KOUSIN-GIDMSG-SEC
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
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
               WHEN    "ACTIVATE"      ALSO    "PTNUM"
                   PERFORM 4101-PTNUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SRYYM"
                   PERFORM 4102-SRYYM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SRYKA"
                   PERFORM 4103-SRYKA-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SKYYM"
                   PERFORM 4104-SKYYM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HENREIYM"
                   PERFORM 4105-HENREIYM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SKYKBN"
                   PERFORM 4106-SKYKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN01"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN02"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN03"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN04"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN05"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN06"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN07"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN08"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN09"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN10"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN11"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN12"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN13"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN14"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN15"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN16"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN17"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN18"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN19"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN20"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN21"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN22"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN23"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN24"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN25"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN26"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN27"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN28"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN29"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN30"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN31"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN32"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN33"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN34"
               WHEN    "ACTIVATE"      ALSO    "NKHNTEN35"
      **         WHEN    "ACTIVATE"      ALSO    "NKHNTEN36"
      **         WHEN    "ACTIVATE"      ALSO    "NKHNTEN37"
      **         WHEN    "ACTIVATE"      ALSO    "NKHNTEN38"
                   MOVE    MCP-WIDGET (8:2)    TO  WRK-WIDGET 
                   MOVE    WRK-WIDGET          TO  IDX 
                   PERFORM 4108-KHNTEN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NKAISU01"
               WHEN    "ACTIVATE"      ALSO    "NKAISU02"
               WHEN    "ACTIVATE"      ALSO    "NKAISU03"
               WHEN    "ACTIVATE"      ALSO    "NKAISU04"
               WHEN    "ACTIVATE"      ALSO    "NKAISU05"
               WHEN    "ACTIVATE"      ALSO    "NKAISU06"
               WHEN    "ACTIVATE"      ALSO    "NKAISU07"
               WHEN    "ACTIVATE"      ALSO    "NKAISU08"
               WHEN    "ACTIVATE"      ALSO    "NKAISU09"
               WHEN    "ACTIVATE"      ALSO    "NKAISU10"
               WHEN    "ACTIVATE"      ALSO    "NKAISU11"
               WHEN    "ACTIVATE"      ALSO    "NKAISU12"
               WHEN    "ACTIVATE"      ALSO    "NKAISU13"
               WHEN    "ACTIVATE"      ALSO    "NKAISU14"
               WHEN    "ACTIVATE"      ALSO    "NKAISU15"
               WHEN    "ACTIVATE"      ALSO    "NKAISU16"
               WHEN    "ACTIVATE"      ALSO    "NKAISU17"
               WHEN    "ACTIVATE"      ALSO    "NKAISU18"
               WHEN    "ACTIVATE"      ALSO    "NKAISU19"
               WHEN    "ACTIVATE"      ALSO    "NKAISU20"
               WHEN    "ACTIVATE"      ALSO    "NKAISU21"
               WHEN    "ACTIVATE"      ALSO    "NKAISU22"
               WHEN    "ACTIVATE"      ALSO    "NKAISU23"
               WHEN    "ACTIVATE"      ALSO    "NKAISU24"
               WHEN    "ACTIVATE"      ALSO    "NKAISU25"
               WHEN    "ACTIVATE"      ALSO    "NKAISU26"
               WHEN    "ACTIVATE"      ALSO    "NKAISU27"
               WHEN    "ACTIVATE"      ALSO    "NKAISU28"
               WHEN    "ACTIVATE"      ALSO    "NKAISU29"
               WHEN    "ACTIVATE"      ALSO    "NKAISU30"
               WHEN    "ACTIVATE"      ALSO    "NKAISU31"
               WHEN    "ACTIVATE"      ALSO    "NKAISU32"
               WHEN    "ACTIVATE"      ALSO    "NKAISU33"
               WHEN    "ACTIVATE"      ALSO    "NKAISU34"
               WHEN    "ACTIVATE"      ALSO    "NKAISU35"
      **         WHEN    "ACTIVATE"      ALSO    "NKAISU36"
      **         WHEN    "ACTIVATE"      ALSO    "NKAISU37"
      **         WHEN    "ACTIVATE"      ALSO    "NKAISU38"
                   MOVE    MCP-WIDGET (7:2)    TO  WRK-WIDGET 
                   MOVE    WRK-WIDGET          TO  IDX  
                   PERFORM 4109-KAISU-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NTENSU01"
               WHEN    "ACTIVATE"      ALSO    "NTENSU02"
               WHEN    "ACTIVATE"      ALSO    "NTENSU03"
               WHEN    "ACTIVATE"      ALSO    "NTENSU04"
               WHEN    "ACTIVATE"      ALSO    "NTENSU05"
               WHEN    "ACTIVATE"      ALSO    "NTENSU06"
               WHEN    "ACTIVATE"      ALSO    "NTENSU07"
               WHEN    "ACTIVATE"      ALSO    "NTENSU08"
               WHEN    "ACTIVATE"      ALSO    "NTENSU09"
               WHEN    "ACTIVATE"      ALSO    "NTENSU10"
               WHEN    "ACTIVATE"      ALSO    "NTENSU11"
               WHEN    "ACTIVATE"      ALSO    "NTENSU12"
               WHEN    "ACTIVATE"      ALSO    "NTENSU13"
               WHEN    "ACTIVATE"      ALSO    "NTENSU14"
               WHEN    "ACTIVATE"      ALSO    "NTENSU15"
               WHEN    "ACTIVATE"      ALSO    "NTENSU16"
               WHEN    "ACTIVATE"      ALSO    "NTENSU17"
               WHEN    "ACTIVATE"      ALSO    "NTENSU18"
               WHEN    "ACTIVATE"      ALSO    "NTENSU19"
               WHEN    "ACTIVATE"      ALSO    "NTENSU20"
               WHEN    "ACTIVATE"      ALSO    "NTENSU21"
               WHEN    "ACTIVATE"      ALSO    "NTENSU22"
               WHEN    "ACTIVATE"      ALSO    "NTENSU23"
               WHEN    "ACTIVATE"      ALSO    "NTENSU24"
               WHEN    "ACTIVATE"      ALSO    "NTENSU25"
               WHEN    "ACTIVATE"      ALSO    "NTENSU26"
               WHEN    "ACTIVATE"      ALSO    "NTENSU27"
               WHEN    "ACTIVATE"      ALSO    "NTENSU28"
               WHEN    "ACTIVATE"      ALSO    "NTENSU29"
               WHEN    "ACTIVATE"      ALSO    "NTENSU30"
               WHEN    "ACTIVATE"      ALSO    "NTENSU31"
               WHEN    "ACTIVATE"      ALSO    "NTENSU32"
               WHEN    "ACTIVATE"      ALSO    "NTENSU33"
               WHEN    "ACTIVATE"      ALSO    "NTENSU34"
               WHEN    "ACTIVATE"      ALSO    "NTENSU35"
      **         WHEN    "ACTIVATE"      ALSO    "NTENSU36"
      **         WHEN    "ACTIVATE"      ALSO    "NTENSU37"
      **         WHEN    "ACTIVATE"      ALSO    "NTENSU38"
                   MOVE    MCP-WIDGET (7:2)    TO  WRK-WIDGET 
                   MOVE    WRK-WIDGET          TO  IDX  
                   MOVE    1                   TO  IDY
                   PERFORM 4110-TENSU-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU101"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU102"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU103"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU104"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU105"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU106"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU107"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU108"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU109"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU110"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU111"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU112"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU113"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU114"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU115"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU116"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU117"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU118"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU119"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU120"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU121"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU122"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU123"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU124"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU125"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU126"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU127"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU128"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU129"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU130"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU131"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU132"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU133"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU134"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU135"
      **         WHEN    "ACTIVATE"      ALSO    "NKOHTENSU136"
      **         WHEN    "ACTIVATE"      ALSO    "NKOHTENSU137"
      **         WHEN    "ACTIVATE"      ALSO    "NKOHTENSU138"
                   MOVE    MCP-WIDGET (11:2)   TO  WRK-WIDGET 
                   MOVE    WRK-WIDGET          TO  IDX 
                   MOVE    2                   TO  IDY 
                   PERFORM 4110-TENSU-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU201"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU202"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU203"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU204"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU205"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU206"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU207"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU208"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU209"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU210"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU211"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU212"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU213"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU214"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU215"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU216"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU217"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU218"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU219"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU220"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU221"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU222"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU223"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU224"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU225"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU226"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU227"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU228"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU229"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU230"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU231"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU232"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU233"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU234"
               WHEN    "ACTIVATE"      ALSO    "NKOHTENSU235"
      **         WHEN    "ACTIVATE"      ALSO    "NKOHTENSU236"
      **         WHEN    "ACTIVATE"      ALSO    "NKOHTENSU237"
      **         WHEN    "ACTIVATE"      ALSO    "NKOHTENSU238"
                   MOVE    MCP-WIDGET (11:2)   TO  WRK-WIDGET 
                   MOVE    WRK-WIDGET          TO  IDX 
                   MOVE    3                   TO  IDY 
                   PERFORM 4110-TENSU-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NFTNMONEY1"
               WHEN    "ACTIVATE"      ALSO    "NFTNMONEY2"
               WHEN    "ACTIVATE"      ALSO    "NFTNMONEY3"
                   MOVE    MCP-WIDGET (10:1)   TO  WRK-WIDGET1 
                   MOVE    WRK-WIDGET1         TO  IDX 
                   PERFORM 4111-FTNMONEY-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NYKZFTN1"
               WHEN    "ACTIVATE"      ALSO    "NYKZFTN2"
               WHEN    "ACTIVATE"      ALSO    "NYKZFTN3"
                   MOVE    MCP-WIDGET (8:1)    TO  WRK-WIDGET1 
                   MOVE    WRK-WIDGET1         TO  IDX 
                   PERFORM 4112-YKZFTN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NJNISSU1"
               WHEN    "ACTIVATE"      ALSO    "NJNISSU2"
               WHEN    "ACTIVATE"      ALSO    "NJNISSU3"
                   MOVE    MCP-WIDGET (8:1)    TO  WRK-WIDGET1 
                   MOVE    WRK-WIDGET1         TO  IDX 
                   PERFORM 4113-JNISSU-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NSHORYOYOHI1"
               WHEN    "ACTIVATE"      ALSO    "NSHORYOYOHI2"
               WHEN    "ACTIVATE"      ALSO    "NSHORYOYOHI3"
                   MOVE    MCP-WIDGET (12:1)   TO  WRK-WIDGET1 
                   MOVE    WRK-WIDGET1         TO  IDX 
                   PERFORM 4114-SHORYOYOHI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NSHOFTN1"
               WHEN    "ACTIVATE"      ALSO    "NSHOFTN2"
               WHEN    "ACTIVATE"      ALSO    "NSHOFTN3"
                   MOVE    MCP-WIDGET (8:1)    TO  WRK-WIDGET1 
                   MOVE    WRK-WIDGET1         TO  IDX 
                   PERFORM 4115-SHOFTN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NSHONISSU1"
               WHEN    "ACTIVATE"      ALSO    "NSHONISSU2"
               WHEN    "ACTIVATE"      ALSO    "NSHONISSU3"
                   MOVE    MCP-WIDGET (10:1)    TO  WRK-WIDGET1 
                   MOVE    WRK-WIDGET1         TO  IDX 
                   PERFORM 4116-SHONISSU-CHK-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号チェック処理
      *****************************************************************
       4101-PTNUM-CHK-SEC            SECTION.
      *
           MOVE    2                   TO  SPA-H01GMN-CUR
      *
           MOVE    SPACE               TO  SPA-UPDFLG
                                           SPA-HENFLG
      *
           MOVE    H01-PTNUM           TO  SPA-H01GMN-PTNUM
      *
           INITIALIZE                  ORCSPTNUMAREA
           MOVE    SPA-H01GMN-PTNUM    TO  SPTNUM-PTNUM
           CALL    "ORCSPTNUM"         USING   ORCSPTNUMAREA
                                               SPA-AREA
           EVALUATE    SPTNUM-RC
               WHEN    00
                   MOVE    SPTNUM-PTNUM        TO  SPTID-PTNUM
                   MOVE    SPTNUM-PTID         TO  SPTID-PTID
               WHEN   10
                   MOVE    "0004"              TO  SPA-ERRCD
               WHEN    20
                   MOVE    SPACE               TO  LINKAREA
                   MOVE    SPA-KYOUTU          TO  LNK-COMMON
                   MOVE    SPA-H01-AREA        TO  LNK-SCRSPA
      *
                   MOVE    "H01"               TO  SPA-MOTOPG
                   MOVE    "P97"               TO  SPA-SAKIPG
      *            氏名セット
                   MOVE    SPA-H01GMN-PTNUM    TO  SPA-NAME
                   MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
                   MOVE    "CHANGE"            TO  MCP-PUTTYPE
                   MOVE    "P97"               TO  MCP-WINDOW
                   PERFORM 900-PUT-WINDOW
                   MOVE    1                   TO  FLG-END
                   GO      TO     4101-PTNUM-CHK-EXT
               WHEN    OTHER
                   MOVE    "0004"          TO  SPA-ERRCD
           END-EVALUATE
      *
           IF      SPA-ERRCD           =   SPACE
               INITIALIZE                  SPA-H01GMN-TABLE
                                           SPA-H01GMN-KOUMOKU
               MOVE    SPTID-PTNUM     TO  SPA-H01GMN-PTNUM
               MOVE    SPTID-PTID      TO  SPA-H01NAI-PTID
      *        患者マスター存在チェック
               MOVE    SPA-HOSPNUM     TO  PTINF-HOSPNUM
               MOVE    SPA-H01NAI-PTID TO  PTINF-PTID
               PERFORM 900-PTINF-READ-SEC
               IF      FLG-PTINF   NOT =   ZERO
                   MOVE    "0001"      TO  SPA-ERRCD
               ELSE
      *
      *            排他制御処理
                   PERFORM 990-LOCK-IN-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                       GO      TO     4101-PTNUM-CHK-EXT
                   ELSE
                       MOVE    PTINF-NAME  TO  SPA-H01GMN-NAME
                   END-IF
               END-IF
           END-IF
      *
      *    請求管理ＤＢ検索処理
      *
           IF      SPA-ERRCD               =   SPACE
               IF      SPA-SYS-1001-HOSPSBT1   =   ZERO
                   MOVE    SPACE               TO  SPA-H01GMN-SRYKA 
                   PERFORM 41021-SEIKYU-KENSAKU-SEC
               ELSE
                   MOVE    3               TO  SPA-H01GMN-CUR
               END-IF
           ELSE
               INITIALIZE                  SPA-H01GMN-TABLE    
                                           SPA-H01GMN-KOUMOKU
               INITIALIZE                  SPA-H01GMN-NAME
                                           SPA-H01NAI-PTID
           END-IF
           .
       4101-PTNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療年月　入力処理
      *****************************************************************
       4102-SRYYM-CHK-SEC          SECTION.
      *
           MOVE    1               TO  SPA-H01GMN-CUR
      *
           MOVE    SPACE           TO  SPA-UPDFLG
                                       SPA-HENFLG
      *
           MOVE    H01-SRYYM       TO  SPA-H01GMN-SRYYM
           MOVE    ZERO            TO  SPA-H01NAI-SRYYM
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    "1"                 TO  SGDAY-INTYPE
           MOVE    SPA-H01GMN-SRYYM    TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY(1:6)    TO  SPA-H01GMN-SRYYM
               MOVE    SGDAY-SDAY (1:6)    TO  SPA-H01NAI-SRYYM
           ELSE
               INITIALIZE                  SPA-H01GMN-TABLE
                                           SPA-H01GMN-KOUMOKU
               MOVE    "0002"          TO  SPA-ERRCD
               GO  TO  4102-SRYYM-CHK-EXT
           END-IF
      *
           IF      SPA-ERRCD               =   SPACE
               MOVE    2                       TO  SPA-H01GMN-CUR
           END-IF
           .
       4102-SRYYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理ＤＢ検索処理
      *****************************************************************
       41021-SEIKYU-KENSAKU-SEC        SECTION.
      *
           INITIALIZE                  SPA-H01GMN-TABLE
                                       SPA-H01GMN-KOUMOKU
      *    請求管理ＤＢ検索
           INITIALIZE                  RECE10-REC
           MOVE    SPA-HOSPNUM         TO  RECE10-HOSPNUM
           MOVE    SPA-H01NAI-PTID     TO  RECE10-PTID
           IF      SPA-H01GMN-SRYKA    =   SPACE
               MOVE    "%%"                TO  RECE10-RECEKA
           ELSE
               MOVE    SPA-H01GMN-SRYKA    TO  RECE10-RECEKA
           END-IF
           MOVE    SPA-H01NAI-SRYYM       TO  RECE10-SRYYM
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SEIKYU
           END-IF
      *
           MOVE    ZERO                TO  IDX 
           PERFORM     UNTIL       FLG-SEIKYU     =   1
                       OR          IDX            =   2
               ADD     1                   TO  IDX
               IF      IDX                 =   1 
                   MOVE    MCPDATA-REC     TO  RECE10-REC
               END-IF
      *
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-SEIKYU-READ-SEC
           END-PERFORM
      *   
      *    カーソルクロース
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           EVALUATE    IDX
               WHEN    ZERO
                   MOVE    "0003"         TO  SPA-ERRCD
               WHEN    1
                   PERFORM 41021-SEIKYU-HENSYU-SEC
               WHEN    OTHER
                   PERFORM 41021-H99-HENSYU-SEC
           END-EVALUATE
           .
       41021-SEIKYU-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求マスタ画面編集処理
      *****************************************************************
       41021-SEIKYU-HENSYU-SEC         SECTION.
      *
           MOVE    RECE10-KEY         TO  SPA-RECE10-KEY
      *
      *    見出し編集
           PERFORM 3101-MIDASI-HENSYU-SEC
      *
      *    主科対応のとき主科を表示する
           IF    ( SPA-SYUKA-KBN      =   "1"  )
      *****AND   ( RECE10-TEISYUTUSAKI 
      *****                           =   "1"  )
           AND   ( RECE10-RECEKA  NOT =   "00" )
               MOVE    RECE10-RECEKA      TO  SPA-H01GMN-SRYKA
           END-IF
      *
           IF      RECE10-NYUGAIKBN   =   "1"
               MOVE    "入  院"       TO  SPA-H01GMN-HNYUGAIKBN
           ELSE    
               MOVE    "入院外"       TO  SPA-H01GMN-HNYUGAIKBN
           END-IF
           EVALUATE    RECE10-TEISYUTUSAKI
               WHEN    "1"
                   MOVE    "支払基金"      TO  SPA-H01GMN-HTEISYUTUSAKI
               WHEN    "2"
                   MOVE    "国保連合会"    TO  SPA-H01GMN-HTEISYUTUSAKI
               WHEN    "5"
                   MOVE    "公害"          TO  SPA-H01GMN-HTEISYUTUSAKI
               WHEN    "6"
                   MOVE    "広域連合"      TO  SPA-H01GMN-HTEISYUTUSAKI
           END-EVALUATE
      *
           PERFORM 530-RECESYUBETU-HENSYU-SEC
           MOVE    WRK-RECESYUBETU     TO  SPA-H01GMN-HRECESYUBETU
      *
           EVALUATE    RECE10-TEISYUTUSAKI
               WHEN    "1"
               WHEN    "2"
               WHEN    "6"
                   MOVE    RECE10-HKNJANUM     TO  SPA-H01GMN-HHKNJANUM
           END-EVALUATE
      *
           EVALUATE    RECE10-TEISYUTUSAKI
               WHEN    "6"
                   MOVE    RECE10-NUM          TO  SPA-H01GMN-HKIGO
               WHEN    OTHER
                   STRING  RECE10-KIGO     DELIMITED   BY  SPACE
                           "　"            DELIMITED   BY  SIZE
                           RECE10-NUM      DELIMITED   BY  SPACE
                                           INTO    SPA-H01GMN-HKIGO
                   END-STRING
           END-EVALUATE        
      *
           EVALUATE    RECE10-HKNNUM
               WHEN    "002"
               WHEN    "031"  THRU  "034"
                   EVALUATE    RECE10-HOJOKBN-KEY
                       WHEN    "1"
                       WHEN    "A"
                       WHEN    "D"
                       WHEN    "G"
                           MOVE    "職務上"    TO  SPA-H01GMN-HHOJOKBN
                       WHEN    "2"
                       WHEN    "B"
                       WHEN    "E"
                       WHEN    "H"
                           MOVE    "下船３月"  TO  SPA-H01GMN-HHOJOKBN
                       WHEN    "3"
                       WHEN    "C"
                       WHEN    "F"
                       WHEN    "I"
                           MOVE    "通勤災害"  TO  SPA-H01GMN-HHOJOKBN
                   END-EVALUATE
           END-EVALUATE
      *
           MOVE    RECE10-SKYYM        TO  SPA-H01NAI-SKYYM
                                           WRK-SYMD (1:6)
           MOVE    "01"                TO  WRK-SYMD (7:2) 
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG(1:6)    TO  SPA-H01GMN-SKYYM
      *
           MOVE    RECE10-HENREIYM     TO  SPA-H01NAI-HENREIYM
                                           WRK-SYMD (1:6)
           MOVE    "01"                TO  WRK-SYMD (7:2) 
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG(1:6)    TO  SPA-H01GMN-HENREIYM
      *
           MOVE    RECE10-SKYKBN       TO  SPA-H01GMN-SKYKBN
      * 
           PERFORM VARYING IDY FROM   1   BY  1
                   UNTIL   IDY >      3
               IF      SPA-H01GMN-SKYKBN
                                      =   SPA-H01GMN-SKYKBNL (IDY)
                   MOVE    SPA-H01GMN-SKYKBNMEIL (IDY)
                                          TO  SPA-H01GMN-SKYKBNMEI
                   MOVE    3              TO  IDY
               END-IF
           END-PERFORM
      *
           EVALUATE    RECE10-TEISEIKBN
               WHEN    "0"
                   MOVE    SPACE       TO  SPA-H01GMN-TEISEIKBNNM
               WHEN    "1"
                   MOVE    "手書き修正"
                                       TO  SPA-H01GMN-TEISEIKBNNM
               WHEN    "2"
                   MOVE    "レセプト再作成"
                                       TO  SPA-H01GMN-TEISEIKBNNM
           END-EVALUATE   
      *
           EVALUATE    RECE10-NYUGAIKBN
               WHEN    "1"
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       32
                       IF    ( RECE10-TEISYUTUSAKI     =   "5" )
                       AND   ( IDX                     >   31  )
                           CONTINUE
                       ELSE 
                           MOVE    RECE10-KHNTEN (IDX)
                                       TO  SPA-H01GMN-KHNTEN (IDX)
                                           SPA-H01GMN-NKHNTEN(IDX)
                           MOVE    RECE10-KAISU  (IDX)
                                       TO  SPA-H01GMN-KAISU  (IDX)
                                           SPA-H01GMN-NKAISU (IDX)
                           PERFORM VARYING IDY FROM    1   BY  1
                                   UNTIL   IDY >       3
                               MOVE    RECE10-TENSU  (IDX IDY)
                                       TO  SPA-H01GMN-TENSU  (IDY IDX)
                                           SPA-H01GMN-NTENSU (IDY IDX)
                          END-PERFORM
                       END-IF 
                   END-PERFORM       
               WHEN    "2"
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       38
                       IF    ( RECE10-TEISYUTUSAKI     =   "1" OR  "2"
                                                               OR  "6" )
                       AND   ( IDX                     >   35          )
                           CONTINUE
                       ELSE 
                           MOVE    RECE10-KHNTEN (IDX)
                                           TO  SPA-H01GMN-KHNTEN (IDX)
                                               SPA-H01GMN-NKHNTEN(IDX)
                           MOVE    RECE10-KAISU  (IDX)
                                           TO  SPA-H01GMN-KAISU  (IDX)
                                               SPA-H01GMN-NKAISU (IDX)
                           PERFORM VARYING IDY FROM    1   BY  1
                                   UNTIL   IDY >       3
                               MOVE    RECE10-TENSU  (IDX IDY)
                                       TO  SPA-H01GMN-TENSU  (IDY IDX)
                                           SPA-H01GMN-NTENSU (IDY IDX)
                           END-PERFORM
                       END-IF        
                   END-PERFORM
           END-EVALUATE 
      *    
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       3
               MOVE    RECE10-TOTALTEN (IDY)
                                   TO  SPA-H01GMN-TOTALTEN (IDY)
                                       SPA-H01GMN-NTOTALTEN(IDY)
               MOVE    RECE10-JNISSU   (IDY)
                                   TO  SPA-H01GMN-JNISSU   (IDY)
                                       SPA-H01GMN-NJNISSU  (IDY)
               IF      RECE10-TEISYUTUSAKI =   "5"
      *            小計
                   MOVE    RECE10-FTNMONEY (IDY)
                                       TO  SPA-H01GMN-YKZFTN   (IDY)
                                           SPA-H01GMN-NYKZFTN  (IDY)
      *            小計（食事）
                   MOVE    RECE10-YKZFTN   (IDY)
                                       TO  SPA-H01GMN-FTNMONEY (IDY)
                                           SPA-H01GMN-NFTNMONEY(IDY)
               ELSE
                   MOVE    RECE10-FTNMONEY (IDY)
                                       TO  SPA-H01GMN-FTNMONEY (IDY)
                                           SPA-H01GMN-NFTNMONEY(IDY)
                   MOVE    RECE10-YKZFTN   (IDY)
                                       TO  SPA-H01GMN-YKZFTN   (IDY)
                                           SPA-H01GMN-NYKZFTN  (IDY)
               END-IF
           END-PERFORM
      *
           IF     RECE10-NYUGAIKBN     =   "1"
               IF      RECE10-TEISYUTUSAKI =   "5"
                   CONTINUE
               ELSE
                   PERFORM VARYING IDY FROM    1   BY  1
                           UNTIL   IDY >       3
                       MOVE    RECE10-SHOKUJIRYOYOHI (IDY)
                                   TO  SPA-H01GMN-SHORYOYOHI (IDY)
                                       SPA-H01GMN-NSHORYOYOHI(IDY)
                       MOVE    RECE10-SHOKUJIFTN   (IDY)
                                   TO  SPA-H01GMN-SHOFTN     (IDY)
                                       SPA-H01GMN-NSHOFTN    (IDY)
                       MOVE    RECE10-SHOKUJINISSU   (IDY)
                                   TO  SPA-H01GMN-SHONISSU   (IDY)
                                       SPA-H01GMN-NSHONISSU  (IDY)
                   END-PERFORM
               END-IF
           END-IF
      *
           MOVE    RECE10-AGE      TO  SPA-H01GMN-AGE
           IF      RECE10-TEISYUTUSAKI =   "5"
               CONTINUE
           ELSE
               MOVE    RECE10-KYURATE  TO  SPA-H01GMN-KYURATE
      *
               IF      RECE10-ZAITAKU  =   "1"
                   MOVE    "在医総等"          TO  SPA-H01GMN-ZAITAKU
               END-IF
           END-IF         
      *
           IF    ( RECE10-RECESYUBETU  =   "6666" )
           OR    ( RECE10-TEISYUTUSAKI =   "5"    )
               CONTINUE
           ELSE
               EVALUATE    RECE10-RECESYUBETU (4:1)
                   WHEN    "1"
                   WHEN    "2"
                       MOVE    "本人"          TO  SPA-H01GMN-HONKZKKBN
                   WHEN    "3"
                   WHEN    "4"
                       IF      SPA-RECE10-SRYYM    >=  "200804"
                           MOVE    "未就"      TO  SPA-H01GMN-HONKZKKBN
                       ELSE
                           MOVE    "三歳"      TO  SPA-H01GMN-HONKZKKBN
                       END-IF
                   WHEN    "5"
                   WHEN    "6"
                       MOVE    "家族"          TO  SPA-H01GMN-HONKZKKBN
                   WHEN    "7"
                   WHEN    "8"
                       IF      SPA-RECE10-SRYYM    >=  "200804"
                           MOVE    "高一"      TO  SPA-H01GMN-HONKZKKBN
                       ELSE 
                           MOVE    "高９"      TO  SPA-H01GMN-HONKZKKBN
                       END-IF
                   WHEN    "9"
                   WHEN    "0"
                       IF      RECE10-SRYYM    <   WRK-CONS-SRYYM-200610
                           MOVE    "高８"      TO  SPA-H01GMN-HONKZKKBN
                       ELSE
                           EVALUATE    RECE10-KYURATE
                               WHEN    8
                                   MOVE    "高８"
                                               TO  SPA-H01GMN-HONKZKKBN
                               WHEN    7
                                   MOVE    "高７"
                                               TO  SPA-H01GMN-HONKZKKBN
                           END-EVALUATE
                       END-IF
               END-EVALUATE
           END-IF             
      * 
           MOVE    "1"                 TO  SPA-HENFLG
      *         
           MOVE    4                   TO  SPA-H01GMN-CUR
           .
       41021-SEIKYU-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト検索画面編集処理
      *****************************************************************
       41021-H99-HENSYU-SEC         SECTION.
      *
           INITIALIZE                  SPA-H99GMN-AREA
           MOVE    SPACE               TO  SPA-H99-AREA
      *
           MOVE    SPA-H01GMN-PTNUM    TO  SPA-H99GMN-PTNUM
           MOVE    SPA-H01GMN-NAME     TO  SPA-H99GMN-NAME
           MOVE    SPA-H01GMN-SRYYM    TO  SPA-H99GMN-SRYYM
           MOVE    SPA-H01GMN-SRYKA    TO  SPA-H99GMN-SRYKA
           MOVE    SPA-H01GMN-SRYKANAME
                                       TO  SPA-H99GMN-SRYKANAME
           MOVE    SPA-H01NAI-PTID     TO  SPA-H99NAI-PTID
           MOVE    SPA-H01NAI-SRYYM    TO  SPA-H99NAI-SRYYM
      *
           MOVE    SPA-H01KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-H01FREE         TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGH99"           USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA
      *
           MOVE    SPA-COMMON          TO  SPA-AREA
           MOVE    SPA-FREE            TO  SPA-H01FREE
           MOVE    SPA-WORK            TO  SPA-H01KYOUTU
      *
           MOVE    SPA-H01KYOUTU       TO  SPA-WORK
      *
           MOVE    "SELNUM"             TO  MCP-WIDGET
      *
           MOVE    "H01"                TO  SPA-MOTOPG
           MOVE    "H99"                TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "H99"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
           .
       41021-H99-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科入力処理
      *****************************************************************
       4103-SRYKA-CHK-SEC             SECTION.
      *
           MOVE    3                   TO  SPA-H01GMN-CUR
      *
           MOVE    SPACE           TO  SPA-UPDFLG
                                       SPA-HENFLG
      *
           MOVE    H01-SRYKA-VALUE TO  SPA-H01GMN-SRYKA
      *
           IF      SPA-H01GMN-SRYKA    =   SPACE
               CONTINUE
           ELSE
               INITIALIZE                  SYS-1005-REC
               MOVE    "1005"              TO  SYS-1005-KANRICD
               MOVE    SPA-H01GMN-SRYKA    TO  SYS-1005-KBNCD
               MOVE    SPA-SYSYMD          TO  SYS-1005-STYUKYMD
                                               SYS-1005-EDYUKYMD
grpsys         MOVE    SPA-HOSPNUM         TO  SYS-1005-HOSPNUM
               MOVE    SYS-1005-REC        TO  MCPDATA-REC
               PERFORM 910-SYSKANRI-INV-SEC
               IF      FLG-SYSKANRI        =   ZERO
                   MOVE    MCPDATA-REC         TO  SYS-1005-REC
                   MOVE    SYS-1005-SRYKANAME  TO  SPA-H01GMN-SRYKANAME
               ELSE
                   MOVE    "0001"              TO  SPA-ERRCD
                   MOVE    SPACE               TO  SPA-H01GMN-SRYKANAME
               END-IF
           END-IF
      *
           IF      SPA-ERRCD           =   SPACE 
      *    請求管理ＤＢ検索処理
               PERFORM 41021-SEIKYU-KENSAKU-SEC
           END-IF
           .
       4103-SRYKA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求年月　入力処理
      *****************************************************************
       4104-SKYYM-CHK-SEC          SECTION.
      *
           MOVE    4               TO  SPA-H01GMN-CUR
      *
           MOVE    H01-SKYYM       TO  SPA-H01GMN-SKYYM
           MOVE    ZERO            TO  SPA-H01NAI-SKYYM
      *
           IF      SPA-H01GMN-SKYYM    =   SPACE
              CONTINUE
           ELSE 
      *    日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    "1"                 TO  SGDAY-INTYPE
               MOVE    SPA-H01GMN-SKYYM    TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY(1:6)
                                           TO  SPA-H01GMN-SKYYM
                   MOVE    SGDAY-SDAY (1:6)
                                           TO  SPA-H01NAI-SKYYM
                   IF      SPA-H01NAI-SKYYM
                                           <   SPA-H01NAI-SRYYM
                       MOVE    "0002"          TO  SPA-ERRCD
                   END-IF
               ELSE
                   MOVE    "0002"          TO  SPA-ERRCD
               END-IF
           END-IF
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    5               TO  SPA-H01GMN-CUR
           END-IF
           .
       4104-SRYYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    返戻年月　入力処理
      *****************************************************************
       4105-HENREIYM-CHK-SEC          SECTION.
      *
           MOVE    5               TO  SPA-H01GMN-CUR
      *
           MOVE    H01-HENREIYM    TO  SPA-H01GMN-HENREIYM
           MOVE    ZERO            TO  SPA-H01NAI-HENREIYM
      *
           IF      SPA-H01GMN-HENREIYM =   SPACE
               CONTINUE
           ELSE
      *    日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    "1"                 TO  SGDAY-INTYPE
               MOVE    SPA-H01GMN-HENREIYM TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY(1:6)
                                       TO  SPA-H01GMN-HENREIYM
                   MOVE    SGDAY-SDAY (1:6)
                                       TO  SPA-H01NAI-HENREIYM
                   IF      SPA-H01NAI-HENREIYM
                                           <   SPA-H01NAI-SRYYM
                       MOVE    "0002"          TO  SPA-ERRCD
                   END-IF
               ELSE
                   MOVE    "0002"          TO  SPA-ERRCD
               END-IF
           END-IF
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    6               TO  SPA-H01GMN-CUR
           END-IF
           .
       4105-HENREIYM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求区分入力処理
      *****************************************************************
       4106-SKYKBN-CHK-SEC             SECTION.
      *
           MOVE    6                   TO  SPA-H01GMN-CUR
      *
           MOVE    H01-SKYKBN          TO  SPA-H01GMN-SKYKBN-G
      *
           MOVE    SPACE               TO  SPA-H01GMN-SKYKBNMEI 
           PERFORM VARYING IDY FROM   1   BY  1
                   UNTIL   IDY >      3
               IF      SPA-H01GMN-SKYKBN
                                      =   SPA-H01GMN-SKYKBNL (IDY)
                   MOVE    SPA-H01GMN-SKYKBNMEIL (IDY)
                                          TO  SPA-H01GMN-SKYKBNMEI
                   MOVE    3              TO  IDY
               END-IF
           END-PERFORM
      *
           IF      SPA-H01GMN-SKYKBNMEI    =   SPACE
              MOVE    "0001"       TO  SPA-ERRCD
           END-IF       
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    8               TO  SPA-H01GMN-CUR
           END-IF
           .
       4106-SKYKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本点数チェック処理
      *****************************************************************
       4108-KHNTEN-CHK-SEC          SECTION.
      *
      *
           MOVE    3                  TO  SPA-H01GMN-CUR
      *
           COMPUTE SPA-H01GMN-CUR        =   SPA-H01GMN-CUR     +
                                          IDX *  5
           MOVE    H01-NKHNTEN (IDX)      TO  SPA-H01GMN-NKHNTEN (IDX)
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               ADD     1                   TO  SPA-H01GMN-CUR
           END-IF 
           .
       4108-KHNTEN-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    回数チェック処理
      *****************************************************************
       4109-KAISU-CHK-SEC          SECTION.
      *
      *
           MOVE    4                  TO  SPA-H01GMN-CUR
      *
           COMPUTE SPA-H01GMN-CUR        =   SPA-H01GMN-CUR     +
                                          IDX *  5
           MOVE    H01-NKAISU (IDX)       TO  SPA-H01GMN-NKAISU (IDX)
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               ADD     1                   TO  SPA-H01GMN-CUR
           END-IF 
           .
       4109-KAISU-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    点数チェック処理
      *****************************************************************
       4110-TENSU-CHK-SEC          SECTION.
      *
           MOVE    4                  TO  SPA-H01GMN-CUR
      *
           COMPUTE SPA-H01GMN-CUR        =   SPA-H01GMN-CUR     +
                                          IDY             +
                                          IDX *  5
      *
           COMPUTE SPA-H01GMN-NTOTALTEN (IDY) = 
                                      SPA-H01GMN-NTOTALTEN (IDY)     -
                                      SPA-H01GMN-NTENSU    (IDY IDX)
      *           
           MOVE    H01-NTENSU (IDY IDX)
                                       TO  SPA-H01GMN-NTENSU (IDY IDX)
      *
           COMPUTE SPA-H01GMN-NTOTALTEN (IDY) = 
                                      SPA-H01GMN-NTOTALTEN (IDY)     +
                                      SPA-H01GMN-NTENSU    (IDY IDX)
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               ADD     1                   TO  SPA-H01GMN-CUR
           END-IF 
           .
       4110-TENSU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    一部負担金チェック処理
      *****************************************************************
       4111-FTNMONEY-CHK-SEC          SECTION.
      *
           MOVE    182                TO  SPA-H01GMN-CUR
      *
           COMPUTE SPA-H01GMN-CUR        =   SPA-H01GMN-CUR     +
                                          IDX
      *
           MOVE    H01-NFTNMONEY (IDX) TO  SPA-H01GMN-NFTNMONEY (IDX)
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               ADD     1                   TO  SPA-H01GMN-CUR
           END-IF 
           .
       4111-FTNMONEY-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    薬剤一部負担金チェック処理
      *****************************************************************
       4112-YKZFTN-CHK-SEC          SECTION.
      *
           MOVE    185                TO  SPA-H01GMN-CUR
      *
           COMPUTE SPA-H01GMN-CUR        =   SPA-H01GMN-CUR     +
                                          IDX
      *
           MOVE    H01-NYKZFTN (IDX)      TO  SPA-H01GMN-NYKZFTN (IDX)
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               ADD     1                   TO  SPA-H01GMN-CUR
           END-IF 
           .
       4112-YKZFTN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *     実日数チェック処理
      *****************************************************************
       4113-JNISSU-CHK-SEC          SECTION.
      *
           MOVE    188                TO  SPA-H01GMN-CUR
      *
           COMPUTE SPA-H01GMN-CUR        =   SPA-H01GMN-CUR     +
                                          IDX
      *
           MOVE    H01-NJNISSU (IDX)      TO  SPA-H01GMN-NJNISSU (IDX)
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD          =   SPACE
               IF      SPA-H01GMN-CUR        =   191
               AND     SPA-RECE10-NYUGAIKBN  =   "2"
                   MOVE    8                  TO  SPA-H01GMN-CUR
               ELSE 
                   ADD     1                  TO  SPA-H01GMN-CUR
               END-IF
           END-IF 
           .
       4113-JNISSU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    食事療養費チェック処理
      *****************************************************************
       4114-SHORYOYOHI-CHK-SEC          SECTION.
      *
           MOVE    191                TO  SPA-H01GMN-CUR
      *
           COMPUTE SPA-H01GMN-CUR     =   SPA-H01GMN-CUR     +
                                          IDX
      *
           MOVE    H01-NSHORYOYOHI (IDX)
                                      TO  SPA-H01GMN-NSHORYOYOHI (IDX)
      *
      *    更新フラグセット
           MOVE    "1"                TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD          =   SPACE
               ADD     1                  TO  SPA-H01GMN-CUR
           END-IF 
           .
       4114-SHORYOYOHI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    食事標準負担額チェック処理
      *****************************************************************
       4115-SHOFTN-CHK-SEC          SECTION.
      *
           MOVE    194                TO  SPA-H01GMN-CUR
      *
           COMPUTE SPA-H01GMN-CUR        =   SPA-H01GMN-CUR     +
                                          IDX
      *
           MOVE    H01-NSHOFTN (IDX)      TO  SPA-H01GMN-NSHOFTN (IDX)
      *
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD           =   SPACE
               ADD     1                   TO  SPA-H01GMN-CUR
           END-IF 
           .
       4115-SHOFTN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *     食事日数チェック処理
      *****************************************************************
       4116-SHONISSU-CHK-SEC          SECTION.
      *
      *
           MOVE    197                TO  SPA-H01GMN-CUR
      *
           COMPUTE SPA-H01GMN-CUR     =   SPA-H01GMN-CUR     +
                                          IDX
      *
           MOVE    H01-NSHONISSU (IDX)
                                      TO  SPA-H01GMN-NSHONISSU (IDX)
      *
      *    更新フラグセット
           MOVE    "1"                TO  SPA-UPDFLG
      *
           IF      SPA-ERRCD          =   SPACE
               IF      SPA-H01GMN-CUR     =   200
                   MOVE    8                  TO  SPA-H01GMN-CUR
               ELSE 
                   ADD     1                  TO  SPA-H01GMN-CUR
               END-IF
           END-IF 
           .
       4116-SHONISSU-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *
           IF      SPA-UPDFLG          =   "1"
               MOVE    "0101"          TO  SPA-HIDCD
               GO      TO      210-BACK-EXT
           END-IF
      *
      *    排他制御解除処理
           PERFORM 990-LOCK-OUT-SEC
      *
           MOVE    "M01"               TO  SPA-SAKIPG
           MOVE    "H01"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  SPA-WORK 
           INITIALIZE                      SPA-KYOTUKEY
                                           SPA-KYOTU-SET
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
      ***  MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *
      *****************************************************************
      *    クリア処理
      *****************************************************************
       420-CLEAR-SEC                   SECTION.
      *
           MOVE    2                   TO  SPA-H01GMN-CUR
           INITIALIZE                      SPA-H01GMN-TABLE
                                           SPA-H01GMN-KOUMOKU
                                           SPA-H01GMN-KOUMOKU1
                                           SPA-H01NAI-KOUMOKU
                                           SPA-H01NAI-KOUMOKU1
                                           SPA-RECE10-KEY
      *
           MOVE    SPACE               TO  SPA-HENFLG
                                           SPA-UPDFLG                                     
      *
      *    排他制御解除処理
           PERFORM 990-LOCK-OUT-SEC
           .
       420-CLEAR-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新前処理
      *****************************************************************
       450-KOUSIN-GIDMSG-SEC                SECTION.
      *
           IF      SPA-HENFLG          =   SPACE
               MOVE    "0015"              TO  SPA-ERRCD
               GO  TO  450-KOUSIN-GIDMSG-EXT
           END-IF
      *
           IF      SPA-UPDFLG          =   SPACE
               MOVE    "0010"              TO  SPA-ERRCD
               GO  TO  450-KOUSIN-GIDMSG-EXT
           END-IF
      *
           IF    ( SPA-H01GMN-SKYYM
                                   NOT =   SPACE )
           AND   ( SPA-H01NAI-SKYYM    =   ZERO  )
               MOVE    "0002"              TO  SPA-ERRCD
               MOVE    4                   TO  SPA-H01GMN-CUR  
               GO  TO  450-KOUSIN-GIDMSG-EXT
           END-IF       
      *
           IF    ( SPA-H01GMN-HENREIYM
                                   NOT =   SPACE )
           AND   ( SPA-H01NAI-HENREIYM =   ZERO  )
              MOVE    "0002"               TO  SPA-ERRCD
               MOVE    5                   TO  SPA-H01GMN-CUR  
               GO  TO  450-KOUSIN-GIDMSG-EXT
           END-IF
      *       
           IF    ( SPA-H01NAI-SKYYM    >   ZERO  )
           AND   ( SPA-H01NAI-SRYYM    >   ZERO  )
               IF      SPA-H01NAI-SKYYM    <   SPA-H01NAI-SRYYM
                   MOVE    "0002"              TO  SPA-ERRCD
                   MOVE    4                   TO  SPA-H01GMN-CUR  
                   GO  TO  450-KOUSIN-GIDMSG-EXT
               END-IF
           END-IF 
      *        
           IF      SPA-H01GMN-SKYKBNMEI
                                       =   SPACE
              MOVE    "0001"               TO  SPA-ERRCD
               MOVE    6                   TO  SPA-H01GMN-CUR  
               GO  TO  450-KOUSIN-GIDMSG-EXT
           END-IF       
      *         
      *    ガイドメッセージセット
           IF      SPA-ERRCD           =   SPACE
               MOVE    "1001"              TO  SPA-HIDCD
           END-IF    
           .
       450-KOUSIN-GIDMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    更新処理
      *****************************************************************
       450-KOUSIN-SEC                SECTION.
      *
      *    更新済
           MOVE    SPACE           TO  SPA-UPDFLG
                                       SPA-HENFLG
      *
           MOVE    SPACE           TO  RECE10-REC   
           INITIALIZE                  RECE10-REC
           MOVE    SPA-RECE10-KEY  TO  RECE10-KEY
      *
           PERFORM 900-SEIKYU-INV-SEC
           IF      FLG-SEIKYU          =   ZERO
               MOVE    MCPDATA-REC         TO  RECE10-REC
           ELSE
               MOVE    "1010"          TO  SPA-ERRCD
               GO  TO  450-KOUSIN-EXT
           END-IF
      *
           MOVE    SPA-H01NAI-SKYYM       TO  RECE10-SKYYM
           MOVE    SPA-H01NAI-HENREIYM    TO  RECE10-HENREIYM
           MOVE    SPA-H01GMN-SKYKBN      TO  RECE10-SKYKBN
           MOVE    "1"                    TO  RECE10-TEISEIKBN
      *
      *    公害は点数等の更新はしない
           IF      SPA-RECE10-TEISYUTUSAKI =   "5"
               CONTINUE
           ELSE
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       3
                   MOVE    SPA-H01GMN-NJNISSU (IDX)  TO
                                           RECE10-JNISSU   (IDX)
                   MOVE    SPA-H01GMN-NTOTALTEN (IDX)    TO 
                                           RECE10-TOTALTEN (IDX)
                   MOVE    SPA-H01GMN-NFTNMONEY(IDX) TO
                                           RECE10-FTNMONEY (IDX)
                   MOVE    SPA-H01GMN-NYKZFTN  (IDX) TO
                                           RECE10-YKZFTN   (IDX)
                   IF      SPA-RECE10-NYUGAIKBN      =   "1"
                       MOVE    SPA-H01GMN-NSHONISSU (IDX)  TO
                                           RECE10-SHOKUJINISSU   (IDX)
                       MOVE    SPA-H01GMN-NSHORYOYOHI (IDX)    TO 
                                           RECE10-SHOKUJIRYOYOHI (IDX)
                       MOVE    SPA-H01GMN-NSHOFTN(IDX) TO
                                           RECE10-SHOKUJIFTN (IDX)
                   END-IF
               END-PERFORM
               EVALUATE    SPA-RECE10-NYUGAIKBN
                   WHEN    "1"
                       PERFORM VARYING IDX FROM    1   BY  1
                               UNTIL   IDX >       32
                           MOVE    SPA-H01GMN-NKHNTEN  (IDX)  TO
                                               RECE10-KHNTEN (IDX)
                           MOVE    SPA-H01GMN-NKAISU   (IDX)  TO
                                               RECE10-KAISU  (IDX)
                           PERFORM VARYING IDY FROM    1   BY  1
                                   UNTIL   IDY >       3
                               MOVE    SPA-H01GMN-NTENSU (IDY IDX)  TO
                                               RECE10-TENSU (IDX IDY)
                           END-PERFORM 
                       END-PERFORM
                   WHEN    "2"
                       PERFORM VARYING IDX FROM    1   BY  1
                               UNTIL   IDX >       38
                           MOVE    SPA-H01GMN-NKHNTEN  (IDX)  TO
                                               RECE10-KHNTEN (IDX)
                           MOVE    SPA-H01GMN-NKAISU   (IDX)  TO
                                               RECE10-KAISU  (IDX)
                           PERFORM VARYING IDY FROM    1   BY  1
                                   UNTIL   IDY >       3
                               MOVE    SPA-H01GMN-NTENSU (IDY IDX)  TO
                                               RECE10-TENSU (IDX IDY)
                           END-PERFORM 
                       END-PERFORM
               END-EVALUATE
           END-IF     
      *     
           MOVE    SPA-SYSYMD          TO  RECE10-UPDYMD
      *
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
      *    公費請求書があれば更新する
           IF      MCP-RC              =   ZERO
               MOVE    SPACE           TO  KOHSKY-REC   
               INITIALIZE                  KOHSKY-REC
               MOVE    SPA-RECE10-KEY      TO  KOHSKY-KEY
      *
               PERFORM 900-KOHSKY-INV-SEC
               IF      FLG-KOHSKY          =   ZERO
                   MOVE    MCPDATA-REC         TO  KOHSKY-REC
                   MOVE    SPA-H01NAI-SKYYM    TO  KOHSKY-SKYYM
                   MOVE    SPA-H01NAI-HENREIYM TO  KOHSKY-HENREIYM
                   MOVE    SPA-H01GMN-SKYKBN   TO  KOHSKY-SKYKBN
                   MOVE    "1"                 TO  KOHSKY-TEISEIKBN
                   MOVE    SPA-SYSYMD          TO  KOHSKY-UPDYMD
      *
                   MOVE    KOHSKY-REC          TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "tbl_kohsky"        TO  MCP-TABLE
                   MOVE    "key"               TO  MCP-PATHNAME
grpsys             PERFORM 900-ORCDBMAIN-SEC
      *
                   IF      MCP-RC     NOT =   ZERO
                       MOVE    "1002"          TO  SPA-ERRCD
                       GO  TO  450-KOUSIN-EXT
                   END-IF
               END-IF
           ELSE    
               MOVE    "1001"          TO  SPA-ERRCD
               GO  TO  450-KOUSIN-EXT
           END-IF
      *
           MOVE    2               TO  SPA-H01GMN-CUR
           INITIALIZE                  SPA-H01GMN-TABLE
                                       SPA-H01GMN-KOUMOKU
                                       SPA-H01GMN-KOUMOKU1
                                       SPA-H01NAI-KOUMOKU
                                       SPA-H01NAI-KOUMOKU1
                                       SPA-RECE10-KEY
      *
      *    排他制御解除処理
           PERFORM 990-LOCK-OUT-SEC
           .
       450-KOUSIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    氏名検索へ
      *****************************************************************
       480-KENSAKU-SEC             SECTION.
      *
           IF      SPA-H01NAI-SRYYM    =   ZERO
               MOVE    "0005"              TO  SPA-ERRCD
               GO  TO  480-KENSAKU-EXT
           END-IF
      *         
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-H01-AREA        TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "H01"               TO  SPA-MOTOPG
           MOVE    "P97"               TO  SPA-SAKIPG
      *
      *    氏名をクリアする
           MOVE    SPACE               TO  SPA-NAME
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    "P97"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
           .
       480-KENSAKU-EXT.
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
           IF      SPA-HIDCD       NOT =   SPACE
               PERFORM 520-RIDSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "H01    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      *
           INITIALIZE              H01
      *
           MOVE    SPA-H01GMN-PTNUM       TO  H01-PTNUM
           MOVE    SPA-H01GMN-NAME        TO  H01-NAME-VALUE
           MOVE    SPA-H01GMN-SRYYM       TO  H01-SRYYM
           MOVE    SPA-H01GMN-SRYKA       TO  H01-SRYKA-VALUE
           MOVE    SPA-H01GMN-SRYKANAME   TO  H01-SRYKANAME-VALUE
           MOVE    SPA-H01GMN-SKYYM       TO  H01-SKYYM
           MOVE    SPA-H01GMN-HENREIYM    TO  H01-HENREIYM
           MOVE    SPA-H01GMN-SKYKBN-G    TO  H01-SKYKBN
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   3
                   OR          SPA-H01GMN-SKYKBNL  (IDX)   =   SPACE 
               MOVE    SPA-H01GMN-SKYKBNLST (IDX)
                                          TO  H01-SKYKBNLST (IDX)
               MOVE    IDX                TO  H01-SKYKBN-COUNT
           END-PERFORM
           MOVE    SPA-H01GMN-TEISEIKBNNM TO  H01-TEISEIKBNNM-VALUE
           MOVE    SPA-H01GMN-HNYUGAIKBN  TO  H01-HNYUGAIKBN-VALUE
           MOVE    SPA-H01GMN-HTEISYUTUSAKI 
                                          TO  H01-HTEISYUTUSAKI-VALUE
           MOVE    SPA-H01GMN-HRECESYUBETU
                                          TO  H01-HRECESYUBETU-VALUE
           MOVE    SPA-H01GMN-HHKNJANUM   TO  H01-HHKNJANUM-VALUE
           MOVE    SPA-H01GMN-HHOJOKBN    TO  H01-HHOJOKBN-VALUE
           MOVE    SPA-H01GMN-HKIGO       TO  H01-HKIGO-VALUE   
      *
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL   IDX     >   38
      *****        OR          SPA-H01GMN-MIDASI (IDX)    =   SPACE
               MOVE    SPA-H01GMN-MIDASI (IDX)    TO  H01-MIDASI (IDX)
               MOVE    SPA-H01GMN-KHNTEN (IDX)    TO  H01-KHNTEN (IDX)
               MOVE    SPA-H01GMN-KAISU  (IDX)    TO  H01-KAISU  (IDX)
               PERFORM VARYING IDY FROM    1       BY  1
                       UNTIL   IDY     >   3
                   MOVE    SPA-H01GMN-TENSU (IDY IDX)
                                           TO  H01-TENSU (IDY IDX)
               END-PERFORM
      *
               MOVE    SPA-H01GMN-NKHNTEN (IDX)
                                           TO  H01-NKHNTEN (IDX)
               MOVE    SPA-H01GMN-NKAISU  (IDX)
                                           TO  H01-NKAISU  (IDX)
               PERFORM VARYING IDY FROM    1       BY  1
                       UNTIL   IDY     >   3
                   MOVE    SPA-H01GMN-NTENSU (IDY IDX)
                                           TO  H01-NTENSU (IDY IDX)
               END-PERFORM
           END-PERFORM
      *
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL   IDX     >   3
               MOVE    SPA-H01GMN-TOTALTEN (IDX)
                                               TO  H01-TOTALTEN (IDX)
               MOVE    SPA-H01GMN-FTNMONEY (IDX)
                                               TO  H01-FTNMONEY (IDX)
               MOVE    SPA-H01GMN-YKZFTN   (IDX)
                                               TO  H01-YKZFTN   (IDX)
               MOVE    SPA-H01GMN-JNISSU   (IDX)
                                               TO  H01-JNISSU   (IDX)
               MOVE    SPA-H01GMN-SHORYOYOHI (IDX)
                                               TO  H01-SHORYOYOHI (IDX)
               MOVE    SPA-H01GMN-SHOFTN   (IDX)
                                               TO  H01-SHOFTN   (IDX)
               MOVE    SPA-H01GMN-SHONISSU (IDX)
                                               TO  H01-SHONISSU (IDX)
      *
               MOVE    SPA-H01GMN-NTOTALTEN(IDX)
                                               TO  H01-NTOTALTEN(IDX)
               MOVE    SPA-H01GMN-NFTNMONEY(IDX)
                                               TO  H01-NFTNMONEY(IDX)
               MOVE    SPA-H01GMN-NYKZFTN  (IDX)
                                               TO  H01-NYKZFTN  (IDX)
               MOVE    SPA-H01GMN-NJNISSU  (IDX)
                                               TO  H01-NJNISSU  (IDX)
               MOVE    SPA-H01GMN-NSHORYOYOHI (IDX)
                                               TO  H01-NSHORYOYOHI (IDX)
               MOVE    SPA-H01GMN-NSHOFTN   (IDX)
                                               TO  H01-NSHOFTN   (IDX)
               MOVE    SPA-H01GMN-NSHONISSU (IDX)
                                               TO  H01-NSHONISSU (IDX)
           END-PERFORM
      *
           MOVE    SPA-H01GMN-SHOMIDASI (1)    TO  H01-SHOMIDASI (1)
                                                   H01-SHOMIDASI (4) 
           MOVE    SPA-H01GMN-SHOMIDASI (2)    TO  H01-SHOMIDASI (2)
                                                   H01-SHOMIDASI (5) 
           MOVE    SPA-H01GMN-SHOMIDASI (3)    TO  H01-SHOMIDASI (3)
                                                   H01-SHOMIDASI (6) 
      *
           MOVE    SPA-H01GMN-TENMIDASI (1)    TO  H01-TENMIDASI (1)
                                                   H01-TENMIDASI (5) 
           MOVE    SPA-H01GMN-TENMIDASI (2)    TO  H01-TENMIDASI (2)
                                                   H01-TENMIDASI (6) 
           MOVE    SPA-H01GMN-TENMIDASI (3)    TO  H01-TENMIDASI (3)
                                                   H01-TENMIDASI (7) 
           MOVE    SPA-H01GMN-TENMIDASI (4)    TO  H01-TENMIDASI (4)
                                                   H01-TENMIDASI (8) 
      *    色の設定
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL   IDX     >   38
               MOVE    SPA-H01GMN-MIDASI-STYLE (IDX)
                                       TO  H01-MIDASI-STYLE (IDX)
           END-PERFORM
           MOVE    "blue"              TO  H01-NAME-STYLE
                                           H01-SRYKANAME-STYLE
                                           H01-TEISEIKBNNM-STYLE
           MOVE    "blue"              TO  H01-HNYUGAIKBN-STYLE
                                           H01-HTEISYUTUSAKI-STYLE
                                           H01-HRECESYUBETU-STYLE
                                           H01-HHKNJANUM-STYLE
                                           H01-HKIGO-STYLE
                                           H01-HHOJOKBN-STYLE
      *
      *    入力の設定
           IF      SPA-SYS-1001-HOSPSBT1   =   "0"
               MOVE    WIDGET-INSENSITIVE  TO  H01-SRYKA-STATE
           ELSE
               MOVE    WIDGET-NORMAL       TO  H01-SRYKA-STATE
           END-IF
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX     >   38
               MOVE    WIDGET-INSENSITIVE  TO  H01-KHNTEN-STATE (IDX)
                                               H01-KAISU-STATE  (IDX)
               PERFORM VARYING IDY FROM    1       BY  1
                       UNTIL   IDY     >   3
                   MOVE    WIDGET-INSENSITIVE
                                   TO  H01-TENSU-STATE (IDY IDX)
               END-PERFORM
           END-PERFORM
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL   IDX     >   3
               MOVE    WIDGET-INSENSITIVE
                                   TO  H01-TOTALTEN-STATE  (IDX)
                                       H01-FTNMONEY-STATE  (IDX)
                                       H01-YKZFTN-STATE    (IDX)
                                       H01-JNISSU-STATE    (IDX)
                                       H01-NTOTALTEN-STATE (IDX)
                                       H01-SHORYOYOHI-STATE(IDX)
                                       H01-SHOFTN-STATE    (IDX)
                                       H01-SHONISSU-STATE  (IDX)
               MOVE    SPA-H01GMN-SHO-STATE
                                   TO  H01-NSHORYOYOHI-STATE(IDX)
                                       H01-NSHOFTN-STATE    (IDX)
                                       H01-NSHONISSU-STATE  (IDX)
           END-PERFORM
      *
           MOVE    SPA-H01GMN-AGE     TO  H01-AGE
           MOVE    SPA-H01GMN-KYURATE TO  H01-KYURATE     
           MOVE    SPA-H01GMN-ZAITAKU TO  H01-ZAITAKU 
           MOVE    SPA-H01GMN-HONKZKKBN
                                      TO  H01-HONKZKKBN
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
         EVALUATE    SPA-H01GMN-CUR
             WHEN    2
                    MOVE  "PTNUM"        TO  MCP-WIDGET
             WHEN    1
                    MOVE  "SRYYM"        TO  MCP-WIDGET
             WHEN    3
                    MOVE  "SRYKA"        TO  MCP-WIDGET
             WHEN    4
                    MOVE  "SKYYM"        TO  MCP-WIDGET
             WHEN    5
                    MOVE  "HENREIYM"     TO  MCP-WIDGET
             WHEN    6
                    MOVE  "SKYKBN"       TO  MCP-WIDGET
             WHEN    8   THRU    182
                 COMPUTE IDX     =   SPA-H01GMN-CUR     -   3   
                 DIVIDE   IDX          BY  5
                                       GIVING       WRK-SYO
                                       REMAINDER    WRK-AMARI
                 MOVE    WRK-SYO          TO  WRK-WIDGET 
                 EVALUATE    WRK-AMARI
                     WHEN    0
                         MOVE  "NKHNTEN"  TO  MCP-WIDGET
                         MOVE  WRK-WIDGET-X TO  MCP-WIDGET (8:2)
                     WHEN    1
                         MOVE  "NKAISU"   TO  MCP-WIDGET
                         MOVE  WRK-WIDGET-X TO  MCP-WIDGET (7:2)
                     WHEN    2
                         MOVE  "NTENSU"   TO  MCP-WIDGET
                         MOVE  WRK-WIDGET-X TO  MCP-WIDGET (7:2)
                     WHEN    3
                         MOVE  "NKOHTENSU1"  TO  MCP-WIDGET
                         MOVE  WRK-WIDGET-X TO  MCP-WIDGET (11:2)
                     WHEN    4
                         MOVE  "NKOHTENSU2"  TO  MCP-WIDGET
                         MOVE  WRK-WIDGET-X TO  MCP-WIDGET (11:2)
                 END-EVALUATE                    
             WHEN    183
                    MOVE  "NFTNMONEY1"   TO  MCP-WIDGET
             WHEN    184
                    MOVE  "NFTNMONEY2"   TO  MCP-WIDGET
             WHEN    185
                    MOVE  "NFTNMONEY3"   TO  MCP-WIDGET
             WHEN    186
                    MOVE  "NYKZFTN1"     TO  MCP-WIDGET
             WHEN    187
                    MOVE  "NYKZFTN2"     TO  MCP-WIDGET
             WHEN    188
                    MOVE  "NYKZFTN3"     TO  MCP-WIDGET
             WHEN    189
                    MOVE  "NJNISSU1"     TO  MCP-WIDGET
             WHEN    190
                    MOVE  "NJNISSU2"     TO  MCP-WIDGET
             WHEN    191
                    MOVE  "NJNISSU3"     TO  MCP-WIDGET
             WHEN    192
                    MOVE  "NSHORYOYOHI1"   TO  MCP-WIDGET
             WHEN    193
                    MOVE  "NSHORYOYOHI2"   TO  MCP-WIDGET
             WHEN    194
                    MOVE  "NSHORYOYOHI3"   TO  MCP-WIDGET
             WHEN    195
                    MOVE  "NSHOFTN1"     TO  MCP-WIDGET
             WHEN    196
                    MOVE  "NSHOFTN2"     TO  MCP-WIDGET
             WHEN    197
                    MOVE  "NSHOFTN3"     TO  MCP-WIDGET
             WHEN    198
                    MOVE  "NSHONISSU1"     TO  MCP-WIDGET
             WHEN    199
                    MOVE  "NSHONISSU2"     TO  MCP-WIDGET
             WHEN    200
                    MOVE  "NSHONISSU3"     TO  MCP-WIDGET
             WHEN    300
                    MOVE  "B12"        TO  MCP-WIDGET   
         END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
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
                   MOVE    "入力エラーです"  TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "年月の入力エラーです"
                                             TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "対象のレセプトは存在しません"
                                             TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "該当の患者が存在しません"
                                               TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "診療年月が未入力です" 
                                               TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "修正項目がありません" 
                                               TO  SPA-ERRMSG
               WHEN    "0015"
                   MOVE    "更新対象のデータを入力して下さい" 
                                               TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新できませんでした"
                                             TO  SPA-ERRMSG
               WHEN    "1010"
                   MOVE
                       "対象の請求データが存在しないので更新できません"
                                             TO  SPA-ERRMSG
      *
               WHEN    "9999"
                   MOVE    "他端末で使用中です。"
                                               TO  SPA-ERRMSG
                   MOVE    SLOCK-MSG           TO  SPA-ERRMSG(21:)
           END-EVALUATE
      *
           MOVE    SPACE                TO  HERR
           MOVE    SPA-ERRCD            TO  HERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  HERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "H01"                TO  SPA-MOTOPG
           MOVE    "HERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "HERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    確認メッセージ表示処理
      *****************************************************************
       520-RIDSET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-HIDMSG
      *
           EVALUATE    SPA-HIDCD
               WHEN    "1001"
                   MOVE    "更新処理をします"
                                        TO  WRK-HIDMSG
               WHEN    "0101"
                   MOVE    "入力の途中です。終了してよろしいですか。"
                                        TO  WRK-HIDMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  HID1
           MOVE    SPA-HIDCD            TO  HID1-ID1CODE
           MOVE    WRK-HIDMSG           TO  HID1-ID1MSG
           MOVE    "B12"                TO  MCP-WIDGET
      *
           MOVE    "H01"                TO  SPA-MOTOPG
           MOVE    "HID1"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "HID1"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       520-RIDSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD (1:6)          =   ZERO    OR  SPACE
               MOVE    SPACE                   TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト種別編集処理
      *****************************************************************
       530-RECESYUBETU-HENSYU-SEC          SECTION.
      *
           MOVE   SPACE                TO  WRK-RECESYUBETU
      *
           IF      RECE10-TEISYUTUSAKI =   "5"
      ***      MOVE    "公害"              TO  WRK-RECESYUBETU
               GO  TO  530-RECESYUBETU-HENSYU-EXT
           END-IF        
      *
           IF      RECE10-RECESYUBETU  =   "6666"
               MOVE    "特別療養費"        TO  WRK-RECESYUBETU
               GO  TO  530-RECESYUBETU-HENSYU-EXT
           END-IF        
      *
           IF      RECE10-SRYYM        >   "200209"
               MOVE    RECE10-RECESYUBETU  TO  WRK-RECESYUBETU
               GO  TO  530-RECESYUBETU-HENSYU-EXT
           END-IF        
      *         
           EVALUATE  RECE10-RECESYUBETU
                                 ALSO  RECE10-TEISYUTUSAKI
           WHEN    1111      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "★★★"    TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "★"        TO  WRK-RECESYUBETU
               END-IF
           WHEN    1111      ALSO      1
           WHEN    1111      ALSO      ANY
               MOVE    "★"            TO  WRK-RECESYUBETU
      *
           WHEN    1112      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "☆☆☆☆"  TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "☆☆"      TO  WRK-RECESYUBETU
               END-IF
           WHEN    1112      ALSO      1
               MOVE    "☆☆"          TO  WRK-RECESYUBETU
      *
           WHEN    1115      ALSO      ANY
               MOVE    "★★★"        TO  WRK-RECESYUBETU
      *
           WHEN    1116      ALSO      ANY
               MOVE    "☆☆☆☆"      TO  WRK-RECESYUBETU
      ****     MOVE    "★★★★"      TO  WRK-RECESYUBETU
      *
           WHEN    1121      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "★★★"    TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "★"        TO  WRK-RECESYUBETU
               END-IF
           WHEN    1121      ALSO      1
               MOVE    "★"            TO  WRK-RECESYUBETU
      *
           WHEN    1122      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "☆☆☆☆"  TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "☆☆"      TO  WRK-RECESYUBETU
               END-IF
           WHEN    1122      ALSO      1
               MOVE    "☆☆"          TO  WRK-RECESYUBETU
      *
           WHEN    1125      ALSO      ANY
               MOVE    "★★★"        TO  WRK-RECESYUBETU
      *
           WHEN    1126      ALSO      ANY
               MOVE    "☆☆☆☆"      TO  WRK-RECESYUBETU
      *
           WHEN    1131      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "★★★"    TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "★"        TO  WRK-RECESYUBETU
               END-IF
           WHEN    1131      ALSO      1
               MOVE    "★"            TO  WRK-RECESYUBETU
      *
           WHEN    1132      ALSO      2
               IF  RECE10-HONKZKKBN    =   2
                   MOVE    "☆☆☆☆"  TO  WRK-RECESYUBETU
               ELSE
                   MOVE    "☆☆"      TO  WRK-RECESYUBETU
               END-IF
           WHEN    1132      ALSO      1
               MOVE    "☆☆"          TO  WRK-RECESYUBETU
      *
           WHEN    1135      ALSO      ANY
               MOVE    "★★★"        TO  WRK-RECESYUBETU
      *
           WHEN    1136      ALSO      ANY
               MOVE    "☆☆☆☆"      TO  WRK-RECESYUBETU
      *
           WHEN    1211      ALSO      ANY
           WHEN    1221      ALSO      ANY
           WHEN    1231      ALSO      ANY
               MOVE    "●"            TO  WRK-RECESYUBETU
      *
           WHEN    1212      ALSO      ANY
           WHEN    1222      ALSO      ANY
           WHEN    1232      ALSO      ANY
               MOVE    "○○"          TO  WRK-RECESYUBETU
      *
           WHEN    1311      ALSO      ANY
           WHEN    1321      ALSO      ANY
           WHEN    1331      ALSO      ANY
               MOVE    "▲"            TO  WRK-RECESYUBETU
      *
           WHEN    1312      ALSO      ANY
           WHEN    1322      ALSO      ANY
           WHEN    1332      ALSO      ANY
               MOVE    "△△"          TO  WRK-RECESYUBETU
      *
           WHEN    1411      ALSO      ANY
           WHEN    1421      ALSO      ANY
           WHEN    1431      ALSO      ANY
               MOVE    "◆"            TO  WRK-RECESYUBETU
      *
           WHEN    1412      ALSO      ANY
           WHEN    1422      ALSO      ANY
           WHEN    1432      ALSO      ANY
               MOVE    "◇◇"          TO  WRK-RECESYUBETU
      *
           WHEN    1415      ALSO      ANY
           WHEN    1425      ALSO      ANY
           WHEN    1435      ALSO      ANY
               MOVE    "◆◆◆"        TO  WRK-RECESYUBETU
      *
           WHEN    1416      ALSO      ANY
           WHEN    1426      ALSO      ANY
           WHEN    1436      ALSO      ANY
               MOVE    "◇◇◇◇"      TO  WRK-RECESYUBETU
           END-EVALUATE
      *
           .
       530-RECESYUBETU-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       910-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key10"             TO  MCP-PATHNAME
grpsys         PERFORM 900-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       910-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込（主キー）
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptinf"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
grpsys         PERFORM 900-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTINF-REC
                   MOVE    ZERO                TO  FLG-PTINF
               ELSE
                   MOVE    1                   TO  FLG-PTINF
                   INITIALIZE                      PTINF-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTINF
               INITIALIZE                      PTINF-REC
           END-IF
      *
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求マスター読込（主キー）
      *****************************************************************
       900-SEIKYU-INV-SEC         SECTION.
      *
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_seikyu"        TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SEIKYU
           END-IF
      *
           MOVE    "tbl_seikyu"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-SEIKYU-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求マスター読込
      *****************************************************************
       900-SEIKYU-READ-SEC           SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SEIKYU
           ELSE
               MOVE    1               TO  FLG-SEIKYU
           END-IF
      *
           .
       900-SEIKYU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費請求マスター読込（主キー）
      *****************************************************************
       900-KOHSKY-INV-SEC         SECTION.
      *
           MOVE    KOHSKY-REC          TO  MCPDATA-REC
           MOVE    "tbl_kohsky"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
grpsys     PERFORM 900-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_kohsky"        TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 900-KOHSKY-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-KOHSKY
           END-IF
      *
           MOVE    "tbl_kohsky"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 900-CLOSE-SEC
      *
           .
       900-KOHSKY-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費請求マスター読込
      *****************************************************************
       900-KOHSKY-READ-SEC           SECTION.
      *
grpsys     PERFORM 900-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-KOHSKY
           ELSE
               MOVE    1               TO  FLG-KOHSKY
           END-IF
      *
           .
       900-KOHSKY-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    排他制御処理
      *****************************************************************
       990-LOCK-IN-SEC         SECTION.
      *
      *    排他制御処理
           MOVE    1                   TO  SLOCK-MODE
           MOVE    SPA-H01NAI-PTID     TO  SLOCK-PTID
           CALL    "ORCSLOCK"          USING
                                       MCPAREA
                                       SPA-AREA
                                       ORCSLOCKAREA
           IF      SLOCK-RETURN    NOT =   ZERO
               MOVE    "9999"              TO  SPA-ERRCD
           END-IF
           .
       990-LOCK-IN-EXT.
           EXIT.
      *
      *****************************************************************
      *    排他制御解除処理
      *****************************************************************
       990-LOCK-OUT-SEC         SECTION.
      *
      *    排他制御解除処理
           MOVE    2                   TO  SLOCK-MODE
           CALL    "ORCSLOCK"          USING
                                       MCPAREA
                                       SPA-AREA
                                       ORCSLOCKAREA
           .
       990-LOCK-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＳＥＬＥＣＴ処理
      *****************************************************************
       900-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢＦＥＴＣＨ処理
      *****************************************************************
       900-DBFETCH-SEC                SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルクローズ処理
      *****************************************************************
       900-CLOSE-SEC               SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
grpsys     PERFORM 900-ORCDBMAIN-SEC
      *
           .
       900-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブルアクセス処理
      *****************************************************************
       900-ORCDBMAIN-SEC               SECTION.
      *
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
      *
       900-ORCDBMAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"          TO  MCP-FUNC
           PERFORM 900-ORCDBMAIN-SEC
           .
      *
       900-PUT-WINDOW-EXT.
           EXIT.
