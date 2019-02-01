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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCBGS137.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 新保険別請求チェック表 社保
      *  管理者            :
      *  作成日付    作業者        記述
      *  11/01/13    NACL-太田     新規作成
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
      *    請求ファイル
           SELECT  BGSSKY-FILE     ASSIGN  ASS-BGSSKY
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  BGSSKY-KEY
                                   FILE    STATUS  IS  STS-BGSSKY.
      *
      *    公費ファイル
           SELECT  BGSKOH-FILE     ASSIGN  ASS-BGSKOH
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  BGSKOH-KEY
                                   FILE    STATUS  IS  STS-BGSKOH.
      *
      *    その他請求ファイル
           SELECT  BGSETC-FILE     ASSIGN  ASS-BGSETC
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  BGSETC-KEY
                                   FILE    STATUS  IS  STS-BGSETC.
      *
      *    エラーファイル
           SELECT  BGS100ERR-FILE  ASSIGN  ASS-BGS100ERR
                                   FILE    STATUS  IS  STS-BGS100ERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    請求ファイル
       FD  BGSSKY-FILE.
       01  BGSSKY-REC.
           COPY    "CPBGSF01.INC"  REPLACING  //BGSF01-//
                                   BY         //BGSSKY-//.
      *
      *    公費ファイル
       FD  BGSKOH-FILE.
       01  BGSKOH-REC.
           COPY    "CPBGSF01.INC"  REPLACING  //BGSF01-//
                                   BY         //BGSKOH-//.
      *    その他請求ファイル
       FD  BGSETC-FILE.
       01  BGSETC-REC.
           COPY    "CPBGSF01.INC"  REPLACING  //BGSF01-//
                                   BY         //BGSETC-//.
      *
      *    エラーファイル
       FD  BGS100ERR-FILE.
       01  BGS100ERR-REC           PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
           COPY  "HCGS137N1.INC".
           COPY  "HCGS137N2.INC".
           COPY  "HCGS137G.INC".
      *
           COPY "CPASGNPARA.INC"   REPLACING  //ASGNPARA//
                                   BY         //ASS-BGSSKY//.
      *
           COPY "CPASGNPARA.INC"   REPLACING  //ASGNPARA//
                                   BY         //ASS-BGSKOH//.
      *
           COPY "CPASGNPARA.INC"   REPLACING  //ASGNPARA//
                                   BY         //ASS-BGSETC//.
      *
           COPY "CPASGNPARA.INC"   REPLACING  //ASGNPARA//
                                   BY         //ASS-BGS100ERR//.
      *
       01  STS-AREA.
           03  STS-BGSSKY          PIC X(02).
           03  STS-BGSKOH          PIC X(02).
           03  STS-BGSETC          PIC X(02).
           03  STS-BGS100ERR       PIC X(02).
      *
       01  CNT-AREA.
           03  CNT-NYUIN           PIC 9(05).
           03  CNT-GAIRAI          PIC 9(05).
           03  CNT-PAGE            PIC 9(05).
           03  CNT-LINE            PIC 9(05).
           03  CNT-KENSU           PIC 9(05).
           03  CNT-LEN             PIC 9(05).
      *
       01  FLG-AREA.
           03  FLG-BGSSKY          PIC 9(01).
           03  FLG-BGSKOH          PIC 9(01).
           03  FLG-BGSETC          PIC 9(01).
           03  FLG-LOOPEND         PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
      *
       01  IDX-AREA.
           03  IDX0                PIC 9(05).
           03  IDX1                PIC 9(05).
           03  IDX2                PIC 9(05).
           03  IDX-HKN             PIC 9(05).
           03  IDX-TTL             PIC 9(05).
           03  IDX-KOH             PIC 9(05).
           03  IDX-BASE            PIC 9(05).
           03  IDXP                PIC 9(05).
           03  IDX-RECEKA          PIC 9(05).
           03  IDXI                PIC 9(05).
           03  IDXL                PIC 9(05).
      *
       01  WRK-AREA.
           03  WRK-ITEM-SIZE       PIC 9(05).
           03  WRK-ITEM            PIC X(100).
           03  WRK-SYMD            PIC X(08).
           03  WRK-EDTYMD1         PIC X(10).
           03  WRK-EDTYMD3         PIC X(22).
           03  WRK-ERRMSG          PIC X(200).
           03  WRK-Z3              PIC Z(3).
           03  WRK-Z4              PIC Z(4).
           03  WRK-Z5              PIC Z(5).
           03  WRK-Z9              PIC Z(9).
           03  WRK-M9              PIC -(9).
           03  WRK-HKNNUM          PIC X(3).
           03  WRK-TTLID           PIC 9(5).
           03  WRK-CSV-SRYYM       PIC X(10).
           03  WRK-PRT-SRYYM       PIC X(16).
           03  WRK-PRT-SAKYMD      PIC X(22).
           03  WRK-KANACHK-STR     PIC X(500).
           03  WRK-SRYKANAME1      PIC X(24).
           03  WRK-SKYSBTNAME      PIC X(50).
           03  WRK-MAX             PIC 9(05).
           03  WRK-CSVDATA         PIC X(20000).
           03  WRK-NYUGAIKBN       PIC X(01).
           03  WRK-NYUGAIKBNMEI    PIC X(04).
           03  WRK-PRTKBN          PIC X(01).
           03  WRK-PRTKBNMEI       PIC X(10).
           03  WRK-DATAKBN         PIC X(01).
           03  WRK-DATAKBNMEI      PIC X(50).
      *
       01  KEY-AREA.
           03  KEY-SKYSBT          PIC X(01).
           03  KEY-RECEKA          PIC X(02).
      *
       01  THKN-AREA.
           03  THKN-NYUGAI-OCC     OCCURS  2.
               05  THKN-BODY-OCC   OCCURS  100.
                   07  THKN-KENSU          PIC 9(06).
                   07  THKN-NISSU          PIC 9(08).
                   07  THKN-TENSU          PIC 9(08).
                   07  THKN-FTNMONEY       PIC 9(09).
                   07  THKN-HKNMONEY       PIC 9(09).
                   07  THKN-KOHMONEY       PIC 9(09).
                   07  THKN-TTLMONEY       PIC 9(09).
                   07  THKN-SKJKAISU       PIC 9(06).
                   07  THKN-SKJTTLMONEY    PIC 9(09).
                   07  THKN-SKJFTNMONEY    PIC 9(09).
                   07  THKN-SKJHKNMONEY    PIC 9(09).
                   07  THKN-SKJKOHMONEY    PIC 9(09).
                   07  THKN-TTLTTLMONEY    PIC 9(09).
      *
       01  TKOH-AREA.
           03  TKOH-NYUGAI-OCC     OCCURS  2.
               05  TKOH-CNT                PIC 9(05).
               05  TKOH-MAX                PIC 9(05).
               05  TKOH-KOHMSG             PIC 9(01).
               05  TKOH-BODY-OCC   OCCURS  30.
                   07  TKOH-KOHNUM         PIC X(03).
                   07  TKOH-KOHKBN         PIC X(01).
                   07  TKOH-KENSU          PIC 9(06).
                   07  TKOH-NISSU          PIC 9(08).
                   07  TKOH-TENSU          PIC 9(08).
      *
       01  TETC-AREA.
           03  TETC-NYUGAI-OCC     OCCURS  2.
               05  TETC-JIHIMONEY          PIC S9(08).
               05  TETC-GENMEN             PIC S9(08).
               05  TETC-CHOSEI1            PIC S9(08).
               05  TETC-CHOSEI2            PIC S9(08).
               05  TETC-HASU               PIC S9(08).
      *
       01  CSV-HEAD-AREA.
           03  CSV-H01-G.
               05  CSV-H01-VAL.
                   07  CSV-H01-PRTKBN          PIC X(50)
                           VALUE   "帳票区分".
                   07  CSV-H01-PRTKBNMEI       PIC X(50)
                           VALUE   "帳票区分名".
                   07  CSV-H01-DATAKBN         PIC X(50)
                           VALUE   "データ区分".
                   07  CSV-H01-DATAKBNMEI      PIC X(50)
                           VALUE   "データ区分名".
                   07  CSV-H01-SRYYMD          PIC X(50)
                           VALUE   "診療年月".
                   07  CSV-H01-NYUGAIKBN       PIC X(50)
                           VALUE   "入外区分".
                   07  CSV-H01-NYUGAIKBNMEI    PIC X(50)
                           VALUE   "入外区分名称".
                   07  CSV-H01-SKYSBTKBN       PIC X(50)
                           VALUE   "当月・当月外区分".
                   07  CSV-H01-SKYSBT          PIC X(50)
                           VALUE   "当月・当月外区分名称".
                   07  CSV-H01-SRYKA           PIC X(50)
                           VALUE   "診療科コード".
                   07  CSV-H01-SRYKAMEI        PIC X(50)
                           VALUE   "診療科名称".
                   07  CSV-H01-HKNKBN          PIC X(50)
                           VALUE   "保険区分".
                   07  CSV-H01-KENSU           PIC X(50)
                           VALUE   "件数".
                   07  CSV-H01-NISSU           PIC X(50)
                           VALUE   "日数".
                   07  CSV-H01-TENSU           PIC X(50)
                           VALUE   "点数".
                   07  CSV-H01-FTNMONEY        PIC X(50)
                           VALUE   "患者負担額".
                   07  CSV-H01-HKNMONEY        PIC X(50)
                           VALUE   "保険請求額".
                   07  CSV-H01-KOHMONEY        PIC X(50)
                           VALUE   "公費請求額".
                   07  CSV-H01-TTLMONEY        PIC X(50)
                           VALUE   "保険診療収益（ａ）".
                   07  CSV-H01-SKJKAISU        PIC X(50)
                           VALUE   "食事・生活回数".
                   07  CSV-H01-SKJTTLMONEY     PIC X(50)
                           VALUE   "食事・生活標準負担額".
                   07  CSV-H01-SKJHKNMONEY     PIC X(50)
                           VALUE   "食事・生活保険請求額".
                   07  CSV-H01-SKJKOHMONEY     PIC X(50)
                           VALUE   "食事・生活公費請求額".
                   07  CSV-H01-SKJFTNMONEY     PIC X(50)
                           VALUE   "食事・生活請求円（ｂ）".
                   07  CSV-H01-TTLTTLMONEY     PIC X(50)
                           VALUE   "（ａ）＋（ｂ）".
               05  CSV-H01-R   REDEFINES   CSV-H01-VAL.
                   07  CSV-H01-ITEM            PIC X(50)
                                               OCCURS  25.
               05  CSV-H01-MAX                 PIC 9(05)
                                               VALUE   25.
           03  CSV-H02-G.
               05  CSV-H02-VAL.
                   07  CSV-H02-PRTKBN          PIC X(50)
                           VALUE   "帳票区分".
                   07  CSV-H02-PRTKBNMEI       PIC X(50)
                           VALUE   "帳票区分名".
                   07  CSV-H02-DATAKBN         PIC X(50)
                           VALUE   "データ区分".
                   07  CSV-H02-DATAKBNMEI      PIC X(50)
                           VALUE   "データ区分名".
                   07  CSV-H02-SRYYMD          PIC X(50)
                           VALUE   "診療年月".
                   07  CSV-H02-NYUGAIKBN       PIC X(50)
                           VALUE   "入外区分".
                   07  CSV-H02-NYUGAIKBNMEI    PIC X(50)
                           VALUE   "入外区分名称".
                   07  CSV-H02-SKYSBTKBN       PIC X(50)
                           VALUE   "当月・当月外区分".
                   07  CSV-H02-SKYSBT          PIC X(50)
                           VALUE   "当月・当月外区分名称".
                   07  CSV-H02-SRYKA           PIC X(50)
                           VALUE   "診療科コード".
                   07  CSV-H02-SRYKAMEI        PIC X(50)
                           VALUE   "診療科名称".
                   07  CSV-H02-KOHNAME         PIC X(50)
                           VALUE   "公費単独および併用公費一覧".
                   07  CSV-H02-KENSU           PIC X(50)
                           VALUE   "件数".
                   07  CSV-H02-NISSU           PIC X(50)
                           VALUE   "日数".
                   07  CSV-H02-TENSU           PIC X(50)
                           VALUE   "点数".
               05  CSV-H02-R   REDEFINES   CSV-H02-VAL.
                   07  CSV-H02-ITEM            PIC X(50)
                                               OCCURS  15.
               05  CSV-H02-MAX                 PIC 9(05)
                                               VALUE   15.
           03  CSV-H03-G.
               05  CSV-H03-VAL.
                   07  CSV-H03-PRTKBN          PIC X(50)
                           VALUE   "帳票区分".
                   07  CSV-H03-PRTKBNMEI       PIC X(50)
                           VALUE   "帳票区分名".
                   07  CSV-H03-DATAKBN         PIC X(50)
                           VALUE   "データ区分".
                   07  CSV-H03-DATAKBNMEI      PIC X(50)
                           VALUE   "データ区分名".
                   07  CSV-H03-SRYYMD          PIC X(50)
                           VALUE   "診療年月".
                   07  CSV-H03-NYUGAIKBN       PIC X(50)
                           VALUE   "入外区分".
                   07  CSV-H03-NYUGAIKBNMEI    PIC X(50)
                           VALUE   "入外区分名称".
                   07  CSV-H03-SKYSBTKBN       PIC X(50)
                           VALUE   "当月・当月外区分".
                   07  CSV-H03-SKYSBT          PIC X(50)
                           VALUE   "当月・当月外区分名称".
                   07  CSV-H03-SRYKA           PIC X(50)
                           VALUE   "診療科コード".
                   07  CSV-H03-SRYKAMEI        PIC X(50)
                           VALUE   "診療科名称".
                   07  CSV-H03-ETCNAME         PIC X(50)
                           VALUE   "その他計".
                   07  CSV-H03-JIHIMONEY       PIC X(50)
                           VALUE   "自費".
                   07  CSV-H03-GENMEN          PIC X(50)
                           VALUE   "減免".
                   07  CSV-H03-CHOSEI1         PIC X(50)
                           VALUE   "調整金１".
                   07  CSV-H03-CHOSEI2         PIC X(50)
                           VALUE   "調整金２".
                   07  CSV-H03-HASU            PIC X(50)
                           VALUE   "窓口請求端数処理額".
               05  CSV-H03-R   REDEFINES   CSV-H03-VAL.
                   07  CSV-H03-ITEM            PIC X(50)
                                               OCCURS  17.
               05  CSV-H03-MAX                 PIC 9(05)
                                               VALUE   17.
           03  CSV-H04-G.
               05  CSV-H04-VAL.
                   07  CSV-H04-PRTKBN          PIC X(50)
                           VALUE   "帳票区分".
                   07  CSV-H04-PRTKBNMEI       PIC X(50)
                           VALUE   "帳票区分名".
                   07  CSV-H04-DATAKBN         PIC X(50)
                           VALUE   "データ区分".
                   07  CSV-H04-DATAKBNMEI      PIC X(50)
                           VALUE   "データ区分".
                   07  CSV-H04-SRYYMD          PIC X(50)
                           VALUE   "診療年月".
                   07  CSV-H04-NYUGAIKBN       PIC X(50)
                           VALUE   "入外区分".
                   07  CSV-H04-NYUGAIKBNMEI    PIC X(50)
                           VALUE   "入外区分名称".
                   07  CSV-H04-SKYSBTKBN       PIC X(50)
                           VALUE   "当月・当月外区分".
                   07  CSV-H04-SKYSBT          PIC X(50)
                           VALUE   "当月・当月外区分名称".
                   07  CSV-H04-SRYKA           PIC X(50)
                           VALUE   "診療科コード".
                   07  CSV-H04-SRYKAMEI        PIC X(50)
                           VALUE   "診療科名称".
                   07  CSV-H04-HKNKBN          PIC X(50)
                           VALUE   "保険区分".
                   07  CSV-H04-KENSU           PIC X(50)
                           VALUE   "件数".
                   07  CSV-H04-NISSU           PIC X(50)
                           VALUE   "日数".
                   07  CSV-H04-TENSU           PIC X(50)
                           VALUE   "点数".
                   07  CSV-H04-FTNMONEY        PIC X(50)
                           VALUE   "患者負担額".
                   07  CSV-H04-HKNMONEY        PIC X(50)
                           VALUE   "保険請求額".
                   07  CSV-H04-KOHMONEY        PIC X(50)
                           VALUE   "公費請求額".
                   07  CSV-H04-TTLMONEY        PIC X(50)
                           VALUE   "保険診療収益".
               05  CSV-H04-R   REDEFINES   CSV-H04-VAL.
                   07  CSV-H04-ITEM            PIC X(50)
                                               OCCURS  19.
               05  CSV-H04-MAX                 PIC 9(05)
                                               VALUE   19.
      *
       01  CONST-AREA.
           03  CONST-H2605         PIC X(06) VALUE "201405".
           03  CONST-SYAHO         PIC 9(02) VALUE 1.
           03  CONST-KOU9          PIC 9(03) VALUE 1.
           03  CONST-KOU7          PIC 9(03) VALUE 10.
           03  CONST-HON           PIC 9(03) VALUE 19.
           03  CONST-KZK           PIC 9(03) VALUE 29.
           03  CONST-MISGK         PIC 9(03) VALUE 38.
           03  CONST-HKNTTL        PIC 9(03) VALUE 47.
           03  CONST-KOHTAN        PIC 9(03) VALUE 48.
           03  CONST-KOH2HEI       PIC 9(03) VALUE 49.
           03  CONST-KOH3HEI       PIC 9(03) VALUE 50.
           03  CONST-KOH4HEI       PIC 9(03) VALUE 51.
           03  CONST-KOHTTL        PIC 9(03) VALUE 52.
           03  CONST-HKNKOHTTL     PIC 9(03) VALUE 53.
           03  CONST-TKOH-MAX      PIC 9(03) VALUE 30.
           03  CONST-HKNMEI-G.
               05  CONST-HKNMEI01  PIC X(50)
                                   VALUE "高９公費併用".
               05  CONST-HKNMEI02  PIC X(50)
                                   VALUE "高９単独０１".
               05  CONST-HKNMEI03  PIC X(50)
                                   VALUE "高９単独０２".
               05  CONST-HKNMEI04  PIC X(50)
                                   VALUE "高９単独０３".
               05  CONST-HKNMEI05  PIC X(50)
                                   VALUE "高９単独０４".
               05  CONST-HKNMEI06  PIC X(50)
                                   VALUE "高９単独３１〜３４".
               05  CONST-HKNMEI07  PIC X(50)
                                   VALUE "高９単独０６".
               05  CONST-HKNMEI08  PIC X(50)
                                   VALUE "高９単独６３・７２〜７５".
               05  CONST-HKNMEI09  PIC X(50)
                                   VALUE "高９単独小計".
               05  CONST-HKNMEI10  PIC X(50)
                                   VALUE "高７公費併用".
               05  CONST-HKNMEI11  PIC X(50)
                                   VALUE "高７単独０１".
               05  CONST-HKNMEI12  PIC X(50)
                                   VALUE "高７単独０２".
               05  CONST-HKNMEI13  PIC X(50)
                                   VALUE "高７単独０３".
               05  CONST-HKNMEI14  PIC X(50)
                                   VALUE "高７単独０４".
               05  CONST-HKNMEI15  PIC X(50)
                                   VALUE "高７単独３１〜３４".
               05  CONST-HKNMEI16  PIC X(50)
                                   VALUE "高７単独０６".
               05  CONST-HKNMEI17  PIC X(50)
                                   VALUE "高７単独６３・７２〜７５".
               05  CONST-HKNMEI18  PIC X(50)
                                   VALUE "高７単独小計".
               05  CONST-HKNMEI19  PIC X(50)
                                   VALUE "本人公費併用".
               05  CONST-HKNMEI20  PIC X(50)
                                   VALUE "本人単独０１".
               05  CONST-HKNMEI21  PIC X(50)
                                   VALUE "本人単独０２".
               05  CONST-HKNMEI22  PIC X(50)
                                   VALUE "本人単独０３".
               05  CONST-HKNMEI23  PIC X(50)
                                   VALUE "本人単独０４".
               05  CONST-HKNMEI24  PIC X(50)
                                   VALUE "本人単独３１〜３４".
               05  CONST-HKNMEI25  PIC X(50)
                                   VALUE "本人単独０６".
               05  CONST-HKNMEI26  PIC X(50)
                                   VALUE "本人単独０７".
               05  CONST-HKNMEI27  PIC X(50)
                                   VALUE "本人単独６３・７２〜７５".
               05  CONST-HKNMEI28  PIC X(50)
                                   VALUE "本人単独小計".
               05  CONST-HKNMEI29  PIC X(50)
                                   VALUE "家族公費併用".
               05  CONST-HKNMEI30  PIC X(50)
                                   VALUE "家族単独０１".
               05  CONST-HKNMEI31  PIC X(50)
                                   VALUE "家族単独０２".
               05  CONST-HKNMEI32  PIC X(50)
                                   VALUE "家族単独０３".
               05  CONST-HKNMEI33  PIC X(50)
                                   VALUE "家族単独０４".
               05  CONST-HKNMEI34  PIC X(50)
                                   VALUE "家族単独３１〜３４".
               05  CONST-HKNMEI35  PIC X(50)
                                   VALUE "家族単独０６".
               05  CONST-HKNMEI36  PIC X(50)
                                   VALUE "家族単独６３・７２〜７５".
               05  CONST-HKNMEI37  PIC X(50)
                                   VALUE "家族単独小計".
               05  CONST-HKNMEI38  PIC X(50)
                                   VALUE "家族公費併用".
               05  CONST-HKNMEI39  PIC X(50)
                                   VALUE "家族単独０１".
               05  CONST-HKNMEI40  PIC X(50)
                                   VALUE "家族単独０２".
               05  CONST-HKNMEI41  PIC X(50)
                                   VALUE "家族単独０３".
               05  CONST-HKNMEI42  PIC X(50)
                                   VALUE "家族単独０４".
               05  CONST-HKNMEI43  PIC X(50)
                                   VALUE "家族単独３１〜３４".
               05  CONST-HKNMEI44  PIC X(50)
                                   VALUE "家族単独０６".
               05  CONST-HKNMEI45  PIC X(50)
                                   VALUE "家族単独６３・７２〜７５".
               05  CONST-HKNMEI46  PIC X(50)
                                   VALUE "家族単独小計".
               05  CONST-HKNMEI47  PIC X(50)
                                   VALUE "小計（１）（医療保険）".
               05  CONST-HKNMEI48  PIC X(50)
                                   VALUE "公費単独".
               05  CONST-HKNMEI49  PIC X(50)
                                   VALUE "公費併用２".
               05  CONST-HKNMEI50  PIC X(50)
                                   VALUE "公費併用３".
               05  CONST-HKNMEI51  PIC X(50)
                                   VALUE "公費併用４".
               05  CONST-HKNMEI52  PIC X(50)
                       VALUE "小計（２）（公費単独・公費と公費の併用）".
               05  CONST-HKNMEI53  PIC X(50)
                       VALUE "総計（（１）＋（２））".
           03  CONST-HKNMEI-R  REDEFINES   CONST-HKNMEI-G.
               05  CONST-HKNMEI-OCC    OCCURS 53.
                   07  CONST-HKNMEI    PIC X(50).
      *
       01  BGSF01-REC.
           COPY    "CPBGSF01.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理
           COPY    "CPSYSKANRI.INC".
           COPY    "CPSK1005.INC".
      *
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    文字列操作サブ
           COPY    "CPORCSSTRING.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *    全角半角チェック
           COPY    "CPORCSKANACHK.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    統計ＣＳＶ制御サブ
           COPY    "CPORCSTOUKEICSV.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
           COPY    "MCPDATA.INC".
      *
      ****************************************************************
       LINKAGE                     SECTION.
       01  BGS100P-AREA.
           COPY    "CPORCSPRTLNK.INC".
           COPY    "CPBGS100PARA.INC".
      *
           COPY    "COMMON-SPA".
      *
      ****************************************************************
       PROCEDURE               DIVISION
                                       USING
                                       BGS100P-AREA
                                       SPA-AREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
      *
           PERFORM 300-END-SEC
      *
           PERFORM 990-EXIT-PROGRAM-SEC
      *
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                      STS-AREA
                                           CNT-AREA
                                           FLG-AREA
                                           IDX-AREA
                                           WRK-AREA
                                           THKN-AREA
                                           TKOH-AREA
                                           TETC-AREA
      *
           MOVE    BGS100P-SKYFNAME    TO  ASS-BGSSKY
           MOVE    BGS100P-KOHFNAME    TO  ASS-BGSKOH
           MOVE    BGS100P-ETCFNAME    TO  ASS-BGSETC
           MOVE    BGS100P-ERRFNAME    TO  ASS-BGS100ERR
      *
           MOVE    "STM"               TO  SJOBKANRI-MODE
           INITIALIZE                      JOBKANRI-REC
           MOVE    "社保分作成中"
                                       TO  JOB-YOBI
           PERFORM 800-ORCSJOB-SEC
      *
           MOVE    SPA-SYSYMD          TO  WRK-SYMD
           PERFORM 800-HIZUKE-EDIT-SEC
           MOVE    WRK-EDTYMD3         TO  WRK-PRT-SAKYMD
      *
           MOVE    BGS100P-SRYYMD      TO  WRK-SYMD
           PERFORM 800-HIZUKE-EDIT-SEC
           MOVE    WRK-EDTYMD3(1:16)   TO  WRK-PRT-SRYYM
      *
           MOVE    BGS100P-SRYYM(1:4)  TO  WRK-CSV-SRYYM(1:4)
           MOVE    "/"                 TO  WRK-CSV-SRYYM(5:1)
           MOVE    BGS100P-SRYYM(5:2)  TO  WRK-CSV-SRYYM(6:2)
      *
           MOVE    SPACE               TO  WRK-ITEM
           INSPECT WRK-ITEM  TALLYING  WRK-ITEM-SIZE   FOR ALL " "
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           IF    ( BGS100P-EDITKBN =   "1" )
               MOVE    "1"         TO  KEY-SKYSBT
               PERFORM 201-MAIN-SEC
               MOVE    "2"         TO  KEY-SKYSBT
               PERFORM 201-MAIN-SEC
           ELSE
               MOVE    SPACE       TO  KEY-SKYSBT
               PERFORM 201-MAIN-SEC
           END-IF
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　処理
      *****************************************************************
       201-MAIN-SEC                SECTION.
      *
           IF    ( BGS100P-SYUKA-SYA   =   1 )
               PERFORM VARYING IDX-RECEKA  FROM    1   BY  1
                       UNTIL ( IDX-RECEKA  >   BGS100P-RECEKA-MAX )
      *
                   MOVE    BGS100P-RECEKA (IDX-RECEKA)
                                   TO  KEY-RECEKA
      *
                   PERFORM 2001-MAIN-SEC
               END-PERFORM
               MOVE    SPACE       TO  KEY-RECEKA
               PERFORM 2001-MAIN-SEC
           ELSE
               MOVE    SPACE       TO  KEY-RECEKA
               PERFORM 2001-MAIN-SEC
           END-IF
      *
           .
       201-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　処理
      *****************************************************************
       2001-MAIN-SEC               SECTION.
      *
           MOVE    ZERO            TO      CNT-NYUIN
                                           CNT-GAIRAI
      *
           INITIALIZE                      THKN-AREA
                                           TKOH-AREA
                                           TETC-AREA
      *
           MOVE    SPACE               TO      WRK-SKYSBTNAME
           IF    ( BGS100P-EDITKBN =   "1" )
               EVALUATE    KEY-SKYSBT
               WHEN    "1"
                   MOVE  "当月診療分"  TO      WRK-SKYSBTNAME
               WHEN    "2"
                   MOVE  "当月診療分以外（月遅れ請求、返戻分再請求）"
                                       TO      WRK-SKYSBTNAME
               END-EVALUATE
           END-IF
      *
           MOVE    SPACE           TO      WRK-SRYKANAME1
           IF    ( BGS100P-SYUKA-SYA   =   1 )
               EVALUATE    KEY-RECEKA
               WHEN    SPACE
                   MOVE    "全科合計"  TO  WRK-SRYKANAME1
               WHEN    "00"
                   MOVE    "主科設定なし"
                                       TO  WRK-SRYKANAME1
               WHEN    OTHER
                   INITIALIZE                  SYSKANRI-REC
                   MOVE    SPA-HOSPNUM     TO  SYS-HOSPNUM
                   MOVE    "1005"          TO  SYS-KANRICD
                   MOVE    KEY-RECEKA      TO  SYS-KBNCD
                   MOVE    BGS100P-SRYYMD  TO  SYS-STYUKYMD
                                               SYS-EDYUKYMD
                   PERFORM 900-SYSKANRI-KEY10-SEL-SEC
                   MOVE    SYSKANRI-REC    TO  SYS-1005-REC
                   MOVE    SYS-1005-SRYKANAME1
                                       TO  WRK-SRYKANAME1
               END-EVALUATE
           END-IF
      *
           PERFORM 2001-SKY-EDIT-SEC
      *
           PERFORM 2001-KOH-EDIT-SEC
      *
           PERFORM 2001-ETC-EDIT-SEC
      *
           IF    ( CNT-NYUIN   >   ZERO )
               MOVE    1       TO  IDX1
               PERFORM 2001-HCGS137N1-EDIT-SEC
               PERFORM 2001-HCGS137N2-EDIT-SEC
               PERFORM 2001-HCGS137N-CSV-SEC
           END-IF
      *
           IF    ( CNT-GAIRAI  >   ZERO )
               MOVE    2       TO  IDX1
               PERFORM 2001-HCGS137G-EDIT-SEC
               PERFORM 2001-HCGS137G-CSV-SEC
           END-IF
      *
           .
       2001-MAIN-EXT.
           EXIT.
      *****************************************************************
      *    請求情報編集処理
      *****************************************************************
       2001-SKY-EDIT-SEC           SECTION.
      *
            OPEN    INPUT  BGSSKY-FILE
      *
            PERFORM 900-BGSSKY-READ-SEC
      *
            PERFORM UNTIL ( FLG-BGSSKY NOT =   ZERO )
      *
                PERFORM 20011-SKY-EDIT-SEC
      *
                PERFORM 900-BGSSKY-READ-SEC
      *
            END-PERFORM
      *
            CLOSE   BGSSKY-FILE
      *
           .
       2001-SKY-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    請求情報編集処理
      *****************************************************************
       20011-SKY-EDIT-SEC           SECTION.
      *
           IF    ( BGSSKY-NYUGAIKBN =   "1" )
               MOVE    1           TO   IDX1
           ELSE
               MOVE    2           TO   IDX1
           END-IF
      *
           EVALUATE    BGSSKY-RECESBT
           WHEN    "1117"
           WHEN    "1118"
           WHEN    "1127"
           WHEN    "1128"
           WHEN    "1137"
           WHEN    "1138"
           WHEN    "1147"
           WHEN    "1148"
           WHEN    "1157"
           WHEN    "1158"
               MOVE    CONST-KOU9  TO  IDX-BASE
               PERFORM 200111-SKY-SUM-SEC
           WHEN    "1119"
           WHEN    "1110"
           WHEN    "1129"
           WHEN    "1120"
           WHEN    "1139"
           WHEN    "1130"
           WHEN    "1149"
           WHEN    "1140"
           WHEN    "1159"
           WHEN    "1150"
               MOVE    CONST-KOU7  TO  IDX-BASE
               PERFORM 200111-SKY-SUM-SEC
           WHEN    "1111"
           WHEN    "1112"
           WHEN    "1121"
           WHEN    "1122"
           WHEN    "1131"
           WHEN    "1132"
           WHEN    "1141"
           WHEN    "1142"
           WHEN    "1151"
           WHEN    "1152"
               MOVE    CONST-HON   TO  IDX-BASE
               PERFORM 200111-SKY-SUM-SEC
           WHEN    "1115"
           WHEN    "1116"
           WHEN    "1125"
           WHEN    "1126"
           WHEN    "1135"
           WHEN    "1136"
           WHEN    "1145"
           WHEN    "1146"
           WHEN    "1155"
           WHEN    "1156"
               MOVE    CONST-KZK   TO  IDX-BASE
               PERFORM 200111-SKY-SUM-SEC
           WHEN    "1113"
           WHEN    "1114"
           WHEN    "1123"
           WHEN    "1124"
           WHEN    "1133"
           WHEN    "1134"
           WHEN    "1143"
           WHEN    "1144"
           WHEN    "1153"
           WHEN    "1154"
               MOVE    CONST-MISGK TO  IDX-BASE
               PERFORM 200111-SKY-SUM-SEC
           WHEN    "1211"
           WHEN    "1212"
               MOVE    CONST-KOHTAN    TO  IDX2
               PERFORM 2001111-SKY-SUM-SEC
               MOVE    CONST-KOHTTL    TO  IDX2
               PERFORM 2001111-SKY-SUM-SEC
           WHEN    "1221"
           WHEN    "1222"
               MOVE    CONST-KOH2HEI   TO  IDX2
               PERFORM 2001111-SKY-SUM-SEC
               MOVE    CONST-KOHTTL    TO  IDX2
               PERFORM 2001111-SKY-SUM-SEC
           WHEN    "1231"
           WHEN    "1232"
           WHEN    "1241"
           WHEN    "1242"
               MOVE    CONST-KOH3HEI   TO  IDX2
               PERFORM 2001111-SKY-SUM-SEC
               MOVE    CONST-KOHTTL    TO  IDX2
               PERFORM 2001111-SKY-SUM-SEC
           WHEN    OTHER
               DISPLAY "RECESBT[" BGSSKY-RECESBT "]" BGSSKY-REC
           END-EVALUATE
      *
           MOVE    CONST-HKNKOHTTL     TO  IDX2
           PERFORM 2001111-SKY-SUM-SEC
      *
           .
       20011-SKY-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    請求情報集計処理
      *****************************************************************
       200111-SKY-SUM-SEC          SECTION.
      *
           IF    ( BGSSKY-RECESBT(1:3) =   "111" )
      *
               PERFORM 200111-HKNIDX-CHK-SEC
      *
               IF    ( IDX-HKN     >   ZERO )
                   COMPUTE IDX2
                       =   IDX-BASE    +   IDX-HKN
                   PERFORM 2001111-SKY-SUM-SEC
               END-IF
      *
               IF    ( IDX-TTL     >   ZERO )
                   COMPUTE IDX2
                       =   IDX-BASE    +   IDX-TTL
                   PERFORM 2001111-SKY-SUM-SEC
               END-IF
               MOVE    CONST-HKNTTL TO IDX2
               PERFORM 2001111-SKY-SUM-SEC
           ELSE
      *
               MOVE    IDX-BASE    TO  IDX2
               PERFORM 2001111-SKY-SUM-SEC
      *
               MOVE    CONST-HKNTTL TO IDX2
               PERFORM 2001111-SKY-SUM-SEC
           END-IF
      *
           .
       200111-SKY-SUM-EXT.
           EXIT.
      *****************************************************************
      *    請求情報集計処理
      *****************************************************************
       2001111-SKY-SUM-SEC         SECTION.
      *
           COMPUTE THKN-KENSU (IDX1 IDX2)
               =   THKN-KENSU (IDX1 IDX2)    +   BGSSKY-KENSU
           COMPUTE THKN-NISSU (IDX1 IDX2)
               =   THKN-NISSU (IDX1 IDX2)    +   BGSSKY-NISSU
           COMPUTE THKN-TENSU (IDX1 IDX2)
               =   THKN-TENSU (IDX1 IDX2)        + BGSSKY-TENSU
           COMPUTE THKN-FTNMONEY (IDX1 IDX2)
               =   THKN-FTNMONEY (IDX1 IDX2)     + BGSSKY-FTNMONEY
           COMPUTE THKN-HKNMONEY (IDX1 IDX2)
               =   THKN-HKNMONEY (IDX1 IDX2)     + BGSSKY-HKNMONEY
           COMPUTE THKN-KOHMONEY (IDX1 IDX2)
               =   THKN-KOHMONEY (IDX1 IDX2)     + BGSSKY-KOHMONEY
           COMPUTE THKN-TTLMONEY (IDX1 IDX2)
               =   THKN-TTLMONEY (IDX1 IDX2)     + BGSSKY-TTLMONEY
      *
           COMPUTE THKN-SKJKAISU (IDX1 IDX2)
               =   THKN-SKJKAISU (IDX1 IDX2)     + BGSSKY-SKJKAISU
           COMPUTE THKN-SKJTTLMONEY (IDX1 IDX2)
               =   THKN-SKJTTLMONEY (IDX1 IDX2)  + BGSSKY-SKJTTLMONEY
           COMPUTE THKN-SKJFTNMONEY (IDX1 IDX2)
               =   THKN-SKJFTNMONEY (IDX1 IDX2)  + BGSSKY-SKJFTNMONEY
           COMPUTE THKN-SKJHKNMONEY (IDX1 IDX2)
               =   THKN-SKJHKNMONEY (IDX1 IDX2)  + BGSSKY-SKJHKNMONEY
           COMPUTE THKN-SKJKOHMONEY (IDX1 IDX2)
               =   THKN-SKJKOHMONEY (IDX1 IDX2)  + BGSSKY-SKJKOHMONEY
           COMPUTE THKN-TTLTTLMONEY (IDX1 IDX2)
               =   THKN-TTLTTLMONEY (IDX1 IDX2)  + BGSSKY-TTLTTLMONEY
      *
           IF    ( IDX1    =   1 )
               COMPUTE CNT-NYUIN   =   CNT-NYUIN   +   1
           ELSE
               COMPUTE CNT-GAIRAI  =   CNT-GAIRAI  +   1
           END-IF
      *
           .
       2001111-SKY-SUM-EXT.
           EXIT.
      *****************************************************************
      *    保険別集計先チェック処理
      *****************************************************************
       200111-HKNIDX-CHK-SEC           SECTION.
      *
           MOVE    ZERO            TO  IDX-HKN
           MOVE    ZERO            TO  IDX-TTL
      *
           EVALUATE     BGSSKY-RECESBT
           WHEN    "1111"
           WHEN    "1112"
               MOVE    9           TO  IDX-TTL
               EVALUATE    BGSSKY-HKNNUM
               WHEN    "001"
               WHEN    "009"
                   MOVE    1       TO  IDX-HKN
               WHEN    "002"
                   MOVE    2       TO  IDX-HKN
               WHEN    "003"
                   MOVE    3       TO  IDX-HKN
               WHEN    "004"
                   MOVE    4       TO  IDX-HKN
               WHEN    "031"   THRU    "034"
                   MOVE    5       TO  IDX-HKN
               WHEN    "006"
                   MOVE    6       TO  IDX-HKN
               WHEN    "007"
                   MOVE    7       TO  IDX-HKN
               WHEN    "063"
               WHEN    "072"   THRU    "075"
                   MOVE    8       TO  IDX-HKN
               END-EVALUATE
           WHEN    OTHER
               MOVE    8           TO  IDX-TTL
               EVALUATE    BGSSKY-HKNNUM
               WHEN    "001"
               WHEN    "009"
                   MOVE    1       TO  IDX-HKN
               WHEN    "002"
                   MOVE    2       TO  IDX-HKN
               WHEN    "003"
                   MOVE    3       TO  IDX-HKN
               WHEN    "004"
                   MOVE    4       TO  IDX-HKN
               WHEN    "031"   THRU    "034"
                   MOVE    5       TO  IDX-HKN
               WHEN    "006"
                   MOVE    6       TO  IDX-HKN
               WHEN    "063"
               WHEN    "072"   THRU    "075"
                   MOVE    7       TO  IDX-HKN
               END-EVALUATE
           END-EVALUATE
      *
           IF    ( IDX-HKN     =   ZERO )
               DISPLAY "HKNNUM[" BGSSKY-HKNNUM "]" BGSSKY-REC
           END-IF
      *
           .
       200111-HKNIDX-CHK-EXT.
           EXIT.
      *****************************************************************
      *    公費情報編集処理
      *****************************************************************
       2001-KOH-EDIT-SEC           SECTION.
      *
            OPEN    INPUT  BGSKOH-FILE
      *
            PERFORM 900-BGSKOH-READ-SEC
      *
            PERFORM UNTIL ( FLG-BGSKOH NOT =   ZERO )
      *
                PERFORM 20011-KOH-EDIT-SEC
      *
                PERFORM 900-BGSKOH-READ-SEC
      *
            END-PERFORM
      *
            CLOSE   BGSKOH-FILE
      *
           .
       2001-KOH-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    公費情報編集処理
      *****************************************************************
       20011-KOH-EDIT-SEC          SECTION.
      *
           IF    ( BGSKOH-NYUGAIKBN    =  "1" )
               MOVE    1           TO  IDX1
           ELSE
               MOVE    2           TO  IDX1
           END-IF
      *
           COMPUTE TKOH-CNT (IDX1)
              =    TKOH-CNT (IDX1)    +   1
      *
           IF    ( TKOH-CNT (IDX1)    >    CONST-TKOH-MAX )
               MOVE    CONST-TKOH-MAX  TO  IDX2
                                           TKOH-MAX (IDX1)
           ELSE
               MOVE    TKOH-CNT (IDX1) TO  IDX2
                                           TKOH-MAX (IDX1)
               MOVE    BGSKOH-KOHNUM   TO  TKOH-KOHNUM (IDX1 IDX2)
               MOVE    BGSKOH-KOHKBN   TO  TKOH-KOHKBN (IDX1 IDX2)
               IF    ( BGSKOH-KOHKBN   =   "2" )
                   MOVE    1           TO  TKOH-KOHMSG (IDX1)
               END-IF
           END-IF
      *
           COMPUTE TKOH-KENSU (IDX1 IDX2)
               =   TKOH-KENSU (IDX1 IDX2)  +   BGSKOH-KENSU
      *
           COMPUTE TKOH-NISSU (IDX1 IDX2)
               =   TKOH-NISSU (IDX1 IDX2)  +   BGSKOH-NISSU
      *
           COMPUTE TKOH-TENSU (IDX1 IDX2)
               =   TKOH-TENSU (IDX1 IDX2)  +   BGSKOH-TENSU
      *
           .
       20011-KOH-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    請求情報編集処理
      *****************************************************************
       2001-ETC-EDIT-SEC           SECTION.
      *
            OPEN    INPUT  BGSETC-FILE
      *
            PERFORM 900-BGSETC-READ-SEC
      *
            PERFORM UNTIL ( FLG-BGSETC NOT =   ZERO )
      *
               IF    ( BGSETC-NYUGAIKBN    =  "1" )
                   MOVE    1           TO  IDX1
               ELSE
                   MOVE    2           TO  IDX1
               END-IF
      *
               MOVE    BGSETC-JIHIMONEY    TO  TETC-JIHIMONEY (IDX1)
               MOVE    BGSETC-GENMEN       TO  TETC-GENMEN    (IDX1)
               MOVE    BGSETC-CHOSEI1      TO  TETC-CHOSEI1   (IDX1)
               MOVE    BGSETC-CHOSEI2      TO  TETC-CHOSEI2   (IDX1)
               MOVE    BGSETC-HASU         TO  TETC-HASU      (IDX1)
      *
               PERFORM 900-BGSETC-READ-SEC
      *
            END-PERFORM
      *
            CLOSE   BGSETC-FILE
      *
           .
       2001-ETC-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    入院チェック表編集処理（１枚目）
      *****************************************************************
       2001-HCGS137N1-EDIT-SEC         SECTION.
      *
           INITIALIZE                      HCGS137N1
      *
           MOVE    WRK-PRT-SRYYM       TO  HCGS137N1-SRYYM
           MOVE    "入院"              TO  HCGS137N1-NYUGAI
           MOVE    WRK-PRT-SAKYMD      TO  HCGS137N1-SYSYMD
           MOVE    WRK-SKYSBTNAME      TO  HCGS137N1-SKYSBT
           MOVE    WRK-SRYKANAME1      TO  HCGS137N1-SRYKANAME
      *
           COMPUTE CNT-PAGE  = CNT-PAGE    +   1
           MOVE    CNT-PAGE            TO  WRK-Z3
           MOVE    WRK-Z3              TO  HCGS137N1-PAGE
      *
           MOVE    ZERO                TO  CNT-LINE
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   CONST-HKNTTL )
      *
               COMPUTE CNT-LINE    =   CNT-LINE    +   1
      *
               MOVE    THKN-KENSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137N1-KENSU (CNT-LINE)
      *
               MOVE    THKN-NISSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137N1-NISSU (CNT-LINE)
      *
               MOVE    THKN-TENSU (IDX1 IDX2)     TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N1-TENSU (CNT-LINE)
      *
               MOVE    THKN-FTNMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N1-FTNMONEY (CNT-LINE)
      *
               MOVE    THKN-HKNMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N1-HKNMONEY (CNT-LINE)
      *
               MOVE    THKN-KOHMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N1-KOHMONEY (CNT-LINE)
      *
               MOVE    THKN-TTLMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N1-TTLMONEY (CNT-LINE)
      *
               MOVE    THKN-SKJKAISU (IDX1 IDX2)  TO  WRK-Z5
               MOVE    WRK-Z5  TO  HCGS137N1-SKJKAISU (CNT-LINE)
      *
               MOVE    THKN-SKJTTLMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N1-SKJTTLMONEY (CNT-LINE)
      *
               MOVE    THKN-SKJFTNMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N1-SKJFTNMONEY (CNT-LINE)
      *
               MOVE    THKN-SKJHKNMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N1-SKJHKNMONEY (CNT-LINE)
      *
               MOVE    THKN-SKJKOHMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N1-SKJKOHMONEY (CNT-LINE)
      *
               MOVE    THKN-TTLTTLMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N1-TTLTTLMONEY (CNT-LINE)
      *
           END-PERFORM
      *
           IF    ( BGS100P-SRYYM   >=  CONST-H2605 )
               STRING  "MonpeLayerIn"      DELIMITED  BY  SIZE
                       " -L LBL0101 "      DELIMITED  BY  SIZE
                       "MonpeLayerOut"     DELIMITED  BY  SIZE
               INTO    HCGS137N1-LOPTION
               END-STRING
           ELSE
               STRING  "MonpeLayerIn"      DELIMITED  BY  SIZE
                       " -L LBL0102 "      DELIMITED  BY  SIZE
                       "MonpeLayerOut"     DELIMITED  BY  SIZE
               INTO    HCGS137N1-LOPTION
               END-STRING
           END-IF
      *
           PERFORM 230-HCGS137N1-PRINT-SEC
      *
           .
       2001-HCGS137N1-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    印刷処理
      *****************************************************************
       230-HCGS137N1-PRINT-SEC         SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
      *
           MOVE    "HCGS137N1.red" TO  SPRT-PRTID
           MOVE    HCGS137N1       TO  SPRT-PRTDATA
      *
           PERFORM 230-PRINT-SEC
      *
           .
       230-HCGS137N1-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    入院チェック表編集処理（２枚目）
      *****************************************************************
       2001-HCGS137N2-EDIT-SEC         SECTION.
      *
           INITIALIZE                      HCGS137N2
      *
           MOVE    WRK-PRT-SRYYM       TO  HCGS137N2-SRYYM
           MOVE    "入院"              TO  HCGS137N2-NYUGAI
           MOVE    WRK-PRT-SAKYMD      TO  HCGS137N2-SYSYMD
           MOVE    WRK-SKYSBTNAME      TO  HCGS137N2-SKYSBT
           MOVE    WRK-SRYKANAME1      TO  HCGS137N2-SRYKANAME
      *
           COMPUTE CNT-PAGE  = CNT-PAGE    +   1
           MOVE    CNT-PAGE            TO  WRK-Z3
           MOVE    WRK-Z3              TO  HCGS137N2-PAGE
      *
           MOVE    ZERO                TO  CNT-LINE
           PERFORM VARYING IDX2    FROM    CONST-KOHTAN  BY  1
                   UNTIL ( IDX2    >       CONST-KOHTTL )
      *
               COMPUTE CNT-LINE    =   CNT-LINE    +   1
      *
               MOVE    THKN-KENSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137N2-KENSU (CNT-LINE)
      *
               MOVE    THKN-NISSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137N2-NISSU (CNT-LINE)
      *
               MOVE    THKN-TENSU (IDX1 IDX2)     TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-TENSU (CNT-LINE)
      *
               MOVE    THKN-FTNMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-FTNMONEY (CNT-LINE)
      *
               MOVE    THKN-HKNMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-HKNMONEY (CNT-LINE)
      *
               MOVE    THKN-KOHMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-KOHMONEY (CNT-LINE)
      *
               MOVE    THKN-TTLMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-TTLMONEY (CNT-LINE)
      *
               MOVE    THKN-SKJKAISU (IDX1 IDX2)  TO  WRK-Z5
               MOVE    WRK-Z5  TO  HCGS137N2-SKJKAISU (CNT-LINE)
      *
               MOVE    THKN-SKJTTLMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-SKJTTLMONEY (CNT-LINE)
      *
               MOVE    THKN-SKJFTNMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-SKJFTNMONEY (CNT-LINE)
      *
               MOVE    THKN-SKJHKNMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-SKJHKNMONEY (CNT-LINE)
      *
               MOVE    THKN-SKJKOHMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-SKJKOHMONEY (CNT-LINE)
      *
               MOVE    THKN-TTLTTLMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-TTLTTLMONEY (CNT-LINE)
      *
           END-PERFORM
      *
               MOVE    CONST-HKNKOHTTL         TO  IDX2
      *
               MOVE    THKN-KENSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137N2-GKENSU
      *
               MOVE    THKN-NISSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137N2-GNISSU
      *
               MOVE    THKN-TENSU (IDX1 IDX2)     TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-GTENSU
      *
               MOVE    THKN-FTNMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-GFTNMONEY
      *
               MOVE    THKN-HKNMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-GHKNMONEY
      *
               MOVE    THKN-KOHMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-GKOHMONEY
      *
               MOVE    THKN-TTLMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-GTTLMONEY
      *
               MOVE    THKN-SKJKAISU (IDX1 IDX2)  TO  WRK-Z5
               MOVE    WRK-Z5  TO  HCGS137N2-GSKJKAISU
      *
               MOVE    THKN-SKJTTLMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-GSKJTTLMONEY
      *
               MOVE    THKN-SKJFTNMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-GSKJFTNMONEY
      *
               MOVE    THKN-SKJHKNMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-GSKJHKNMONEY
      *
               MOVE    THKN-SKJKOHMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-GSKJKOHMONEY
      *
               MOVE    THKN-TTLTTLMONEY (IDX1 IDX2)   TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-GTTLTTLMONEY
      *
           MOVE    ZERO                TO  CNT-LINE
           MOVE    ZERO                TO  CNT-KENSU
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >       TKOH-MAX (IDX1) )
      *
               COMPUTE CNT-LINE  = CNT-LINE  +   1
      *
               COMPUTE CNT-KENSU = CNT-KENSU +   TKOH-KENSU (IDX1 IDX2)
      *
               MOVE    TKOH-KOHNUM (IDX1 IDX2)    TO  WRK-HKNNUM
               PERFORM 900-HKNNUM-KEY-SEL-SEC
               MOVE    SPACE           TO  WRK-KANACHK-STR
               MOVE    1               TO  IDXP
               IF    ( TKOH-KOHKBN (IDX1 IDX2)    =   "1" )
                   STRING  "　"            DELIMITED BY SIZE
                   INTO    WRK-KANACHK-STR
                   WITH    POINTER IDXP
                   END-STRING
               ELSE
                   STRING    "＊"          DELIMITED BY SIZE
                   INTO    WRK-KANACHK-STR
                   WITH    POINTER IDXP
                   END-STRING
               END-IF
               STRING  HKN-HBTNUM          DELIMITED BY SIZE
                       "（"                DELIMITED BY SIZE
                       HKN-TANSEIDONAME    DELIMITED BY SPACE
                       "）"                DELIMITED BY SIZE
               INTO    WRK-KANACHK-STR
               WITH    POINTER IDXP
               END-STRING
               IF    ( IDX2        =       CONST-TKOH-MAX )
                AND  ( TKOH-CNT(IDX1) >       CONST-TKOH-MAX )
                   STRING    "　他"        DELIMITED BY SIZE
                   INTO    WRK-KANACHK-STR
                   WITH    POINTER IDXP
                   END-STRING
               END-IF
               PERFORM 800-ZENKAKU-SEC
               MOVE    WRK-KANACHK-STR TO  HCGS137N2-KOHNAME (CNT-LINE)
      *
               MOVE    TKOH-KENSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137N2-KOHKENSU (CNT-LINE)
      *
               MOVE    TKOH-NISSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137N2-KOHNISSU (CNT-LINE)
      *
               MOVE    TKOH-TENSU (IDX1 IDX2)     TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137N2-KOHTENSU (CNT-LINE)
      *
           END-PERFORM
           MOVE    CNT-KENSU       TO  WRK-Z4
           MOVE    WRK-Z4          TO  HCGS137N2-GKOHKENSU
           IF    ( TKOH-KOHMSG (IDX1) =   1 )
               MOVE    "＊：レセプトで請求を行わない公費"
                                   TO  HCGS137N2-KOHMSG
           END-IF
      *
           IF    ( KEY-RECEKA      =   SPACE )
               MOVE    TETC-JIHIMONEY (IDX1)
                                   TO  WRK-M9
               MOVE    WRK-M9      TO  HCGS137N2-JIHIMONEY
               MOVE    TETC-GENMEN    (IDX1)
                                   TO  WRK-M9
               MOVE    WRK-M9      TO  HCGS137N2-GENMEN
               MOVE    TETC-CHOSEI1   (IDX1)
                                   TO  WRK-M9
               MOVE    WRK-M9      TO  HCGS137N2-CHOSEI1
               MOVE    TETC-CHOSEI2   (IDX1)
                                   TO  WRK-M9
               MOVE    WRK-M9      TO  HCGS137N2-CHOSEI2
               MOVE    TETC-HASU      (IDX1)
                                   TO  WRK-M9
               MOVE    WRK-M9      TO  HCGS137N2-HASU
           ELSE
               MOVE    SPACE   TO  HCGS137N2-ETCMSG
               STRING  "その他計は全科合計に編集されます。"
                                       DELIMITED   BY  SIZE
               INTO    HCGS137N2-ETCMSG
               END-STRING
           END-IF
      *
           PERFORM 230-HCGS137N2-PRINT-SEC
      *
           .
       2001-HCGS137N2-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    印刷処理
      *****************************************************************
       230-HCGS137N2-PRINT-SEC         SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
      *
           MOVE    "HCGS137N2.red" TO  SPRT-PRTID
           MOVE    HCGS137N2       TO  SPRT-PRTDATA
      *
           PERFORM 230-PRINT-SEC
      *
           .
       230-HCGS137N2-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    入院チェック表編集処理（ＣＳＶ）
      *****************************************************************
       2001-HCGS137N-CSV-SEC           SECTION.
      *
           MOVE    "1"             TO  WRK-PRTKBN
           MOVE    "社保"          TO  WRK-PRTKBNMEI
           MOVE    "1"             TO  WRK-NYUGAIKBN
           MOVE    "入院"          TO  WRK-NYUGAIKBNMEI
      *
           MOVE    SPACE           TO  WRK-CSVDATA
           MOVE    1               TO  IDXP
           PERFORM VARYING IDXI    FROM    1   BY  1
                   UNTIL ( IDXI    >   CSV-H01-MAX )
      *
               MOVE    CSV-H01-ITEM (IDXI)
                                   TO  WRK-ITEM
               IF    ( IDXI   >=   CSV-H01-MAX    )
                   PERFORM 802-CSVDATA-EDIT-SEC
               ELSE
                   PERFORM 801-CSVDATA-EDIT-SEC
               END-IF
      *
           END-PERFORM
      *
           PERFORM 230-TOUKEICSV-SEC
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   CONST-HKNKOHTTL )
      *
               IF    ( IDX2        =   CONST-KOH4HEI )
                   CONTINUE
               ELSE
                   MOVE  SPACE         TO  WRK-CSVDATA
                   MOVE    1           TO  IDXP
      *
                   MOVE    "1"         TO  WRK-DATAKBN
                   MOVE    "保険区分別"
                                       TO  WRK-DATAKBNMEI
                   PERFORM 20011-CSV-KEY-EDIT-SEC
      *
                   MOVE  CONST-HKNMEI (IDX2)
                                       TO  WRK-ITEM
                   IF    ( BGS100P-SRYYM   >=  CONST-H2605 )
                       INITIALIZE          ORCSSTRINGAREA
                       MOVE    "sub"   TO  ORCSSTR-COMMAND
                       MOVE    WRK-ITEM TO ORCSSTR-STRING1
                       MOVE    "高９"  TO  ORCSSTR-STRING2
                       MOVE    "高一"  TO  ORCSSTR-STRING3
                       CALL    "orcsstring" USING  ORCSSTRINGAREA
                       MOVE    ORCSSTR-STRING1
                                       TO  WRK-ITEM
                   END-IF
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-KENSU (IDX1 IDX2)
                                       TO  WRK-Z4
                   MOVE    WRK-Z4      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-NISSU (IDX1 IDX2)
                                       TO  WRK-Z4
                   MOVE    WRK-Z4      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-TENSU (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-FTNMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-HKNMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-KOHMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-TTLMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-SKJKAISU (IDX1 IDX2)
                                       TO  WRK-Z5
                   MOVE    WRK-Z5      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-SKJFTNMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-SKJHKNMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-SKJKOHMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-SKJTTLMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-TTLTTLMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 802-CSVDATA-EDIT-SEC
      *
                   PERFORM 230-TOUKEICSV-SEC
      *
               END-IF
      *
           END-PERFORM
      *
           MOVE    SPACE           TO  WRK-CSVDATA
           MOVE    1               TO  IDXP
           PERFORM VARYING IDXI    FROM    1   BY  1
                   UNTIL ( IDXI    >   CSV-H02-MAX )
      *
               MOVE    CSV-H02-ITEM (IDXI)
                                   TO  WRK-ITEM
               IF    ( IDXI   >=   CSV-H02-MAX    )
                   PERFORM 802-CSVDATA-EDIT-SEC
               ELSE
                   PERFORM 801-CSVDATA-EDIT-SEC
               END-IF
      *
           END-PERFORM
      *
           PERFORM 230-TOUKEICSV-SEC
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   TKOH-MAX (IDX1) )
      *
               MOVE  SPACE         TO  WRK-CSVDATA
               MOVE    1           TO  IDXP
      *
               MOVE    "2"         TO  WRK-DATAKBN
               MOVE    CSV-H02-KOHNAME
                                   TO  WRK-DATAKBNMEI
               PERFORM 20011-CSV-KEY-EDIT-SEC
      *
               MOVE  HCGS137N2-KOHNAME (IDX2)
                                   TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE  HCGS137N2-KOHKENSU (IDX2)
                                   TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE  HCGS137N2-KOHNISSU (IDX2)
                                   TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE  HCGS137N2-KOHTENSU (IDX2)
                                   TO  WRK-ITEM
               PERFORM 802-CSVDATA-EDIT-SEC
      *
               PERFORM 230-TOUKEICSV-SEC
      *
           END-PERFORM
      *
           MOVE  SPACE         TO  WRK-CSVDATA
           MOVE    1           TO  IDXP
      *
           MOVE    "2"         TO  WRK-DATAKBN
           MOVE    CSV-H02-KOHNAME
                               TO  WRK-DATAKBNMEI
           PERFORM 20011-CSV-KEY-EDIT-SEC
      *
           MOVE  "件数計"      TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  HCGS137N2-GKOHKENSU
                               TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  SPACE         TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  SPACE         TO  WRK-ITEM
           PERFORM 802-CSVDATA-EDIT-SEC
      *
           PERFORM 230-TOUKEICSV-SEC
      *
           IF    ( KEY-RECEKA      =   SPACE )
      *
               MOVE    SPACE           TO  WRK-CSVDATA
               MOVE    1               TO  IDXP
               PERFORM VARYING IDXI    FROM    1   BY  1
                       UNTIL ( IDXI    >   CSV-H03-MAX )
      *
                   MOVE    CSV-H03-ITEM (IDXI)
                                       TO  WRK-ITEM
                   IF    ( IDXI   >=   CSV-H03-MAX    )
                       PERFORM 802-CSVDATA-EDIT-SEC
                   ELSE
                       PERFORM 801-CSVDATA-EDIT-SEC
                   END-IF
      *
               END-PERFORM
      *
               PERFORM 230-TOUKEICSV-SEC
      *
               MOVE    SPACE           TO  WRK-CSVDATA
               MOVE    1               TO  IDXP
      *
               MOVE    "3"         TO  WRK-DATAKBN
               MOVE    CSV-H03-ETCNAME
                               TO  WRK-DATAKBNMEI
               PERFORM 20011-CSV-KEY-EDIT-SEC
      *
               MOVE  WRK-PRTKBNMEI TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE    HCGS137N2-JIHIMONEY
                                       TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE    HCGS137N2-GENMEN
                                       TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE    HCGS137N2-CHOSEI1
                                       TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE    HCGS137N2-CHOSEI2
                                       TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE    HCGS137N2-HASU  TO  WRK-ITEM
               PERFORM 802-CSVDATA-EDIT-SEC
      *
               PERFORM 230-TOUKEICSV-SEC
      *
           END-IF
      *
           .
       2001-HCGS137N-CSV-EXT.
           EXIT.
      *****************************************************************
      *    ＣＳＶファイルＫＥＹ項目編集処理
      *****************************************************************
       20011-CSV-KEY-EDIT-SEC         SECTION.
      *
           MOVE  WRK-PRTKBN        TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  WRK-PRTKBNMEI     TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  WRK-DATAKBN       TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  WRK-DATAKBNMEI    TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  WRK-CSV-SRYYM     TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  WRK-NYUGAIKBN     TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  WRK-NYUGAIKBNMEI
                                   TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  KEY-SKYSBT        TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  WRK-SKYSBTNAME    TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  KEY-RECEKA        TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  WRK-SRYKANAME1    TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           .
       20011-CSV-KEY-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    外来チェック表編集処理
      *****************************************************************
       2001-HCGS137G-EDIT-SEC         SECTION.
      *
           INITIALIZE                      HCGS137G
      *
           MOVE    WRK-PRT-SRYYM       TO  HCGS137G-SRYYM
           MOVE    "外来"              TO  HCGS137G-NYUGAI
           MOVE    WRK-PRT-SAKYMD      TO  HCGS137G-SYSYMD
           MOVE    WRK-SKYSBTNAME      TO  HCGS137G-SKYSBT
           MOVE    WRK-SRYKANAME1      TO  HCGS137G-SRYKANAME
      *
           COMPUTE CNT-PAGE  = CNT-PAGE    +   1
           MOVE    CNT-PAGE            TO  WRK-Z3
           MOVE    WRK-Z3              TO  HCGS137G-PAGE
      *
           MOVE    ZERO                TO  CNT-LINE
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >       CONST-KOHTTL )
      *
               COMPUTE CNT-LINE    =   CNT-LINE    +   1
      *
               MOVE    THKN-KENSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137G-KENSU (CNT-LINE)
      *
               MOVE    THKN-NISSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137G-NISSU (CNT-LINE)
      *
               MOVE    THKN-TENSU (IDX1 IDX2)     TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137G-TENSU (CNT-LINE)
      *
               MOVE    THKN-FTNMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137G-FTNMONEY (CNT-LINE)
      *
               MOVE    THKN-HKNMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137G-HKNMONEY (CNT-LINE)
      *
               MOVE    THKN-KOHMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137G-KOHMONEY (CNT-LINE)
      *
               MOVE    THKN-TTLMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137G-TTLMONEY (CNT-LINE)
      *
      *
           END-PERFORM
      *
               MOVE    CONST-HKNKOHTTL         TO  IDX2
      *
               MOVE    THKN-KENSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137G-GKENSU
      *
               MOVE    THKN-NISSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137G-GNISSU
      *
               MOVE    THKN-TENSU (IDX1 IDX2)     TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137G-GTENSU
      *
               MOVE    THKN-FTNMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137G-GFTNMONEY
      *
               MOVE    THKN-HKNMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137G-GHKNMONEY
      *
               MOVE    THKN-KOHMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137G-GKOHMONEY
      *
               MOVE    THKN-TTLMONEY (IDX1 IDX2)  TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137G-GTTLMONEY
      *
           MOVE    ZERO                TO  CNT-LINE
           MOVE    ZERO                TO  CNT-KENSU
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >       TKOH-MAX (IDX1) )
      *
               COMPUTE CNT-LINE  = CNT-LINE  +   1
      *
               COMPUTE CNT-KENSU = CNT-KENSU +   TKOH-KENSU (IDX1 IDX2)
      *
               MOVE    TKOH-KOHNUM (IDX1 IDX2)    TO  WRK-HKNNUM
               PERFORM 900-HKNNUM-KEY-SEL-SEC
               MOVE    SPACE           TO  WRK-KANACHK-STR
               MOVE    1               TO  IDXP
               IF    ( TKOH-KOHKBN (IDX1 IDX2)    =   "1" )
                   STRING    "　"          DELIMITED BY SIZE
                   INTO    WRK-KANACHK-STR
                   WITH    POINTER IDXP
                   END-STRING
               ELSE
                   STRING    "＊"          DELIMITED BY SIZE
                   INTO    WRK-KANACHK-STR
                   WITH    POINTER IDXP
                   END-STRING
               END-IF
               STRING  HKN-HBTNUM          DELIMITED BY SIZE
                       "（"                DELIMITED BY SIZE
                       HKN-TANSEIDONAME    DELIMITED BY SPACE
                       "）"                DELIMITED BY SIZE
               INTO    WRK-KANACHK-STR
               WITH    POINTER IDXP
               END-STRING
               IF    ( IDX2        =       CONST-TKOH-MAX )
                AND  ( TKOH-CNT(IDX1) >       CONST-TKOH-MAX )
                   STRING    "　他"        DELIMITED BY SIZE
                   INTO    WRK-KANACHK-STR
                   WITH    POINTER IDXP
                   END-STRING
               END-IF
               PERFORM 800-ZENKAKU-SEC
               MOVE    WRK-KANACHK-STR TO  HCGS137G-KOHNAME (CNT-LINE)
      *
               MOVE    TKOH-KENSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137G-KOHKENSU (CNT-LINE)
      *
               MOVE    TKOH-NISSU (IDX1 IDX2)     TO  WRK-Z4
               MOVE    WRK-Z4  TO  HCGS137G-KOHNISSU (CNT-LINE)
      *
               MOVE    TKOH-TENSU (IDX1 IDX2)     TO  WRK-Z9
               MOVE    WRK-Z9  TO  HCGS137G-KOHTENSU (CNT-LINE)
      *
           END-PERFORM
           MOVE    CNT-KENSU       TO  WRK-Z4
           MOVE    WRK-Z4          TO  HCGS137G-GKOHKENSU
           IF    ( TKOH-KOHMSG (IDX1) =   1 )
               MOVE    "＊：レセプトで請求を行わない公費"
                                   TO  HCGS137G-KOHMSG
           END-IF
      *
           IF    ( KEY-RECEKA      =   SPACE )
               MOVE    TETC-JIHIMONEY (IDX1)
                                   TO  WRK-M9
               MOVE    WRK-M9      TO  HCGS137G-JIHIMONEY
               MOVE    TETC-GENMEN    (IDX1)
                                   TO  WRK-M9
               MOVE    WRK-M9      TO  HCGS137G-GENMEN
               MOVE    TETC-CHOSEI1   (IDX1)
                                   TO  WRK-M9
               MOVE    WRK-M9      TO  HCGS137G-CHOSEI1
               MOVE    TETC-CHOSEI2   (IDX1)
                                   TO  WRK-M9
               MOVE    WRK-M9      TO  HCGS137G-CHOSEI2
               MOVE    TETC-HASU      (IDX1)
                                   TO  WRK-M9
               MOVE    WRK-M9      TO  HCGS137G-HASU
           ELSE
               MOVE    SPACE   TO  HCGS137G-ETCMSG
               STRING  "その他計は全科合計に編集されます。"
                                       DELIMITED   BY  SIZE
               INTO    HCGS137G-ETCMSG
               END-STRING
           END-IF
      *
           IF    ( BGS100P-SRYYM   >=  CONST-H2605 )
               STRING  "MonpeLayerIn"      DELIMITED  BY  SIZE
                       " -L LBL0101 "      DELIMITED  BY  SIZE
                       "MonpeLayerOut"     DELIMITED  BY  SIZE
               INTO    HCGS137G-LOPTION
               END-STRING
           ELSE
               STRING  "MonpeLayerIn"      DELIMITED  BY  SIZE
                       " -L LBL0102 "      DELIMITED  BY  SIZE
                       "MonpeLayerOut"     DELIMITED  BY  SIZE
               INTO    HCGS137G-LOPTION
               END-STRING
           END-IF
      *
           PERFORM 230-HCGS137G-PRINT-SEC
      *
           .
       2001-HCGS137G-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    印刷処理
      *****************************************************************
       230-HCGS137G-PRINT-SEC         SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
      *
           MOVE    "HCGS137G.red" TO  SPRT-PRTID
           MOVE    HCGS137G       TO  SPRT-PRTDATA
      *
           PERFORM 230-PRINT-SEC
      *
           .
       230-HCGS137G-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    外来チェック表編集処理（ＣＳＶ）
      *****************************************************************
       2001-HCGS137G-CSV-SEC           SECTION.
      *
           MOVE    "1"             TO  WRK-PRTKBN
           MOVE    "社保"          TO  WRK-PRTKBNMEI
           MOVE    "2"             TO  WRK-NYUGAIKBN
           MOVE    "外来"          TO  WRK-NYUGAIKBNMEI
      *
           MOVE    SPACE           TO  WRK-CSVDATA
           MOVE    1               TO  IDXP
           PERFORM VARYING IDXI    FROM    1   BY  1
                   UNTIL ( IDXI    >   CSV-H04-MAX )
      *
               MOVE    CSV-H04-ITEM (IDXI)
                                   TO  WRK-ITEM
               IF    ( IDXI   >=   CSV-H04-MAX    )
                   PERFORM 802-CSVDATA-EDIT-SEC
               ELSE
                   PERFORM 801-CSVDATA-EDIT-SEC
               END-IF
      *
           END-PERFORM
      *
           PERFORM 230-TOUKEICSV-SEC
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   CONST-HKNKOHTTL )
      *
               IF    ( IDX2        =   CONST-KOH4HEI )
                   CONTINUE
               ELSE
                   MOVE  SPACE         TO  WRK-CSVDATA
                   MOVE    1           TO  IDXP
      *
                   MOVE    "1"         TO  WRK-DATAKBN
                   MOVE    "保険区分別"
                                       TO  WRK-DATAKBNMEI
                   PERFORM 20011-CSV-KEY-EDIT-SEC
      *
                   MOVE  CONST-HKNMEI (IDX2)
                                       TO  WRK-ITEM
                   IF    ( BGS100P-SRYYM   >=  CONST-H2605 )
                       INITIALIZE          ORCSSTRINGAREA
                       MOVE    "sub"   TO  ORCSSTR-COMMAND
                       MOVE    WRK-ITEM TO ORCSSTR-STRING1
                       MOVE    "高９"  TO  ORCSSTR-STRING2
                       MOVE    "高一"  TO  ORCSSTR-STRING3
                       CALL    "orcsstring" USING  ORCSSTRINGAREA
                       MOVE    ORCSSTR-STRING1
                                       TO  WRK-ITEM
                   END-IF
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
      *
                   MOVE    THKN-KENSU (IDX1 IDX2)
                                       TO  WRK-Z4
                   MOVE    WRK-Z4      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-NISSU (IDX1 IDX2)
                                       TO  WRK-Z4
                   MOVE    WRK-Z4      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-TENSU (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-FTNMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-HKNMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-KOHMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   MOVE    THKN-TTLMONEY (IDX1 IDX2)
                                       TO  WRK-Z9
                   MOVE    WRK-Z9      TO  WRK-ITEM
                   PERFORM 801-CSVDATA-EDIT-SEC
      *
                   PERFORM 230-TOUKEICSV-SEC
      *
               END-IF
      *
           END-PERFORM
      *
           MOVE    SPACE           TO  WRK-CSVDATA
           MOVE    1               TO  IDXP
           PERFORM VARYING IDXI    FROM    1   BY  1
                   UNTIL ( IDXI    >   CSV-H02-MAX )
      *
               MOVE    CSV-H02-ITEM (IDXI)
                                   TO  WRK-ITEM
               IF    ( IDXI   >=   CSV-H02-MAX    )
                   PERFORM 802-CSVDATA-EDIT-SEC
               ELSE
                   PERFORM 801-CSVDATA-EDIT-SEC
               END-IF
      *
           END-PERFORM
      *
           PERFORM 230-TOUKEICSV-SEC
      *
           PERFORM VARYING IDX2    FROM    1   BY  1
                   UNTIL ( IDX2    >   TKOH-MAX (IDX1) )
      *
               MOVE  SPACE         TO  WRK-CSVDATA
               MOVE    1           TO  IDXP
      *
               MOVE    "2"         TO  WRK-DATAKBN
               MOVE    CSV-H02-KOHNAME
                                   TO  WRK-DATAKBNMEI
               PERFORM 20011-CSV-KEY-EDIT-SEC
      *
               MOVE  HCGS137G-KOHNAME (IDX2)
                                   TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE  HCGS137G-KOHKENSU (IDX2)
                                   TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE  HCGS137G-KOHNISSU (IDX2)
                                   TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE  HCGS137G-KOHTENSU (IDX2)
                                   TO  WRK-ITEM
               PERFORM 802-CSVDATA-EDIT-SEC
      *
               PERFORM 230-TOUKEICSV-SEC
      *
           END-PERFORM
      *
           MOVE  SPACE         TO  WRK-CSVDATA
           MOVE    1           TO  IDXP
      *
           MOVE    "2"         TO  WRK-DATAKBN
           MOVE    CSV-H02-KOHNAME
                               TO  WRK-DATAKBNMEI
           PERFORM 20011-CSV-KEY-EDIT-SEC
      *
           MOVE  "件数計"      TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  HCGS137G-GKOHKENSU
                               TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  SPACE         TO  WRK-ITEM
           PERFORM 801-CSVDATA-EDIT-SEC
      *
           MOVE  SPACE         TO  WRK-ITEM
           PERFORM 802-CSVDATA-EDIT-SEC
      *
           PERFORM 230-TOUKEICSV-SEC
      *
           IF    ( KEY-RECEKA      =   SPACE )
      *
               MOVE    SPACE           TO  WRK-CSVDATA
               MOVE    1               TO  IDXP
               PERFORM VARYING IDXI    FROM    1   BY  1
                       UNTIL ( IDXI    >   CSV-H03-MAX )
      *
                   MOVE    CSV-H03-ITEM (IDXI)
                                       TO  WRK-ITEM
                   IF    ( IDXI   >=   CSV-H03-MAX    )
                       PERFORM 802-CSVDATA-EDIT-SEC
                   ELSE
                       PERFORM 801-CSVDATA-EDIT-SEC
                   END-IF
      *
               END-PERFORM
      *
               PERFORM 230-TOUKEICSV-SEC
      *
               MOVE    SPACE           TO  WRK-CSVDATA
               MOVE    1               TO  IDXP
      *
               MOVE    "3"         TO  WRK-DATAKBN
               MOVE    CSV-H03-ETCNAME
                               TO  WRK-DATAKBNMEI
               PERFORM 20011-CSV-KEY-EDIT-SEC
      *
               MOVE  WRK-PRTKBNMEI TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE    HCGS137G-JIHIMONEY
                                       TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE    HCGS137G-GENMEN
                                       TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE    HCGS137G-CHOSEI1
                                       TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE    HCGS137G-CHOSEI2
                                       TO  WRK-ITEM
               PERFORM 801-CSVDATA-EDIT-SEC
      *
               MOVE    HCGS137G-HASU   TO  WRK-ITEM
               PERFORM 802-CSVDATA-EDIT-SEC
      *
               PERFORM 230-TOUKEICSV-SEC
      *
           END-IF
      *
           .
       2001-HCGS137G-CSV-EXT.
           EXIT.
      *****************************************************************
      *    印刷処理
      *****************************************************************
       230-PRINT-SEC                   SECTION.
      *
           MOVE    "INS"           TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM
                                   TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                   TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                   TO  SPRT-TBL-GROUP
           MOVE    BGS100P-SRYYM   TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID
                                   TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                   TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                   TO  SPRT-PRIORITY
           MOVE    BGS100P-SHELLMSG TO SPRT-TITLE
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID
                                   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM
                                   TO  SPRT-PRTNM
           MOVE    "1"             TO  SPRT-SITEKBN
      *
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
                                       SPA-AREA
           IF    ( SPRT-RETURN     =   ZERO )
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                   TO  WRK-ERRMSG
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
       230-PRINT-EXT.
           EXIT.
      *****************************************************************
      *    ＣＳＶ出力処理
      *****************************************************************
       230-TOUKEICSV-SEC               SECTION.
      *
           INITIALIZE                  ORCSTOUKEICSVAREA
           MOVE    "INS"           TO  STOUKEICSV-MODE
           MOVE    LNK-PRTKANRI-TBL-KEY
                                   TO  STOUKEICSV-TBL-KEY
           MOVE    LNK-PRTKANRI-RENNUM
                                   TO  STOUKEICSV-RENNUM
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                   TO  STOUKEICSV-TBL-GROUP
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                   TO  STOUKEICSV-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-SHELLID
                                   TO  STOUKEICSV-SHELLID
           MOVE    BGS100P-SRYYM   TO  STOUKEICSV-SRYYM
           MOVE    BGS100P-NYUGAIKBN
                                   TO  STOUKEICSV-NYUGAIKBN
           MOVE    ZERO            TO  STOUKEICSV-PTID
           MOVE    BGS100P-CSVDIR  TO  STOUKEICSV-TO-FOLDER
           MOVE    BGS100P-CSVFNAME TO STOUKEICSV-TO-DATA
           MOVE    "2"             TO  STOUKEICSV-CODE-TYPE
           MOVE    WRK-CSVDATA     TO  STOUKEICSV-CSVDATA
           MOVE    "保険別請求チェック表ＣＳＶ作成"
                                   TO  STOUKEICSV-TITLE
      *
           CALL    "ORCSTOUKEICSV"     USING
                                       ORCSTOUKEICSVAREA
                                       SPA-AREA
           IF    ( STOUKEICSV-RETURN   =   ZERO )
               CONTINUE
           ELSE
               MOVE    "統計ＣＳＶＤＢに更新できませんでした"
                                   TO  WRK-ERRMSG
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *
           .
      *
       230-TOUKEICSV-EXT.
           EXIT.
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           COMPUTE BGS100P-PAGE
               =   BGS100P-PAGE    +   CNT-PAGE
      *
           .
       300-END-EXT.
           EXIT.
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT   BGS100ERR-FILE
           IF      STS-BGS100ERR     =   ZERO
               CLOSE   BGS100ERR-FILE
           ELSE
               OPEN    OUTPUT              BGS100ERR-FILE
      *
               MOVE    WRK-ERRMSG      TO  BGS100ERR-REC
               WRITE   BGS100ERR-REC
               CLOSE   BGS100ERR-FILE
      *
      *        ジョブ管理開始処理
               MOVE    "JBE"           TO  SJOBKANRI-MODE
               INITIALIZE                  JOBKANRI-REC
               MOVE    WRK-ERRMSG      TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               PERFORM 800-ORCSJOB-SEC
           END-IF
      *
           MOVE    1                   TO  BGS100P-RC
      *
           PERFORM 990-EXIT-PROGRAM-SEC
      *
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *****************************************************************
      *    CSVデータ編集処理
      *****************************************************************
       800-CSVDATA-EDIT-SEC            SECTION.
      *
           IF    ( WRK-ITEM        NOT =   SPACE )
               PERFORM 800-GET-ITEM-SIZE-SEC
               STRING  WRK-ITEM(IDXL:CNT-LEN)  DELIMITED   BY  SIZE
               INTO    WRK-CSVDATA
               WITH    POINTER   IDXP
               END-STRING
           END-IF
           .
      *
       800-CSVDATA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    CSVデータ編集処理
      *****************************************************************
       801-CSVDATA-EDIT-SEC            SECTION.
      *
           PERFORM 800-CSVDATA-EDIT-SEC
           PERFORM 800-PUT-DELIMITER-SEC
           .
      *
       801-CSVDATA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    CSVデータ編集処理
      *****************************************************************
       802-CSVDATA-EDIT-SEC            SECTION.
      *
           PERFORM 800-CSVDATA-EDIT-SEC
      *    PERFORM 800-PUT-CR-SEC
           .
      *
       802-CSVDATA-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    項目サイズ取得処理
      *****************************************************************
       800-GET-ITEM-SIZE-SEC           SECTION.
      *
           MOVE    ZERO            TO  IDXL
                                       CNT-LEN
      *
           PERFORM VARYING IDX0    FROM    1   BY  1
                   UNTIL ( IDX0    >   WRK-ITEM-SIZE )
                    OR   ( WRK-ITEM (IDX0:)    =  SPACE )
      *
               IF    ( IDXL = ZERO )
                   IF    ( WRK-ITEM (IDX0:1)   NOT =  SPACE )
                       MOVE    IDX0 TO IDXL
                       MOVE    1    TO CNT-LEN
                   END-IF
               ELSE
                   COMPUTE CNT-LEN  =  CNT-LEN + 1
               END-IF
      *
           END-PERFORM
      *
           .
       800-GET-ITEM-SIZE-EXT.
           EXIT.
      *****************************************************************
      *    区切り文字編集処理
      *****************************************************************
       800-PUT-DELIMITER-SEC           SECTION.
      *
           STRING    ","   DELIMITED   BY  SIZE
           INTO      WRK-CSVDATA
           WITH      POINTER   IDXP
           END-STRING
      *
           .
       800-PUT-DELIMITER-EXT.
           EXIT.
      *****************************************************************
      *    改行文字編集処理
      *****************************************************************
       800-PUT-CR-SEC                  SECTION.
      *
           STRING    X"0D"   DELIMITED BY  SIZE
           INTO      WRK-CSVDATA
           WITH      POINTER   IDXP
           END-STRING
      *
           .
       800-PUT-CR-EXT.
           EXIT.
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       800-HIZUKE-EDIT-SEC             SECTION.
      *
           MOVE    SPACE           TO  WRK-EDTYMD1
                                       WRK-EDTYMD3
      *
           IF    ( WRK-SYMD            =   SPACE )
               CONTINUE
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"   USING
                                   STS-AREA-DAY
                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-EDTYMD1
               MOVE    LNK-DAY2-EDTYMD3    TO  WRK-EDTYMD3
               INSPECT WRK-EDTYMD3 REPLACING  ALL "  "  BY  "　"
           END-IF
      *
      *
           .
       800-HIZUKE-EDIT-EXT.
           EXIT.
      *****************************************************************
      *    全角変換処理
      *****************************************************************
       800-ZENKAKU-SEC                 SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE   "2"              TO  KANACHK-SYORI
           MOVE  500               TO  KANACHK-MAX-CNT
           MOVE  WRK-KANACHK-STR   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           MOVE    KANACHK-OUT-INPUT
                                   TO  WRK-KANACHK-STR
      *
           .
       800-ZENKAKU-EXT.
           EXIT.
      *****************************************************************
      *    ジョブ管理サブ
      *****************************************************************
       800-ORCSJOB-SEC                 SECTION.
      *
           MOVE    SPA-HOSPNUM         TO  JOB-HOSPNUM
           MOVE    BGS100P-JOBID       TO  JOB-JOBID
           MOVE    BGS100P-SHELLID     TO  JOB-SHELLID
           MOVE    "ORCBGS100"         TO  JOB-PGID
           MOVE    BGS100P-SHELLMSG    TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA 
                                       JOBKANRI-REC
                                       SPA-AREA
      *
           .
      *
       800-ORCSJOB-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求ファイル読込処理
      *****************************************************************
       900-BGSSKY-READ-SEC             SECTION.
      *
           MOVE    ZERO            TO  FLG-BGSSKY
                                       FLG-LOOPEND
      *
           PERFORM UNTIL ( FLG-BGSSKY  NOT =   ZERO )
                    OR   ( FLG-LOOPEND NOT =   ZERO )
      *
               READ    BGSSKY-FILE     NEXT
               AT  END
                   MOVE    1       TO  FLG-BGSSKY
               NOT AT  END
      *
                   MOVE    1       TO  FLG-LOOPEND
      *
                   MOVE    BGSSKY-REC  TO  BGSF01-REC
                   PERFORM 9001-SKIP-CHK-SEC
      *
               END-READ
           END-PERFORM
      *
           .
      *
       900-BGSSKY-READ-EXT.
           EXIT.
      *****************************************************************
      *    公費ファイル読込処理
      *****************************************************************
       900-BGSKOH-READ-SEC             SECTION.
      *
           MOVE    ZERO            TO  FLG-BGSKOH
                                       FLG-LOOPEND
      *
           PERFORM UNTIL ( FLG-BGSKOH  NOT =   ZERO )
                    OR   ( FLG-LOOPEND NOT =   ZERO )
      *
               READ    BGSKOH-FILE     NEXT
               AT  END
                   MOVE    1       TO  FLG-BGSKOH
               NOT AT  END
      *
                   MOVE    1       TO  FLG-LOOPEND
      *
                   MOVE    BGSKOH-REC  TO  BGSF01-REC
                   PERFORM 9001-SKIP-CHK-SEC
      *
               END-READ
           END-PERFORM
      *
           .
      *
       900-BGSKOH-READ-EXT.
           EXIT.
      *****************************************************************
      *    その他請求ファイル読込処理
      *****************************************************************
       900-BGSETC-READ-SEC             SECTION.
      *
           MOVE    ZERO            TO  FLG-BGSETC
                                       FLG-LOOPEND
      *
           PERFORM UNTIL ( FLG-BGSETC  NOT =   ZERO )
                    OR   ( FLG-LOOPEND NOT =   ZERO )
      *
               READ    BGSETC-FILE     NEXT
               AT  END
                   MOVE    1       TO  FLG-BGSETC
               NOT AT  END
      *
                   MOVE    1       TO  FLG-LOOPEND
      *
                   MOVE    BGSETC-REC  TO  BGSF01-REC
                   PERFORM 9001-SKIP-CHK-SEC
      *
               END-READ
           END-PERFORM
      *
           .
      *
       900-BGSETC-READ-EXT.
           EXIT.
      *****************************************************************
      *    読み飛ばしチェック処理
      *****************************************************************
       9001-SKIP-CHK-SEC           SECTION.
      *
           IF    ( BGSF01-HOKEN    NOT =   CONST-SYAHO )
               MOVE    ZERO    TO  FLG-LOOPEND
           END-IF
      *
           IF    ( BGS100P-NYUGAIKBN   =   "1" OR "2" )
               IF    ( BGS100P-NYUGAIKBN
                                   NOT =   BGSF01-NYUGAIKBN )
                   MOVE    ZERO    TO  FLG-LOOPEND
               END-IF
      *
           END-IF
      *
           IF    ( KEY-SKYSBT      NOT =   SPACE )
               IF   (( KEY-SKYSBT      =   "1" )
                AND  ( BGSF01-SKYSBT   =   "1" ))
                 OR (( KEY-SKYSBT      =   "2" )
                AND  ( BGSF01-SKYSBT   =   "2" OR "3" ))
                   CONTINUE
               ELSE
                   MOVE    ZERO    TO  FLG-LOOPEND
               END-IF
           END-IF
      *
           IF    ( KEY-RECEKA      NOT =   SPACE )
               IF    ( KEY-RECEKA  NOT =   BGSF01-RECEKA )
                   MOVE    ZERO    TO  FLG-LOOPEND
               END-IF
           END-IF
      *
           .
      *
       9001-SKIP-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険番号マスタ検索処理
      *****************************************************************
       900-HKNNUM-KEY-SEL-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-HKNNUM
      *
           INITIALIZE                      HKNNUM-REC
           MOVE    SPA-HOSPNUM         TO  HKN-HOSPNUM
           MOVE    BGS100P-SRYYMD      TO  HKN-TEKSTYMD
           MOVE    BGS100P-SRYYMD      TO  HKN-TEKEDYMD
           MOVE    WRK-HKNNUM          TO  HKN-HKNNUM
           MOVE    ZERO                TO  HKN-PAYKBN
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "tbl_hknnum"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF ( MCP-RC                 =   ZERO )
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
           ELSE
               MOVE    1               TO  FLG-HKNNUM
               INITIALIZE                  HKNNUM-REC
           END-IF
      *
           MOVE    "tbl_hknnum"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
       900-HKNNUM-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    システム管理検索処理
      *****************************************************************
       900-SYSKANRI-KEY10-SEL-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-SYSKANRI
      *
           MOVE    SYSKANRI-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          =   ZERO )
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
               INITIALIZE                  SYSKANRI-REC
           END-IF
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBCLOSECURSOR-SEC
      *
           .
      *
       900-SYSKANRI-KEY10-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHも行う)
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理（FHETCHを行わない)
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
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
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSECURSOR-SEC                 SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
           CALL    "ORCDBMAIN"         USING
                                       MCPAREA
                                       MCPDATA-REC
                                       SPA-AREA
      *
           .
      *
       910-DBCLOSECURSOR-EXT.
           EXIT.
      *****************************************************************
      *    プログラム終了処理
      *****************************************************************
       990-EXIT-PROGRAM-SEC            SECTION.
      *
           DISPLAY "ORCBGS137 RC [" BGS100P-RC "]"
      *
           EXIT PROGRAM
      *
           .
       990-EXIT-PROGRAM-EXT.
           EXIT.
