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
       PROGRAM-ID.             ORCGP029.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : 患者番号登録処理
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-太田      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-太田     01/04/13  帳票出力時パラメータ誤り
      *  01.00.02    MCC-太田     01/05/24  パラメタの変更
      *  01.00.03    MCC-多々納   01/06/13  登録後、診療行為遷移を追加
      *  01.00.04    MCC-多々納   02/04/05  労災保険の追加
      *  01.00.05    MCC-多々納   02/06/18  月代り受給者番号の追加
      *  02.00.00    MCC-多々納   02/06/25  患者情報・旧姓履歴・患者番号
      *                                     をパラメタからＳＰＡで更新へ
      *  02.00.01    NACL-多々納  02/07/31  パラメタファイルをＤＢへ
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
      *FILE-CONTROL.
      *
      *    パラメタデータ
      *    SELECT  PARA-FILE       ASSIGN  FILE-NAME1
      *                            ORGANIZATION    IS  INDEXED
      *                            ACCESS  MODE    IS  DYNAMIC
      *                            RECORD  KEY     IS  PAR-KEY
      *                            FILE    STATUS  IS  STS-PARA.
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
      *    パラメタデータ
      *FD  PARA-FILE.
      *01  PARA-REC.
      *    03  PAR-KEY.
      *        05  PAR-FILEMEI         PIC X(08).
      *        05  PAR-EDANUM          PIC 9(04).
      *    03  PARA-DATA-REC            PIC X(3000).
      *
       WORKING-STORAGE             SECTION.
      *    パラメタファイル名
      *01  FILE-NAME1.
      *    03  FILLER              PIC X(09)   VALUE   "/var/tmp/".
      *    03  FILLER              PIC X(07)   VALUE   "P01PARA".
      *    03  FILE-TERMID1        PIC X(32)   VALUE   SPACE.
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *    患者登録スパ領域
           COPY    "P02COMMON-SPA".
      *    患者登録全画面スパ領域
           COPY    "P02SCR-SPA".
      *    処方箋印刷パラメータ
           COPY    "CPORCHC02.INC".
      *
      *    処方箋印刷パラメータ
           COPY    "CPORCHC19.INC".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-PTHKNINF        PIC 9(01).
           03  FLG-PTKOHINF        PIC 9(01).
           03  FLG-UKETUKE         PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-KYUSEIRRK       PIC 9(01).
           03  FLG-KNJSAI          PIC 9(01).
           03  FLG-PTNUM           PIC 9(01).
           03  FLG-YYK             PIC 9(01).
           03  FLG-TSYRRK          PIC 9(01).
           03  FLG-TNKRRK          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-PTRSIINF        PIC 9(01).
           03  FLG-MONTHLYNUM      PIC 9(01).
      *
           03  FLG-SYORI           PIC X(01).
           03  FLG-SYORI2          PIC X(01).
           03  FLG-TSYRRK2         PIC X(01).
           03  FLG-TNKRRK2         PIC X(01).
           03  FLG-KYUSEIRRK2      PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
           03  SYS-TIME.
               05  SYS-THH         PIC 9(02).
               05  SYS-TMM         PIC 9(02).
               05  SYS-TSS         PIC 9(02).
               05  SYS-TDD         PIC 9(02).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX2                PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYSYMD.
               05  WRK-SYSYY         PIC 9(04).
               05  WRK-SYSMM         PIC 9(02).
               05  WRK-SYSDD         PIC 9(02).
      *
           03  WRK-WSYSYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-UKEID           PIC 9(04).
           03  WRK-HKN-CNT         PIC 9(04).
           03  WRK-KOH-CNT         PIC 9(04).
      *
      *    カルテＰＧ名
           03  WRK-KARUTE-PG           PIC X(20).
      *    処方せんＰＧ名
           03  WRK-SYOHOU-PG           PIC X(20).
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
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    患者番号構成管理マスタ
           COPY    "CPSK1009.INC".
      *　　（帳票プログラム）
           COPY    "CPSK1032.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険マスタ
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *
      *    公費マスタ
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *
      *    受診内容
       01  UKETUKE-REC.
           COPY    "CPUKETUKE.INC".
      *
      *    予約マスター
       01  YYK-REC.
           COPY    "CPYYK.INC".
      *
      *    保険組合せ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    旧姓履歴
       01  KYUSEIRRK-REC.
           COPY    "CPKYUSEIRRK.INC".
      *
      *    低所得
       01  TSYRRK-REC.
           COPY    "CPTSYRRK.INC".
      *
      *    年金
       01  TNKRRK-REC.
           COPY    "CPTNKRRK.INC".
      *
      *    患者番号変換（管理）
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *    月代り受給者番号
       01  MONTHLYNUM-REC.
           COPY    "CPMONTHLYNUM.INC".
      *
      *    パラメタテーブル
       01  PARA-REC.
           COPY    "CPPARA.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
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
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-P02KYOUTU
           MOVE    SPA-FREE        TO  SPA-P02SCRAREA
      *
      *    初期　処理
           PERFORM 100-INIT-SEC
      *
      *    ＤＢ更新処理
           PERFORM 200-MAIN-SEC
      *
           MOVE    SPA-P02KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-P02SCRAREA  TO  SPA-FREE
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
           INITIALIZE                  STS-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
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
      *    患者情報更新
           PERFORM 210-PTINF-SYORI-SEC
      *
      *    旧姓履歴更新
           PERFORM 260-KYUSEIRRK-SYORI-SEC
      *
      *    患者番号情報更新
           PERFORM 280-PTNUM-SYORI-SEC
      *
      *
           INITIALIZE                      PARA-REC
           MOVE    "P02"               TO  PARA-GYOUMUID
           MOVE    SPA-TERMID          TO  PARA-TERMID
      *
           MOVE    PARA-REC            TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PARA-KEY3"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PARA-KEY3"         TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           ELSE
               INITIALIZE                  PARA-REC
               MOVE    1               TO  FLG-PARA
           END-IF
      *
           PERFORM
               UNTIL   FLG-PARA            =   1
               EVALUATE    PARA-FILEMEI
      **********   WHEN    "PTINF"
      *********        PERFORM 210-PTINF-SYORI-SEC
                   WHEN    "PTHKNINF"
                       PERFORM 220-PTHKNINF-SYORI-SEC
                       ADD     1        TO  WRK-HKN-CNT
                   WHEN    "PTKOHINF"
                       PERFORM 230-PTKOHINF-SYORI-SEC
                       ADD     1        TO  WRK-KOH-CNT
                   WHEN    "UKETUKE"
                       PERFORM 240-UKETUKE-SYORI-SEC
                   WHEN    "HKNCOMBI"
                       IF  PARA-DATA-REC   NOT =   SPACE
                           PERFORM 250-HKNCOMBI-SYORI-SEC
                       ELSE
                           CONTINUE
                       END-IF
      **********   WHEN    "KYUSEI"
      *                PERFORM 260-KYUSEIRRK-SYORI-SEC
      *            WHEN    "PTNUM"
      *************    PERFORM 280-PTNUM-SYORI-SEC
                   WHEN    "TSYRRK"
                       PERFORM 290-TSYRRK-SYORI-SEC
                   WHEN    "TNKRRK"
                       PERFORM 291-TNKRRK-SYORI-SEC
                   WHEN    "PTRSIINF"
      *                患者労災保険情報
                       PERFORM 292-PTRSIINF-SYORI-SEC
               END-EVALUATE
      *
               MOVE    "PARA-KEY3"         TO  ORC-DBPATH
               PERFORM 990-PARA-READ-SEC
           END-PERFORM
      *
      *
      *    カルテ／処方箋発行処理
           PERFORM 2100-HC01-SYORI-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
           .
      *****************************************************************
      *    患者マスター処理
      *****************************************************************
       210-PTINF-SYORI-SEC            SECTION.
      *
      *
           INITIALIZE                      PTINF-REC
           MOVE    SPA-HOSPID          TO  PTINF-HOSPID
           MOVE    SPA-GMN-PTID        TO  PTINF-PTID
           MOVE    PTINF-REC           TO  MCPDATA-REC
           PERFORM 900-PTINF-READ-SEC
      *
           IF      FLG-PTINF           =   1
               INITIALIZE                      PTINF-REC
               MOVE    SPA-HOSPID          TO  PTINF-HOSPID
               MOVE    SPA-GMN-PTID        TO  PTINF-PTID
      *        入力値編集
               PERFORM 2101-PTINF-HENSYU-SEC
      *        作成年月日
               MOVE    SPA-SYSYMD          TO  PTINF-CREYMD
      *        更新年月日
               MOVE    SPA-SYSYMD          TO  PTINF-UPYMD
      *
               MOVE    PTINF-REC           TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 PTINF INS ERR:" MCP-RC
               END-IF
           ELSE
               MOVE    MCPDATA-REC         TO  PTINF-REC
      *        入力値編集
               PERFORM 2101-PTINF-HENSYU-SEC
      *        更新年月日
               MOVE    SPA-SYSYMD          TO  PTINF-UPYMD
      *
               MOVE    PTINF-REC           TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PTINF-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 PTINF UPD ERR:" MCP-RC
               END-IF
           END-IF
           .
       210-PTINF-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    患者情報編集処理
      *****************************************************************
       2101-PTINF-HENSYU-SEC        SECTION.
      *
           MOVE    SPA-GMN-NAME            TO  PTINF-NAME
           MOVE    SPA-GMN-KANANAME        TO  PTINF-KANANAME
           MOVE    SPA-GMN-SEX             TO  PTINF-SEX
           IF      SPA-NAI-BIRTHDAY        =   SPACE  OR  ZERO
               MOVE    SPACE               TO  PTINF-BIRTHDAY
           ELSE
               MOVE    SPA-NAI-BIRTHDAY    TO  PTINF-BIRTHDAY
           END-IF
           MOVE    SPA-GMN-NICKNAME        TO  PTINF-NICKNAME
           MOVE    SPA-GMN-DEATHKBN        TO  PTINF-DEATHKBN
           MOVE    SPA-GMN-POST            TO  PTINF-HOME-POST
           MOVE    SPA-GMN-EDITADRS-NAME   TO  PTINF-HOME-ADRS
           MOVE    SPA-GMN-BANTI           TO  PTINF-HOME-BANTI
           MOVE    SPA-GMN-TEL1            TO  PTINF-HOME-TEL1
           MOVE    SPA-GMN-TEL2            TO  PTINF-HOME-TEL2
           MOVE    SPA-GMN-SETAINUSI       TO  PTINF-SETAINUSI
           MOVE    SPA-GMN-ZOKUGARA        TO  PTINF-ZOKUGARA
           MOVE    SPA-GMN-DISCOUNTKBN     TO  PTINF-DISCOUNT-KBN
           MOVE    SPA-GMN-DISCOUNT        TO  PTINF-DISCOUNT
           MOVE    SPA-GMN-CONDITION(1)    TO  PTINF-CONDITION-1
           MOVE    SPA-GMN-CONDITION(2)    TO  PTINF-CONDITION-2
           MOVE    SPA-GMN-CONDITION(3)    TO  PTINF-CONDITION-3
           MOVE    SPA-GMN-COMMENT-1       TO  PTINF-COMMENT-1
           MOVE    SPA-GMN-COMMENT-2       TO  PTINF-COMMENT-2
           MOVE    SPA-GMN-TABOO-1         TO  PTINF-TABOO-1
           MOVE    SPA-GMN-TABOO-2         TO  PTINF-TABOO-2
           MOVE    SPA-GMN-ALLERGY-1       TO  PTINF-ALLERGY-1
           MOVE    SPA-GMN-ALLERGY-2       TO  PTINF-ALLERGY-2
           MOVE    SPA-GMN-KANSENSYO-1     TO  PTINF-KANSENSYO-1
           MOVE    SPA-GMN-KANSENSYO-2     TO  PTINF-KANSENSYO-2
      *
      *    テスト患者番号区分
           MOVE    SPA-GMN-TSTPTNUMKBN     TO  PTINF-TSTPTNUMKBN
      *
      *    連絡先
           MOVE    SPA-GMN21-FAX            TO  PTINF-FAX
           MOVE    SPA-GMN21-KEITAI-TEL     TO  PTINF-KEITAI-TEL
           MOVE    SPA-GMN21-EMAIL          TO  PTINF-EMAIL
           MOVE    SPA-GMN21-JOB            TO  PTINF-JOB
           MOVE    SPA-GMN21-RENRAKU-NAME   TO  PTINF-RENRAKU-NAME
           MOVE    SPA-GMN21-RENRAKU-ZOKUGARA
                                            TO  PTINF-RENRAKU-ZOKUGARA
           MOVE    SPA-GMN21-RENRAKU-POST   TO  PTINF-RENRAKU-POST
           MOVE    SPA-GMN21-RENRAKU-ADRS   TO  PTINF-RENRAKU-ADRS
           MOVE    SPA-GMN21-RENRAKU-BANTI  TO  PTINF-RENRAKU-BANTI
           MOVE    SPA-GMN21-RENRAKU-TEL1   TO  PTINF-RENRAKU-TEL1
           MOVE    SPA-GMN21-RENRAKU-TEL2   TO  PTINF-RENRAKU-TEL2
           MOVE    SPA-GMN21-OFFICE-NAME    TO  PTINF-OFFICE-NAME
           MOVE    SPA-GMN21-OFFICE-POST    TO  PTINF-OFFICE-POST
           MOVE    SPA-GMN21-OFFICE-ADRS    TO  PTINF-OFFICE-ADRS
           MOVE    SPA-GMN21-OFFICE-BANTI   TO  PTINF-OFFICE-BANTI
           MOVE    SPA-GMN21-OFFICE-TEL     TO  PTINF-OFFICE-TEL
           MOVE    SPA-GMN21-KISEI-NAME     TO  PTINF-KISEI-NAME
           MOVE    SPA-GMN21-KISEI-POST     TO  PTINF-KISEI-POST
           MOVE    SPA-GMN21-KISEI-ADRS     TO  PTINF-KISEI-ADRS
           MOVE    SPA-GMN21-KISEI-BANTI    TO  PTINF-KISEI-BANTI
           MOVE    SPA-GMN21-KISEI-TEL      TO  PTINF-KISEI-TEL
      *
      *
           .
       2101-PTINF-HENSYUI-EXT.
           EXIT.
      *****************************************************************
      *    患者保険マスター処理
      *****************************************************************
       220-PTHKNINF-SYORI-SEC        SECTION.
      *
           MOVE    PARA-DATA-REC       TO  PTHKNINF-REC
      *
           MOVE    PTHKNINF-REC        TO  MCPDATA-REC
           PERFORM 910-PTHKNINF-READ-SEC
      *
           IF      FLG-PTHKNINF        =   1
               MOVE    PTHKNINF-REC        TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 PTHKNINF INS ERR:" MCP-RC 
               END-IF
           ELSE
               MOVE    PTHKNINF-REC        TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 PTHKNINF UPD ERR:" MCP-RC
               END-IF
           END-IF
           .
       220-PTHKNINF-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    患者保険マスター処理
      *****************************************************************
       230-PTKOHINF-SYORI-SEC        SECTION.
      *
           MOVE    PARA-DATA-REC        TO  PTKOHINF-REC
      *
           MOVE    PTKOHINF-REC        TO  MCPDATA-REC
           PERFORM 920-PTKOHINF-READ-SEC
      *
           IF      FLG-PTKOHINF        =   1
               MOVE    PTKOHINF-REC        TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "PTKOHINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 PTKOHINF INS ERR:" MCP-RC
               END-IF
           ELSE
               MOVE    PTKOHINF-REC        TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PTKOHINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 PTKOHINF UPD ERR:" MCP-RC
               END-IF
           END-IF
      *
      *    月代り受給者番号登録（生活保護で、新規登録の時）
           IF      PTKOH-KOHNUM        =   "012"
               PERFORM 2301-MONTHLYNUM-SYORI-SEC
           END-IF
           .
       230-PTKOHINF-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    月代り受給者番号マスター処理
      *****************************************************************
       2301-MONTHLYNUM-SYORI-SEC        SECTION.
      *
           MOVE    PARA-DATA-REC        TO  PTKOHINF-REC
      *
      *    編集
           MOVE    SPACE               TO  MONTHLYNUM-REC
           INITIALIZE                      MONTHLYNUM-REC
           MOVE    PTKOH-HOSPID        TO  MONTHLYNUM-HOSPID
           MOVE    PTKOH-PTID          TO  MONTHLYNUM-PTID
           MOVE    PTKOH-KOHNUM        TO  MONTHLYNUM-KOHNUM
      *    適用開始年月日
           MOVE    PTKOH-TEKSTYMD(1:6) TO  MONTHLYNUM-SRYYM
           PERFORM 925-MONTHLYNUM-READ-SEC
      *
           IF      FLG-MONTHLYNUM      =   ZERO
      *        削除分
               IF      PTKOH-SAKJOKBN      =   "1"
                   MOVE    MONTHLYNUM-REC      TO  MCPDATA-REC
                   MOVE    "DBDELETE"          TO  MCP-FUNC
                   MOVE    "MONTHLYNUM-KEY"    TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
               ELSE
      *            修正分
                   IF      PTKOH-JKYSNUM   NOT =   MONTHLYNUM-JKYSNUM
                       MOVE    PTKOH-JKYSNUM   TO  MONTHLYNUM-JKYSNUM
      *
                       MOVE    MONTHLYNUM-REC      TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "MONTHLYNUM-KEY"    TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"         USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
                   END-IF
               END-IF
           ELSE
               IF      PTKOH-JKYSNUM       =   SPACE
                   GO      TO      2301-MONTHLYNUM-SYORI-EXT
               END-IF
      *        新規
               MOVE    SPACE               TO  MONTHLYNUM-REC
               INITIALIZE                      MONTHLYNUM-REC
               MOVE    PTKOH-HOSPID        TO  MONTHLYNUM-HOSPID
               MOVE    PTKOH-PTID          TO  MONTHLYNUM-PTID
               MOVE    PTKOH-KOHNUM        TO  MONTHLYNUM-KOHNUM
               MOVE    PTKOH-TEKSTYMD(1:6) TO  MONTHLYNUM-SRYYM
               MOVE    PTKOH-JKYSNUM       TO  MONTHLYNUM-JKYSNUM
      *
               MOVE    MONTHLYNUM-REC      TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "MONTHLYNUM-KEY"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           END-IF
      *
      *
           .
       2301-MONTHLYNUM-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    受診受付マスター処理
      *****************************************************************
       240-UKETUKE-SYORI-SEC        SECTION.
      *
           MOVE    PARA-DATA-REC        TO  UKETUKE-REC
      *
      *    削除以外の診療科、ドクターを診療行為入力の為ＳＰＡへセット
           IF     (UKE-UPYMD       NOT =   ALL "9")  AND
                  (UKE-KAIKEITIME      =   ZERO   )
               MOVE    UKE-SRYKA           TO  SPA-SRYKA
               MOVE    UKE-DRCD            TO  SPA-DRCD
           END-IF
      *
           MOVE    UKETUKE-REC         TO  MCPDATA-REC
           MOVE    "UKETUKE-KEY"       TO  ORC-DBPATH
           PERFORM 930-UKETUKE-READ-SEC
      *
           IF      FLG-UKETUKE         =   1
      *        追加の時、受付ＩＤを取得
               MOVE    SPA-HOSPID          TO  UKE-HOSPID
               MOVE    SPA-SYSYMD          TO  UKE-UKEYMD
               MOVE    ZERO                TO  UKE-UKEID
               MOVE    UKETUKE-REC         TO  MCPDATA-REC
               PERFORM 930-UKETUKE-READ-SEC
               IF      FLG-UKETUKE         =   ZERO
                   ADD     1                   TO  UKE-PTID
                   MOVE    UKE-PTID            TO  WRK-UKEID
      *
                   MOVE    UKETUKE-REC         TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "UKETUKE-KEY"       TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               ELSE
                   INITIALIZE                  UKETUKE-REC
                   MOVE    SPA-HOSPID          TO  UKE-HOSPID
                   MOVE    SPA-SYSYMD          TO  UKE-UKEYMD
                   MOVE    ZERO                TO  UKE-UKEID
                   MOVE    1                   TO  UKE-PTID
                   MOVE    UKE-PTID            TO  WRK-UKEID
      *
                   MOVE    UKETUKE-REC         TO  MCPDATA-REC
                   MOVE    "DBINSERT"          TO  MCP-FUNC
                   MOVE    "UKETUKE-KEY"       TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO
                       DISPLAY "P029 UKETUKE INS ERR:" MCP-RC 
                       MOVE    "0030"          TO  SPA-ERRCD
                   END-IF
               END-IF
      *
               MOVE    PARA-DATA-REC        TO  UKETUKE-REC
               MOVE    WRK-UKEID           TO  UKE-UKEID
      *
      *
               MOVE    UKETUKE-REC         TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "UKETUKE-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 UKETUKE INS ERR:" MCP-RC
                   MOVE    "0030"          TO  SPA-ERRCD
               END-IF
           ELSE
               MOVE    PARA-DATA-REC        TO  UKETUKE-REC
      *
               IF      UKE-UPYMD       =   ALL "9"
      *            削除
                   MOVE    UKETUKE-REC         TO  MCPDATA-REC
                   MOVE    "DBDELETE"          TO  MCP-FUNC
                   MOVE    "UKETUKE-KEY"       TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO
                       DISPLAY "P029 UKETUKE UPD ERR:" MCP-RC
                   END-IF
               ELSE
      *            更新
                   MOVE    UKETUKE-REC         TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "UKETUKE-KEY"       TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO
                       DISPLAY "P029 UKETUKE UPD ERR:" MCP-RC
                       MOVE    "0030"          TO  SPA-ERRCD
                   END-IF
                END-IF
           END-IF
      *
      *    予約者の来院済みを処理
           IF      UKE-KEYYYKTIME  NOT =   SPACE
               PERFORM 2401-YYK-SYORI-SEC
           END-IF
           .
       240-UKETUKE-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    予約処理
      *****************************************************************
       2401-YYK-SYORI-SEC             SECTION.
      *
           INITIALIZE                  YYK-REC
           MOVE    UKE-HOSPID          TO  YYK-HOSPID
           MOVE    UKE-SRYNAIYO        TO  YYK-SRYNAIYO
           MOVE    UKE-DRCD            TO  YYK-DRCD
           MOVE    UKE-UKEYMD          TO  YYK-YYKYMD
           MOVE    UKE-KEYYYKTIME      TO  YYK-KEYYYKTIME
           MOVE    UKE-YYKID           TO  YYK-YYKID
      *
           MOVE    YYK-REC             TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "YYK-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "YYK-KEY"           TO  ORC-DBPATH
               PERFORM 980-YYK-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-YYK
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "YYK-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
     *
           IF      FLG-YYK             =   ZERO
               IF      UKE-UPYMD       =   ALL "9"
                   IF      YYK-RAIINZUMI   =   "1"
                       MOVE    SPACE               TO  YYK-RAIINZUMI
                       MOVE    YYK-REC             TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "YYK-KEY"           TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                   END-IF
               ELSE
                   IF      YYK-RAIINZUMI   =   SPACE
                       MOVE    "1"                 TO  YYK-RAIINZUMI
                       MOVE    YYK-REC             TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "YYK-KEY"           TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"          USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                   END-IF
               END-IF
           END-IF
      *
           .
       240-UKETUKE-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ処理
      *****************************************************************
       250-HKNCOMBI-SYORI-SEC        SECTION.
      *
           MOVE    PARA-DATA-REC       TO  HKNCOMBI-REC
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           PERFORM 940-HKNCOMBI-READ-SEC
           IF      FLG-HKNCOMBI        =   1
               MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 HKNCOMBI INS ERR:" MCP-RC
                   MOVE    "0030"          TO  SPA-ERRCD
               END-IF
           ELSE
               MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 HKNCOMBI UPD ERR:" MCP-RC
               END-IF
           END-IF
           .
       250-HKNCOMBI-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    旧姓履歴マスター処理
      *****************************************************************
       260-KYUSEIRRK-SYORI-SEC             SECTION.
      *
      *    旧姓履歴はすべて削除
           PERFORM 260-KYUSEIRRK-DEL-SEC
      *
      *
           PERFORM VARYING     IDX     FROM    1  BY  1
                   UNTIL       IDX     >   SPA-NAI25-KYU-MAX
               IF     SPA-GMN25-KYU-DELKBN (IDX)   =   SPACE
                   INITIALIZE                      KYUSEIRRK-REC
                   MOVE    SPA-HOSPID          TO  KYUSEI-HOSPID
                   MOVE    SPA-GMN-PTID        TO  KYUSEI-PTID
                   MOVE    SPA-GMN25-KYU-CHGYMD (IDX)
                                               TO  KYUSEI-CHGYMD
                   MOVE    SPA-GMN25-KYU-KANANAME (IDX)
                                               TO  KYUSEI-KANANAME
                   MOVE    SPA-GMN25-KYU-NAME  (IDX)
                                               TO  KYUSEI-NAME
                   MOVE    SPA-GMN25-KYU-NICKNAME (IDX)
                                               TO  KYUSEI-NICKNAME
                   MOVE    SPA-GMN25-KYU-UPYMD (IDX)
                                               TO  KYUSEI-UPYMD
                   MOVE    SPA-GMN25-KYU-CREYMD (IDX)
                                               TO  KYUSEI-CREYMD
      *
                   MOVE    "DBINSERT"          TO  MCP-FUNC
                   MOVE    "KYUSEIRRK-KEY"     TO  ORC-DBPATH
                   MOVE    KYUSEIRRK-REC       TO  MCPDATA-REC
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO
                          DISPLAY "P029 KYUSEIRRK INS ERR:" MCP-RC
                   END-IF
               END-IF
           END-PERFORM
      *
           .
       260-KYUSEIRRK-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    旧姓履歴マスター処理
      *****************************************************************
       260-KYUSEIRRK-DEL-SEC            SECTION.
      *
           INITIALIZE                      KYUSEIRRK-REC
           MOVE    SPA-HOSPID          TO  KYUSEI-HOSPID
           MOVE    SPA-GMN-PTID        TO  KYUSEI-PTID
           MOVE    KYUSEIRRK-REC       TO  MCPDATA-REC
      *
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    "KYUSEIRRK-DEL1"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       260-KYUSEIRRK-DEL-EXT.
           EXIT.
      *****************************************************************
      *    患者番号変換（管理）マスター処理
      *****************************************************************
       280-PTNUM-SYORI-SEC             SECTION.
      *
           INITIALIZE                      PTNUM-REC
           MOVE    SPA-HOSPID          TO  PTNUM-HOSPID
           MOVE    SPA-GMN-PTID        TO  PTNUM-PTID
      *
           MOVE    PTNUM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
               PERFORM 950-PTNUM-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-PTNUM
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           IF      FLG-PTNUM           =   1
               INITIALIZE                      PTNUM-REC
               MOVE    SPA-HOSPID              TO  PTNUM-HOSPID
               MOVE    SPA-GMN-PTID            TO  PTNUM-PTID
               MOVE    SPA-GMN-PTNUM           TO  PTNUM-PTNUM
               MOVE    SPA-PTNUM-HKNID         TO  PTNUM-HKNID
               MOVE    SPA-PTNUM-KOHID         TO  PTNUM-KOHID
               MOVE    SPA-PTNUM-AUTOCOMBINUM  TO  PTNUM-AUTOCOMBINUM
               MOVE    SPA-PTNUM-MANUCOMBINUM  TO  PTNUM-MANUCOMBINUM
      *
               MOVE    PTNUM-REC           TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 PTNUM INS ERR:" MCP-RC
                          ",KEY:" PTNUM-KEY   "."
               END-IF
           ELSE
               MOVE    SPA-HOSPID              TO  PTNUM-HOSPID
               MOVE    SPA-GMN-PTID            TO  PTNUM-PTID
               MOVE    SPA-GMN-PTNUM           TO  PTNUM-PTNUM
               MOVE    SPA-PTNUM-HKNID         TO  PTNUM-HKNID
               MOVE    SPA-PTNUM-KOHID         TO  PTNUM-KOHID
               MOVE    SPA-PTNUM-AUTOCOMBINUM  TO  PTNUM-AUTOCOMBINUM
               MOVE    SPA-PTNUM-MANUCOMBINUM  TO  PTNUM-MANUCOMBINUM
      *
               MOVE    PTNUM-REC           TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PTNUM-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 PTNUM UPD ERR:" MCP-RC "."
               END-IF
           END-IF
           .
       280-PTNUM-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    低所得マスター処理
      *****************************************************************
       290-TSYRRK-SYORI-SEC            SECTION.
      *
           MOVE    PARA-DATA-REC        TO  TSYRRK-REC
      *
      *
           EVALUATE    TRUE
      *    削除
           WHEN    ( TSYRRK-UPYMD      =   ALL "9" )
               MOVE    TSYRRK-REC      TO  MCPDATA-REC
               MOVE    "DBDELETE"      TO  MCP-FUNC
               MOVE    "TSYRRK-KEY"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC      NOT =   ZERO
                   DISPLAY "P029 TSYRRK DEL ERR:" MCP-RC
               END-IF
      *    変更
           WHEN    ( TSYRRK-NINSTYMD-O     NOT =   SPACE )
               MOVE    TSYRRK-REC      TO  MCPDATA-REC
               MOVE    "DBUPDATE"      TO  MCP-FUNC
               MOVE    "TSYRRK-UPD1"   TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC      NOT =   ZERO
                   DISPLAY "P029 TSYRRK UPD ERR:" MCP-RC
               END-IF
      *    追加
           WHEN    OTHER
               MOVE    TSYRRK-REC      TO  MCPDATA-REC
               MOVE    "DBINSERT"      TO  MCP-FUNC
               MOVE    "TSYRRK-KEY"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
      **        存在した時、修正
      *         MOVE    TSYRRK-REC          TO  MCPDATA-REC
      *         MOVE    "DBUPDATE"          TO  MCP-FUNC
      *         MOVE    "TSYRRK-KEY"        TO  ORC-DBPATH
      *         CALL    "MCPDBSUB"          USING
      *                                     MCPAREA
      *                                     MCPDATA-REC
      *         IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 TSYRRK INS ERR:" MCP-RC
      *         END-IF
               END-IF
           END-EVALUATE
      *
           .
       290-TSYRRK-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    年金マスター処理
      *****************************************************************
       291-TNKRRK-SYORI-SEC             SECTION.
      *
           MOVE    PARA-DATA-REC        TO  TNKRRK-REC
      *
           EVALUATE    TRUE
      *    削除
           WHEN    ( TNKRRK-UPYMD      =   ALL "9" )
               MOVE    TNKRRK-REC      TO  MCPDATA-REC
               MOVE    "DBDELETE"      TO  MCP-FUNC
               MOVE    "TNKRRK-KEY"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC      NOT =   ZERO
                   DISPLAY "P029 TNKRRK DEL ERR:" MCP-RC
               END-IF
      *    変更
           WHEN    ( TNKRRK-STYMD-O    NOT =   SPACE )
               MOVE    TNKRRK-REC      TO  MCPDATA-REC
               MOVE    "DBUPDATE"      TO  MCP-FUNC
               MOVE    "TNKRRK-UPD1"   TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC      NOT =   ZERO
                   DISPLAY "P029 TNKRRK UPD ERR:" MCP-RC
               END-IF
      *    追加
           WHEN    OTHER
               MOVE    TNKRRK-REC      TO  MCPDATA-REC
               MOVE    "DBINSERT"      TO  MCP-FUNC
               MOVE    "TNKRRK-KEY"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
      **        存在した時、修正
      *         MOVE    TNKRRK-REC          TO  MCPDATA-REC
      *         MOVE    "DBUPDATE"          TO  MCP-FUNC
      *         MOVE    "TNKRRK-KEY"        TO  ORC-DBPATH
      *         CALL    "MCPDBSUB"          USING
      *                                     MCPAREA
      *                                     MCPDATA-REC
      *         IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 TNKRRK INS ERR:" MCP-RC
      *         END-IF
               END-IF
           END-EVALUATE
           .
       291-TNKRRK-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者労災保険情報マスター処理
      *****************************************************************
       292-PTRSIINF-SYORI-SEC        SECTION.
      *
           MOVE    PARA-DATA-REC       TO  PTRSIINF-REC
      *
           MOVE    PTRSIINF-REC        TO  MCPDATA-REC
           PERFORM 990-PTRSIINF-READ-SEC
      *
           IF      FLG-PTRSIINF        =   1
               MOVE    PTRSIINF-REC        TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 PTRSIINF INS ERR:" MCP-RC
               END-IF
           ELSE
               MOVE    PTRSIINF-REC        TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC          NOT =   ZERO
                   DISPLAY "P029 PTRSIINF UPD ERR:" MCP-RC
               END-IF
           END-IF
           .
       292-PTRSIINF-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    カルテ　出力へ
      *****************************************************************
       2100-HC01-SYORI-SEC         SECTION.
      *
      *    ＳＰＡに共通項目を設定
           MOVE    SPA-SYSYMD          TO  SPA-SRYYMD
           MOVE    "2"                 TO  SPA-NYUGAIKBN
      *
      *    帳票プログラム取得
           PERFORM 21000-PRINT-PG-SEC
      *
      *    基本画面のカルテ出力
           IF      SPA-GMN-HAKKO       =   "1"
               PERFORM 21003-HC01-CALL2-SEC
           END-IF
      *
           MOVE    ZERO                TO  IDX
           PERFORM   VARYING   IDX2    FROM    1   BY  1
                     UNTIL   ( IDX2            >   10 )
                     OR      ( SPA-GMN20-YBANGOU(IDX2)
                                               =   ZERO  OR  SPACE )
      *        カルテ出力
      *********IF  ( SPA-GMN20-TKARUTE (IDX2)      =   "1"   )  AND
      *            ( SPA-GMN20-THKNKUMI(IDX2)  NOT =   SPACE  AND
      **********     SPA-GMN20-THKNKUMI(IDX2)  NOT =   ZERO  )
               IF    SPA-GMN20-TKARUTE (IDX2)      =   "1"
                   PERFORM 21001-HC01-CALL-SEC
               END-IF
      *        処方箋出力
      ******** IF  ( SPA-GMN20-TSYOHOU (IDX2)      =   "1"   )  AND
      *            ( SPA-GMN20-THKNKUMI(IDX2)  NOT =   SPACE  AND
      **********     SPA-GMN20-THKNKUMI(IDX2)  NOT =   ZERO  )
               IF    SPA-GMN20-TSYOHOU (IDX2)      =   "1"
                   PERFORM 21001-HC02-CALL-SEC
               END-IF
           END-PERFORM
      *
           .
       2100-HC01-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票プログラム取得処理
      *****************************************************************
       21000-PRINT-PG-SEC              SECTION.
      *
      *    カルテ
           MOVE    SPACE               TO  WRK-KARUTE-PG
           INITIALIZE                      SYS-1032-REC
           MOVE    "1032"              TO  SYS-1032-KANRICD
           MOVE    "00000001"          TO  SYS-1032-KBNCD
      *
           MOVE    SYS-1032-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               PERFORM 960-SYSKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1032-REC
      *        独自開発分
               IF      SYS-1032-ORCACSTCHK     =   "T"
                   MOVE    SYS-1032-ORCACSTNM  TO  WRK-KARUTE-PG
               ELSE
      *        ＯＲＣＡ標準分
                   MOVE    SYS-1032-ORCAORGNM  TO  WRK-KARUTE-PG
               END-IF
           END-IF
           IF      WRK-KARUTE-PG       =   SPACE
               MOVE    "ORCHC01"           TO  WRK-KARUTE-PG
           END-IF
      *
      *    処方せん
           MOVE    SPACE               TO  WRK-SYOHOU-PG
           INITIALIZE                      SYS-1032-REC
           MOVE    "1032"              TO  SYS-1032-KANRICD
           MOVE    "00000002"          TO  SYS-1032-KBNCD
      *
           MOVE    SYS-1032-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           MOVE    SPA-SYSYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               PERFORM 960-SYSKANRI-READ-SEC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1032-REC
      *        独自開発分
               IF      SYS-1032-ORCACSTCHK     =   "T"
                   MOVE    SYS-1032-ORCACSTNM  TO  WRK-SYOHOU-PG
               ELSE
      *        ＯＲＣＡ標準分
                   MOVE    SYS-1032-ORCAORGNM  TO  WRK-SYOHOU-PG
               END-IF
           END-IF
           IF      WRK-SYOHOU-PG       =   SPACE
               MOVE    "ORCHC19"           TO  WRK-SYOHOU-PG
           END-IF
      *
           .
      *
       21000-PRINT-PG-EXT.
           EXIT.
      *
      *****************************************************************
      *    基本画面のカルテ出力処理
      *****************************************************************
       21003-HC01-CALL2-SEC           SECTION.
      *
      *
           MOVE    SPA-GMN-PTID        TO  SPA-PTID
           MOVE    SPA-GMN-PTNUM       TO  SPA-PTNUM
      *
           MOVE    SPA-GMN-SELNUM      TO  SPA-HKNCOMBINUM
           MOVE    SPA-GMN-SRYKA       TO  SPA-SRYKA
           MOVE    SPA-GMN-SRYKAMEI    TO  SPA-SRYKAMEI
      *
           CALL    WRK-KARUTE-PG     USING  SPA-AREA
      *
           .
       21003-HC01-CALL2-EXT.
           EXIT.
      *
      *****************************************************************
      *    カルテ　出力へ
      *****************************************************************
       21001-HC01-CALL-SEC           SECTION.
      *
      *
           MOVE    SPA-GMN-PTID        TO  SPA-PTID
           MOVE    SPA-GMN-PTNUM       TO  SPA-PTNUM
      *----(01.00.02) LINE ADD START -------------------------------
           MOVE    SPA-GMN20-THKNKUMI(IDX2)
                                     TO  SPA-HKNCOMBINUM
           MOVE    SPA-NAI20-SRYKA   (IDX2)
                                     TO  SPA-SRYKA
           MOVE    SPA-GMN20-TSRYKA  (IDX2)
                                     TO  SPA-SRYKAMEI
      *
      *****CALL    "ORCHC01"         USING  SPA-AREA
           CALL    WRK-KARUTE-PG     USING  SPA-AREA
      *
           .
       21001-HC01-CALL-EXT.
           EXIT.
      *****************************************************************
      *    処方箋　出力へ
      *****************************************************************
       21001-HC02-CALL-SEC           SECTION.
      *
      *    MOVE    ZERO              TO  ORCHC02-RENNUM
      *    MOVE    "1"               TO  ORCHC02-KBN
      *
      *----(01.00.01) LINE MOD START --------------------------------
      *     MOVE    SPA-GMN20-TSRYKA  (IDX2)(1:2)  TO  SPA-SRYKA
      *     MOVE    SPA-GMN20-TSRYKA  (IDX2)(4:)   TO  SPA-SRYKAMEI
      *     MOVE    "1"                            TO  SPA-DRCD (1:1)
      *     MOVE    SPA-GMN20-TDRCD   (IDX2)(1:4)  TO  SPA-DRCD (2:)
           MOVE    SPA-GMN-PTID        TO  SPA-PTID
           MOVE    SPA-GMN-PTNUM       TO  SPA-PTNUM
           MOVE    SPA-GMN-NAME        TO  SPA-NAME
           MOVE    SPA-GMN-SEXH        TO  SPA-SEX
           MOVE    SPA-NAI-BIRTHDAY    TO  SPA-BIRTHDAY
      *
           MOVE    SPA-NAI20-SRYKA   (IDX2)       TO  SPA-SRYKA
           MOVE    SPA-GMN20-TSRYKA  (IDX2)       TO  SPA-SRYKAMEI
           MOVE    "1"                            TO  SPA-DRCD (1:1)
           MOVE    SPA-NAI20-DRCD    (IDX2)       TO  SPA-DRCD (2:)
      *----(01.00.01) LINE MOD END   --------------------------------
           MOVE    SPA-GMN20-THKNKUMI(IDX2)       TO  SPA-HKNCOMBINUM
      **** CALL    "ORCHC02"         USING   MCPAREA
      *                                      SPA-AREA
      *********                              ORCHC02AREA
      *    Ａ５を印刷
           MOVE    ZERO              TO  ORCHC19-RENNUM
           MOVE    "1"               TO  ORCHC19-KBN
      *****CALL    "ORCHC19"         USING   MCPAREA
           CALL    WRK-SYOHOU-PG     USING   SPA-AREA
                                             ORCHC19AREA
      *
           .
       21001-HC02-CALL-EXT.
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
      *    保険マスター読み込み
      *****************************************************************
       910-PTHKNINF-READ-SEC         SECTION.
      *
           MOVE    PTHKNINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-PTHKNINF
               ELSE
                   MOVE    1               TO  FLG-PTHKNINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTHKNINF
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-PTHKNINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費マスター読み込み
      *****************************************************************
       920-PTKOHINF-READ-SEC         SECTION.
      *
           MOVE    PTKOHINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTKOHINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-PTKOHINF
               ELSE
                   MOVE    1               TO  FLG-PTKOHINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTKOHINF
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       920-PTKOHINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費マスター読み込み
      *****************************************************************
       925-MONTHLYNUM-READ-SEC         SECTION.
      *
           MOVE    MONTHLYNUM-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "MONTHLYNUM-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "MONTHLYNUM-KEY"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-MONTHLYNUM
                   MOVE    MCPDATA-REC     TO  MONTHLYNUM-REC
               ELSE
                   MOVE    1               TO  FLG-MONTHLYNUM
               END-IF
           ELSE
               MOVE    1               TO  FLG-MONTHLYNUM
           END-IF
      *
           .
       925-MONTHLYNUM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    労災保険マスター読み込み
      *****************************************************************
       990-PTRSIINF-READ-SEC         SECTION.
      *
           MOVE    PTRSIINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-PTRSIINF
               ELSE
                   MOVE    1               TO  FLG-PTRSIINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTRSIINF
           END-IF
      *
           .
       990-PTRSIINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    受付マスター読み込み
      *****************************************************************
       930-UKETUKE-READ-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "UKETUKE-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "UKETUKE-KEY"       TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  UKETUKE-REC
                   MOVE    ZERO            TO  FLG-UKETUKE
               ELSE
                   MOVE    1               TO  FLG-UKETUKE
               END-IF
           ELSE
               MOVE    1               TO  FLG-UKETUKE
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "UKETUKE-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       930-UKETUKE-READ-EXT.
      *****************************************************************
      *    患者番号変換読み込み
      *****************************************************************
       950-PTNUM-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTNUM-REC
               MOVE    ZERO            TO  FLG-PTNUM
           ELSE
               MOVE    1               TO  FLG-PTNUM
           END-IF
      *
           .
       950-PTNUM-READ-EXT.
           EXIT.
      *****************************************************************
      *    予約読み込み
      *****************************************************************
       980-YYK-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  YYK-REC
               MOVE    ZERO                TO  FLG-YYK
           ELSE
               MOVE    1                   TO  FLG-YYK
           END-IF
      *
           .
       980-YYK-READ-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せマスター読み込み
      *****************************************************************
       940-HKNCOMBI-READ-SEC         SECTION.
      *
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
                   MOVE    ZERO            TO  FLG-HKNCOMBI
               ELSE
                   MOVE    1               TO  FLG-HKNCOMBI
               END-IF
           ELSE
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       940-HKNCOMBI-READ-EXT.
           EXIT.
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       960-SYSKANRI-READ-SEC           SECTION.
      *
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1009-REC
               MOVE    ZERO                TO  FLG-SYSKANRI
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           .
      *
       960-SYSKANRI-READ-EXT.
           EXIT.
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
