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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCGS03N.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 収納登録
      *  コンポーネント名  : 請求確認　（Ｓ０３Ｎ）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    NACL-太田    02/12/12  新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    診療行為用共通パラメタ
           COPY    "S01COMMON-SPA".
      *
           COPY    ENUM-VALUE.
      *
      *    スパ領域
       01  SPA-S03N.
      *
           03  SPA-S03N-AREA.
               05  SPA-GMN-PAGE                  PIC 9(02).
               05  SPA-GMN-MAX                   PIC 9(02).
               05  SPA-GMN-CUR                   PIC 9(02).
               05  SPA-GMN-AREA.
                   07  SPA-GMN-PTNUM             PIC X(20).
                   07  SPA-GMN-KANANAME          PIC X(100).
                   07  SPA-GMN-SEX               PIC X(02).
                   07  SPA-GMN-KUMI              PIC X(36).
                   07  SPA-GMN-RITU              PIC X(10).
                   07  SPA-GMN-SRYYMD            PIC X(09).
                   07  SPA-GMN-NAME              PIC X(100).
                   07  SPA-GMN-BIRTHDAY          PIC X(09).
                   07  SPA-GMN-SRYKA             PIC X(16).
                   07  SPA-GMN-NYUGAIKBN         PIC X(06).
      
                   07  SPA-GMN-SYORINAIYO        PIC X(10).
                   07  SPA-GMN-JOUTAI            PIC X(10).
                   07  SPA-GMN-HAKYMD            PIC X(09).
                   07  SPA-GMN-DENPNO            PIC X(10).
      *
                   07  SPA-GMN-KINGAKU-AREA.
                       09  SPA-GMN-HKNRYO            PIC 9(07)
                                                         OCCURS  12.
                       09  SPA-GMN-TGMONEY           PIC 9(07)
                                                         OCCURS  11.
                       09  SPA-GMN-HKNTEKI           PIC 9(10).
                       09  SPA-GMN-SKJRYOYO          PIC 9(07).
                       09  SPA-GMN-SKJFTN            PIC 9(07).
                       09  SPA-GMN-ROUFTN            PIC 9(07).
                       09  SPA-GMN-KOHFTN            PIC 9(07).
                       09  SPA-GMN-JIHI-G            OCCURS  2.
                           11  SPA-GMN-JIHI          PIC 9(07)
                                                         OCCURS  5.
                           11  SPA-GMN-JIHIKEI       PIC 9(07).
                       09  SPA-GMN-JIHIZEI           PIC 9(07).
                       09  SPA-GMN-HKNGAI            PIC 9(07).
                       09  SPA-GMN-ICHIFTN           PIC 9(07).
                       09  SPA-GMN-YAKFTN            PIC 9(07).
                       09  SPA-GMN-CHOSEI            PIC S9(07).
                       09  SPA-GMN-RMSAGAKU          PIC 9(07).
                       09  SPA-GMN-SEIKYU            PIC 9(07).
                       09  SPA-GMN-ZENMISYU-GAI      PIC 9(07).
                       09  SPA-GMN-ZENMISYU-NYU      PIC 9(07).
                       09  SPA-GMN-SEIGOK            PIC 9(07).
                       09  SPA-GMN-MISYU-ZAN         PIC S9(07).
                       09  SPA-GMN-NYUKIN-IN         PIC 9(10).
                       09  SPA-GMN-DENPYO-KEI        PIC 9(08).
      *----(01.01.04) LINE UPD START ----------------------------------
      ********     07  SPA-GMN-NYUKINYMD-IN      PIC X(09).
                   07  SPA-GMN-NYUKINYMD-IN      PIC X(10).
      *----(01.01.04) LINE UPD END   ----------------------------------
      *
                   07  SPA-GMN-NYUKIN-DSP.
                       09  SPA-GMN-NYUKINCD      PIC X(02).
                       09  SPA-GMN-NYU1          PIC X(01).
                       09  SPA-GMN-NYUKINMEI     PIC X(20).
                   07  SPA-GMN-NYUKINLST         OCCURS  10.
                       09  SPA-GMN-NYUKINL       PIC X(02).
                       09  SPA-GMN-FI1L          PIC X(01).
                       09  SPA-GMN-NYUKINLMEI    PIC X(24).
      *
                   07  SPA-GMN-TBL               OCCURS  12.
                       09  SPA-GMN-EDABAN-T      PIC 9(02).
                       09  SPA-GMN-SEIKYU-T      PIC S9(10).
                       09  SPA-GMN-NYUKIN-T      PIC S9(10).
                       09  SPA-GMN-SYORIYMD-T    PIC X(09).
                       09  SPA-GMN-JOUTAI-T      PIC X(10).
                       09  SPA-GMN-NYUKINYMD-IN9 PIC 9(08).
                       09  SPA-GMN-JOUTAI-TX     PIC X(16).
      *                 
                   07  SPA-GMN-RIREKIIN          PIC 9(02).
                   07  SPA-GMN-RIREKIIN9         PIC 9(02).
                   07  SPA-GMN-NYUKINYMD-IN99    PIC 9(08).
      *
                   07  SPA-GMN-JIHIMSG           PIC X(20)
                                                 OCCURS   5.
                   07  SPA-GMN-RSISHOSHIN        PIC 9(10).
                   07  SPA-GMN-RSISAISHIN        PIC 9(10).
                   07  SPA-GMN-RSISDO            PIC 9(10).
                   07  SPA-GMN-RSIETC            PIC 9(10).
      *
               05  SPA-IDX                       PIC 9(02).
               05  SPA-SAGAKU                    PIC S9(10).
               05  SPA-NYUKINGK                  PIC S9(10).
               05  SPA-NAI-AREA.
                   07  SPA-NAI-CHOSEI            PIC X(01).
                   07  SPA-NAI-SRYKA             PIC X(02).
               05  SPA-GMN-MISYU-MAX             PIC 9(02).
      *    フラグ領域
       01  STS-AREA.
           03  STS-KNJMST          PIC X(02).
           03  STS-SYUNOU          PIC X(02).
           03  STS-SINKOU          PIC X(02).
           03  STS-SINKAI          PIC X(02).
           03  STS-SYUMEI          PIC X(02).
           03  STS-S03N-KEY         PIC X(02).
           03  STS-PARA            PIC X(02).
           03  STS-ERRMSG-KEY      PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYUNOU          PIC 9(01).
           03  FLG-SINKOU          PIC 9(01).
           03  FLG-SINKAI          PIC 9(01).
           03  FLG-SYUMEI          PIC 9(01).
           03  FLG-KNJMST          PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-SYORI           PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
           03  FLG-OK              PIC 9(01).
           03  FLG-ERR             PIC 9(01).
           03  FLG-ARI             PIC 9(01).
           03  FLG-SINKI           PIC 9(01).
           03  FLG-CHK             PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
           03  CNT-ENT             PIC 9(06).
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
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDW                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(02).
           03  IDX-P               PIC 9(04).
           03  IDX-KOUI            PIC 9(04).
           03  IDX-SIN             PIC 9(04).
           03  IDX-ATO             PIC 9(04).
           03  IDX3                PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MOTOPG          PIC X(08).
           03  WRK-YMD             PIC X(09).
           03  WRK-YMDMAX          PIC 9(01). 
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
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
           03  WRK-KIN             PIC 9(07).
           03  WRK-GMN-LINE        PIC 9(02).
      *
           03  WRK-Z9              PIC ----------.
           03  WRK-EDABAN          PIC ZZ.
      *    診療行為計算用
           03  WRK-TENSU           PIC 9(08).
           03  WRK-TENSUKEI        PIC 9(10).
           03  WRK-ZAITEN          PIC 9(07).
           03  WRK-KAISUUKEI       PIC 9(03).
           03  WRK-SURYOUKEI       PIC 9(14).
           03  WRK-MEISAISU        PIC 9(07).
           03  WRK-SRYCD           PIC 9(09).
           03  WRK-SRYCDKEI        PIC 9(14).
           03  WRK-ZAIBAN          PIC 9(05).
           03  WRK-H-ZAIBAN        PIC 9(05).
      *
           03  WRK-DENPNO          PIC 9(07).
      *
           03  WRK-MISYU           PIC 9(08).
      *
           03  WRK-NYUGAIKBN       PIC X(01).
      *
           03  WRK-ERRMSG          PIC X(40).
      *
      *    マップ画面行
           03  WRK-MAP-INDEX       PIC 9(04).
      *
      *    診療行為内容比較用テーブル
       01  TBL-AREA.
           03  TBL-MAE-AREA.
               05  TBL-MAE-REC     OCCURS   30.
                   07  TBL-MAE-SRYCD       PIC  X(09).
                   07  TBL-MAE-SURYOU      PIC  9(03).
                   07  TBL-MAE-KAISUU      PIC  9(03).
           03  TBL-ATO-AREA.
               05  TBL-ATO-REC     OCCURS   30.
                   07  TBL-ATO-SRYCD       PIC  X(09).
                   07  TBL-ATO-SURYOU      PIC  9(03).
                   07  TBL-ATO-KAISUU      PIC  9(03).
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
       01  WK-GMN-RITU.
           03  FILLER              PIC X(02).
           03  WK-GMN-FTNRITU      PIC ZZZ.
           03  WK-GMN-PA           PIC X(01).
      *
      *************************************************************
      *    ファイルレイアウト
      *************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1005.INC".
      *
           COPY    "CPSK1010.INC".
      *
           COPY    "CPSK1013.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *    診療行為マスタ−
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    診療会計マスタ−
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
          COPY    "CPSYUNOU.INC".
      *    収納明細マスター
       01  SYUMEI-REC.
           COPY    "CPSYUMEI.INC".
      *
      *
      *
      *************************************************************
      *    サブプロ用　領域
      *************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *----(01.00.01) LINE ADD START ----------------------------------
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *----(01.00.01) LINE ADD END   ----------------------------------
      *    数字変換領域
      **     COPY    "CPORCSNUM.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".

      *
      *    収納登録用共通データ
      *>     COPY    "CPS01PARA.INC".
      *
      *    負担金額計算用パラメタ
           COPY    "CPORCS01.INC".
      *>     COPY    "CPLNKSTS.INC".
      *    ＤＢ検索
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *
       01  LNK-SYUNOU-REC.
           COPY "CPSYUNOU.INC" REPLACING //SYU-// BY //LNK-SYU-//.
      *
      *************************************************************
      *    連絡　領域
      *************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "MCPAREA".
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
      *****COPY    "S01.INC".
           COPY    "S02.INC".
           COPY    "S03.INC".
           COPY    "S03N.INC".
           COPY    "SERR.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *************************************************************
      *    主　　処理
      *************************************************************
       000-PROC-SEC                SECTION.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-S01KYOUTU
           MOVE    SPA-FREE        TO  SPA-S03N
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
           MOVE    SPA-S01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-S03N         TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *************************************************************
      *    初期　処理
      *************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "SERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *        画面編集
               PERFORM 500-GMNHEN-SEC
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "S03N"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
          .
       100-INIT-EXT.
           EXIT.
      *
      *
      *************************************************************
      *    初期画面処理
      *************************************************************
       300-SCREEN-SEC             SECTION.
      *
           INITIALIZE              SPA-S03N
      *
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    SPA-MOTOPG          TO  WRK-MOTOPG 
      *
      *        元の画面へ戻す
               IF      WRK-MOTOPG(1:3)     =   "Y01"  OR  "U01"  OR
                                               "E01"
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-S03N
                   MOVE    SPA-WORK        TO  SPA-S01KYOUTU
               END-IF
      *        予約とエラー表示の時、そのまま画面表示へ
               IF      WRK-MOTOPG(1:3)     =   "Y01" 
                   GO      TO      300-SCREEN-EXT
               END-IF
      *        外部より選択がある時
               IF      WRK-MOTOPG(1:3)     =   "U01" 
                   GO      TO      300-SCREEN-EXT
               ELSE
                   MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
               END-IF
           END-IF
      *
           MOVE    SPA-WORK        TO  SPA-S01KYOUTU
      *
      *
           PERFORM                 310-SPA-SET-SEC
      *
           MOVE    3               TO  SPA-GMN-PAGE
           EVALUATE   SPA-S01-SYORINO
               WHEN   "05" 
                 MOVE    2               TO  SPA-GMN-CUR
               WHEN   "08"
               WHEN   "07" 
                 MOVE    1               TO  SPA-GMN-CUR
           END-EVALUATE
           .

       300-SCREEN-EXT.

           EXIT.
      *
      *************************************************************
      *    画面編集処理
      *************************************************************
       310-SPA-SET-SEC                  SECTION.
      *
      *
           INITIALIZE                  SPA-S03N
      *
      *****MOVE    SPA-S01-PTID        TO  SPA-GMN-PTID
           MOVE    SPA-S01-PTNUM       TO  SPA-GMN-PTNUM
           MOVE    SPA-S01-KANANAME    TO  SPA-GMN-KANANAME
           MOVE    SPA-S01-NAME        TO  SPA-GMN-NAME
           MOVE    SPA-S01-SEX         TO  SPA-GMN-SEX
           MOVE    SPA-S01-BIRTHDAYW   TO  SPA-GMN-BIRTHDAY
           MOVE    SPA-S01-HKNCOMBIMEI TO  SPA-GMN-KUMI
      *****MOVE    SPA-S01-FTNRATEMEI  TO  SPA-GMN-RITU
           MOVE    SPA-S01-SRYKA       TO  SPA-NAI-SRYKA
           MOVE    SPA-S01-SRYKAMEI    TO  SPA-GMN-SRYKA
      *****MOVE    SPA-S01-SRYYMW      TO  SPA-GMN-SRYYMD 
           EVALUATE    SPA-S01-NYUGAIKBN
               WHEN    "1"
                   MOVE    "入院"          TO  SPA-GMN-NYUGAIKBN      
               WHEN    "2"
                   MOVE    "外来"          TO  SPA-GMN-NYUGAIKBN      
           END-EVALUATE    
      *
      *    処理内容
           EVALUATE     SPA-S01-SYORINO
               WHEN     "05"
                   MOVE    "入金"      TO  SPA-GMN-SYORINAIYO
               WHEN     "07"
                   MOVE    "調整金"    TO  SPA-GMN-SYORINAIYO
               WHEN     "08"
                   MOVE    "履歴修正"  TO  SPA-GMN-SYORINAIYO
               WHEN     "09"
                   MOVE    "照会"      TO  SPA-GMN-SYORINAIYO
           END-EVALUATE.
      *    伝票番号
      *>     MOVE    179                 TO  SPA-DENPNUM.
           MOVE    SPA-S01-DENPNUM       TO  SPA-GMN-DENPNO.
      *****MOVE    "2"                 TO  SPA-NYUGAIKBN.
      *
      *    収納マスターを検索し内容をスパ領域にセット
           INITIALIZE                      SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-S01-NYUGAIKBN   TO  SYU-NYUGAIKBN
           MOVE    SPA-S01-PTID        TO  SYU-PTID
           MOVE    SPA-S01-DENPNUM     TO  SYU-DENPNUM
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =    ZERO
               MOVE    "SYUNOU-KEY"         TO  ORC-DBPATH
               PERFORM SYUNOU-READ-SEC
           ELSE
               MOVE    1                    TO  FLG-SYUNOU
           END-IF
           IF      FLG-SYUNOU          =   1
                  GO    TO    310-SPA-SET-EXT
           END-IF.
      *
           MOVE    SYU-SRYYMD        TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG (1:6) TO  SPA-GMN-SRYYMD
      *
      *    発行日
           MOVE    SYU-DENPPRTYMD    TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG       TO  SPA-GMN-HAKYMD
      *
      *    患者負担率
           IF      SYU-PTFTNRATE       =   ZERO
                   MOVE    SPACE       TO  SPA-GMN-RITU
           ELSE
                   MOVE    SPACE       TO  WK-GMN-RITU
                   MOVE    SYU-PTFTNRATE TO  WK-GMN-FTNRITU
                   MOVE    "%"         TO  WK-GMN-PA
                   MOVE    WK-GMN-RITU TO  SPA-GMN-RITU
           END-IF.
      *
      *    伝票状態区分
           EVALUATE   SYU-DENPJTIKBN
               WHEN   SPACE
                      MOVE  "請求額なし"  TO  SPA-GMN-JOUTAI
               WHEN   "1"
                      MOVE  "入金済"      TO  SPA-GMN-JOUTAI
               WHEN   "2"
                      MOVE  "未入金"      TO  SPA-GMN-JOUTAI
               WHEN   "3"
                      MOVE  "請求取消し"  TO  SPA-GMN-JOUTAI
               WHEN   "7"
                      MOVE  "継続"  TO  SPA-GMN-JOUTAI
           END-EVALUATE
      *
      *    保険料
           MOVE    ZERO                TO  SPA-GMN-HKNRYO (12)
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   11
               MOVE    SYU-HKNTEN (IDX)    TO  SPA-GMN-HKNRYO (IDX)
               ADD     SYU-HKNTEN (IDX)    TO  SPA-GMN-HKNRYO (12)
           END-PERFORM.
      *    保険適用外
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   11
               MOVE    ZERO                TO   SPA-GMN-TGMONEY (IDX)
               COMPUTE  SPA-GMN-TGMONEY (IDX) = SYU-TGMONEY (IDX)  +
                                                SYU-TGMONEY-TAX (IDX)
           END-PERFORM.
      *    保険適用分
           MOVE    SYU-HKNTEKMONEY     TO  SPA-GMN-HKNTEKI.
      *    老人一部負担金
           MOVE    SYU-RJN-FTN         TO  SPA-GMN-ROUFTN.
      *    公費一部負担金
           MOVE    SYU-KOH-FTN         TO  SPA-GMN-KOHFTN.
      *    その他自費
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       5
               MOVE    SYU-JIHI-TAXNASI (IDX)  TO  SPA-GMN-JIHI (1 IDX)
               MOVE    SYU-JIHI-TAXARI  (IDX)  TO  SPA-GMN-JIHI (2 IDX)
           END-PERFORM    
           MOVE    SYU-JIHI-TOTAL      TO  SPA-GMN-JIHIKEI(1).
           MOVE    SYU-JIHI-TOTAL-TAX  TO  SPA-GMN-JIHIKEI(2).
           MOVE    SYU-JIHI-TAX        TO  SPA-GMN-JIHIZEI.
      *    保険適用外
           MOVE    ZERO                TO  SPA-GMN-HKNGAI.
           COMPUTE  SPA-GMN-HKNGAI     =  SYU-TGMONEY (12)  +
                                          SYU-TGMONEY-TAX (12).
      *    労災保険適用分  
           MOVE    SYU-RSISHOSHIN-MONEY TO SPA-GMN-RSISHOSHIN.
           MOVE    SYU-RSISAISHIN-MONEY TO SPA-GMN-RSISAISHIN.
           MOVE    SYU-RSISDO-MONEY     TO SPA-GMN-RSISDO.
           MOVE    SYU-RSIETC-MONEY     TO SPA-GMN-RSIETC.
      *
      *    食事療養費
           MOVE    SYU-RYOYOHI-SKJ     TO  SPA-GMN-SKJRYOYO
      *    食事負担額
           MOVE    SYU-SKYMONEY-SKJ    TO  SPA-GMN-SKJFTN
      *
      *    薬剤一部負担  
           MOVE    SYU-YKZ-FTN         TO  SPA-GMN-YAKFTN.
      *    一部負担金
           COMPUTE SPA-GMN-ICHIFTN     =   SPA-GMN-ROUFTN
                                       +   SPA-GMN-KOHFTN
                                       +   SPA-GMN-YAKFTN
                                       +   SPA-GMN-SKJFTN.
      *    室料差額
           MOVE    SYU-RMSAGAKU        TO  SPA-GMN-RMSAGAKU
      *
      *    調整金
           MOVE    SYU-CHOSEI          TO  SPA-GMN-CHOSEI.
      *
      *    入金額
           MOVE    SYU-NYUKIN-TOTAL    TO  SPA-GMN-DENPYO-KEI.
      *    未収残
           COMPUTE SPA-GMN-MISYU-ZAN   =   SYU-SKYMONEY   -
                                           SYU-NYUKIN-TOTAL
      *    合計請求額計算処理
           PERFORM    3102-SEIKYU-KEI-SEC.
      *    前回未収
           PERFORM    3101-ZENMISYU-SEC.
      *    合計未収額
           IF      SPA-GMN-MISYU-ZAN   >   ZERO
               COMPUTE SPA-GMN-SEIGOK      =   SPA-GMN-MISYU-ZAN
                                           +   SPA-GMN-ZENMISYU-GAI
                                           +   SPA-GMN-ZENMISYU-NYU
           ELSE
               COMPUTE SPA-GMN-SEIGOK      =   SPA-GMN-ZENMISYU-GAI
                                           +   SPA-GMN-ZENMISYU-NYU
           END-IF.
      *
      *    収納明細マスターを検索し内容をスパ領域にセット
           MOVE    ZERO                TO  SPA-GMN-MISYU-MAX
           MOVE    SPA-HOSPID          TO  SMEI-HOSPID.
      *****MOVE    SPA-NYUGAIKBN       TO  SMEI-NYUGAIKBN.
           MOVE    SPA-S01-NYUGAIKBN   TO  SMEI-NYUGAIKBN.
           MOVE    SPA-S01-PTID        TO  SMEI-PTID.
           MOVE    SPA-S01-DENPNUM     TO  SMEI-DENPNUM.
           MOVE    SYUMEI-REC          TO  MCPDATA-REC.
           MOVE    "DBSELECT"          TO  MCP-FUNC.
           MOVE    "SYUMEI-KEY2"         TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           IF      MCP-RC              =    ZERO
              MOVE    "SYUMEI-KEY2"         TO  ORC-DBPATH
              PERFORM SYUMEI-READ-SEC
          ELSE
              MOVE    1                    TO  FLG-SYUMEI
          END-IF.
          MOVE    1                   TO      IDX.
          PERFORM
               UNTIL   (FLG-SYUMEI     =       1          ) OR
                       (IDX            >       12         ) 
                   MOVE SMEI-DENPEDANUM TO  SPA-GMN-EDABAN-T (IDX)
                   MOVE SMEI-SKYMONEY   TO  SPA-GMN-SEIKYU-T (IDX)
                   MOVE SMEI-NYUHEN-MONEY TO SPA-GMN-NYUKIN-T (IDX)
                   EVALUATE SMEI-JOUTAIKBN
                       WHEN SPACE
                            MOVE   "請求額なし"
                                      TO    SPA-GMN-JOUTAI-T (IDX)
                       WHEN "1"
                            MOVE   "請求・入金"
                                      TO    SPA-GMN-JOUTAI-T (IDX)
                            MOVE   "01  現金"
                                      TO    SPA-GMN-JOUTAI-TX (IDX)
                       WHEN "2"
                            IF     SMEI-NYUKIN-HOHO  =   "01"
                                MOVE   "入金／現金"
                                      TO    SPA-GMN-JOUTAI-T (IDX)
                                MOVE   "01  現金"
                                      TO    SPA-GMN-JOUTAI-TX (IDX)
                            ELSE
                                MOVE   "入金／ＪＤ"
                                      TO    SPA-GMN-JOUTAI-T (IDX)
                                MOVE   "02  デビットカード"
                                      TO    SPA-GMN-JOUTAI-TX (IDX)
                            END-IF
                       WHEN "3"
                        MOVE "再計算"   TO  SPA-GMN-JOUTAI-T (IDX)
                       WHEN "4"
                        MOVE "返金"     TO  SPA-GMN-JOUTAI-T (IDX)
                       WHEN "5"
                        MOVE "請求取消" TO  SPA-GMN-JOUTAI-T (IDX)
                       WHEN "6"
                        MOVE "入金取消" TO  SPA-GMN-JOUTAI-T (IDX)
                       WHEN "7"
                        MOVE "継続"     TO  SPA-GMN-JOUTAI-T (IDX)
                       WHEN "8"
                        MOVE "診療訂正" TO  SPA-GMN-JOUTAI-T (IDX)
                       WHEN "9"
                        MOVE "請求"     TO  SPA-GMN-JOUTAI-T (IDX)
                   END-EVALUATE
                   MOVE    SMEI-NYUHEN-YMD      TO  WRK-SYMD
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG        TO
                                          SPA-GMN-SYORIYMD-T (IDX)
                   MOVE    SMEI-NYUHEN-YMD  TO
                                          SPA-GMN-NYUKINYMD-IN9(IDX)
                   MOVE    IDX              TO SPA-GMN-MISYU-MAX
      *             
                   PERFORM SYUMEI-READ-SEC
                   ADD      1          TO      IDX
           END-PERFORM.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           MOVE    "DBCLOSE"           TO  MCP-FUNC.
           MOVE    "SYUMEI-KEY2"        TO  ORC-DBPATH.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
      *    入金欄
           IF     SPA-S01-SYORINO      =   "05"  OR  "08"
               MOVE    "01  現金"      TO  SPA-GMN-NYUKINLST (1)
      *****    MOVE    "02  デビットカード"
      *****                            TO  SPA-GMN-NYUKINLST (2)
           END-IF.
           IF     SPA-S01-SYORINO      =   "05"
               IF  SPA-GMN-NYUKIN-DSP  =   SPACE
                 MOVE    "01  現金"      TO  SPA-GMN-NYUKIN-DSP
               END-IF
           END-IF.
      *
      *    自費名称編集
           PERFORM 3102-JIHIMSG-HEN-SEC
           .
       310-SPA-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    自費名称編集処理
      *****************************************************************
       3102-JIHIMSG-HEN-SEC             SECTION.
      *
      *    医療機関情報−自費名称
           MOVE    SPACE               TO  SYS-1013-REC
           MOVE    "1013"              TO  SYS-1013-KANRICD
           MOVE    ZERO                TO  SYS-1013-STYUKYMD
           MOVE    ALL "9"             TO  SYS-1013-EDYUKYMD
      *    システム管理検索
           MOVE    SYS-1013-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           MOVE    SPA-SRYYMD          TO  ORC-DBYMD
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"      TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1013-REC
               END-IF
           ELSE
               INITIALIZE                  SYS-1013-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM
               UNTIL       FLG-SYSKANRI    =   1
      *****    IF      SPA-NYUGAIKBN       =   SYS-1013-KBNCD(1:1)
               IF      SPA-S01-NYUGAIKBN   =   SYS-1013-KBNCD(1:1)
                   EVALUATE    SYS-1013-KBNCD(2:1)
                       WHEN    "1"
                           MOVE    SYS-1013-JIHINAME   TO
                                               SPA-GMN-JIHIMSG (1)
                       WHEN    "2"
                           MOVE    SYS-1013-JIHINAME   TO
                                               SPA-GMN-JIHIMSG (2)
                       WHEN    "3"
                           MOVE    SYS-1013-JIHINAME   TO
                                               SPA-GMN-JIHIMSG (3)
                       WHEN    "4"
                           MOVE    SYS-1013-JIHINAME   TO
                                               SPA-GMN-JIHIMSG (4)
                       WHEN    "5"
                           MOVE    SYS-1013-JIHINAME   TO
                                               SPA-GMN-JIHIMSG (5)
                   END-EVALUATE
               END-IF
      *
               MOVE    "SYSKANRI-KEY2"      TO  ORC-DBPATH
               PERFORM 960-KANRIMST-READ-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYS-1013-REC
               END-IF
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       3102-JIHIMSG-HEN-EXT.
           EXIT.
      *
      *
      *************************************************************
      *    前回未収額算出処理
      *************************************************************
       3101-ZENMISYU-SEC                  SECTION.
      *
           MOVE    "1"             TO  WRK-NYUGAIKBN
           PERFORM 3101-MISYU-SEC
           MOVE    WRK-MISYU       TO  SPA-GMN-ZENMISYU-NYU
      *
           MOVE    "2"             TO  WRK-NYUGAIKBN
           PERFORM 3101-MISYU-SEC
           MOVE    WRK-MISYU       TO  SPA-GMN-ZENMISYU-GAI
      *
           .
       3101-ZENMISYU-EXT.
           EXIT.
      *
      *************************************************************
      *    未収額算出処理
      *************************************************************
       3101-MISYU-SEC                      SECTION.
      *
           MOVE   ZERO                 TO  WRK-MISYU
      *
           INITIALIZE                      SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
           MOVE    WRK-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-S01-PTID        TO  SYU-PTID
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY2"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =    ZERO
               MOVE    "SYUNOU-KEY2"         TO  ORC-DBPATH
               PERFORM SYUNOU-READ-SEC
           ELSE
               MOVE    1                    TO  FLG-SYUNOU
           END-IF
      *
           PERFORM     UNTIL      (FLG-SYUNOU      =   1  )
               MOVE    ZERO               TO  FLG-SYORI
               IF     (SPA-NAI-SRYKA       NOT =   SPACE    )  AND
                      (SPA-NAI-SRYKA       NOT =   SYU-SRYKA)
                   MOVE    1                 TO  FLG-SYORI
               END-IF
      *
               IF     (SPA-S01-DENPPRTYMD  <  SYU-DENPPRTYMD )
                OR   ((SPA-S01-NYUGAIKBN   =  SYU-NYUGAIKBN )
                  AND (SPA-S01-DENPNUM     =  SYU-DENPNUM   ))
                       MOVE    1     TO      FLG-SYORI
               END-IF
      *
               IF      FLG-SYORI           =   ZERO
                   IF     SYU-SKYMONEY     >   SYU-NYUKIN-TOTAL
                      COMPUTE   WRK-MISYU
                           =    WRK-MISYU
                           +  ( SYU-SKYMONEY   -    SYU-NYUKIN-TOTAL )
                   END-IF
               END-IF
      *
               PERFORM SYUNOU-READ-SEC
           END-PERFORM
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY2"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       3101-MISYU-EXT.
           EXIT.
      *************************************************************
      *    合計請求額計算処理
      *************************************************************
       3102-SEIKYU-KEI-SEC                  SECTION.
      * 
      *    今回請求額
      *     COMPUTE SPA-GMN-SEIKYU      =   SPA-GMN-HKNTEKI
      *                                 +   SPA-GMN-HKNGAI
      *                                 +   SPA-GMN-ICHIFTN
      *                                 +   SPA-GMN-JIHIGOK
      *                                 +   SPA-GMN-CHOSEI
           MOVE   SYU-SKYMONEY         TO  SPA-GMN-SEIKYU 
           .
       3102-SEIKYU-KEI-EXT.
           EXIT.
      *************************************************************
      *    戻る　処理
      *************************************************************
       210-BACK                    SECTION.
      *
           MOVE    "S02"               TO  SPA-SAKIPG
           MOVE    "S03N"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
      *D   INITIALIZE                  SPA-KYOTUKEY
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
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
      *************************************************************
      *    自画面編集処理
      *************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC.
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF.
      *
      *
      *    PERFORM 510-ERRSET-SEC.
      *
           MOVE    SPACE               TO  LNK-KYOUTU.
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "S03N    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *
      *************************************************************
      *    画面編集処理
      *************************************************************
       500-GMNHEN-SEC                  SECTION.
      *
           MOVE    SPACE               TO  S03N
           INITIALIZE                      S03N
      *
           MOVE    SPA-GMN-PTNUM       TO  S03N-PTNUM
           MOVE    SPA-GMN-KANANAME    TO  S03N-KANANAME
           MOVE    SPA-GMN-NAME        TO  S03N-NAME
           MOVE    SPA-GMN-SEX         TO  S03N-SEX
           MOVE    SPA-GMN-KUMI        TO  S03N-HKNCOMBI
           MOVE    SPA-GMN-RITU        TO  S03N-RATE
           MOVE    SPA-GMN-SRYYMD      TO  S03N-SRYYMD
           MOVE    SPA-GMN-BIRTHDAY    TO  S03N-BIRTHDAY
           MOVE    SPA-GMN-SRYKA       TO  S03N-SRYKA
           MOVE    SPA-GMN-NYUGAIKBN   TO  S03N-NYUGAIKBN
      *
           MOVE    SPA-GMN-SYORINAIYO  TO  S03N-NAIYO
           MOVE    SPA-GMN-JOUTAI      TO  S03N-DENPJTI
           MOVE    SPA-GMN-HAKYMD      TO  S03N-HAKYMD
           MOVE    SPA-S01-DENPNUM     TO  S03N-DENPNUM (3:)
      *
           MOVE    SPA-GMN-HKNRYO (01) TO  S03N-SSUHKNTEN
           MOVE    SPA-GMN-HKNRYO (02) TO  S03N-SDOHKNTEN
           MOVE    SPA-GMN-HKNRYO (03) TO  S03N-ZTKHKNTEN
           MOVE    SPA-GMN-HKNRYO (04) TO  S03N-TYKHKNTEN
           MOVE    SPA-GMN-HKNRYO (05) TO  S03N-CSYHKNTEN
           MOVE    SPA-GMN-HKNRYO (06) TO  S03N-SYCHKNTEN
           MOVE    SPA-GMN-HKNRYO (07) TO  S03N-SJTHKNTEN
           MOVE    SPA-GMN-HKNRYO (08) TO  S03N-KNSHKNTEN
           MOVE    SPA-GMN-HKNRYO (09) TO  S03N-GZUHKNTEN
           MOVE    SPA-GMN-HKNRYO (10) TO  S03N-ETCHKNTEN
           MOVE    SPA-GMN-HKNRYO (11) TO  S03N-NYUHKNTEN
           MOVE    SPA-GMN-HKNRYO (12) TO  S03N-TOTALHKNTEN
           MOVE    SPA-GMN-HKNTEKI     TO  S03N-HKNTEKMONEY
           MOVE    SPA-GMN-ROUFTN      TO  S03N-RJNFTN
           MOVE    SPA-GMN-KOHFTN      TO  S03N-KOHFTN
           MOVE    SPA-GMN-JIHI (1 1)  TO  S03N-JIHI1
           MOVE    SPA-GMN-JIHI (1 2)  TO  S03N-JIHI2
           MOVE    SPA-GMN-JIHI (1 3)  TO  S03N-JIHI3
           MOVE    SPA-GMN-JIHI (1 4)  TO  S03N-JIHI4
           MOVE    SPA-GMN-JIHI (1 5)  TO  S03N-JIHI5
           MOVE    SPA-GMN-JIHIKEI(1)  TO  S03N-JIHITOTAL
           MOVE    SPA-GMN-JIHI (2 1)  TO  S03N-JIHI1TAX
           MOVE    SPA-GMN-JIHI (2 2)  TO  S03N-JIHI2TAX
           MOVE    SPA-GMN-JIHI (2 3)  TO  S03N-JIHI3TAX
           MOVE    SPA-GMN-JIHI (2 4)  TO  S03N-JIHI4TAX
           MOVE    SPA-GMN-JIHI (2 5)  TO  S03N-JIHI5TAX
           MOVE    SPA-GMN-JIHIKEI(2)  TO  S03N-JIHITAXTOTAL
           MOVE    SPA-GMN-JIHIZEI     TO  S03N-JIHITAX
           MOVE    SPA-GMN-TGMONEY (01) TO  S03N-SSUTGMONEY
           MOVE    SPA-GMN-TGMONEY (02) TO  S03N-SDOTGMONEY
           MOVE    SPA-GMN-TGMONEY (03) TO  S03N-ZTKTGMONEY
           MOVE    SPA-GMN-TGMONEY (04) TO  S03N-TYKTGMONEY
           MOVE    SPA-GMN-TGMONEY (05) TO  S03N-CSYTGMONEY
           MOVE    SPA-GMN-TGMONEY (06) TO  S03N-SYCTGMONEY
           MOVE    SPA-GMN-TGMONEY (07) TO  S03N-SJTGMONEY
           MOVE    SPA-GMN-TGMONEY (08) TO  S03N-KNSTGMONEY
           MOVE    SPA-GMN-TGMONEY (09) TO  S03N-GZUTGMONEY
           MOVE    SPA-GMN-TGMONEY (10) TO  S03N-ETCTGMONEY
           MOVE    SPA-GMN-HKNGAI      TO  S03N-HKNTEKGAI
           MOVE    SPA-GMN-ICHIFTN     TO  S03N-FTNTOTAL
           MOVE    SPA-GMN-YAKFTN      TO  S03N-YKZFTN 
           MOVE    SPA-GMN-SKJFTN      TO  S03N-SKJFTN
           MOVE    SPA-GMN-SKJRYOYO    TO  S03N-SKJRYOYO
           MOVE    SPA-GMN-RMSAGAKU    TO  S03N-RMSAGAKU
           MOVE    SPA-GMN-CHOSEI      TO  S03N-NYUKINGK1
           MOVE    SPA-GMN-SEIKYU      TO  S03N-SYKMONEY
           MOVE    SPA-GMN-ZENMISYU-GAI
                                       TO  S03N-ZENMISYU-GAI
           MOVE    SPA-GMN-ZENMISYU-NYU
                                       TO  S03N-ZENMISYU-NYU
           MOVE    SPA-GMN-SEIGOK      TO  S03N-GOKMISYU
           MOVE    SPA-GMN-MISYU-ZAN   TO  WRK-Z9
           MOVE    WRK-Z9              TO  S03N-MISYUZAN
           MOVE    SPA-GMN-DENPYO-KEI  TO  S03N-NYUKINGK1
      *    入金欄
           IF     SPA-S01-SYORINO        =   "05"  OR  "08"
               MOVE    SPA-GMN-NYUKIN-IN  TO  S03N-NYUKINGK2
               MOVE    SPA-GMN-NYUKINYMD-IN
                                       TO  S03N-NYUKINYMD
               MOVE    SPA-GMN-NYUKINLST (1)
                                       TO  S03N-NYUKINHOUHOULST(1)
               MOVE    SPA-GMN-NYUKINLST (2)
                                       TO  S03N-NYUKINHOUHOULST(2)
               MOVE    2               TO  S03N-NYUKINHOUHOU-COUNT
               MOVE    SPA-GMN-NYUKIN-DSP  TO  S03N-NYUKINHOUHOU
           END-IF.
           IF     SPA-S01-SYORINO      =   "08"
               MOVE    SPA-GMN-RIREKIIN    TO  S03N-RIREKIIN
           END-IF.
      *
           PERFORM    VARYING IDX     FROM    1   BY  1      
                      UNTIL   IDX     >       10 
                      OR      SPA-GMN-EDABAN-T (IDX)  =   ZERO
               MOVE   SPA-GMN-EDABAN-T(IDX)   TO  WRK-EDABAN
               MOVE   WRK-EDABAN              TO  S03N-TRENNUM (IDX)
               MOVE   SPA-GMN-SEIKYU-T(IDX)   TO  WRK-Z9
               MOVE   WRK-Z9                  TO  S03N-TSKYMONY(IDX)
               MOVE   SPA-GMN-NYUKIN-T(IDX)   TO  WRK-Z9
               MOVE   WRK-Z9                  TO  S03N-TNYUKINMONEY(IDX)
               MOVE   SPA-GMN-SYORIYMD-T(IDX) TO  S03N-TSYORIYMD(IDX)
               MOVE   SPA-GMN-JOUTAI-T (IDX)  TO  S03N-TJTI(IDX)
               MOVE   IDX                     TO  S03N-CLIST1-COUNT
           END-PERFORM
      *
      *    自費名称
           PERFORM     VARYING IDX     FROM    1   BY  1
                       UNTIL   IDX     >       5 
               MOVE    SPA-GMN-JIHIMSG(IDX)  TO  S03N-JIHIMSG (IDX)
           END-PERFORM
      *    労災保険適用分
           MOVE    SPA-GMN-RSISHOSHIN    TO  S03N-RSISHOSHIN
           MOVE    SPA-GMN-RSISAISHIN    TO  S03N-RSISAISHIN
           MOVE    SPA-GMN-RSISDO        TO  S03N-RSISDO
           MOVE    SPA-GMN-RSIETC        TO  S03N-RSIETC
      * 
           PERFORM 5001-MAPCUR-SEC
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *************************************************************
      *    画面カーソルセット処理
      *************************************************************
       5001-MAPCUR-SEC             SECTION.
      * 入金項目(LNK-SYORINAIYO="05")
       IF     SPA-S01-SYORINO     =   "05"
          EVALUATE   SPA-GMN-CUR
               WHEN   02
                 MOVE  "NYUKINGK2"      TO  MCP-WIDGET   
               WHEN   03
                 MOVE  "NYUKINYMD"      TO  MCP-WIDGET   
               WHEN   04
                 MOVE  "NYUKINHOUHOU"   TO  MCP-WIDGET   
               WHEN   05
                 MOVE  "B12"            TO  MCP-WIDGET   
           END-EVALUATE
       END-IF
      *  調整金項目(LNK-SYORINAIYO="07")
       IF     SPA-S01-SYORINO     =   "07"
          EVALUATE   SPA-GMN-CUR
               WHEN   01
                 MOVE  "CHOSEIKIN"      TO  MCP-WIDGET   
           END-EVALUATE
       END-IF
      * 歴修正(LNK-SYORINAIYO="08")
       IF  SPA-S01-SYORINO     =  "08"
           EVALUATE   SPA-GMN-CUR
               WHEN   01
                 MOVE  "RIREKIIN"      TO  MCP-WIDGET   
              WHEN   02
                 MOVE  "NYUKINGK2"      TO  MCP-WIDGET   
               WHEN   03
                 MOVE  "NYUKINYMD"      TO  MCP-WIDGET   
               WHEN   04
                 MOVE  "NYUKINHOUHOU"   TO  MCP-WIDGET   
               WHEN   05
                 MOVE  "B12"            TO  MCP-WIDGET   
           END-EVALUATE
       END-IF
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *************************************************************
      *    画面遷移処理
      *************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT         ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"         ALSO    "B01"
                   PERFORM 210-BACK
      *    予約登録
               WHEN    "CLICKED"         ALSO    "B10"
                   PERFORM 480-YOYAKU-SEC
      *    受付一覧
               WHEN    "CLICKED"         ALSO    "B11"
                   PERFORM 490-UKEICHI-SEC
      *    登録
               WHEN    "CLICKED"           ALSO    "B12"
                   IF  SPA-S01-SYORINO    =    "08"
                   AND SPA-IDX            =   ZERO
                       MOVE    "0006"          TO  SPA-ERRCD
                       GO  TO  200-GMNSENI-EXT
                   END-IF    
                   IF  SPA-S01-SYORINO        =    "05"
                       IF      SPA-GMN-NYUKIN-IN      =   ZERO
                       OR      SPA-GMN-NYUKINYMD-IN99 =   ZERO
                           MOVE    "0007"          TO  SPA-ERRCD
                           GO  TO  200-GMNSENI-EXT
                       END-IF
                   END-IF        
      *----(01.00.01) LINE MOD START -------------------------------
      *            PERFORM 410-KOUMOKU-SYORI-SEC
      *            PERFORM 310-SPA-SET-SEC
                   IF   SPA-S01-SYORINO    =     "09"
                        CONTINUE
                   ELSE
                        PERFORM 410-KOUMOKU-SYORI-SEC
                   END-IF
      *----(01.00.01) LINE MOD END   -------------------------------
           END-EVALUATE
           .
       200-GMNSENI-EXT.
           EXIT.
      *************************************************************
      *    会話　処理
      *************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *        番号入力
               WHEN    ANY             ALSO    "clist1"
                   PERFORM   VARYING   WRK-MAP-INDEX   FROM   1   BY  1
                             UNTIL     WRK-MAP-INDEX 
                                               >   SPA-GMN-MISYU-MAX
                       IF    S03N-SELECT (WRK-MAP-INDEX)    =   "T"
                           MOVE WRK-MAP-INDEX   TO   SPA-IDX
                           MOVE SPA-GMN-NYUKIN-T(SPA-IDX)
                                            TO  SPA-GMN-NYUKIN-IN
                           MOVE SPA-GMN-SYORIYMD-T(SPA-IDX)
                                        TO  SPA-GMN-NYUKINYMD-IN
                           MOVE SPA-GMN-NYUKINYMD-IN9(SPA-IDX)
                                       TO  SPA-GMN-NYUKINYMD-IN99
                           MOVE SPA-GMN-JOUTAI-TX (SPA-IDX)
                                       TO  SPA-GMN-NYUKIN-DSP
                           MOVE    SPA-GMN-EDABAN-T (SPA-IDX)
                                               TO  SPA-GMN-RIREKIIN
                           MOVE    SPA-GMN-EDABAN-T (SPA-IDX)
                                               TO  SPA-GMN-RIREKIIN9
                           MOVE    SPA-IDX
                                               TO  S03N-RIREKIIN
                           MOVE    SPA-GMN-MISYU-MAX
                                               TO  WRK-MAP-INDEX
                       END-IF
                   END-PERFORM
                   MOVE 02                   TO  SPA-GMN-CUR
      *        履歴入力
               WHEN    "ACTIVATE"      ALSO    "RIREKIIN"
                   MOVE    1                  TO  SPA-GMN-CUR
                   MOVE    ZERO            TO  SPA-GMN-RIREKIIN
                   MOVE S03N-RIREKIIN       TO  SPA-IDX
                   IF      SPA-IDX    <  1   OR  >  SPA-GMN-MISYU-MAX
                       MOVE    "0005"         TO  SPA-ERRCD
                   ELSE    
                       MOVE SPA-GMN-NYUKIN-T(SPA-IDX)
                                            TO  SPA-GMN-NYUKIN-IN
                       MOVE SPA-GMN-SYORIYMD-T(SPA-IDX)
                                        TO  SPA-GMN-NYUKINYMD-IN
                       MOVE SPA-GMN-NYUKINYMD-IN9(SPA-IDX)
                                       TO  SPA-GMN-NYUKINYMD-IN99
                       MOVE SPA-GMN-JOUTAI-TX (SPA-IDX)
                                       TO  SPA-GMN-NYUKIN-DSP
                       MOVE SPA-IDX              TO  SPA-GMN-RIREKIIN
                       MOVE SPA-IDX              TO  SPA-GMN-RIREKIIN9
                       MOVE 02                   TO  SPA-GMN-CUR
                   END-IF    
      *        入金額
               WHEN    "ACTIVATE"      ALSO    "NYUKINGK2"
                   MOVE    02              TO  SPA-GMN-CUR
                       IF  SPA-S01-SYORINO    =    "08"
                       AND    SPA-IDX         =   ZERO
                       MOVE    "0006"          TO  SPA-ERRCD
                   ELSE    
                       MOVE  S03N-NYUKINGK2     TO  SPA-GMN-NYUKIN-IN
                       IF  SPA-S01-SYORINO    =    "05"
                           IF  SPA-GMN-NYUKIN-IN    =    ZERO
                               MOVE  SPA-GMN-MISYU-ZAN   TO
                                               SPA-GMN-NYUKIN-IN
                           END-IF
                       END-IF
                       PERFORM 41011-CHK-SEC
                       IF  SPA-ERRCD  NOT = SPACE
                           GO    TO    200-ENTRY-EXT
                       END-IF
                       ADD     1                   TO  SPA-GMN-CUR
                       IF  SPA-GMN-NYUKIN-IN    =    ZERO
                           MOVE    02              TO  SPA-GMN-CUR
                       END-IF
                   END-IF    
      *        入金日
               WHEN    "ACTIVATE"      ALSO    "NYUKINYMD"
                   PERFORM  41012-DAY-SEC
      *        入金方法
               WHEN    "ACTIVATE"      ALSO    "NYUKINHOUHOU"
                   PERFORM  41013-HOU-SEC
      *        調整金
               WHEN    "ACTIVATE"      ALSO    "CHOSEIKIN"
                   PERFORM 4101-ENT-SEC
      *        未収理由
               WHEN    "ACTIVATE"      ALSO    "MISYURIYU"
                   PERFORM 4101-ENT-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *************************************************************
      *    項目チェック処理
      *************************************************************
       410-KOUMOKU-SYORI-SEC       SECTION.
      *     登録
           EVALUATE     SPA-S01-SYORINO
               WHEN     "05"
      *            登録前チェック
                   PERFORM 410-TOROK-MAE-CHK-SEC
                   IF  ( SPA-ERRCD NOT = SPACE )
                       GO  TO  410-KOUMOKU-SYORI-EXT
                   END-IF
                   PERFORM   420-NYUKIN-SEC
                   MOVE    2       TO  SPA-GMN-CUR
               WHEN     "07"
                   PERFORM   430-CHOSEIKIN-SEC
               WHEN     "08"
      *            登録前チェック
                   PERFORM 410-TOROK-MAE-CHK-SEC
                   IF  ( SPA-ERRCD NOT = SPACE )
                       GO  TO  410-KOUMOKU-SYORI-EXT
                   END-IF
                   PERFORM   440-RIREKI-SEC
                   MOVE    1       TO  SPA-GMN-CUR
           END-EVALUATE
      *
           PERFORM 310-SPA-SET-SEC
      *
           .
       410-KOUMOKU-SYORI-EXT.
           EXIT.
      *
      *************************************************************
      *    登録前チェック処理
      *************************************************************
       410-TOROK-MAE-CHK-SEC           SECTION.
      *
      *    入金額チェック処理
           PERFORM 41011-CHK-SEC
           IF    ( SPA-ERRCD       NOT =   SPACE )
               GO  TO  410-TOROK-MAE-CHK-EXT
           END-IF
      *
      *    入金日チェック
           IF  SPA-S01-SYORINO    =    "08"
           AND SPA-IDX            =   ZERO
               MOVE    "0006"          TO  SPA-ERRCD
               MOVE    3               TO  SPA-GMN-CUR
               GO  TO  410-TOROK-MAE-CHK-EXT
           END-IF    
      *
           MOVE   ZERO               TO  SPA-GMN-NYUKINYMD-IN99
      *
           IF     SPA-GMN-NYUKINYMD-IN     =   SPACE
               MOVE    SPA-SYSYMDWH        TO  SPA-GMN-NYUKINYMD-IN
               MOVE    SPA-SYSYMD          TO  SPA-GMN-NYUKINYMD-IN99
           ELSE 
      *
      *        日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-NYUKINYMD-IN    TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY     TO  SPA-GMN-NYUKINYMD-IN
                   MOVE    SGDAY-SDAY      TO  SPA-GMN-NYUKINYMD-IN99
               ELSE
                   MOVE    "0001"          TO  SPA-ERRCD
                   MOVE    3               TO  SPA-GMN-CUR
                   GO  TO  410-TOROK-MAE-CHK-EXT
               END-IF
           END-IF 
      *
      *    入金方法チェック
           IF  SPA-GMN-NYUKINCD        =   SPACE
               MOVE    "0004"          TO  SPA-ERRCD
               MOVE    4               TO  SPA-GMN-CUR
               GO     TO    410-TOROK-MAE-CHK-EXT
           END-IF
      *
           MOVE    1                   TO  FLG-CHK
           PERFORM VARYING IDX3    FROM    1   BY  1
               UNTIL     ( IDX3    >   10 )
               OR        ( SPA-GMN-NYUKINL (IDX3)  =   SPACE )
      *
               IF    ( SPA-GMN-NYUKINL (IDX3)  =   SPA-GMN-NYUKINCD )
                   MOVE    ZERO        TO  FLG-CHK
                   MOVE    10          TO  IDX3
               END-IF
      *
           END-PERFORM
      *
           IF    ( FLG-CHK     NOT =   ZERO )
               MOVE    "0001"          TO  SPA-ERRCD
               MOVE    4               TO  SPA-GMN-CUR
               GO  TO  410-TOROK-MAE-CHK-EXT
           END-IF
      *
      *
           .
       410-TOROK-MAE-CHK-EXT.
           EXIT.
      *************************************************************
      *    項目入力　処理
      *************************************************************
       4101-ENT-SEC                SECTION.
      *
           EVALUATE    SPA-S01-SYORINO
               WHEN    "05"
      *入金額
                     MOVE    S03N-NYUKINGK2    TO  SPA-GMN-NYUKIN-IN
      *入金額チェック処理
                     PERFORM 41011-CHK-SEC
                     IF  SPA-ERRCD  NOT = SPACE
                         GO    TO    4101-ENT-EXT
                     END-IF
                     ADD     1                   TO  SPA-GMN-CUR
                     IF  SPA-GMN-NYUKIN-IN    =    ZERO
                         MOVE    02              TO  SPA-GMN-CUR
                     END-IF
      *入金日付
                     PERFORM  41012-DAY-SEC
      *入金方法
                     PERFORM  41013-HOU-SEC
               WHEN    "08"
                     CONTINUE
      *>               MOVE WRK-GMN-LINE         TO  SPA-GMN-RIREKIIN
      *>               MOVE WRK-GMN-LINE     TO  SPA-GMN-RIREKIIN9
      *>               MOVE SPA-GMN-NYUKIN-T(WRK-GMN-LINE)
      *>                                     TO  SPA-GMN-NYUKIN-IN
      *>               MOVE SPA-GMN-SYORIYMD-T(WRK-GMN-LINE)
      *>                                     TO  SPA-GMN-NYUKINYMD-IN
      *>               MOVE SPA-GMN-NYUKINYMD-IN9(WRK-GMN-LINE)
      *>                                 TO  SPA-GMN-NYUKINYMD-IN99
      *>               MOVE SPA-GMN-JOUTAI-TX (WRK-GMN-LINE)
      *>                                 TO  SPA-GMN-NYUKIN-DSP
      *>               MOVE 02                   TO  SPA-GMN-CUR
           END-EVALUATE
      *ＳＰＡにセット
      *>     PERFORM 310-SPA-SET-SEC
           .
      *
       4101-ENT-EXT.
           EXIT.
      *
      *************************************************************
      *    入金額チェック処理
      *************************************************************
       41011-CHK-SEC              SECTION.
      *
           MOVE     2             TO  SPA-GMN-CUR
      *
           MOVE     ZERO          TO  SPA-NYUKINGK
           EVALUATE    SPA-S01-SYORINO
               WHEN    "05"
                 PERFORM  VARYING   IDY  FROM 1  BY  1
                          UNTIL     IDY  >  12
                   COMPUTE SPA-NYUKINGK = SPA-NYUKINGK
                                        + SPA-GMN-NYUKIN-T(IDY)
                 END-PERFORM
      *
                 COMPUTE SPA-NYUKINGK = SPA-NYUKINGK
                                        + SPA-GMN-NYUKIN-IN
               WHEN    "08"
                 COMPUTE SPA-NYUKINGK = SPA-GMN-DENPYO-KEI - 
                             SPA-GMN-NYUKIN-T(SPA-GMN-RIREKIIN) +
                               SPA-GMN-NYUKIN-IN
           END-EVALUATE
      *
           IF  SPA-GMN-SEIKYU   <  SPA-NYUKINGK
               MOVE    "0003"      TO  SPA-ERRCD
           END-IF
      *
           .
      *
       41011-CHK-EXT.
           EXIT.
      *
      *************************************************************
      *    入金日付チェック編集処理
      *************************************************************
       41012-DAY-SEC              SECTION.
      *
           MOVE    3              TO  SPA-GMN-CUR
      *
           IF  SPA-S01-SYORINO    =    "08"
           AND SPA-IDX            =   ZERO
               MOVE    "0006"          TO  SPA-ERRCD
               GO  TO  41012-DAY-EXT
           END-IF    
      *
           MOVE   ZERO               TO  SPA-GMN-NYUKINYMD-IN99
           MOVE   S03N-NYUKINYMD      TO   SPA-GMN-NYUKINYMD-IN
      *
           IF     SPA-GMN-NYUKINYMD-IN     =   SPACE
               MOVE    SPA-SYSYMDWH        TO  SPA-GMN-NYUKINYMD-IN
               MOVE    SPA-SYSYMD          TO  SPA-GMN-NYUKINYMD-IN99
           ELSE 
      *----(01.00.01) LINE MOD START   ----------------------------------
      ***      MOVE    SPA-GMN-NYUKINYMD-IN    TO  WRK-YMD
      ***      PERFORM 5002-HIZUKE-CHK-SEC
      ***      IF      SPA-ERRCD           =   SPACE
      ***          MOVE    WRK-SYMD        TO  SPA-GMN-NYUKINYMD-IN99
      ***          MOVE    WRK-HENYMDG     TO  SPA-GMN-NYUKINYMD-IN
      ***      ELSE    
      ***          GO      TO      41012-DAY-EXT
      ***      END-IF
      *
      *        日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-NYUKINYMD-IN    TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY     TO  SPA-GMN-NYUKINYMD-IN
                   MOVE    SGDAY-SDAY      TO  SPA-GMN-NYUKINYMD-IN99
               ELSE
                   MOVE    "0001"          TO  SPA-ERRCD
                   GO  TO  41012-DAY-EXT
               END-IF
           END-IF 
      *----(01.00.01) LINE MOD END   ----------------------------------
      *
           ADD     1                   TO  SPA-GMN-CUR
           .
      *
       41012-DAY-EXT.
           EXIT.
      *
      *************************************************************
      *    入金方法チェック編集処理
      *************************************************************
       41013-HOU-SEC              SECTION.
      *
           MOVE        4               TO  SPA-GMN-CUR 
      *
           MOVE    S03N-NYUKINHOUHOU    TO  SPA-GMN-NYUKIN-DSP
      *
           IF  SPA-GMN-NYUKINCD        =   SPACE
               MOVE    "0004"          TO  SPA-ERRCD
               GO     TO    41013-HOU-EXT
           END-IF
      *
           MOVE    1                   TO  FLG-CHK
           PERFORM VARYING IDX3    FROM    1   BY  1
               UNTIL     ( IDX3    >   10 )
               OR        ( SPA-GMN-NYUKINL (IDX3)  =   SPACE )
      *
               IF    ( SPA-GMN-NYUKINL (IDX3)  =   SPA-GMN-NYUKINCD )
                   MOVE    ZERO        TO  FLG-CHK
                   MOVE    10          TO  IDX3
               END-IF
      *
           END-PERFORM
      *
           IF    ( FLG-CHK     NOT =   ZERO )
               MOVE    "0001"          TO  SPA-ERRCD
               GO  TO  41013-HOU-EXT
           END-IF
      *
           MOVE       5                TO  SPA-GMN-CUR 
           .
      *
       41013-HOU-EXT.
           EXIT.
      *
      *************************************************************
      *    入金編集処理
      *************************************************************
       420-NYUKIN-SEC             SECTION.
      *    収納マスタの請求金額と入金合計額を比較して
      *    収納マスタの更新と、収納明細マスタを作成する
      *
           INITIALIZE                      SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-S01-NYUGAIKBN   TO  SYU-NYUGAIKBN
           MOVE    SPA-S01-PTID        TO  SYU-PTID
           MOVE    SPA-S01-DENPNUM     TO  SYU-DENPNUM
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =    ZERO
               MOVE    "SYUNOU-KEY"         TO  ORC-DBPATH
               PERFORM SYUNOU-READ-SEC
           ELSE
               MOVE    1                    TO  FLG-SYUNOU
           END-IF
           IF      FLG-SYUNOU          =   1
                   CONTINUE
           ELSE
                   COMPUTE SYU-NYUKIN-TOTAL = SYU-NYUKIN-TOTAL + 
                                              SPA-GMN-NYUKIN-IN
                   ADD     1                   TO  SYU-NYUKIN-KAISU
                   IF  SYU-SKYMONEY >  SYU-NYUKIN-TOTAL
                       MOVE    "2"             TO    SYU-DENPJTIKBN
                   ELSE
                       MOVE    "1"             TO    SYU-DENPJTIKBN
                   END-IF
                   MOVE    SYUNOU-REC          TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      * 
                   IF      MCP-RC              NOT =   ZERO 
                       MOVE    "1001"                  TO  SPA-ERRCD
                       GO  TO  420-NYUKIN-EXT
                   END-IF
      *      
                   INITIALIZE                      SYUMEI-REC
                   MOVE    SPA-HOSPID          TO  SMEI-HOSPID
      *************MOVE    SPA-NYUGAIKBN       TO  SMEI-NYUGAIKBN
                   MOVE    SPA-S01-NYUGAIKBN   TO  SMEI-NYUGAIKBN
                   MOVE    SPA-S01-PTID        TO  SMEI-PTID
                   MOVE    SPA-S01-DENPNUM     TO  SMEI-DENPNUM
                   MOVE    SYUMEI-REC          TO  MCPDATA-REC
                   MOVE    "DBSELECT"          TO  MCP-FUNC
                   MOVE    "SYUMEI-KEY2"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC              =    ZERO
                      MOVE    "SYUMEI-KEY2"         TO  ORC-DBPATH
                      PERFORM SYUMEI-READ-SEC
                   ELSE
                      MOVE    1                    TO  FLG-SYUMEI
                   END-IF
                   IF      FLG-SYUMEI    =     1
                       CONTINUE
                   ELSE
                       PERFORM VARYING  IDX  FROM  1  BY  1
                               UNTIL  (FLG-SYUMEI  =  1)
                           MOVE  "SYUMEI-KEY2"     TO  ORC-DBPATH
                           PERFORM   SYUMEI-READ-SEC
                       END-PERFORM  
                       PERFORM    4201-SMEI-SAKUSEI-SEC
      * 
                       IF      MCP-RC           NOT =   ZERO 
                           MOVE    "1002"       TO    SPA-ERRCD
                           GO  TO  420-NYUKIN-EXT
                       END-IF
                   END-IF
           END-IF
           MOVE    ZERO        TO    SPA-GMN-NYUKIN-IN
           MOVE    SPACE       TO    SPA-GMN-NYUKINYMD-IN
           MOVE    ZERO        TO    SPA-GMN-RIREKIIN
           MOVE    SPACE       TO    SPA-GMN-NYUKIN-DSP
      *     
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       420-NYUKIN-EXT.
           EXIT.
      *************************************************************
      *    入金処理（収納明細レコード作成）
      *************************************************************
       4201-SMEI-SAKUSEI-SEC           SECTION.
      *
           MOVE    SPACE               TO  SYUMEI-REC
           INITIALIZE                      SYUMEI-REC
           MOVE    SPA-HOSPID          TO  SMEI-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SMEI-NYUGAIKBN
           MOVE    SPA-S01-NYUGAIKBN   TO  SMEI-NYUGAIKBN
           MOVE    SPA-S01-PTID        TO  SMEI-PTID
      *伝票番号
           MOVE    SPA-S01-DENPNUM     TO  SMEI-DENPNUM
      *伝票番号枝番
           MOVE    IDX                 TO  SMEI-DENPEDANUM
      *入金連番
           MOVE    ZERO                TO  SMEI-NYUKINRENNUM
      *伝票状態区分
           MOVE    SPACE               TO  SMEI-MEISAIJOUTAIKBN
      *請求発行日（発行日の西暦）
           MOVE    SPACE               TO  SMEI-SKYPRINTYMD
      *請求再発行日
           MOVE    SPACE               TO  SMEI-SKYREPRINTYMD
      *領収書発行日
           MOVE    SPACE               TO  SMEI-RYOSYUPRINTYMD
      *領収書再発行日
           MOVE    SPACE               TO  SMEI-RYOSYUREPRINTYMD
      *請求金額
           MOVE    ZERO                TO  SMEI-SKYMONEY
      *入返金区分
           MOVE    "1"                 TO  SMEI-NYUHEN-KBN
      *入返金額
           MOVE    SPA-GMN-NYUKIN-IN   TO  SMEI-NYUHEN-MONEY
      *入返金日
           IF  SPA-GMN-NYUKINYMD-IN99  =  ZERO
               MOVE    SPA-SYSYMD             TO  SMEI-NYUHEN-YMD
           ELSE
               MOVE    SPA-GMN-NYUKINYMD-IN99 TO  SMEI-NYUHEN-YMD
           END-IF
      *入金方法
           MOVE    SPA-GMN-NYUKINCD    TO  SMEI-NYUKIN-HOHO
      *状態区分
           MOVE    "2"                 TO  SMEI-JOUTAIKBN
      *
           MOVE    SYUMEI-REC          TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "SYUMEI-KEY2"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      **** MOVE    "DBCLOSE"           TO  MCP-FUNC
      **** MOVE    "SYUMEI-KEY2"        TO  ORC-DBPATH
      **** CALL    "MCPDBSUB"          USING
      ****                             MCPAREA
      ****                             MCPDATA-REC
           .
       4201-SMEI-SAKUSEI-EXT.
           EXIT.
      *
      **************************************************************
      *    予約登録へ
      **************************************************************
       480-YOYAKU-SEC             SECTION.
      *
      *    戻り時、画面を元へ戻す
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-S03N            TO  LNK-SCRSPA
      *    画面移行用のパラメタ変更
           MOVE    "S03N"              TO  SPA-MOTOPG
           MOVE    "S03N"              TO  SPA-MOTOPG3
           MOVE    "Y01"               TO  SPA-SAKIPG
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "Y01"                TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       480-YOYAKU-EXT.
           EXIT.
      *
      **************************************************************
      *    受付一覧へ
      **************************************************************
       490-UKEICHI-SEC             SECTION.
      *
      *    戻り時、画面を元へ戻す
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-S03N            TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "S03N"              TO  SPA-MOTOPG
           MOVE    "U01"               TO  SPA-SAKIPG
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "U01    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-UKEICHI-EXT.
           EXIT.
      *
      *
      *************************************************************
      *    調整金チェック処理
      *************************************************************
       430-CHOSEIKIN-SEC             SECTION.
       430-CHOSEIKIN-EXT.
           EXIT.
      *
      *************************************************************
      *    履歴修正処理
      *************************************************************
       440-RIREKI-SEC             SECTION.
      *
      *    収納明細マスタを更新する
      *
           INITIALIZE                      SYUNOU-REC
           MOVE    SPA-HOSPID          TO  SYU-HOSPID
      *****MOVE    SPA-NYUGAIKBN       TO  SYU-NYUGAIKBN
           MOVE    SPA-S01-NYUGAIKBN   TO  SYU-NYUGAIKBN
           MOVE    SPA-S01-PTID        TO  SYU-PTID
           MOVE    SPA-S01-DENPNUM     TO  SYU-DENPNUM
           MOVE    SYUNOU-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
          IF      MCP-RC              =    ZERO
               MOVE    "SYUNOU-KEY"         TO  ORC-DBPATH
               PERFORM SYUNOU-READ-SEC
           ELSE
               MOVE    1                    TO  FLG-SYUNOU
           END-IF
           IF      FLG-SYUNOU          =   1
                   CONTINUE
           ELSE
                   MOVE    ZERO           TO   SPA-SAGAKU
                   COMPUTE SPA-SAGAKU   = SPA-GMN-NYUKIN-IN - 
                            SPA-GMN-NYUKIN-T(SPA-GMN-RIREKIIN9) 
                   COMPUTE SYU-NYUKIN-TOTAL =  SYU-NYUKIN-TOTAL
                                             + SPA-SAGAKU
                   ADD     1                   TO SYU-NYUKIN-KAISU
                   IF  SYU-SKYMONEY  >  SYU-NYUKIN-TOTAL
                       MOVE    "2"      TO    SYU-DENPJTIKBN
                   ELSE
                       MOVE    "1"      TO    SYU-DENPJTIKBN
                   END-IF
                   MOVE    SYUNOU-REC          TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   INITIALIZE                      SYUMEI-REC
                   MOVE    SPA-HOSPID          TO  SMEI-HOSPID
      *************MOVE    SPA-NYUGAIKBN       TO  SMEI-NYUGAIKBN
                   MOVE    SPA-S01-NYUGAIKBN   TO  SMEI-NYUGAIKBN
                   MOVE    SPA-S01-PTID        TO  SMEI-PTID
                   MOVE    SPA-S01-DENPNUM     TO  SMEI-DENPNUM
                   MOVE    SPA-IDX             TO  SMEI-DENPEDANUM
                   MOVE    SYUMEI-REC          TO  MCPDATA-REC
                   MOVE    "DBSELECT"          TO  MCP-FUNC
                   MOVE    "SYUMEI-KEY"         TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"          USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC            
                   IF      MCP-RC              =    ZERO
                      MOVE    "SYUMEI-KEY"         TO  ORC-DBPATH
                      PERFORM SYUMEI-READ-SEC
                   ELSE
                      MOVE    1                    TO  FLG-SYUMEI
                   END-IF
                   IF      FLG-SYUMEI    =     1
                       CONTINUE
                   ELSE
      *入返金額
                      MOVE SPA-GMN-NYUKIN-IN TO  SMEI-NYUHEN-MONEY
      *入返金日
                      IF  SPA-GMN-NYUKINYMD-IN99  =  ZERO
                        MOVE SPA-SYSYMD      TO SMEI-NYUHEN-YMD
                      ELSE
                        MOVE SPA-GMN-NYUKINYMD-IN99 TO
                            SMEI-NYUHEN-YMD
                      END-IF
      *入金方法
                      MOVE  SPA-GMN-NYUKINCD  TO  SMEI-NYUKIN-HOHO
      *伝票状態区分
                      IF  SPA-GMN-NYUKIN-IN  NOT = ZERO
                          MOVE    "2"         TO  SMEI-JOUTAIKBN
                      END-IF 
                      MOVE    SYUMEI-REC          TO  MCPDATA-REC
                      MOVE    "DBUPDATE"          TO  MCP-FUNC
                      MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
                      CALL    "ORCMCPSUB"          USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
                  END-IF
           END-IF
           MOVE    ZERO        TO    SPA-GMN-NYUKIN-IN
           MOVE    SPACE       TO    SPA-GMN-NYUKINYMD-IN
           MOVE    ZERO        TO    SPA-GMN-RIREKIIN
           MOVE    SPACE       TO    SPA-GMN-NYUKIN-DSP
      *     
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYUMEI-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
      *
       440-RIREKI-EXT.
           EXIT.
      *
      *************************************************************
      *    確定　処理
      *************************************************************
       430-TOROKU-SEC             SECTION.
       430-TOROKU-EXT.
           EXIT.
      *
      *************************************************************
      *    システム管理より、伝票番号取得処理
      *************************************************************
       45001-DENPNO-SET-SEC            SECTION.
       45001-DENPNO-SET-EXT.
           EXIT.
      *
      *************************************************************
      *    収納明細マスター作成処理
      *************************************************************
       45001-SINMEI-SYORI-SEC          SECTION.
       45001-SINMEI-SYORI-EXT.
           EXIT.
      *
      *************************************************************
      *    診療行為マスター更新処理
      *************************************************************
       4501-SINKOUI-KOU-SEC            SECTION.
       4501-SINKOUI-KOU-EXT.
           EXIT.
      *
      *************************************************************
      *     診療会計マスター処理
      *************************************************************
       4501-SINKAI-SYORI-SEC              SECTION.
       4501-SINKAI-SYORI-EXT.
           EXIT.
      *
      *************************************************************
      *   診療行為内容の比較処理
      *************************************************************
       45012-SINKAI-CHK-SEC          SECTION.
      *
       45012-SINKAI-CHK-EXT.
           EXIT.
      *
      *************************************************************
      *   剤番号取得処理
      *************************************************************
       45013-ZAIBAN-SET-SEC          SECTION.
      *
       45013-ZAIBAN-SET-EXT.
           EXIT.
      *
      *************************************************************
      *   診療会計マスター新規編集処理
      *************************************************************
       45015-SINKAI-SIN-SEC          SECTION.
      *
       45015-SINKAI-SIN-EXT.
           EXIT.
      *
      *************************************************************
      *   診療会計マスター編集処理
      *************************************************************
       45014-SINKAI-HEN-SEC          SECTION.
      *
       45014-SINKAI-HEN-EXT.
           EXIT.
      *************************************************************
      *    診療行為マスター処理
      *************************************************************
       4501-SINKOUI-SYORI-SEC          SECTION.
      *
      *
       4501-SINKOUI-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   SPACE
               MOVE    SPACE               TO  WRK-HGO
               MOVE    WRK-SYMD(3:2)       TO  WRK-HYY
               MOVE    WRK-SYMD(5:2)       TO  WRK-HMM
               MOVE    WRK-SYMD(7:2)       TO  WRK-HDD
               MOVE    WRK-HENYMD          TO  WRK-HENYMDG
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
      *************************************************************
      *    エラーメッセージ表示理
      *************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "処理順エラー？？？"
                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "入金合計額が請求額を超えています"
                                       TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "入金方法を入力して下さい"
                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "選択番号入力エラー"
                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "選択番号が未入力です"
                                       TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "入金額、入金日が未入力です"
                                       TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "収納の更新処理でエラーになりました"
                                       TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "収納明細の更新処理でエラーになりました"
                                       TO  SPA-ERRMSG
           END-EVALUATE
      *
           MOVE    SPACE                TO  SERR
           MOVE    SPA-ERRCD            TO  SERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  SERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "S03N"               TO  SPA-MOTOPG
           MOVE    "SERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "SERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRSET-EXT.
           EXIT.
      *
      *************************************************************
      *    収納マスター読込
      *************************************************************
       SYUNOU-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =  ZERO
               MOVE    MCPDATA-REC     TO  SYUNOU-REC
               MOVE    ZERO            TO FLG-SYUNOU
           ELSE
               MOVE    1               TO FLG-SYUNOU
           END-IF 
           .
       SYUNOU-READ-EXT.
           EXIT.
      *
      *************************************************************
      *    収納明細マスター読込
      *************************************************************
       SYUMEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYUMEI-REC
               MOVE    ZERO            TO  FLG-SYUMEI
           ELSE
               INITIALIZE                  SYUMEI-REC
               MOVE    1               TO  FLG-SYUMEI
          END-IF
           .
       SYUMEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       960-KANRIMST-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-SYSKANRI
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           .
       960-KANRIMST-READ-EXT.
           EXIT.
      *
      *************************************************************
      *    ＰＵＴ　処理
      *************************************************************
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
