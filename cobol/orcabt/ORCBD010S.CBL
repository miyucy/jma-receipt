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
       PROGRAM-ID.             ORCBD010S.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 日次帳票
      *  コンポーネント名  : 収納日報
      *  管理者            : 
      *  作成日付    作業者        記述
      *  07/01/23    NACL-太田     新規作成
      *****************************************************************
      *  プログラム修正履歴
      *  Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    中間ファイル
           SELECT  BD01001-FILE   ASSIGN   BD01001PARA
                                  ORGANIZATION    IS  INDEXED
                                  ACCESS  MODE    IS  DYNAMIC
                                  RECORD  KEY     IS  BD01001-KEY
                                  FILE    STATUS  IS  STS-BD01001.
      *
           SELECT  BD01002-FILE   ASSIGN   BD01002PARA
                                  ORGANIZATION    IS  INDEXED
                                  ACCESS  MODE    IS  DYNAMIC
                                  RECORD  KEY     IS  BD01002-KEY
                                  FILE    STATUS  IS  STS-BD01002.
      *
           SELECT  BD01003-FILE   ASSIGN   BD01003PARA
                                  ORGANIZATION    IS  INDEXED
                                  ACCESS  MODE    IS  DYNAMIC
                                  RECORD  KEY     IS  BD01003-KEY
                                  FILE    STATUS  IS  STS-BD01003.
      *
           SELECT  BD01004-FILE   ASSIGN   BD01004PARA
                                  ORGANIZATION    IS  INDEXED
                                  ACCESS  MODE    IS  DYNAMIC
                                  RECORD  KEY     IS  BD01004-KEY
                                  FILE    STATUS  IS  STS-BD01004.
      *
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS IS  STS-RECEERR.
      *
       DATA                        DIVISION.
      *
       FILE                        SECTION.
      *
       FD  BD01001-FILE.
       01  BD01001-REC.
           COPY    "CPBD01001.INC".
      *
       FD  BD01002-FILE.
       01  BD01002-REC.
           COPY    "CPBD01002.INC".
      *
       FD  BD01003-FILE.
       01  BD01003-REC.
           COPY    "CPBD01003.INC".
      *
       FD  BD01004-FILE.
       01  BD01004-REC.
           COPY    "CPBD01004.INC".
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
       01  STS-AREA.
           03  STS-BD01001                 PIC X(02).
           03  STS-BD01002                 PIC X(02).
           03  STS-BD01003                 PIC X(02).
           03  STS-BD01004                 PIC X(02).
           03  STS-RECEERR                 PIC X(02).
      *
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING   //RECE01//
                                   BY          //BD01001//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING   //RECE01//
                                   BY          //BD01002//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING   //RECE01//
                                   BY          //BD01003//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING   //RECE01//
                                   BY          //BD01004//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING   //RECE01PARA//
                                   BY          //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
           COPY    "HCM51.INC".
           COPY    "HCM52.INC".
      *
       01  FLG-AREA.
           03  FLG-END                     PIC 9(01).
           03  FLG-SYUNOU                  PIC 9(01).
           03  FLG-SYUMEI                  PIC 9(01).
           03  FLG-SMEITMP                 PIC 9(01).
           03  FLG-SYURRK                  PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-BD01001                 PIC 9(01).
           03  FLG-BD01002                 PIC 9(01).
           03  FLG-BD01003                 PIC 9(01).
           03  FLG-BD01004                 PIC 9(01).
           03  FLG-HKNCOMBI                PIC 9(01).
           03  FLG-PTINF                   PIC 9(01).
           03  FLG-PTNUM                   PIC 9(01).
           03  FLG-TARGET                  PIC 9(01).
      *
       01  CNT-AREA.
           03  CNT-RENNUM                  PIC 9(05).
           03  CNT-PAGE                    PIC 9(05).
           03  CNT-LINE                    PIC 9(05).
           03  CNT-BD01002                 PIC 9(05).
           03  CNT-NO                      PIC 9(05).
      *
       01  IDX-AREA.
           03  IDX0                        PIC 9(05).
           03  IDX1                        PIC 9(05).
           03  IDX2                        PIC 9(05).
           03  IDX-SUM                     PIC 9(05).
           03  IDX-HOKEN                   PIC 9(05).
           03  IDX-JIHI                    PIC 9(05).
           03  IDX-SRH                     PIC 9(05).
           03  IDX-HOHO                    PIC 9(05).
      *
       01  WRK-AREA.
           03  WRK-RECEERR                 PIC X(200).
           03  WRK-SYSYMD                  PIC X(08).
           03  WRK-SYMD                    PIC X(10).
           03  WRK-EDTYMD1                 PIC X(10).
           03  WRK-EDTYMD3                 PIC X(22).
           03  WRK-STDAILYKEY.
               05  WRK-STDAILYKEY-YMD      PIC X(08).
               05  WRK-STDAILYKEY-TIME     PIC X(04).
           03  WRK-EDDAILYKEY.
               05  WRK-EDDAILYKEY-YMD      PIC X(08).
               05  WRK-EDDAILYKEY-TIME     PIC X(04).
           03  WRK-KANACHK-INPUT           PIC X(100).
           03  WRK-KANACHK-MAX             PIC 9(05).
           03  WRK-PRT-SAKYMD              PIC X(22).
           03  WRK-PRT-SRYYMD              PIC X(64).
           03  WRK-PRT-STYMD               PIC X(22).
           03  WRK-PRT-STTIME.
               05  WRK-PRT-STTIME-HH       PIC X(04).
               05  WRK-PRT-STTIME-MM       PIC X(04).
           03  WRK-PRT-EDYMD               PIC X(22).
           03  WRK-PRT-EDTIME.
               05  WRK-PRT-EDTIME-HH       PIC X(04).
               05  WRK-PRT-EDTIME-MM       PIC X(04).
           03  WRK-OUT-INPUT               PIC X(300).
           03  WRK-OUT-MAX                 PIC 9(05).
           03  WRK-HOKEN                   PIC 9(02).
           03  WRK-HKNNUM                  PIC X(03).
           03  WRK-HOJOKBN                 PIC X(01).
           03  WRK-HOKENMSG                PIC X(10).
           03  WRK-HKNTEN                  PIC S9(10).
           03  WRK-FTNMONEY                PIC S9(10).
           03  WRK-SKJMONEY                PIC S9(10).
           03  WRK-JIHIMONEY               PIC S9(10).
           03  WRK-HOHO                    PIC X(02).
           03  WRK-HKNCOMBINUM             PIC X(04).
           03  WRK-MISYU                   PIC S9(9).
           03  WRK-ZZ9                     PIC ZZ9.
           03  WRK-ZZZZ9                   PIC ZZZZ9.
           03  WRK-ZZZZZZZ9                PIC -------9.
           03  WRK-ZZZZZZZZ                PIC --------.
           03  WRK-CHOSEI                  PIC S9(9).
           03  WRK-9-X.
               05  WRK-9                   PIC 9(01).
           03  WRK-MIN-DENPEDANUM          PIC 9(02).
           03  WRK-SAGAKU                  PIC S9(9).
      *
       01  SUMSKY-AREA.
        02 SUMSKY-IDX                  PIC 9(05).
        02 SUMSKY-MAX                  PIC 9(05).
        02 SUMSKY-MAX-SRYKA            PIC X(02).
        02 SUMSKY-MAX-RRKNUM-G.
           03  SUMSKY-MAX-RRKNUM       PIC 9(9).
           03  SUMSKY-MAX-EDANUM       PIC 9(9).
        02 SUMSKY-TOTAL-SKYMONEY       PIC S9(09).
        02 SUMSKY-OCC                  OCCURS  100.
           COPY    "CPBD01001.INC"     REPLACING   //BD01001//
                                       BY          //SUMSKY//.
      *
       01  SUMNYUKIN-AREA.
        02 SUMNYUKIN-IDX               PIC 9(05).
        02 SUMNYUKIN-MAX               PIC 9(05).
        02 SUMNYUKIN-MIN-DENPEDANUM    PIC 9(02).
        02 SUMNYUKIN-TOTAL-NYUKIN      PIC S9(09).
        02 SUMNYUKIN-OCC               OCCURS  100.
           COPY    "CPBD01002.INC"     REPLACING   //BD01002//
                                       BY          //SUMNYUKIN//.
      *
       01  TTL-AREA.
           03  TTL-SYOSIN              PIC     S9(10).
           03  TTL-SAISIN              PIC     S9(10).
           03  TTL-HKNTEN              PIC     S9(10).
           03  TTL-SKYMONEY            PIC     S9(10).
           03  TTL-SKYHOKEN            PIC     S9(10).
           03  TTL-SKYJIHI             PIC     S9(10).
           03  TTL-NYUKIN              PIC     S9(10).
           03  TTL-CHOSEI              PIC     S9(10).
           03  TTL-GENMEN              PIC     S9(10).
           03  TTL-MISYU               PIC     S9(10).
      *
       01  KEY-AREA.
           03  KEY-NYUGAIKBN                   PIC X(01).
           03  KEY-DENPNUM                     PIC 9(07).
           03  KEY-SRYKA                       PIC X(02).
      *
       01  SRH-AREA.
           03  SRH-CD                          PIC X(08).
           03  SRH-IDX                         PIC 9(05).
           03  SRH-ITM-G.
               05  SRH-ITM                     PIC X(100).
               05  SRH-ITM2                    PIC X(100).
           03  SRH-1013-G.
               05  SRH-1013-OCC                OCCURS  2.
                   07  SRH-1013-JIHINAME       PIC X(10)
                                               OCCURS  10.
           03  SRH-1005-G.
               05  SRH-1005-MAX                PIC 9(05).
               05  SRH-1005-OCC                OCCURS  100.
                   07  SRH-1005-CD             PIC X(02).
                   07  SRH-1005-SRYKANAME1     PIC X(10).
                   07  SRH-1005-SRYKANAME3     PIC X(02).
      *
           03  SRH-1041-G.
               05  SRH-1041-MAX                PIC 9(05).
               05  SRH-1041-OCC                OCCURS  100.
                   07  SRH-1041-CD             PIC X(02).
                   07  SRH-1041-NYKN-TANNAME   PIC X(10).
      *
       01  CONST-AREA.
           03  CONST-H190401                   PIC X(08)
                                               VALUE "20070401".
           03  CONST-LINE-MAX                  PIC 9(05) VALUE 50.
           03  CONST-ETCJIHI-MAX               PIC 9(05) VALUE 10.
           03  CONST-1005-MAX                  PIC 9(05) VALUE 100.
           03  CONST-1041-MAX                  PIC 9(05) VALUE 100.
           03  CONST-HOHO-HENKIN               PIC X(02) VALUE "@1".
           03  CONST-HOHO-HENKINMSG            PIC X(10)
                                               VALUE "返金".
           03  CONST-HOHO-TORIKESI             PIC X(02) VALUE "@2".
           03  CONST-HOHO-TORIKESIMSG          PIC X(10)
                                               VALUE "入金取消".
           03  CONST-TEISEI                    PIC X(01) VALUE "8".
           03  CONST-HENKIN                    PIC X(01) VALUE "4".
           03  CONST-TORIKESI                  PIC X(02) VALUE "6".
           03  CONST-SEIKYU-VAL.
      *
               05  CONST-SYAHON                PIC 9(2)    VALUE 1.
               05  CONST-SYAHONMSG             PIC X(10)
                                               VALUE "社保本人".
      *
               05  CONST-SYAKZK                PIC 9(2)    VALUE 2.
               05  CONST-SYAKZKSMSG            PIC X(10)
                                               VALUE "社保家族".
      *
               05  CONST-SYARJN                PIC 9(2)    VALUE 3.
               05  CONST-SYARJNMSG             PIC X(10)
                                               VALUE "社保老人".
      *
               05  CONST-KOKIPN                PIC 9(2)    VALUE 4.
               05  CONST-KOKIPNMSG             PIC X(10)
                                               VALUE "国保一般".
      *
               05  CONST-KOKRJN                PIC 9(2)    VALUE 5.
               05  CONST-KOKRJNMSG             PIC X(10)
                                               VALUE "国保老人".
      *
               05  CONST-KOHTAN                PIC 9(2)    VALUE 6.
               05  CONST-KOHTANMSG             PIC X(10)
                                               VALUE "公費単独".
      *
               05  CONST-JIHHKN                PIC 9(2)    VALUE 7.
               05  CONST-JIHHKNMSG             PIC X(10)
                                               VALUE "自　費".
      *
               05  CONST-ROUSAI                PIC 9(2)    VALUE 8.
               05  CONST-ROUSAIMSG             PIC X(10)
                                               VALUE "労　災".
      *
               05  CONST-JIBAI                 PIC 9(2)    VALUE 9.
               05  CONST-JIBAIMSG              PIC X(10)
                                               VALUE "自賠責".
      *
               05  CONST-CHOSEI                PIC 9(2)    VALUE 10.
               05  CONST-CHOSEIMSG             PIC X(10)
                                               VALUE "調整金".
      *
               05  CONST-GENMEN                PIC 9(2)    VALUE 11.
               05  CONST-GENMENMSG             PIC X(10)
                                               VALUE "減免額".
           03  CONST-SEIKYU-R  REDEFINES   CONST-SEIKYU-VAL.
               05  CONST-SEIKYU-OCC            OCCURS 11.
                   07  CONST-SEIKYU            PIC 9(02).
                   07  CONST-SEIKYUMSG         PIC X(10).
      *
           03  CONST-SUMSKY-MAX            PIC 9(05)   VALUE 100.
           03  CONST-SUMNYUKIN-MAX         PIC 9(05)   VALUE 100.
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    診療科目情報情報
           COPY    "CPSK1005.INC".
      *
      *    自費名称
           COPY    "CPSK1013.INC".
      *
      *    締め時刻情報
           COPY    "CPSK3005.INC".
      *
      *    入金方法
           COPY    "CPSK1041.INC".
      *
      *    収納マスタ
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    収納明細マスタ
       01  SMEI-REC.
           COPY    "CPSYUMEI.INC".
      *
      *    収納明細マスタ(作業用）
       01  SMEITMP-REC.
           COPY    "CPSYUMEI.INC"  REPLACING   //SMEI-//
                                   BY          //SMEITMP-//.
      *
      *    収納履歴マスタ
       01  SYURRK-REC.
           COPY    "CPSYURRK.INC".
      *
      *    患者情報
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    患者番号
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    ジョブ管理
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    初再診取得サブ
           COPY "CPORCSS003.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
      *
      ****************************************************************
       LINKAGE                     SECTION.
      *
      *
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
      *
           COPY    "CPORCBD010S.INC".
      *
      ****************************************************************
       PROCEDURE                   DIVISION
                                   USING
                                   WRK-PARA
                                   SBD010-AREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           IF    ( FLG-END     =   ZERO )
               PERFORM 200-MAIN-SEC
           END-IF
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
           INITIALIZE                      STS-AREA
                                           IDX-AREA
                                           CNT-AREA
                                           FLG-AREA
                                           WRK-AREA
                                           SUMSKY-AREA
                                           SUMNYUKIN-AREA
                                           KEY-AREA
                                           SRH-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    SBD010-JOBID    TO  JOB-JOBID
           MOVE    SBD010-SHELLID  TO  JOB-SHELLID
           IF    ( SBD010-SIMEKBN      =   ZERO )
               MOVE    "ORCBD010"  TO  JOB-PGID
           ELSE
               MOVE    "ORCBD010V02"
                                   TO  JOB-PGID
           END-IF
           MOVE    "収納日報"      TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           MOVE    "BD01001"       TO  BD01001PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  BD01001PARA-TERMID
      *
           MOVE    "BD01002"       TO  BD01002PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  BD01002PARA-TERMID
      *
           MOVE    "BD01003"       TO  BD01003PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  BD01003PARA-TERMID
      *
           MOVE    "BD01004"       TO  BD01004PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  BD01004PARA-TERMID
      *
           MOVE    "RECEERR"       TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  RECEERR-TERMID
      *
      *
           MOVE    LNK-PRTKANRI-SKYYMD TO  WRK-SYSYMD
      *
           IF    ( SBD010-SIMEKBN      =   ZERO )
      *
               MOVE    SBD010-SRYYMD   TO  WRK-STDAILYKEY-YMD
                                           WRK-EDDAILYKEY-YMD
               MOVE     ZERO           TO  WRK-STDAILYKEY-TIME
               MOVE     ALL "9"        TO  WRK-EDDAILYKEY-TIME
      *
               MOVE    SBD010-SRYYMD       TO  WRK-SYMD
               PERFORM 800-SEIWA-HEN-SEC
               MOVE    WRK-EDTYMD3         TO  WRK-PRT-SRYYMD
           ELSE
      *
               INITIALIZE                  SYS-3005-REC
               MOVE    "3005"          TO  SYS-3005-KANRICD
               MOVE    "*"             TO  SYS-3005-KBNCD
               MOVE    WRK-SYSYMD      TO  SYS-3005-STYUKYMD
                                           SYS-3005-EDYUKYMD
               MOVE    SYS-3005-REC    TO  SYSKANRI-REC
               PERFORM 900-SYSKANRI-KEY10-SEL-SEC
               IF    ( FLG-SYSKANRI    =   ZERO )
                   MOVE    SYSKANRI-REC        TO  SYS-3005-REC
                   MOVE    SYS-3005-STSRYYMD   TO  WRK-STDAILYKEY-YMD
                   MOVE    SYS-3005-STTIME     TO  WRK-STDAILYKEY-TIME
                   MOVE    SYS-3005-EDSRYYMD   TO  WRK-EDDAILYKEY-YMD
                   MOVE    SYS-3005-EDTIME     TO  WRK-EDDAILYKEY-TIME
      *
                   MOVE    WRK-STDAILYKEY-YMD  TO  WRK-SYMD
                   PERFORM 800-SEIWA-HEN-SEC
                   MOVE    WRK-EDTYMD3         TO  WRK-PRT-STYMD
      *
                   MOVE    WRK-STDAILYKEY-TIME TO  WRK-KANACHK-INPUT
                   PERFORM 800-ZENKAKU-HEN-SEC
                   MOVE    WRK-KANACHK-INPUT   TO  WRK-PRT-STTIME
      *
                   MOVE    WRK-EDDAILYKEY-YMD  TO  WRK-SYMD
                   PERFORM 800-SEIWA-HEN-SEC
                   MOVE    WRK-EDTYMD3 (11:)   TO  WRK-PRT-EDYMD
      *
                   MOVE    WRK-EDDAILYKEY-TIME TO  WRK-KANACHK-INPUT
                   PERFORM 800-ZENKAKU-HEN-SEC
                   MOVE    WRK-KANACHK-INPUT   TO  WRK-PRT-EDTIME
      *
                   MOVE    SPACE               TO  WRK-PRT-SRYYMD
                   IF    ( WRK-STDAILYKEY-YMD  =   WRK-EDDAILYKEY-YMD )
                       STRING   WRK-PRT-STYMD      DELIMITED   BY  SIZE
                                WRK-PRT-STTIME-HH  DELIMITED   BY  SIZE
                                "："               DELIMITED   BY  SIZE
                                WRK-PRT-STTIME-MM  DELIMITED   BY  SIZE
                                "〜"               DELIMITED   BY  SIZE
                                WRK-PRT-EDTIME-HH  DELIMITED   BY  SIZE
                                "："               DELIMITED   BY  SIZE
                                WRK-PRT-EDTIME-MM  DELIMITED   BY  SIZE
                       INTO   WRK-PRT-SRYYMD
                       END-STRING
                   ELSE
                       STRING   WRK-PRT-STYMD      DELIMITED   BY  SIZE
                                WRK-PRT-STTIME-HH  DELIMITED   BY  SIZE
                                "："               DELIMITED   BY  SIZE
                                WRK-PRT-STTIME-MM  DELIMITED   BY  SIZE
                                "〜"               DELIMITED   BY  SIZE
                                WRK-PRT-EDYMD      DELIMITED   BY  SPACE
                                WRK-PRT-EDTIME-HH  DELIMITED   BY  SIZE
                                "："               DELIMITED   BY  SIZE
                                WRK-PRT-EDTIME-MM  DELIMITED   BY  SIZE
                       INTO   WRK-PRT-SRYYMD
                       END-STRING
                   END-IF
      *
               ELSE
                   MOVE    "締め処理にて対象期間を登録してください"
                                       TO  WRK-RECEERR
                   PERFORM 500-ERR-HENSYU-SEC
               END-IF
           END-IF
      *
      *
           MOVE    WRK-SYSYMD          TO  WRK-SYMD
           PERFORM 800-SEIWA-HEN-SEC
           MOVE    WRK-EDTYMD3         TO  WRK-PRT-SAKYMD
      *
           IF    ( SBD010-NYUGAIKBN    =   "1" OR "2" )
               CONTINUE
           ELSE
               MOVE    "0"             TO  SBD010-NYUGAIKBN
           END-IF
      *
           IF    ( SBD010-SUMKBN       =   "1" )
               CONTINUE
           ELSE
               MOVE    "0"             TO  SBD010-SUMKBN
           END-IF
      *
           IF    ( SBD010-MEISAIKBN    =   "1" )
               CONTINUE
           ELSE
               MOVE    "0"             TO  SBD010-MEISAIKBN
           END-IF
      *
           IF    ( SBD010-TOTALPRTKBN  =   "1" )
               CONTINUE
           ELSE
               MOVE    "0"             TO  SBD010-TOTALPRTKBN
           END-IF
      *
           PERFORM 1001-SET-SRH-1005-SEC
      *
           PERFORM 1001-SET-SRH-1041-SEC
      *
           PERFORM 1001-SET-SRH-1013-SEC
      *
      *    初診／再診判定サブ初期処理
           INITIALIZE                      SS003-AREA
           MOVE    ZERO            TO      SS003-SYORIKBN
           CALL    "ORCSS003"      USING   SS003-AREA
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科退避処理
      *****************************************************************
       1001-SET-SRH-1005-SEC       SECTION.
      *
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1005"              TO  SYS-KANRICD
           MOVE    WRK-STDAILYKEY-YMD  TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-1005-REC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    NOT =   ZERO )
                     OR  ( SRH-1005-MAX       >=   CONST-1005-MAX )
      *
               COMPUTE SRH-1005-MAX    =   SRH-1005-MAX  + 1
               MOVE    SYS-1005-KBNCD  TO  SRH-1005-CD (SRH-1005-MAX)
               MOVE    SYS-1005-SRYKANAME1
                                       TO  SRH-1005-SRYKANAME1
                                                       (SRH-1005-MAX)
               MOVE    SYS-1005-SRYKANAME3
                                       TO  SRH-1005-SRYKANAME3
                                                       (SRH-1005-MAX)
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
               MOVE    SYSKANRI-REC    TO  SYS-1005-REC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       1001-SET-SRH-1005-EXT.
           EXIT.
      *****************************************************************
      *    入金方法退避処理
      *****************************************************************
       1001-SET-SRH-1041-SEC       SECTION.
      *
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1041"              TO  SYS-KANRICD
           MOVE    WRK-STDAILYKEY-YMD  TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-1041-REC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    NOT =   ZERO )
                     OR  ( SRH-1041-MAX       >=   CONST-1041-MAX )
      *
               COMPUTE SRH-1041-MAX    =   SRH-1041-MAX  + 1
               MOVE    SYS-1041-KBNCD  TO  SRH-1041-CD (SRH-1041-MAX)
               MOVE    SYS-1041-NYKN-TANNAME
                                           TO  WRK-KANACHK-INPUT
               PERFORM 800-ZENKAKU-HEN-SEC
               MOVE    WRK-KANACHK-INPUT   TO  SRH-1041-NYKN-TANNAME
                                                       (SRH-1041-MAX)
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
               MOVE    SYSKANRI-REC    TO  SYS-1041-REC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       1001-SET-SRH-1041-EXT.
           EXIT.
      *****************************************************************
      *    自費名称退避処理
      *****************************************************************
       1001-SET-SRH-1013-SEC       SECTION.
      *
           INITIALIZE                      SYSKANRI-REC
           MOVE    "1013"              TO  SYS-KANRICD
           MOVE    WRK-STDAILYKEY-YMD  TO  SYS-STYUKYMD
                                           SYS-EDYUKYMD
           PERFORM 900-SYSKANRI-KEY2-SEL-SEC
           MOVE    SYSKANRI-REC    TO  SYS-1013-REC
      *
           PERFORM UNTIL ( FLG-SYSKANRI    NOT =   ZERO )
      *
               MOVE    ZERO        TO  IDX1
                                       IDX2
      *
               IF    ( SYS-1013-KBNCD(1:1)  =   "1" )
                   MOVE    1       TO  IDX1
               END-IF
               IF    ( SYS-1013-KBNCD(1:1)  =   "2" )
                   MOVE    2       TO  IDX1
               END-IF
      *
               EVALUATE    SYS-1013-KBNCD(2:1)
               WHEN    "0"
                   MOVE    10                  TO  IDX2
               WHEN    "1"     THRU    "9"
                   MOVE    SYS-1013-KBNCD(2:1) TO  WRK-9-X
                   MOVE    WRK-9               TO  IDX2
               END-EVALUATE
      *
               IF    ( IDX1        >   ZERO )
                AND  ( IDX2        >   ZERO )
                   MOVE    SYS-1013-JIHINAME   TO  SRH-1013-JIHINAME
                                                             (IDX1 IDX2)
               END-IF
      *
               PERFORM 900-SYSKANRI-KEY2-FET-SEC
               MOVE    SYSKANRI-REC    TO  SYS-1013-REC
      *
           END-PERFORM
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       1001-SET-SRH-1013-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           PERFORM 2001-EDIT-SYUNOU-SEC
      *
           PERFORM 2001-EDIT-BD004-SEC
      *
           PERFORM 2001-EDIT-FORM-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納情報編集処理
      *****************************************************************
       2001-EDIT-SYUNOU-SEC        SECTION.
      *
           OPEN    OUTPUT          BD01001-FILE
                                   BD01002-FILE
      *
           OPEN    OUTPUT          BD01003-FILE
           CLOSE   BD01003-FILE
      *
           OPEN    I-O             BD01003-FILE
      *
           PERFORM 900-SYUMEI-KEY8-SEL-SEC
      *
           PERFORM UNTIL ( FLG-SYUMEI  NOT =   ZERO )
      *
               MOVE    SMEI-NYUGAIKBN  TO  KEY-NYUGAIKBN
               MOVE    SMEI-DENPNUM    TO  KEY-DENPNUM
               INITIALIZE                  SUMSKY-AREA
                                           SUMNYUKIN-AREA
                                           WRK-MIN-DENPEDANUM
      *
               PERFORM 900-SYUNOU-KEY-SEL-SEC
      *
               PERFORM 900-PTINF-KEY-SEL-SEC
      *
               PERFORM 900-PTNUM-KEY-SEL-SEC
      *
               PERFORM UNTIL ( FLG-SYUMEI      NOT =   ZERO )
                        OR   ( KEY-NYUGAIKBN   NOT =   SMEI-NYUGAIKBN )
                        OR   ( KEY-DENPNUM     NOT =   SMEI-DENPNUM )
      *
                   IF    ( PTINF-TSTPTNUMKBN   NOT =   "1" )
                       PERFORM 20011-EDIT-SYUNOU-SEC
                   END-IF
      *
                   PERFORM 900-SYUMEI-KEY8-FET-SEC
      *
               END-PERFORM
      *
               IF    ( SUMSKY-MAX      >   ZERO )
      *
                   PERFORM 20011-WRITE-BD01001-SEC
               ELSE
                   IF    ( SUMNYUKIN-MAX   >   ZERO )
                       PERFORM 20012-WRITE-BD01001-SEC
                   END-IF
               END-IF
      *
               PERFORM 20011-WRITE-BD01002-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_syumei"    TO  MCP-TABLE
           MOVE    "key8"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
      *
           CLOSE   BD01001-FILE
                   BD01002-FILE
                   BD01003-FILE
      *
           .
       2001-EDIT-SYUNOU-EXT.
           EXIT.
      *****************************************************************
      *    収納情報編集処理
      *****************************************************************
       20011-EDIT-SYUNOU-SEC       SECTION.
      *
           IF    ( SMEI-SYURRKNUM  NOT =   ZERO )
               PERFORM 200111-EDIT-SUMSKY-SEC
           END-IF
      *
           IF    ( SMEI-NYUHEN-MONEY   NOT =   ZERO )
               PERFORM 200111-EDIT-SUMNYUKIN-SEC
           END-IF
      *
           IF    ( WRK-MIN-DENPEDANUM  =   ZERO )
            OR   ( WRK-MIN-DENPEDANUM  >   SMEI-DENPEDANUM )
               MOVE    SMEI-DENPEDANUM TO  WRK-MIN-DENPEDANUM
           END-IF
      *
           .
       20011-EDIT-SYUNOU-EXT.
           EXIT.
      *****************************************************************
      *    請求情報編集処理
      *****************************************************************
       200111-EDIT-SUMSKY-SEC      SECTION.
      *
           PERFORM 900-SYURRK-KEY3-SEL-SEC
      *
           PERFORM UNTIL ( FLG-SYURRK  NOT =   ZERO )
      *
               MOVE    SYURRK-HKNCOMBINUM
                                   TO  WRK-HKNCOMBINUM
               PERFORM 2001111-EDIT-HOKEN-SEC
               IF    ( WRK-HOKEN   >   ZERO )
                   PERFORM 2001111-EDIT-SUMSKY-SEC
               END-IF
      *
               PERFORM 900-SYURRK-KEY3-FET-SEC
      *
           END-PERFORM
      *
           MOVE    "tbl_syurrk"    TO  MCP-TABLE
           MOVE    "key3"          TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       200111-EDIT-SUMSKY-EXT.
           EXIT.
      *****************************************************************
      *    請求情報編集処理
      *****************************************************************
       2001111-EDIT-SUMSKY-SEC     SECTION.
      *
           MOVE    ZERO            TO  SUMSKY-IDX
           PERFORM VARYING IDX-SUM FROM    1   BY  1
                   UNTIL ( IDX-SUM     >   SUMSKY-MAX )
                    OR   ( SUMSKY-IDX  >   ZERO )
      *
               IF    ( SUMSKY-SRYKA (IDX-SUM)
                                   =   SYURRK-SRYKA )
                AND  ( SUMSKY-HOKEN (IDX-SUM)
                                   =   WRK-HOKEN )
                   MOVE    IDX-SUM TO  SUMSKY-IDX
               END-IF
      *
           END-PERFORM
      *
           IF    ( SUMSKY-IDX      =   ZERO )
               IF    ( SUMSKY-MAX >=   CONST-SUMSKY-MAX )
                   CONTINUE
               ELSE
                   COMPUTE SUMSKY-MAX  =   SUMSKY-MAX  +   1
                   MOVE    SUMSKY-MAX  TO  SUMSKY-IDX
                   MOVE    SYURRK-NYUGAIKBN TO SUMSKY-SRT-NYUGAIKBN
                                                            (SUMSKY-IDX)
                   IF    ( SBD010-SUMKBN   =   ZERO )
                       MOVE    "00"        TO  SUMSKY-SRT-SRYKA
                                                            (SUMSKY-IDX)
                   ELSE
                       MOVE    SYURRK-SRYKA
                                           TO  SUMSKY-SRT-SRYKA
                                                            (SUMSKY-IDX)
                   END-IF
                   MOVE    SYURRK-DENPNUM  TO  SUMSKY-DENPNUM
                                                            (SUMSKY-IDX)
                   MOVE    SYURRK-SYURRKNUM TO SUMSKY-SYURRKNUM
                                                            (SUMSKY-IDX)
                   MOVE    SYURRK-SYUEDANUM TO SUMSKY-SYUEDANUM
                                                            (SUMSKY-IDX)
                   MOVE    PTNUM-PTNUM     TO SUMSKY-PTNUM
                                                            (SUMSKY-IDX)
                   MOVE    PTINF-NAME      TO SUMSKY-NAME
                                                            (SUMSKY-IDX)
                   MOVE    SYU-SRYYMD      TO SUMSKY-SRYYMD (SUMSKY-IDX)
                   MOVE    SYU-DENPPRTYMD  TO SUMSKY-DENPPRTYMD
                                                            (SUMSKY-IDX)
                   MOVE    WRK-HOKEN       TO SUMSKY-HOKEN  (SUMSKY-IDX)
                   MOVE    SYURRK-SRYKA    TO SUMSKY-SRYKA  (SUMSKY-IDX)
               END-IF
           END-IF
      *
           IF    ( SUMSKY-IDX      NOT =   ZERO )
               MOVE    ZERO            TO  WRK-HKNTEN
                                           WRK-FTNMONEY
                                           WRK-SKJMONEY
                                           WRK-JIHIMONEY
      *
               IF    ( WRK-HKNNUM (1:2)    =   "98" )
      *
                   COMPUTE WRK-JIHIMONEY
                       =   SYURRK-HKNTEKMONEY
                       +   SYURRK-RJN-FTN
                       +   SYURRK-KOH-FTN
                       +   SYURRK-RSI-TOTAL
      *
                       +   SYURRK-SKYMONEY-SKJ-KEI
                       +   SYURRK-SKYMONEY-LIFE-KEI
      *
                       +   SYURRK-RMSAGAKU
                       +   SYURRK-SKYMONEY-SKJ-JIHI-KEI
                       +   SYURRK-SKYMONEY-LIFE-JIHI-KEI
                       +   SYURRK-TOTAL-TGMONEY
                       +   SYURRK-TOTAL-TGMONEY-TAX
                       +   SYURRK-JIHI-TOTAL
                       +   SYURRK-JIHI-TOTAL-TAX
      *
                   IF    ( SYU-SRYYMD  <   CONST-H190401 )
                       COMPUTE WRK-JIHIMONEY
                           =   WRK-JIHIMONEY
                       +   SYURRK-JIHI-TAX
                       IF    ( WRK-HOJOKBN     =   "1" )
                           COMPUTE WRK-JIHIMONEY
                               =   WRK-JIHIMONEY
      *                        +   SYURRK-SKYMONEY-TAX-SAI
                       END-IF
                   END-IF
               ELSE
                   COMPUTE WRK-HKNTEN  =   SYURRK-TOTAL-HKNTEN
      *
                   COMPUTE WRK-FTNMONEY =  SYURRK-HKNTEKMONEY
                                       +   SYURRK-RJN-FTN
                                       +   SYURRK-KOH-FTN
                                       +   SYURRK-RSI-TOTAL
      *
                   COMPUTE WRK-SKJMONEY =  SYURRK-SKYMONEY-SKJ-KEI
                                       +   SYURRK-SKYMONEY-LIFE-KEI
      *
                   COMPUTE WRK-JIHIMONEY = SYURRK-RMSAGAKU
                                       +   SYURRK-SKYMONEY-SKJ-JIHI-KEI
                                       +   SYURRK-SKYMONEY-LIFE-JIHI-KEI
                                       +   SYURRK-TOTAL-TGMONEY
                                       +   SYURRK-TOTAL-TGMONEY-TAX
                                       +   SYURRK-JIHI-TOTAL
                                       +   SYURRK-JIHI-TOTAL-TAX
                   IF    ( SYU-SRYYMD  <   CONST-H190401 )
                       COMPUTE WRK-JIHIMONEY   =   WRK-JIHIMONEY
                                               +   SYURRK-JIHI-TAX
                   END-IF
               END-IF
      *
               COMPUTE SUMSKY-HOKENTEN  (SUMSKY-IDX)
                   =   SUMSKY-HOKENTEN  (SUMSKY-IDX)
                   +   WRK-HKNTEN
      *
               COMPUTE SUMSKY-SKYMONEY  (SUMSKY-IDX)
                   =   SUMSKY-SKYMONEY  (SUMSKY-IDX)
                   +   SYURRK-SKYMONEY
      *
               COMPUTE SUMSKY-FTNMONEY  (SUMSKY-IDX)
                   =   SUMSKY-FTNMONEY  (SUMSKY-IDX)
                   +   WRK-FTNMONEY
                   +   WRK-SKJMONEY
      *
               COMPUTE SUMSKY-JIHIMONEY (SUMSKY-IDX)
                   =   SUMSKY-JIHIMONEY (SUMSKY-IDX)
                   +   WRK-JIHIMONEY
      *
               COMPUTE SUMSKY-CHOSEI (SUMSKY-IDX)
                   =   SUMSKY-CHOSEI (SUMSKY-IDX)
                   +   SYURRK-CHOSEI
      *
               COMPUTE SUMSKY-GENMEN (SUMSKY-IDX)
                   =   SUMSKY-GENMEN (SUMSKY-IDX)
                   +   SYURRK-DISCOUNT-MONEY
      *
               COMPUTE WRK-SAGAKU
                   =   SYURRK-SKYMONEY
                   - ( WRK-FTNMONEY
                   +   WRK-SKJMONEY
                   +   WRK-JIHIMONEY
                   +   SYURRK-CHOSEI
                   +   SYURRK-DISCOUNT-MONEY )
      *
               IF    ( WRK-SAGAKU      NOT =   ZERO )
                   EVALUATE    TRUE
                   WHEN    ( SYURRK-DISCOUNT-MONEY     NOT =   ZERO )
                       COMPUTE SUMSKY-GENMEN (SUMSKY-IDX)
                           =   SUMSKY-GENMEN (SUMSKY-IDX)
                           +   WRK-SAGAKU
                   WHEN    ( SYURRK-CHOSEI             NOT =   ZERO )
                       COMPUTE SUMSKY-CHOSEI (SUMSKY-IDX)
                           =   SUMSKY-CHOSEI (SUMSKY-IDX)
                           +   WRK-SAGAKU
                   WHEN    ( WRK-JIHIMONEY             NOT =   ZERO )
                       COMPUTE SUMSKY-JIHIMONEY (SUMSKY-IDX)
                           =   SUMSKY-JIHIMONEY (SUMSKY-IDX)
                           +   WRK-SAGAKU
                   WHEN    OTHER
                       COMPUTE SUMSKY-FTNMONEY  (SUMSKY-IDX)
                           =   SUMSKY-FTNMONEY  (SUMSKY-IDX)
                           +   WRK-SAGAKU
                   END-EVALUATE
               END-IF
      *
               PERFORM VARYING IDX-JIHI    FROM    1   BY  1
                       UNTIL ( IDX-JIHI    >   CONST-ETCJIHI-MAX )
      *
                   COMPUTE SUMSKY-ETCJIHI (SUMSKY-IDX IDX-JIHI)
                       =   SYURRK-JIHI-TAXNASI (IDX-JIHI)
                       +   SYURRK-JIHI-TAXARI  (IDX-JIHI)
      *
               END-PERFORM
      *
               IF    ( SUMSKY-SYURRKNUM (SUMSKY-IDX)
                                       <   SYURRK-SYURRKNUM )
                AND  ( SUMSKY-SYUEDANUM (SUMSKY-IDX)
                                       <   SYURRK-SYUEDANUM )
                   MOVE    SYURRK-SYURRKNUM
                                   TO  SUMSKY-SYURRKNUM (SUMSKY-IDX)
                   MOVE    SYURRK-SYUEDANUM
                                   TO  SUMSKY-SYUEDANUM (SUMSKY-IDX)
               END-IF
      *
               IF    ( SUMSKY-MAX-RRKNUM
                                       <   SYURRK-SYURRKNUM )
                AND  ( SUMSKY-MAX-EDANUM
                                       <   SYURRK-SYUEDANUM )
                   MOVE    SYURRK-SRYKA
                                   TO  SUMSKY-MAX-SRYKA
                   MOVE    SYURRK-SYURRKNUM
                                   TO  SUMSKY-MAX-RRKNUM
                   MOVE    SYURRK-SYUEDANUM
                                   TO  SUMSKY-MAX-EDANUM
               END-IF
      *
               COMPUTE SUMSKY-TOTAL-SKYMONEY
                   =   SUMSKY-TOTAL-SKYMONEY
                   +   SYURRK-SKYMONEY
      *
           END-IF
      *
           .
       2001111-EDIT-SUMSKY-EXT.
           EXIT.
      *****************************************************************
      *    保険編集処理
      *****************************************************************
       2001111-EDIT-HOKEN-SEC      SECTION.
      *
           MOVE    ZERO            TO  WRK-HOKEN
           MOVE    SPACE           TO  WRK-HKNNUM
                                       WRK-HOJOKBN
      *
           PERFORM 900-HKNCOMBI-KEY-SEL-SEC
           IF    ( FLG-HKNCOMBI    =   ZERO )
      *
               MOVE    COMB-HKNNUM  TO  WRK-HKNNUM
               MOVE    COMB-HOJOKBN TO WRK-HOJOKBN
      *
               EVALUATE    COMB-HKNNUM
               WHEN    SPACE
                   MOVE    CONST-KOHTAN    TO  WRK-HOKEN
               WHEN    "973"
                   MOVE    CONST-JIBAI     TO  WRK-HOKEN
               WHEN    "971"
                   MOVE    CONST-ROUSAI    TO  WRK-HOKEN
               WHEN    "060"
               WHEN    "067"
               WHEN    "068"
               WHEN    "069"
                   IF    ( SYU-KOH1HKNNUM      =   "027" )
                       MOVE    CONST-KOKRJN TO WRK-HOKEN
                   ELSE
                       MOVE    CONST-KOKIPN TO WRK-HOKEN
                   END-IF
               WHEN    OTHER
                   IF    ( COMB-HKNNUM (1:2)   =   "98" )
                       MOVE    CONST-JIHHKN TO WRK-HOKEN
                   ELSE
                       IF    ( COMB-KOH1HKNNUM =   "027" )
                           MOVE    CONST-SYARJN TO WRK-HOKEN
                       ELSE
                           EVALUATE    COMB-HONKZKKBN
                           WHEN    "1"
                               MOVE    CONST-SYAHON
                                               TO  WRK-HOKEN
                           WHEN    "2"
                               MOVE    CONST-SYAKZK
                                               TO  WRK-HOKEN
                           END-EVALUATE
                       END-IF
                   END-IF
               END-EVALUATE
           END-IF
      *
           .
       2001111-EDIT-HOKEN-EXT.
           EXIT.
      *****************************************************************
      *    入金情報集計処理
      *****************************************************************
       200111-EDIT-SUMNYUKIN-SEC   SECTION.
      *
           MOVE    SPACE               TO  WRK-HOHO
           EVALUATE    SMEI-JOUTAIKBN
           WHEN    CONST-TEISEI
               IF    ( SMEI-NYUHEN-MONEY   <   ZERO )
                   MOVE    CONST-HOHO-HENKIN
                                       TO  WRK-HOHO
               ELSE
                   MOVE    SMEI-NYUKIN-HOHO
                                       TO  WRK-HOHO
               END-IF
           WHEN    CONST-HENKIN
               MOVE    CONST-HOHO-HENKIN
                                       TO  WRK-HOHO
           WHEN    CONST-TORIKESI
               MOVE    CONST-HOHO-TORIKESI
                                       TO  WRK-HOHO
           WHEN    OTHER
               MOVE    SMEI-NYUKIN-HOHO    TO  WRK-HOHO
           END-EVALUATE
      *
           MOVE    ZERO            TO  SUMNYUKIN-IDX
           PERFORM VARYING IDX-SUM FROM    1   BY  1
                   UNTIL ( IDX-SUM     >   SUMNYUKIN-MAX )
                    OR   ( SUMNYUKIN-IDX  >   ZERO )
      *
               IF    ( SUMNYUKIN-HOHO (IDX-SUM)
                                   =   WRK-HOHO )
                   MOVE    IDX-SUM TO  SUMNYUKIN-IDX
               END-IF
      *
           END-PERFORM
      *
           IF    ( SUMNYUKIN-IDX      =   ZERO )
               IF    ( SUMNYUKIN-MAX >=   CONST-SUMNYUKIN-MAX )
                   CONTINUE
               ELSE
                   COMPUTE SUMNYUKIN-MAX   =   SUMNYUKIN-MAX  +   1
                   MOVE    SUMNYUKIN-MAX   TO  SUMNYUKIN-IDX
                   MOVE    SMEI-DENPNUM    TO  SUMNYUKIN-DENPNUM
                                                     (SUMNYUKIN-IDX)
                   MOVE    SMEI-DENPEDANUM TO  SUMNYUKIN-DENPEDANUM
                                                     (SUMNYUKIN-IDX)
                   MOVE    WRK-HOHO        TO  SUMNYUKIN-HOHO
                                                     (SUMNYUKIN-IDX)
               END-IF
           END-IF
      *
           IF    ( SUMNYUKIN-IDX       NOT =   ZERO )
               COMPUTE SUMNYUKIN-NYUKIN (SUMNYUKIN-IDX)
                   =   SUMNYUKIN-NYUKIN (SUMNYUKIN-IDX)
                   +   SMEI-NYUHEN-MONEY
      *
               IF    ( SUMNYUKIN-DENPEDANUM (SUMNYUKIN-IDX)
                                       >   SMEI-DENPEDANUM )
                   MOVE    SMEI-DENPEDANUM
                                           TO  SUMNYUKIN-DENPEDANUM
                                                     (SUMNYUKIN-IDX)
               END-IF
      *
               IF    ( SUMNYUKIN-MIN-DENPEDANUM
                                           =   ZERO )
                OR   ( SUMNYUKIN-MIN-DENPEDANUM
                                           >   SMEI-DENPEDANUM )
                   MOVE    SMEI-DENPEDANUM TO  SUMNYUKIN-MIN-DENPEDANUM
               END-IF
      *
               COMPUTE SUMNYUKIN-TOTAL-NYUKIN
                   =   SUMNYUKIN-TOTAL-NYUKIN
                   +   SMEI-NYUHEN-MONEY
      *
           END-IF
      *
           .
       200111-EDIT-SUMNYUKIN-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイル出力処理
      *****************************************************************
       20011-WRITE-BD01001-SEC     SECTION.
      *
           IF    ( SBD010-MEISAIKBN    =   ZERO )
               PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   SUMSKY-MAX )
      *
                   MOVE    SUMSKY-OCC (IDX0)
                                   TO  BD01001-REC
      *
                   MOVE    SUMSKY-MAX-RRKNUM-G
                                   TO  BD01001-MAX-SYURRKNUM-G
      *
                   IF    ( BD01001-SYURRKNUM-G
                                       =   BD01001-MAX-SYURRKNUM-G )
                    AND  ( BD01001-SYUEDANUM
                                       =   BD01001-MAX-SYUEDANUM )
      *
                       PERFORM 200111-EDIT-MISYU-SEC
                       MOVE    WRK-MISYU   TO  BD01001-MISYU
      *
                       IF    ( BD01001-SRT-NYUGAIKBN       =   "1" )
                           IF    ( SYU-CREATEKBN   =   "1" )
                               MOVE    "3" TO  BD01001-SYOSAIKBN
                           ELSE
                               MOVE    "4" TO  BD01001-SYOSAIKBN
                           END-IF
                       ELSE
                           IF    ( WRK-MIN-DENPEDANUM      =   1 )
                            AND  ( SYU-SRYYMD  =  WRK-EDDAILYKEY-YMD )
                               PERFORM 800-CALL-ORCSS003-SEC
                               MOVE    SS003-SYOSAISIN-KBN
                                           TO  BD01001-SYOSAIKBN
                            END-IF
                       END-IF
                   END-IF
                   MOVE    ZERO           TO  BD01001-SKYNYUKBN
      *
                   PERFORM 20011-WRITE-BD01003-SEC
      *
                   WRITE   BD01001-REC
      *
               END-PERFORM
      *
           ELSE
      *
               INITIALIZE              BD01001-REC
      *
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >   SUMSKY-MAX )
      *
                   IF    ( IDX0    =   1 )
                       MOVE    SUMSKY-OCC (IDX0)
                                   TO  BD01001-REC
      *
                       MOVE    SUMSKY-MAX-RRKNUM-G
                                   TO  BD01001-MAX-SYURRKNUM-G
                   ELSE
      *
                       COMPUTE BD01001-HOKENTEN
                           =   BD01001-HOKENTEN
                           +   SUMSKY-HOKENTEN (IDX0)
      *
                       COMPUTE BD01001-SKYMONEY
                           =   BD01001-SKYMONEY
                           +   SUMSKY-SKYMONEY (IDX0)
      *
                       COMPUTE BD01001-FTNMONEY
                           =   BD01001-FTNMONEY
                           +   SUMSKY-FTNMONEY (IDX0)
      *
                       COMPUTE BD01001-JIHIMONEY
                           =   BD01001-JIHIMONEY
                           +   SUMSKY-JIHIMONEY(IDX0)
      *
                       COMPUTE BD01001-CHOSEI
                           =   BD01001-CHOSEI
                           +   SUMSKY-CHOSEI   (IDX0)
      *
                       COMPUTE BD01001-GENMEN
                           =   BD01001-GENMEN
                           +   SUMSKY-GENMEN   (IDX0)
      *
                       PERFORM VARYING IDX-JIHI    FROM    1   BY  1
                           UNTIL ( IDX-JIHI    >   CONST-ETCJIHI-MAX )
      *
                           COMPUTE BD01001-ETCJIHI (IDX-JIHI)
                               =   BD01001-ETCJIHI (IDX-JIHI)
                               +   SUMSKY-ETCJIHI  (IDX0 IDX-JIHI)
      *
                       END-PERFORM
      *
                       IF    ( BD01001-SYURRKNUM-G
                                       <   SUMSKY-SYURRKNUM-G (IDX0) )
                           MOVE    SUMSKY-SYURRKNUM-G (IDX0)
                                       TO  BD01001-SYURRKNUM-G
                           MOVE    SUMSKY-HOKEN (IDX0)
                                       TO  BD01001-HOKEN
                           MOVE    SUMSKY-SRT-SRYKA (IDX0)
                                       TO  BD01001-SRT-SRYKA
                           MOVE    SUMSKY-SRYKA (IDX0)
                                       TO  BD01001-SRYKA
                       END-IF
                   END-IF
      *
               END-PERFORM
      *
               IF    ( BD01001-SRT-NYUGAIKBN       =   "1" )
                   IF    ( SYU-CREATEKBN   =   "1" )
                       MOVE    "3" TO  BD01001-SYOSAIKBN
                   ELSE
                       MOVE    "4" TO  BD01001-SYOSAIKBN
                   END-IF
               ELSE
                   IF    ( WRK-MIN-DENPEDANUM      =   1 )
                    AND  ( SYU-SRYYMD  =  WRK-EDDAILYKEY-YMD )
                       PERFORM 800-CALL-ORCSS003-SEC
                       MOVE    SS003-SYOSAISIN-KBN
                                   TO  BD01001-SYOSAIKBN
                    END-IF
               END-IF
               MOVE    ZERO        TO  BD01001-SKYNYUKBN
      *
               PERFORM 200111-EDIT-MISYU-SEC
               MOVE    WRK-MISYU   TO  BD01001-MISYU
      *
               PERFORM 20011-WRITE-BD01003-SEC
      *
               WRITE   BD01001-REC
      *
           END-IF
      *
           .
       20011-WRITE-BD01001-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイル出力処理
      *****************************************************************
       200111-EDIT-MISYU-SEC       SECTION.
      *
           INITIALIZE              WRK-MISYU
           PERFORM 900-SMEITMP-KEY16-SEL-SEC
           COMPUTE WRK-MISYU
               =   SUMSKY-TOTAL-SKYMONEY
               +   SMEITMP-SKYMONEY
               -   SUMNYUKIN-TOTAL-NYUKIN
               -   SMEITMP-NYUHEN-MONEY
      *
           .
       200111-EDIT-MISYU-EXT.
           EXIT.
           .
      *****************************************************************
      *    中間ファイル出力処理
      *****************************************************************
       20012-WRITE-BD01001-SEC     SECTION.
      *
           MOVE    1               TO  FLG-SYURRK
           PERFORM 900-SMEITMP-KEY15-SEL-SEC
           IF    ( FLG-SMEITMP    =   ZERO )
               PERFORM 900-SYURRK-KEY-SEL-SEC
           END-IF
      *
           IF    ( FLG-SYURRK      =   ZERO )
               MOVE    SYURRK-HKNCOMBINUM
                                   TO  WRK-HKNCOMBINUM
               PERFORM 2001111-EDIT-HOKEN-SEC
               IF    ( WRK-HOKEN   >   ZERO )
                   INITIALIZE                  BD01001-REC
                   MOVE    SYURRK-NYUGAIKBN
                                           TO  BD01001-SRT-NYUGAIKBN
                   IF    ( SBD010-SUMKBN   =   ZERO )
                       MOVE    "00"        TO  BD01001-SRT-SRYKA
                   ELSE
                       MOVE    SYURRK-SRYKA
                                           TO  BD01001-SRT-SRYKA
                   END-IF
                   MOVE    SYURRK-DENPNUM  TO  BD01001-DENPNUM
                   MOVE    SYURRK-SYURRKNUM TO BD01001-SYURRKNUM
                                               BD01001-MAX-SYURRKNUM
                   MOVE    SYURRK-SYUEDANUM TO BD01001-SYUEDANUM
                                               BD01001-MAX-SYUEDANUM
                   MOVE    PTNUM-PTNUM     TO  BD01001-PTNUM
                   MOVE    PTINF-NAME      TO  BD01001-NAME
                   MOVE    SYU-SRYYMD      TO  BD01001-SRYYMD
                   MOVE    SYU-DENPPRTYMD  TO  BD01001-DENPPRTYMD
                   MOVE    WRK-HOKEN       TO  BD01001-HOKEN
                   MOVE    SYURRK-SRYKA    TO  BD01001-SRYKA
      *
                   IF    ( BD01001-SRT-NYUGAIKBN       =   "1" )
                       IF    ( SYU-CREATEKBN   =   "1" )
                           MOVE    "3" TO  BD01001-SYOSAIKBN
                       ELSE
                           MOVE    "4" TO  BD01001-SYOSAIKBN
                       END-IF
                   END-IF
                   MOVE    "1"         TO  BD01001-SKYNYUKBN
      *
                   PERFORM 200111-EDIT-MISYU-SEC
                   MOVE    WRK-MISYU       TO  BD01001-MISYU
      *
                   PERFORM 20011-WRITE-BD01003-SEC
      *
                   WRITE   BD01001-REC
      *
                   MOVE    SYURRK-SRYKA    TO  SUMSKY-MAX-SRYKA
               END-IF
      *
           ELSE
               MOVE    SYU-HKNCOMBINUM
                                   TO  WRK-HKNCOMBINUM
               PERFORM 2001111-EDIT-HOKEN-SEC
               IF    ( WRK-HOKEN   >   ZERO )
                   INITIALIZE                  BD01001-REC
                   MOVE    SYU-NYUGAIKBN
                                           TO  BD01001-SRT-NYUGAIKBN
                   IF    ( SBD010-SUMKBN   =   ZERO )
                       MOVE    "00"        TO  BD01001-SRT-SRYKA
                   ELSE
                       MOVE    SYU-SRYKA   TO  BD01001-SRT-SRYKA
                   END-IF
                   MOVE    SYU-DENPNUM     TO  BD01001-DENPNUM
                   MOVE    0               TO  BD01001-SYURRKNUM
                                               BD01001-MAX-SYURRKNUM
                   MOVE    0               TO  BD01001-SYUEDANUM
                                               BD01001-MAX-SYUEDANUM
                   MOVE    PTNUM-PTNUM     TO  BD01001-PTNUM
                   MOVE    PTINF-NAME      TO  BD01001-NAME
                   MOVE    SYU-SRYYMD      TO  BD01001-SRYYMD
                   MOVE    SYU-DENPPRTYMD  TO  BD01001-DENPPRTYMD
                   MOVE    WRK-HOKEN       TO  BD01001-HOKEN
                   MOVE    SYU-SRYKA       TO  BD01001-SRYKA
      *
                   IF    ( BD01001-SRT-NYUGAIKBN       =   "1" )
                       IF    ( SYU-CREATEKBN   =   "1" )
                           MOVE    "3" TO  BD01001-SYOSAIKBN
                       ELSE
                           MOVE    "4" TO  BD01001-SYOSAIKBN
                       END-IF
                   END-IF
                   MOVE    "1"             TO  BD01001-SKYNYUKBN
      *
                   PERFORM 200111-EDIT-MISYU-SEC
                   MOVE    WRK-MISYU       TO  BD01001-MISYU
      *
                   PERFORM 20011-WRITE-BD01003-SEC
      *
                   WRITE   BD01001-REC
      *
                   MOVE    SYU-SRYKA       TO  SUMSKY-MAX-SRYKA
               END-IF
           END-IF
      *
           .
       20012-WRITE-BD01001-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイル出力処理
      *****************************************************************
       20011-WRITE-BD01002-SEC     SECTION.
      *
           IF    ( SBD010-MEISAIKBN    =   ZERO )
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >   SUMNYUKIN-MAX )
      *
                   MOVE    SUMNYUKIN-OCC (IDX0)
                                       TO  BD01002-REC
                   MOVE    SUMNYUKIN-MAX
                                       TO  BD01002-CNT
      *
                   PERFORM 20012-WRITE-BD01003-SEC
      *
                   WRITE   BD01002-REC
      *
               END-PERFORM
           ELSE
      *
               INITIALIZE              BD01002-REC
      *
               PERFORM VARYING IDX0    FROM    1   BY  1
                       UNTIL ( IDX0    >   SUMNYUKIN-MAX )
      *
                   IF    ( IDX0    =   1 )
                       MOVE    SUMNYUKIN-OCC (IDX0)
                                   TO  BD01002-REC
                   ELSE
                       COMPUTE BD01002-NYUKIN
                           =   BD01002-NYUKIN
                           +   SUMNYUKIN-NYUKIN   (IDX0)
                       IF    ( BD01002-DENPEDANUM
                                       >   SUMNYUKIN-DENPEDANUM (IDX0))
                           MOVE    SUMNYUKIN-DENPEDANUM (IDX0)
                                   TO  BD01002-DENPEDANUM
                           MOVE    SUMNYUKIN-HOHO (IDX0)
                                   TO  BD01002-HOHO
                       END-IF
                   END-IF
      *
               END-PERFORM
      *
               PERFORM 20012-WRITE-BD01003-SEC
      *
               MOVE    1           TO  BD01002-CNT
               WRITE   BD01002-REC
      *
           END-IF
      *
           .
       20011-WRITE-BD01002-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイル出力処理
      *****************************************************************
       20011-WRITE-BD01003-SEC     SECTION.
      *
           INITIALIZE              BD01003-REC
           MOVE    BD01001-SRT-NYUGAIKBN   TO  BD01003-SRT-NYUGAIKBN
           MOVE    BD01001-SRT-SRYKA       TO  BD01003-SRT-SRYKA
           PERFORM 900-BD01003-READ-SEC
           IF    ( FLG-BD01003     =   ZERO )
               PERFORM 20011-EDIT-BD01003-SEC
               REWRITE BD01003-REC
           ELSE
               INITIALIZE              BD01003-REC
               MOVE    BD01001-SRT-NYUGAIKBN
                                           TO  BD01003-SRT-NYUGAIKBN
               MOVE    BD01001-SRT-SRYKA   TO  BD01003-SRT-SRYKA
               PERFORM 20011-EDIT-BD01003-SEC
               WRITE   BD01003-REC
           END-IF
      *
           .
       20011-WRITE-BD01003-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイル出力処理
      *****************************************************************
       20012-WRITE-BD01003-SEC     SECTION.
      *
           INITIALIZE                      BD01003-REC
           MOVE    SYU-NYUGAIKBN       TO  BD01003-SRT-NYUGAIKBN
           IF    ( SBD010-SUMKBN   =   ZERO )
               MOVE    "00"            TO  BD01003-SRT-SRYKA
           ELSE
               MOVE    SUMSKY-MAX-SRYKA TO BD01003-SRT-SRYKA
           END-IF
           PERFORM 900-BD01003-READ-SEC
           IF    ( FLG-BD01003     =   ZERO )
      *
               MOVE    11              TO  IDX-HOHO
      *
               EVALUATE    BD01002-HOHO
               WHEN    CONST-HOHO-HENKIN
                   MOVE    12          TO  IDX-HOHO
               WHEN    CONST-HOHO-TORIKESI
                   MOVE    13          TO  IDX-HOHO
               WHEN    OTHER
                   MOVE    BD01002-HOHO    TO  SRH-CD
                   PERFORM 250-GET-1041-SEC
                   IF    ( SRH-IDX     >=  1 )
                    AND  ( SRH-IDX     <=  10 )
                       MOVE    SRH-IDX TO  IDX-HOHO
                   END-IF
               END-EVALUATE
      *
               COMPUTE BD01003-NYUKIN-TOTAL
                   =   BD01003-NYUKIN-TOTAL
                   +   BD01002-NYUKIN
      *
               COMPUTE BD01003-NYUKIN (IDX-HOHO)
                   =   BD01003-NYUKIN (IDX-HOHO)
                   +   BD01002-NYUKIN
      *
               REWRITE BD01003-REC
      *
           END-IF
      *
           .
       20012-WRITE-BD01003-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイル編集処理
      *****************************************************************
       20011-EDIT-BD01003-SEC      SECTION.
      *
           COMPUTE BD01003-SEIKYU-TOTAL (1)
               =   BD01003-SEIKYU-TOTAL (1)
               +   BD01001-SKYMONEY
      *
           COMPUTE BD01003-SEIKYU (1 BD01001-HOKEN)
               =   BD01003-SEIKYU (1 BD01001-HOKEN)
               +   BD01001-FTNMONEY
      *
           COMPUTE BD01003-SEIKYU (1 CONST-JIHHKN)
               =   BD01003-SEIKYU (1 CONST-JIHHKN)
               +   BD01001-JIHIMONEY
      *
           COMPUTE BD01003-SEIKYU (1 CONST-CHOSEI)
               =   BD01003-SEIKYU (1 CONST-CHOSEI)
               +   BD01001-CHOSEI
      *
           COMPUTE BD01003-SEIKYU (1 CONST-GENMEN)
               =   BD01003-SEIKYU (1 CONST-GENMEN)
               +   BD01001-GENMEN
      *
           EVALUATE    BD01001-SYOSAIKBN
           WHEN    "1"
               COMPUTE BD01003-SEIKYU (2 BD01001-HOKEN)
                   =   BD01003-SEIKYU (2 BD01001-HOKEN)
                   +   1
               COMPUTE BD01003-SEIKYU (4 BD01001-HOKEN)
                   =   BD01003-SEIKYU (4 BD01001-HOKEN)
                   +   1
      *
               COMPUTE BD01003-SEIKYU-TOTAL (2)
                   =   BD01003-SEIKYU-TOTAL (2)
                   +   1
      *
               COMPUTE BD01003-SEIKYU-TOTAL (4)
               =       BD01003-SEIKYU-TOTAL (4)
                   +   1
           WHEN    "2"
               COMPUTE BD01003-SEIKYU (3 BD01001-HOKEN)
                   =   BD01003-SEIKYU (3 BD01001-HOKEN)
                   +   1
               COMPUTE BD01003-SEIKYU (4 BD01001-HOKEN)
                   =   BD01003-SEIKYU (4 BD01001-HOKEN)
                   +   1
      *
               COMPUTE BD01003-SEIKYU-TOTAL (3)
                   =   BD01003-SEIKYU-TOTAL (3)
                   +   1
      *
               COMPUTE BD01003-SEIKYU-TOTAL (4)
               =       BD01003-SEIKYU-TOTAL (4)
                   +   1
           END-EVALUATE
      *
      *
           PERFORM VARYING IDX-JIHI    FROM    1   BY  1
                   UNTIL ( IDX-JIHI    >   CONST-ETCJIHI-MAX )
      *
               COMPUTE BD01003-JIHI (IDX-JIHI)
                   =   BD01003-JIHI (IDX-JIHI)
                   +   BD01001-ETCJIHI (IDX-JIHI)
      *
               COMPUTE BD01003-JIHI-TOTAL
                   =   BD01003-JIHI-TOTAL
                   +   BD01001-ETCJIHI (IDX-JIHI)
           END-PERFORM
      *
           .
       20011-EDIT-BD01003-EXT.
           EXIT.
      *
      *****************************************************************
      *   帳票元データ編集処理
      *****************************************************************
       2001-EDIT-BD004-SEC         SECTION.
      *
           OPEN    INPUT   BD01001-FILE
                           BD01002-FILE
           OPEN    OUTPUT  BD01004-FILE
      *
           PERFORM 900-BD01001-READ-SEC
      *
           PERFORM UNTIL ( FLG-BD01001 NOT =   ZERO )
      *
               MOVE    BD01001-SRT-NYUGAIKBN   TO  KEY-NYUGAIKBN
               MOVE    BD01001-SRT-SRYKA       TO  KEY-SRYKA
               PERFORM UNTIL ( FLG-BD01001         NOT =   ZERO )
                         OR  ( BD01001-SRT-NYUGAIKBN
                                                   NOT = KEY-NYUGAIKBN )
                         OR  ( BD01001-SRT-SRYKA   NOT = KEY-SRYKA )
      *
                   MOVE    ZERO                TO  CNT-RENNUM
                   MOVE    BD01001-DENPNUM     TO  KEY-DENPNUM
                   PERFORM UNTIL ( FLG-BD01001     NOT =   ZERO )
                             OR  ( BD01001-SRT-NYUGAIKBN
                                                   NOT = KEY-NYUGAIKBN )
                             OR  ( BD01001-SRT-SRYKA
                                                   NOT = KEY-SRYKA )
                             OR  ( BD01001-DENPNUM NOT = KEY-DENPNUM )
      *
                       PERFORM 20011-EDIT-BD01004-SEC
      *
                       PERFORM 900-BD01001-READ-SEC
      *
                   END-PERFORM
               END-PERFORM
      *
           END-PERFORM
      *
           CLOSE   BD01001-FILE
                   BD01002-FILE
                   BD01004-FILE
      *
           .
       2001-EDIT-BD004-EXT.
           EXIT.
      *****************************************************************
      *   帳票元データ編集処理
      *****************************************************************
       20011-EDIT-BD01004-SEC          SECTION.
      *
           PERFORM 20011-EDIT-BD01004-COMMON-SEC
           MOVE    BD01001-SKYNYUKBN   TO  BD01004-SKYNYUKBN
           MOVE    BD01001-HOKENTEN    TO  BD01004-HOKENTEN
           MOVE    BD01001-SKYMONEY    TO  BD01004-SKYMONEY
           MOVE    BD01001-FTNMONEY    TO  BD01004-FTNMONEY
           MOVE    BD01001-JIHIMONEY   TO  BD01004-JIHIMONEY
           MOVE    BD01001-CHOSEI      TO  BD01004-CHOSEI
           MOVE    BD01001-GENMEN      TO  BD01004-GENMEN
           PERFORM VARYING IDX-JIHI    FROM    1   BY  1
                   UNTIL ( IDX-JIHI    >   CONST-ETCJIHI-MAX )
               MOVE    BD01001-ETCJIHI (IDX-JIHI)
                                       TO  BD01004-ETCJIHI (IDX-JIHI)
           END-PERFORM
           MOVE    BD01001-SYOSAIKBN   TO  BD01004-SYOSAIKBN
      *
           IF    ( BD01001-SYURRKNUM   =   BD01001-MAX-SYURRKNUM )
            AND  ( BD01001-SYUEDANUM   =   BD01001-MAX-SYUEDANUM )
      *
               PERFORM 20012-EDIT-BD01004-SEC
      *
           ELSE
               WRITE   BD01004-REC
           END-IF
      *
           .
       20011-EDIT-BD01004-EXT.
           EXIT.
      *****************************************************************
      *   帳票元データ編集処理（請求・入金共通項目）
      *****************************************************************
       20011-EDIT-BD01004-COMMON-SEC   SECTION.
      *
           COMPUTE CNT-RENNUM  =   CNT-RENNUM  +   1
      *
           INITIALIZE                  BD01004-REC
           MOVE    BD01001-SRT-NYUGAIKBN
                                       TO  BD01004-SRT-NYUGAIKBN
           MOVE    BD01001-SRT-SRYKA   TO  BD01004-SRT-SRYKA
           MOVE    CNT-RENNUM          TO  BD01004-RENNUM
           MOVE    BD01001-DENPNUM     TO  BD01004-DENPNUM
           MOVE    CNT-RENNUM          TO  BD01004-RENNUM
           MOVE    BD01001-PTNUM       TO  BD01004-PTNUM
           MOVE    BD01001-NAME        TO  BD01004-NAME
           MOVE    BD01001-SRYYMD      TO  BD01004-SRYYMD
           MOVE    BD01001-DENPPRTYMD  TO  BD01004-DENPPRTYMD
           MOVE    BD01001-HOKEN       TO  BD01004-HOKEN
           MOVE    BD01001-SRYKA       TO  BD01004-SRYKA
      *
           .
       20011-EDIT-BD01004-COMMON-EXT.
           EXIT.
      *****************************************************************
      *   帳票元データ編集処理（入金情報より）
      *****************************************************************
       20012-EDIT-BD01004-SEC            SECTION.
      *
           MOVE    ZERO            TO  CNT-BD01002
      *
           PERFORM 901-BD01002-START-SEC
           IF    ( FLG-BD01002     =   ZERO )
               PERFORM UNTIL ( FLG-BD01002 NOT =   ZERO )
      *
                   COMPUTE CNT-BD01002 =   CNT-BD01002 +   1
      *
                   IF    ( CNT-BD01002 >   1 )
                       PERFORM 20011-EDIT-BD01004-COMMON-SEC
                       MOVE    "1"         TO  BD01004-SKYNYUKBN
                   END-IF
      *
                   IF    ( CNT-BD01002 =   BD01002-CNT )
                       MOVE    BD01001-MISYU
                                           TO  BD01004-MISYU
                   END-IF
      *
                   MOVE    BD01002-HOHO    TO  BD01004-HOHO
                   MOVE    BD01002-NYUKIN  TO  BD01004-NYUKIN
      *
                   WRITE   BD01004-REC
      *
                   PERFORM 901-BD01002-READ-SEC
      *
               END-PERFORM
           ELSE
               MOVE    BD01001-MISYU   TO  BD01004-MISYU
               WRITE   BD01004-REC
           END-IF
      *
           .
       20012-EDIT-BD01004-EXT.
           EXIT.
      *****************************************************************
      *   帳票編集処理
      *****************************************************************
       2001-EDIT-FORM-SEC          SECTION.
      *
           OPEN    INPUT   BD01004-FILE
                           BD01003-FILE
      *
           PERFORM 900-BD01004-READ-SEC
      *
           PERFORM UNTIL ( FLG-BD01004 NOT =   ZERO )
      *
               MOVE    BD01004-SRT-NYUGAIKBN    TO  KEY-NYUGAIKBN
               MOVE    BD01004-SRT-SRYKA        TO  KEY-SRYKA
               MOVE    ZERO                     TO  CNT-NO
               INITIALIZE                           TTL-AREA
      *
               PERFORM UNTIL ( FLG-BD01004 NOT =   ZERO )
                        OR   ( BD01004-SRT-NYUGAIKBN
                                           NOT =   KEY-NYUGAIKBN )
                        OR   ( BD01004-SRT-SRYKA
                                           NOT =   KEY-SRYKA )
      *
                   PERFORM 20011-EDIT-FORM-SEC
      *
               END-PERFORM
      *
               IF    ( SBD010-TOTALPRTKBN  =   "1" )
                   PERFORM 20012-EDIT-FORM-SEC
               END-IF
      *
           END-PERFORM
      *
           CLOSE           BD01004-FILE
                           BD01003-FILE
      *
           .
       2001-EDIT-FORM-EXT.
           EXIT.
      *****************************************************************
      *   帳票編集処理
      *****************************************************************
       20011-EDIT-FORM-SEC          SECTION.
      *
           PERFORM 210-HEAD-SEC
      *
      *
           PERFORM UNTIL ( FLG-BD01004           NOT = ZERO )
                    OR   ( BD01004-SRT-NYUGAIKBN NOT = KEY-NYUGAIKBN  )
                    OR   ( BD01004-SRT-SRYKA     NOT = KEY-SRYKA )
                    OR   ( CNT-LINE                 >= CONST-LINE-MAX )
      *
               PERFORM 220-BODY-SEC
      *
               PERFORM 900-BD01004-READ-SEC
      *
           END-PERFORM
      *
           IF    ( FLG-BD01004           NOT = ZERO )
            OR   ( BD01004-SRT-NYUGAIKBN NOT = KEY-NYUGAIKBN  )
            OR   ( BD01004-SRT-SRYKA     NOT = KEY-SRYKA )
      *
               PERFORM 2201-BODY-TOTAL-SEC
           END-IF
      *
           PERFORM 230-PRINT-SEC
      *
           .
       20011-EDIT-FORM-EXT.
           EXIT.
      *****************************************************************
      *   見出し編集処理
      *****************************************************************
       210-HEAD-SEC                SECTION.
      *
           COMPUTE CNT-PAGE  = CNT-PAGE    +   1
           MOVE    ZERO            TO  CNT-LINE
      *
           INITIALIZE                  HCM51
      *
           IF    ( BD01004-SRT-NYUGAIKBN   =   "1" )
               MOVE    "（入院）"      TO  HCM51-NYUGAI
           ELSE
               MOVE    "（外来）"      TO  HCM51-NYUGAI
           END-IF
      *
           MOVE    WRK-PRT-SRYYMD      TO  HCM51-HSRYYMD
      *
           IF    ( SBD010-SUMKBN   =   ZERO )
               CONTINUE
           ELSE
               MOVE    BD01004-SRYKA   TO  SRH-CD
               PERFORM 250-GET-1005-SEC
               MOVE    SRH-ITM         TO  HCM51-HSRYKA
           END-IF
      *
           MOVE    WRK-PRT-SAKYMD  TO  HCM51-SAKYMD
      *
           MOVE    CNT-PAGE        TO  WRK-ZZZZ9
           MOVE    WRK-ZZZZ9       TO  HCM51-PAGE
      *
           IF    ( BD01004-SRT-NYUGAIKBN   =   "1" )
               MOVE    "伝票発行日"    TO  HCM51-SRYYMDMSG
               MOVE    "退定"          TO  HCM51-SYOSAIMSG
           ELSE
               MOVE    "診療年月日"    TO  HCM51-SRYYMDMSG
               MOVE    "初再"          TO  HCM51-SYOSAIMSG
           END-IF
      *
           .
       210-HEAD-EXT.
           EXIT.
      *****************************************************************
      *   明細編集処理
      *****************************************************************
       220-BODY-SEC                SECTION.
      *
           COMPUTE CNT-LINE    =   CNT-LINE   +   1
      *
           IF    ( BD01004-RENNUM  =   1 )
               COMPUTE CNT-NO  =   CNT-NO     +   1
           END-IF
      *
           IF    ( CNT-LINE        =   1 )
            OR   ( BD01004-RENNUM  =   1 )
               MOVE    CNT-NO          TO  WRK-ZZ9
               MOVE    WRK-ZZ9         TO  HCM51-NO (CNT-LINE)
               MOVE    BD01004-DENPNUM     TO  HCM51-DENPNUM (CNT-LINE)
               IF    ( BD01004-PTNUM (11:)    =   SPACE )
                   MOVE    BD01004-PTNUM   TO  HCM51-PTNUM (CNT-LINE)
               ELSE
                   MOVE    BD01004-PTNUM   TO  HCM51-PTNUM2(CNT-LINE)
               END-IF
               MOVE    BD01004-NAME        TO  HCM51-NAME  (CNT-LINE)
               IF    ( BD01004-SRT-NYUGAIKBN   =   "1" )
                   IF    ( BD01004-DENPPRTYMD
                                           NOT =   WRK-EDDAILYKEY-YMD )
                       MOVE    BD01004-DENPPRTYMD  TO  WRK-SYMD
                       PERFORM 800-SEIWA-HEN-SEC
                       MOVE    WRK-EDTYMD1 TO  HCM51-SRYYMD(CNT-LINE)
                   END-IF
               ELSE
                   IF    ( BD01004-SRYYMD  NOT =   WRK-EDDAILYKEY-YMD )
                       MOVE    BD01004-SRYYMD  TO  WRK-SYMD
                       PERFORM 800-SEIWA-HEN-SEC
                       MOVE    WRK-EDTYMD1 TO  HCM51-SRYYMD(CNT-LINE)
                   END-IF
               END-IF
           END-IF
      *
           EVALUATE    BD01004-SYOSAIKBN
           WHEN    "1"
               MOVE    "初診"          TO  HCM51-SYOSAI(CNT-LINE)
           WHEN    "2"
               MOVE    "再診"          TO  HCM51-SYOSAI(CNT-LINE)
           WHEN    "3"
               MOVE    "退院"          TO  HCM51-SYOSAI(CNT-LINE)
           WHEN    "4"
               MOVE    "定期"          TO  HCM51-SYOSAI(CNT-LINE)
           END-EVALUATE
      *
      *
           MOVE    BD01004-SRYKA   TO  SRH-CD
           PERFORM 250-GET-1005-SEC
           MOVE    SRH-ITM2                TO  HCM51-SRYKA (CNT-LINE)
      *
           MOVE    CONST-SEIKYUMSG(BD01004-HOKEN)
                                           TO  HCM51-HOKEN (CNT-LINE)
      *
           IF    ( BD01004-SKYNYUKBN       =   ZERO )
               MOVE    BD01004-HOKENTEN    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCM51-HKNTEN(CNT-LINE)
               MOVE    BD01004-SKYMONEY    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCM51-SKYMONEY(CNT-LINE)
               MOVE    BD01004-FTNMONEY    TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCM51-SKYHOKEN(CNT-LINE)
               MOVE    BD01004-JIHIMONEY   TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCM51-SKYJIHI(CNT-LINE)
               COMPUTE WRK-CHOSEI
                   =   BD01004-CHOSEI
                   +   BD01004-GENMEN
               MOVE    WRK-CHOSEI          TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCM51-CHOSEI(CNT-LINE)
      *
               IF    ( BD01004-GENMEN      NOT =   ZERO )
                   MOVE    "*"             TO  HCM51-CHOSEI-MARK
                                                           (CNT-LINE)
               END-IF
           END-IF
      *
           MOVE    BD01004-NYUKIN          TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9            TO  HCM51-NYUKIN(CNT-LINE)
      *
           IF    ( SBD010-MEISAIKBN    =   ZERO )
               EVALUATE    BD01004-HOHO
               WHEN     CONST-HOHO-HENKIN
                   MOVE    CONST-HOHO-HENKINMSG
                                           TO HCM51-HOHO (CNT-LINE)
               WHEN     CONST-HOHO-TORIKESI
                   MOVE    CONST-HOHO-TORIKESIMSG
                                           TO HCM51-HOHO (CNT-LINE)
               WHEN    OTHER
                   MOVE    BD01004-HOHO    TO  SRH-CD
                   PERFORM 250-GET-1041-SEC
                   MOVE    SRH-ITM         TO  HCM51-HOHO (CNT-LINE)
               END-EVALUATE
           END-IF
      *
           MOVE    BD01004-MISYU           TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9            TO  HCM51-MISYU(CNT-LINE)
      *
      *
           IF    ( BD01004-SYOSAIKBN   =   "1" )
               COMPUTE TTL-SYOSIN
                   =   TTL-SYOSIN  +   1
           END-IF
      *
           IF    ( BD01004-SYOSAIKBN   =   "2" )
               COMPUTE TTL-SAISIN
                   =   TTL-SAISIN  +   1
           END-IF
      *
           COMPUTE TTL-HKNTEN
               =   TTL-HKNTEN  +   BD01004-HOKENTEN
           COMPUTE TTL-SKYMONEY
               =   TTL-SKYMONEY +  BD01004-SKYMONEY
           COMPUTE TTL-SKYHOKEN
               =   TTL-SKYHOKEN +  BD01004-FTNMONEY
           COMPUTE TTL-SKYJIHI
               =   TTL-SKYJIHI +   BD01004-JIHIMONEY
           COMPUTE TTL-NYUKIN
               =   TTL-NYUKIN  +   BD01004-NYUKIN
           COMPUTE TTL-CHOSEI
               =   TTL-CHOSEI  +   BD01004-CHOSEI
           COMPUTE TTL-GENMEN
               =   TTL-GENMEN  +   BD01004-GENMEN
           COMPUTE TTL-MISYU
               =   TTL-MISYU   +   BD01004-MISYU
      *
           .
       220-BODY-EXT.
           EXIT.
      *****************************************************************
      *    明細合計行編集処理
      *****************************************************************
       2201-BODY-TOTAL-SEC             SECTION.
      *
           IF    ( KEY-NYUGAIKBN   =   "2" )
               MOVE    "初診"      TO  HCM51-TTL-SYOSINMSG
               MOVE    TTL-SYOSIN  TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9 TO HCM51-TTL-SYOSIN
               MOVE    "再診"      TO  HCM51-TTL-SAISINMSG
               MOVE    TTL-SAISIN  TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9 TO HCM51-TTL-SAISIN
           END-IF
      *
           MOVE    "保険点数計"    TO  HCM51-TTL-HKNTENMSG
           MOVE    "請求額計"      TO  HCM51-TTL-SKYMONEYMSG
           MOVE    "（保険請求計"  TO  HCM51-TTL-SKYHOKENMSG
           MOVE    "自費請求計"    TO  HCM51-TTL-SKYJIHIMSG
           MOVE    "調整金計）"    TO  HCM51-TTL-CHOSEIMSG
           MOVE    "入金額計"      TO  HCM51-TTL-NYUKINMSG
           MOVE    "未収金額計"    TO  HCM51-TTL-MISYUMSG
      *
           MOVE    TTL-HKNTEN      TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9    TO  HCM51-TTL-HKNTEN
           MOVE    TTL-SKYMONEY    TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9    TO  HCM51-TTL-SKYMONEY
           MOVE    TTL-SKYHOKEN    TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9    TO  HCM51-TTL-SKYHOKEN
           MOVE    TTL-SKYJIHI     TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9    TO  HCM51-TTL-SKYJIHI
           MOVE    TTL-NYUKIN      TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9    TO  HCM51-TTL-NYUKIN
      *
           COMPUTE WRK-CHOSEI
               =   TTL-CHOSEI
               +   TTL-GENMEN
      *
           MOVE    WRK-CHOSEI      TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9    TO  HCM51-TTL-CHOSEI
      *
           IF    ( TTL-GENMEN      NOT =   ZERO )
               MOVE    "*"         TO  HCM51-TTL-CHOSEI-MARK
           END-IF
      *
           MOVE    TTL-MISYU       TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9    TO  HCM51-TTL-MISYU
      *
           .
       2201-BODY-TOTAL-EXT.
           EXIT.
      *****************************************************************
      *   印刷処理
      *****************************************************************
       230-PRINT-SEC               SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
           PERFORM 230-PRINT-COMMON-SEC
           MOVE   "HCM51.red"      TO  SPRT-PRTID
           MOVE    "収納日報"      TO  SPRT-TITLE
           MOVE    HCM51           TO  SPRT-PRTDATA
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF    ( SPRT-RETURN         =   ZERO )
               CONTINUE
           ELSE
               DISPLAY "ORCSPRT ERROR (1) " CNT-PAGE
               MOVE    "印刷ＤＢに更新できませんでした"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
           .
       230-PRINT-EXT.
           EXIT.
      *****************************************************************
      *   印刷パラメタ共通項目設定処理
      *****************************************************************
       230-PRINT-COMMON-SEC        SECTION.
      *
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO SPRT-TBL-KEY
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
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID
                                   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM
                                   TO  SPRT-PRTNM
           MOVE    "1"             TO  SPRT-SITEKBN
      *
           .
       230-PRINT-COMMON-EXT.
           EXIT.
      *****************************************************************
      *   帳票編集処理
      *****************************************************************
       20012-EDIT-FORM-SEC         SECTION.
      *
           INITIALIZE                      BD01003-REC
           MOVE    KEY-NYUGAIKBN       TO  BD01003-SRT-NYUGAIKBN
           MOVE    KEY-SRYKA           TO  BD01003-SRT-SRYKA
           PERFORM 900-BD01003-READ-SEC
           IF    ( FLG-BD01003         =   ZERO )
               PERFORM 211-HEAD-SEC
               PERFORM 221-BODY-SEC
               PERFORM 231-PRINT-SEC
           END-IF
      *
           .
       20012-EDIT-FORM-EXT.
           EXIT.
      *****************************************************************
      *   見出し編集処理
      *****************************************************************
       211-HEAD-SEC                SECTION.
      *
           COMPUTE CNT-PAGE  = CNT-PAGE    +   1
      *
           INITIALIZE                  HCM52
      *
           IF    ( BD01003-SRT-NYUGAIKBN   =   "1" )
               MOVE    "（入院）"      TO  HCM52-NYUGAI
           ELSE
               MOVE    "（外来）"      TO  HCM52-NYUGAI
               MOVE    "初診件数"      TO  HCM52-SYOSINMSG
               MOVE    "再診件数"      TO  HCM52-SAISINMSG
               MOVE    "初再診計"      TO  HCM52-SYOSAIMSG
           END-IF
      *
           MOVE    WRK-PRT-SRYYMD      TO  HCM52-HSRYYMD
      *
           IF    ( SBD010-SUMKBN   =   ZERO )
               CONTINUE
           ELSE
               MOVE    BD01003-SRT-SRYKA
                                       TO  SRH-CD
               PERFORM 250-GET-1005-SEC
               MOVE    SRH-ITM         TO  HCM52-HSRYKA
           END-IF
      *
           MOVE    WRK-PRT-SAKYMD      TO  HCM52-SAKYMD
      *
           MOVE    CNT-PAGE            TO  WRK-ZZZZ9
           MOVE    WRK-ZZZZ9           TO  HCM52-PAGE
      *
           .
       211-HEAD-EXT.
           EXIT.
      *****************************************************************
      *   明細編集処理
      *****************************************************************
       221-BODY-SEC                SECTION.
      *
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >   4 )
      *
               MOVE    ZERO        TO  FLG-TARGET
               IF    ( BD01003-SRT-NYUGAIKBN   =   "1" )
                   IF    ( IDX1        =   1 )
                       MOVE    1           TO  FLG-TARGET
                   END-IF
               ELSE
                       MOVE    1           TO  FLG-TARGET
               END-IF
      *
               IF    ( FLG-TARGET  =   1 )
                   MOVE    BD01003-SEIKYU-TOTAL (IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-GOKEI (IDX1)
      *
                   MOVE    BD01003-SEIKYU-SYAHON(IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-SYAHON(IDX1)
      *
                   MOVE    BD01003-SEIKYU-SYAKZK(IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-SYAKZK(IDX1)
      *
                   MOVE    BD01003-SEIKYU-SYARJN(IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-SYARJN(IDX1)
      *
                   MOVE    BD01003-SEIKYU-KOKIPN(IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-KOKIPN(IDX1)
      *
                   MOVE    BD01003-SEIKYU-KOKRJN(IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-KOKRJN(IDX1)
      *
                   MOVE    BD01003-SEIKYU-KOHTAN(IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-KOHTAN(IDX1)
      *
                   MOVE    BD01003-SEIKYU-JIHHKN(IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-JIHSRY(IDX1)
      *
                   MOVE    BD01003-SEIKYU-ROUSAI(IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-ROUSAI(IDX1)
      *
                   MOVE    BD01003-SEIKYU-JIBAI (IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-JIBAI (IDX1)
      *
                   MOVE    BD01003-SEIKYU-CHOSEI(IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-CHOSEI(IDX1)
      *
                   MOVE    BD01003-SEIKYU-GENMEN(IDX1)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-GENMEN(IDX1)
               END-IF
      *
           END-PERFORM
      *
           MOVE    "合　計"                TO  HCM52-TTLJIHIMSG
           MOVE    BD01003-JIHI-TOTAL      TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9            TO  HCM52-TTLJIHI
      *
           PERFORM VARYING IDX-JIHI    FROM    1   BY  1
                   UNTIL ( IDX-JIHI    >   CONST-ETCJIHI-MAX )
               IF    ( BD01003-SRT-NYUGAIKBN   =   "1" )
                   MOVE    SRH-1013-JIHINAME (1 IDX-JIHI)
                                           TO  HCM52-JIHIMSG (IDX-JIHI)
               ELSE
                   MOVE    SRH-1013-JIHINAME (2 IDX-JIHI)
                                           TO  HCM52-JIHIMSG (IDX-JIHI)
               END-IF
      *
               IF    ( HCM52-JIHIMSG (IDX-JIHI) =  SPACE )
                   MOVE    BD01003-JIHI (IDX-JIHI)
                                           TO  WRK-ZZZZZZZZ
                   MOVE    WRK-ZZZZZZZZ    TO  HCM52-JIHI    (IDX-JIHI)
               ELSE
                   MOVE    BD01003-JIHI (IDX-JIHI)
                                           TO  WRK-ZZZZZZZ9
                   MOVE    WRK-ZZZZZZZ9    TO  HCM52-JIHI    (IDX-JIHI)
               END-IF
      *
           END-PERFORM
      *
           MOVE    "合　計"                TO  HCM52-TTLHOHOMSG
           MOVE    BD01003-NYUKIN-TOTAL    TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9            TO  HCM52-TTLNYUKIN
      *
           MOVE    ZERO                    TO  IDX-HOHO
           PERFORM VARYING IDX1    FROM    1   BY  1
                   UNTIL ( IDX1    >       10 )
                      OR ( IDX1    >       SRH-1041-MAX )
      *
               COMPUTE IDX-HOHO    =   IDX-HOHO    +   1
               MOVE    SRH-1041-NYKN-TANNAME (IDX1)
                                           TO  HCM52-HOHOMSG (IDX-HOHO)
               MOVE    BD01003-NYUKIN (IDX1)
                                           TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCM52-NYUKIN  (IDX-HOHO)
      *
           END-PERFORM
      *
           IF    ( BD01003-NYUKIN (11) NOT =   ZERO )
               COMPUTE IDX-HOHO    =   IDX-HOHO    +   1
               MOVE    "その他"            TO  HCM52-HOHOMSG (IDX-HOHO)
               MOVE    BD01003-NYUKIN (11) TO  WRK-ZZZZZZZ9
               MOVE    WRK-ZZZZZZZ9        TO  HCM52-NYUKIN  (IDX-HOHO)
           END-IF
      *
           COMPUTE IDX-HOHO    =   IDX-HOHO    +   1
           MOVE    "返　金"            TO  HCM52-HOHOMSG (IDX-HOHO)
           MOVE    BD01003-NYUKIN (12) TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9        TO  HCM52-NYUKIN  (IDX-HOHO)
      *
           COMPUTE IDX-HOHO    =   IDX-HOHO    +   1
           MOVE    "入金取消"          TO  HCM52-HOHOMSG (IDX-HOHO)
           MOVE    BD01003-NYUKIN (13) TO  WRK-ZZZZZZZ9
           MOVE    WRK-ZZZZZZZ9        TO  HCM52-NYUKIN  (IDX-HOHO)
      *
           .
       221-BODY-EXT.
           EXIT.
      *****************************************************************
      *   印刷処理
      *****************************************************************
       231-PRINT-SEC               SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
           PERFORM 230-PRINT-COMMON-SEC
           MOVE   "HCM52.red"          TO  SPRT-PRTID
           MOVE    "収納日報（合計）"  TO  SPRT-TITLE
           MOVE    HCM52               TO  SPRT-PRTDATA
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF    ( SPRT-RETURN         =   ZERO )
               CONTINUE
           ELSE
               DISPLAY "ORCSPRT ERROR (2) " CNT-PAGE
               MOVE    "印刷ＤＢに更新できませんでした"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       231-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    診療科取得処理
      *****************************************************************
       250-GET-1005-SEC            SECTION.
      *
           INITIALIZE              SRH-IDX
                                   SRH-ITM-G
      *
           PERFORM VARYING IDX-SRH FROM    1   BY  1
                   UNTIL ( IDX-SRH >   SRH-1005-MAX )
                    OR   ( SRH-ITM NOT =   SPACE )
      *
               IF    ( SRH-1005-CD (IDX-SRH)   =   SRH-CD )
      *
                   MOVE    IDX-SRH TO  SRH-IDX
      *
                   MOVE    SRH-1005-SRYKANAME1 (IDX-SRH)
                                   TO  SRH-ITM
      *
                   MOVE    SRH-1005-SRYKANAME3 (IDX-SRH)
                                   TO  SRH-ITM2
               END-IF
      *
           END-PERFORM
      *
           .
       250-GET-1005-EXT.
           EXIT.
      *****************************************************************
      *    入金方法取得処理
      *****************************************************************
       250-GET-1041-SEC            SECTION.
      *
           INITIALIZE              SRH-IDX
                                   SRH-ITM-G
      *
           PERFORM VARYING IDX-SRH FROM    1   BY  1
                   UNTIL ( IDX-SRH >   SRH-1041-MAX )
                    OR   ( SRH-ITM NOT =   SPACE )
      *
               IF    ( SRH-1041-CD (IDX-SRH)   =   SRH-CD )
      *
                   MOVE    IDX-SRH TO  SRH-IDX
      *
                   MOVE    SRH-1041-NYKN-TANNAME (IDX-SRH)
                                   TO  SRH-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       250-GET-1041-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF    ( STS-RECEERR         =   ZERO )
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
               MOVE    SBD010-JOBID    TO  JOB-JOBID
               MOVE    SBD010-SHELLID  TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           END-IF
      *
           MOVE    1               TO  FLG-END
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           PERFORM 800-DEL-FILE-SEC
      *
           IF    ( CNT-PAGE        =   ZERO )
               MOVE    "対象データがありませんでした"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    SBD010-JOBID    TO  JOB-JOBID
           MOVE    SBD010-SHELLID  TO  JOB-SHELLID
           MOVE    CNT-PAGE        TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
      *
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    中間ファイル削除処理
      *****************************************************************
       800-DEL-FILE-SEC            SECTION.
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    BD01001PARA     TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    BD01001PARA     TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    BD01001PARA     TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
      *    ファイル削除
           MOVE    ZERO            TO  IF-RESULT
           MOVE    BD01001PARA     TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
           .
       800-DEL-FILE-EXT.
           EXIT.
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       800-SEIWA-HEN-SEC           SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD        TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD1
                                   TO  WRK-EDTYMD1
           MOVE    LNK-DAY2-EDTYMD3
                                   TO  WRK-EDTYMD3
           INSPECT WRK-EDTYMD3     REPLACING  ALL "  "  BY  "　"
      *
           .
       800-SEIWA-HEN-EXT.
           EXIT.
      *****************************************************************
      *    全角変換処理
      *****************************************************************
       800-ZENKAKU-HEN-SEC         SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI
           MOVE  WRK-KANACHK-INPUT TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF    ( KANACHK-RC      =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                   TO  WRK-KANACHK-INPUT
               MOVE    KANACHK-MAX TO  WRK-KANACHK-MAX
           END-IF
      *
           .
       800-ZENKAKU-HEN-EXT.
           EXIT.
      *****************************************************************
      *    初再診チェックサブ呼出処理
      *****************************************************************
       800-CALL-ORCSS003-SEC           SECTION.
      *
           INITIALIZE                          SS003-AREA
           MOVE    "1"                 TO      SS003-SYORIKBN
           MOVE    SYU-HOSPID          TO      SS003-HOSPID
           MOVE    SYU-NYUGAIKBN       TO      SS003-NYUGAIKBN
           MOVE    SYU-PTID            TO      SS003-PTID
           MOVE    SYU-DENPNUM         TO      SS003-DENPNUM
           CALL    "ORCSS003"          USING   SS003-AREA
      *
           .
       800-CALL-ORCSS003-EXT.
           EXIT.
      *****************************************************************
      *    収納明細検索処理
      *****************************************************************
       900-SYUMEI-KEY8-SEL-SEC     SECTION.
      *
           MOVE    ZERO            TO  FLG-SYUMEI
      *
           INITIALIZE                  SMEI-REC
           MOVE    SBD010-HOSPID   TO  SMEI-HOSPID
           IF    ( SBD010-NYUGAIKBN    =   "0" )
               MOVE    "%"         TO SMEI-NYUGAIKBN
           ELSE
               MOVE    SBD010-NYUGAIKBN
                                   TO SMEI-NYUGAIKBN
           END-IF
           MOVE    WRK-STDAILYKEY  TO  SMEI-STDAILYKEY
           MOVE    WRK-EDDAILYKEY  TO  SMEI-EDDAILYKEY
           MOVE    SMEI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syumei"    TO  MCP-TABLE
           MOVE    "key8"          TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC TO  SMEI-REC
           ELSE
               INITIALIZE              SMEI-REC
               MOVE    1           TO  FLG-SYUMEI
           END-IF
      *
           .
       900-SYUMEI-KEY8-SEL-EXT.
           EXIT.
      *****************************************************************
      *    収納明細FETCH処理
      *****************************************************************
       900-SYUMEI-KEY8-FET-SEC     SECTION.
      *
           MOVE    ZERO            TO  FLG-SYUMEI
      *
           MOVE    SMEI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syumei"    TO  MCP-TABLE
           MOVE    "key8"          TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SMEI-REC
           ELSE
               INITIALIZE                  SMEI-REC
               MOVE    1               TO  FLG-SYUMEI
           END-IF
      *
           .
       900-SYUMEI-KEY8-FET-EXT.
           EXIT.
      *****************************************************************
      *    収納明細検索処理
      *****************************************************************
       900-SMEITMP-KEY15-SEL-SEC     SECTION.
      *
           MOVE    ZERO            TO  FLG-SMEITMP
      *
           INITIALIZE                  SMEITMP-REC
           MOVE    SYU-HOSPID      TO  SMEITMP-HOSPID
           MOVE    SYU-NYUGAIKBN   TO  SMEITMP-NYUGAIKBN
           MOVE    SYU-PTID        TO  SMEITMP-PTID
           MOVE    SYU-DENPNUM     TO  SMEITMP-DENPNUM
           MOVE    WRK-MIN-DENPEDANUM
                                   TO  SMEITMP-DENPEDANUM
           MOVE    SMEITMP-REC    TO  MCPDATA-REC
           MOVE    "tbl_syumei"    TO  MCP-TABLE
           MOVE    "key15"         TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC TO  SMEITMP-REC
           ELSE
               INITIALIZE              SMEITMP-REC
               MOVE    1           TO  FLG-SMEITMP
           END-IF
      *
           MOVE    "tbl_syumei"    TO  MCP-TABLE
           MOVE    "key15"         TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SMEITMP-KEY15-SEL-EXT.
           EXIT.
      *****************************************************************
      *    収納明細検索処理
      *****************************************************************
       900-SMEITMP-KEY16-SEL-SEC     SECTION.
      *
           MOVE    ZERO            TO  FLG-SMEITMP
      *
           INITIALIZE                  SMEITMP-REC
           MOVE    SYU-HOSPID      TO  SMEITMP-HOSPID
           MOVE    SYU-NYUGAIKBN   TO  SMEITMP-NYUGAIKBN
           MOVE    SYU-PTID        TO  SMEITMP-PTID
           MOVE    SYU-DENPNUM     TO  SMEITMP-DENPNUM
           MOVE    WRK-MIN-DENPEDANUM
                                   TO  SMEITMP-DENPEDANUM
           MOVE    SMEITMP-REC    TO  MCPDATA-REC
           MOVE    "tbl_syumei"    TO  MCP-TABLE
           MOVE    "key16"         TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SMEITMP-REC
           ELSE
               INITIALIZE                  SMEITMP-REC
               MOVE    1               TO  FLG-SMEITMP
           END-IF
      *
           MOVE    "tbl_syumei"    TO  MCP-TABLE
           MOVE    "key16"         TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SMEITMP-KEY16-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理
      *****************************************************************
       900-SYSKANRI-KEY10-SEL-SEC  SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               INITIALIZE                  SYSKANRI-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key10"         TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SYSKANRI-KEY10-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理
      *****************************************************************
       900-SYSKANRI-KEY2-SEL-SEC   SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               INITIALIZE                  SYSKANRI-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理FETCH処理
      *****************************************************************
       900-SYSKANRI-KEY2-FET-SEC   SECTION.
      *
           MOVE    ZERO            TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "tbl_syskanri"  TO  MCP-TABLE
           MOVE    "key2"          TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               INITIALIZE                  SYSKANRI-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       900-SYSKANRI-KEY2-FET-EXT.
           EXIT.
      *****************************************************************
      *    収納履歴検索処理
      *****************************************************************
       900-SYURRK-KEY-SEL-SEC      SECTION.
      *
           MOVE    ZERO               TO  FLG-SYURRK
      *
           INITIALIZE                     SYURRK-REC
           MOVE    SMEITMP-HOSPID     TO  SYURRK-HOSPID
           MOVE    SMEITMP-NYUGAIKBN  TO  SYURRK-NYUGAIKBN
           MOVE    SMEITMP-PTID       TO  SYURRK-PTID
           MOVE    SMEITMP-DENPNUM    TO  SYURRK-DENPNUM
           MOVE    SMEITMP-SYURRKNUM  TO  SYURRK-SYURRKNUM
           MOVE    SMEITMP-SYUEDANUM  TO  SYURRK-SYUEDANUM
           MOVE    SYURRK-REC      TO  MCPDATA-REC
           MOVE    "tbl_syurrk"    TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC TO  SYURRK-REC
           ELSE
               INITIALIZE              SYURRK-REC
               MOVE    1           TO  FLG-SYURRK
           END-IF
      *
           MOVE    "tbl_syurrk"    TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SYURRK-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    収納履歴検索処理
      *****************************************************************
       900-SYURRK-KEY3-SEL-SEC      SECTION.
      *
           MOVE    ZERO            TO  FLG-SYURRK
      *
           INITIALIZE                  SYURRK-REC
           MOVE    SMEI-HOSPID     TO  SYURRK-HOSPID
           MOVE    SMEI-NYUGAIKBN  TO  SYURRK-NYUGAIKBN
           MOVE    SMEI-PTID       TO  SYURRK-PTID
           MOVE    SMEI-DENPNUM    TO  SYURRK-DENPNUM
           MOVE    SMEI-SYURRKNUM  TO  SYURRK-SYURRKNUM
           MOVE    SYURRK-REC      TO  MCPDATA-REC
           MOVE    "tbl_syurrk"    TO  MCP-TABLE
           MOVE    "key3"          TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC TO  SYURRK-REC
           ELSE
               INITIALIZE              SYURRK-REC
               MOVE    1           TO  FLG-SYURRK
           END-IF
      *
           .
       900-SYURRK-KEY3-SEL-EXT.
           EXIT.
      *****************************************************************
      *    収納履歴検索処理
      *****************************************************************
       900-SYURRK-KEY3-FET-SEC      SECTION.
      *
           MOVE    ZERO            TO  FLG-SYURRK
      *
           MOVE    "tbl_syurrk"    TO  MCP-TABLE
           MOVE    "key3"          TO  MCP-PATHNAME
           PERFORM 910-DBFETCH-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC TO  SYURRK-REC
           ELSE
               INITIALIZE              SYURRK-REC
               MOVE    1           TO  FLG-SYURRK
           END-IF
      *
           .
       900-SYURRK-KEY3-FET-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せ取得処理
      *****************************************************************
       900-HKNCOMBI-KEY-SEL-SEC       SECTION.
      *
           MOVE    ZERO                TO  FLG-HKNCOMBI
      *
           INITIALIZE                  HKNCOMBI-REC
           MOVE    SYU-HOSPID          TO  COMB-HOSPID
           MOVE    SYU-PTID            TO  COMB-PTID
           MOVE    WRK-HKNCOMBINUM     TO  COMB-HKNCOMBINUM
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC              =   ZERO )
               MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
           ELSE
               INITIALIZE                  HKNCOMBI-REC
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
      *
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-HKNCOMBI-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    患者番号検索処理
      *****************************************************************
       900-PTNUM-KEY-SEL-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-PTNUM
      *
           INITIALIZE                  PTNUM-REC
           MOVE    SMEI-HOSPID     TO  PTNUM-HOSPID
           MOVE    SMEI-PTID       TO  PTNUM-PTID
           MOVE    PTNUM-REC       TO  MCPDATA-REC
           MOVE    "tbl_ptnum"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  PTNUM-REC
           ELSE
               MOVE    1           TO  FLG-PTNUM
               INITIALIZE              PTNUM-REC
           END-IF
      *
           MOVE    "tbl_ptnum"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-PTNUM-KEY-SEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者情報検索処理
      *****************************************************************
       900-PTINF-KEY-SEL-SEC          SECTION.
      *
           MOVE    ZERO            TO  FLG-PTINF
      *
           INITIALIZE                  PTINF-REC
           MOVE    SMEI-HOSPID     TO  PTINF-HOSPID
           MOVE    SMEI-PTID       TO  PTINF-PTID
           MOVE    PTINF-REC       TO  MCPDATA-REC
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  PTINF-REC
           ELSE
               MOVE    1           TO  FLG-PTINF
               INITIALIZE              PTINF-REC
           END-IF
      *
           MOVE    "tbl_ptinf"     TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-PTINF-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    収納検索処理
      *****************************************************************
       900-SYUNOU-KEY-SEL-SEC      SECTION.
      *
           MOVE    ZERO            TO  FLG-SYUNOU
      *
           INITIALIZE                  SYUNOU-REC
      *
           MOVE    SMEI-HOSPID     TO  SYU-HOSPID
           MOVE    SMEI-NYUGAIKBN  TO  SYU-NYUGAIKBN
           MOVE    SMEI-PTID       TO  SYU-PTID
           MOVE    SMEI-DENPNUM    TO  SYU-DENPNUM
           MOVE    SYUNOU-REC      TO  MCPDATA-REC
           MOVE    "tbl_syunou"    TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC TO  SYUNOU-REC
           ELSE
               MOVE    1           TO  FLG-SYUNOU
               INITIALIZE              SYUNOU-REC
           END-IF
      *
           MOVE    "tbl_syunou"    TO  MCP-TABLE
           MOVE    "key"           TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-SYUNOU-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイル読込処理
      *****************************************************************
       900-BD01001-READ-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-BD01001
      *
           READ    BD01001-FILE    NEXT
           AT  END
               MOVE    1           TO  FLG-BD01001
           END-READ
      *
           .
       900-BD01001-READ-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイルSTART処理
      *****************************************************************
       901-BD01002-START-SEC       SECTION.
      *
           MOVE    ZERO            TO  FLG-BD01002
      *
           INITIALIZE                  BD01002-KEY
           MOVE    BD01001-DENPNUM TO  BD01002-DENPNUM
      *
           START   BD01002-FILE
               KEY IS  >=   BD01002-KEY
           INVALID
               MOVE    1               TO  FLG-BD01002
           NOT INVALID
               PERFORM 901-BD01002-READ-SEC
           END-START
      *
           .
       901-BD01002-START-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイル読込処理
      *****************************************************************
       901-BD01002-READ-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-BD01002
      *
           READ    BD01002-FILE    NEXT
           AT  END
                   MOVE    1       TO  FLG-BD01002
           NOT AT END
               IF    ( BD01001-DENPNUM NOT =   BD01002-DENPNUM )
                   MOVE    1       TO  FLG-BD01002
               END-IF
           END-READ
      *
           .
       901-BD01002-READ-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイル読込処理
      *****************************************************************
       900-BD01002-READ-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-BD01002
      *
           READ    BD01002-FILE    NEXT
           AT  END
               MOVE    1           TO  FLG-BD01002
           END-READ
      *
           .
       900-BD01002-READ-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイル読込処理
      *****************************************************************
       900-BD01003-READ-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-BD01003
      *
           READ    BD01003-FILE
           INVALID
               MOVE    1           TO  FLG-BD01003
           END-READ
      *
           .
       900-BD01003-READ-EXT.
           EXIT.
      *****************************************************************
      *    中間ファイル読込処理
      *****************************************************************
       900-BD01004-READ-SEC        SECTION.
      *
           MOVE    ZERO            TO  FLG-BD01004
      *
           READ    BD01004-FILE    NEXT
           AT  END
               MOVE    1           TO  FLG-BD01004
           END-READ
      *
           .
       900-BD01004-READ-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DBSELECT-SEC               SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MONFUNC"   USING   MCPAREA
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
      *    ＤＢ検索処理
      *****************************************************************
       911-DBSELECT-SEC               SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
           CALL    "MONFUNC"   USING   MCPAREA
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
           MOVE    "DBFETCH"       TO  MCP-FUNC
           CALL    "MONFUNC"   USING   MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC                SECTION.
      *
           MOVE    "DBCLOSECURSOR" TO  MCP-FUNC
           CALL    "MONFUNC"   USING   MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
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
      *    ＤＢ　切断処理
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
      *
           .
       900-DBDISCONNECT-EXT.
           EXIT.
