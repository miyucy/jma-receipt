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
       PROGRAM-ID.             ORCR0040.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト
      *  コンポーネント名  : レセプトコメント編集
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/04/23    MCC-小豆沢    新規作成
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
      *    レセプト０２データ
           SELECT  RECE02-FILE     ASSIGN  RECE01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE02-KEY
                                   FILE    STATUS  IS  STS-RECE02.
      *    レセプト０４データ（ＩＮ）
           SELECT  RECE04-FILE     ASSIGN  RECE04PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE04-KEY
                                   FILE    STATUS  IS  STS-RECE04.
      *    レセプト０５データ（ＩＮ）
           SELECT  RECE05-FILE     ASSIGN  RECE05PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE05-KEY
                                   FILE    STATUS  IS  STS-RECE05.
      *    レセプト０４データ（ＯＵＴ）
           SELECT  RECE041-FILE    ASSIGN  RECE041PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE041-KEY
                                   FILE    STATUS  IS  STS-RECE041.
           SELECT  RECE0441-FILE   ASSIGN  RECE041PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE0441-KEY
                                   FILE    STATUS  IS  STS-RECE041.
      *    レセプト０５データ（ＯＵＴ）
           SELECT  RECE051-FILE    ASSIGN  RECE051PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE051-KEY
                                   FILE    STATUS  IS  STS-RECE051.
           SELECT  RECE0551-FILE   ASSIGN  RECE051PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE0551-KEY
                                   FILE    STATUS  IS  STS-RECE051.
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    レセプト０２データ
       FD  RECE02-FILE.
       01  RECE02-REC.
           COPY    "CPRCF002.INC".
      *
      *    レセプト０４データ
       FD  RECE04-FILE.
       01  RECE04-REC.
           COPY    "CPRCF004.INC".
      *
      *    レセプト０５データ
       FD  RECE05-FILE.
       01  RECE05-REC.
           COPY    "CPRCF005.INC".
      *
       FD  RECE041-FILE.
       01  RECE041-REC. 
           COPY    "CPRCF004.INC"  REPLACING   //RECE04//
                                   BY          //RECE041//.
      *
       FD  RECE051-FILE.
       01  RECE051-REC. 
           COPY    "CPRCF005.INC"  REPLACING   //RECE05//
                                   BY          //RECE051//.
      *
       FD  RECE0441-FILE.
       01  RECE0441-REC. 
           COPY    "CPRCF004.INC"  REPLACING   //RECE04//
                                   BY          //RECE0441//.
      *
       FD  RECE0551-FILE.
       01  RECE0551-REC. 
           COPY    "CPRCF005.INC"  REPLACING   //RECE05//
                                   BY          //RECE0551//.
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC".
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE04//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE05//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE041//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE051//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    スパ領域
       01  SPA2-AREA.
           03  SPA-STS              PIC 9(04).
           03  SPA-ERRCD            PIC X(04).
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE            PIC X(02).
           03  STS-RECE02          PIC X(02).
           03  STS-RECE04          PIC X(02).
           03  STS-RECE041         PIC X(02).
           03  STS-RECE05          PIC X(02).
           03  STS-RECE051         PIC X(02).
           03  STS-PARA            PIC X(02).
           03  STS-RECEERR         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-RECE02          PIC 9(01).
           03  FLG-RECE04          PIC 9(01).
           03  FLG-RECE05          PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
           03  FLG-SHUJUTU-COMMENT PIC 9(01).
           03  FLG-WRKRECE05       PIC 9(01).
           03  FLG-JINZOU-COMMENT  PIC 9(01).
           03  FLG-SHIDOU-COMMENT  PIC 9(01).
           03  FLG-SANTEI          PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-RECE02          PIC 9(06).
           03  CNT-RECE04          PIC 9(06).
           03  CNT-RECE05          PIC 9(06).
           03  CNT-JINZOU          PIC 9(06).
           03  CNT-RIHA            PIC 9(06).
           03  CNT-RIGA1-KO        PIC 9(06).
           03  CNT-RIGA2-KO        PIC 9(06).
           03  CNT-RIGA3-KO        PIC 9(06).
           03  CNT-RIGA4-KO        PIC 9(06).
           03  CNT-RIGA1-SHU       PIC 9(06).
           03  CNT-RIGA2-SHU       PIC 9(06).
           03  CNT-RIGA3-SHU       PIC 9(06).
           03  CNT-RIGA4-SHU       PIC 9(06).
           03  CNT-SAGYO1-KO       PIC 9(06).
           03  CNT-SAGYO2-KO       PIC 9(06).
           03  CNT-SAGYO1-SHU      PIC 9(06).
           03  CNT-SAGYO2-SHU      PIC 9(06).
           03  CNT-GENGO1-KO       PIC 9(06).
           03  CNT-GENGO2-KO       PIC 9(06).
           03  CNT-GENGO1-SHU      PIC 9(06).
           03  CNT-GENGO2-SHU      PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  DAY-IDX             PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX-RECE05          PIC 9(04).
      *     
      *    一時領域
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-SRYYM              PIC  X(06).
               05  WRK-PARA-TERMID             PIC  X(16).
               05  WRK-PARA-SYSYMD             PIC  X(08).
               05  WRK-PARA-JOBID              PIC  9(07).
               05  WRK-PARA-SHELLID            PIC  X(08).
      *
           03  WRK-RENNUM          PIC 9(02).
           03  WRK-CNT-MEISAI      PIC 9(04).
           03  WRK-RECEERR         PIC X(200).
      *
           03  TBL-SHUJUTSU-DAY.
               05  TB-SHUJUTSU-DAY PIC 9(02)   OCCURS  10.
      *
       01  WRK-RECE04-REC. 
           COPY    "CPRCF004.INC"  REPLACING   //RECE04//
                                   BY          //WRK-RECE04//.
      *
       01  WRK-RECE05-REC. 
           COPY    "CPRCF005.INC"  REPLACING   //RECE05//
                                   BY          //WRK-RECE05//.
      *
       01  COM-RECE05-REC. 
           COPY    "CPRCF005.INC"  REPLACING   //RECE05//
                                   BY          //COM//.
      *
       01  WRK-SRYACTINF-AREA.
           03  WRK-SRYACTINF                   OCCURS  50.
               05  WK-RECE05-SRYCD           PIC  X(09).
               05  WK-RECE05-SRYSURYO        PIC  9(05)V9(03).
               05  WK-RECE05-SRYKAISU        PIC  9(03).
               05  WK-RECE05-TANICD          PIC  9(03).
               05  WK-RECE05-TANIMOJISU      PIC  9(01).
               05  WK-RECE05-TANINAME        PIC  X(24).
               05  WK-RECE05-TENSIKIBETU     PIC  9(01).
               05  WK-RECE05-TEN             PIC  9(09)V9(02).
               05  WK-RECE05-MEISKYFLG       PIC  X(01).
               05  WK-RECE05-AUTOKBN         PIC  X(01).
               05  WK-RECE05-INPUTNUM        PIC  9(03).
               05  WK-RECE05-TENTTLKBN       PIC  9(03).
      *
       01  WRK-NAMEINF-AREA.
           03  WRK-NAMEINF                     OCCURS 50.         
               05  WK-RECE05-YUKOKETA        PIC  9(02).
               05  WK-RECE05-NAME            PIC  X(200).
      *
      *理学療法剤番号退避領域
       01  WRK-TAIHI-ZAINUM.
           03  WRK-RIGA1-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA1-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA2-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA2-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA3-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA3-KO-ZAINUM           PIC  9(08).   
           03  WRK-RIGA4-SHU-ZAINUM          PIC  9(08).   
           03  WRK-RIGA4-KO-ZAINUM           PIC  9(08).   
           03  WRK-SAGYO1-SHU-ZAINUM         PIC  9(08).   
           03  WRK-SAGYO1-KO-ZAINUM          PIC  9(08).   
           03  WRK-SAGYO2-SHU-ZAINUM         PIC  9(08).   
           03  WRK-SAGYO2-KO-ZAINUM          PIC  9(08).   
           03  WRK-GENGO1-SHU-ZAINUM         PIC  9(08).   
           03  WRK-GENGO1-KO-ZAINUM          PIC  9(08).   
           03  WRK-GENGO2-SHU-ZAINUM         PIC  9(08).   
           03  WRK-GENGO2-KO-ZAINUM          PIC  9(08).   
      *
      *人工腎臓実施カレンダー
       01  WRK-JINZOU-AREA.
           03  WRK-JINZOU                    PIC  X(01)  OCCURS 31.   
      *
      *再診４回目以降実施カレンダー
       01  WRK-SAISHIN4-AREA.
           03  WRK-SAISHIN4                  PIC  X(01)  OCCURS 31.   
      *
      *理学療法実施カレンダー
       01  WRK-RIGAKU-AREA.
           03  WRK-RIGA1-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA1-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA2-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA2-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA3-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA3-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA4-SHU                 PIC  X(01)  OCCURS 31.   
           03  WRK-RIGA4-KO                  PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO1-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO1-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO2-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-SAGYO2-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO1-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO1-KO                 PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO2-SHU                PIC  X(01)  OCCURS 31.   
           03  WRK-GENGO2-KO                 PIC  X(01)  OCCURS 31.   
      *
      *
      *    日付全角変換領域
       01  TBL-DAY-AREA.
           03  FILLER              PIC X(04)  VALUE "　１".
           03  FILLER              PIC X(04)  VALUE "　２".
           03  FILLER              PIC X(04)  VALUE "　３".
           03  FILLER              PIC X(04)  VALUE "　４".
           03  FILLER              PIC X(04)  VALUE "　５".
           03  FILLER              PIC X(04)  VALUE "　６".
           03  FILLER              PIC X(04)  VALUE "　７".
           03  FILLER              PIC X(04)  VALUE "　８".
           03  FILLER              PIC X(04)  VALUE "　９".
           03  FILLER              PIC X(04)  VALUE "１０".
           03  FILLER              PIC X(04)  VALUE "１１".
           03  FILLER              PIC X(04)  VALUE "１２".
           03  FILLER              PIC X(04)  VALUE "１３".
           03  FILLER              PIC X(04)  VALUE "１４".
           03  FILLER              PIC X(04)  VALUE "１５".
           03  FILLER              PIC X(04)  VALUE "１６".
           03  FILLER              PIC X(04)  VALUE "１７".
           03  FILLER              PIC X(04)  VALUE "１８".
           03  FILLER              PIC X(04)  VALUE "１９".
           03  FILLER              PIC X(04)  VALUE "２０".
           03  FILLER              PIC X(04)  VALUE "２１".
           03  FILLER              PIC X(04)  VALUE "２２".
           03  FILLER              PIC X(04)  VALUE "２３".
           03  FILLER              PIC X(04)  VALUE "２４".
           03  FILLER              PIC X(04)  VALUE "２５".
           03  FILLER              PIC X(04)  VALUE "２６".
           03  FILLER              PIC X(04)  VALUE "２７".
           03  FILLER              PIC X(04)  VALUE "２８".
           03  FILLER              PIC X(04)  VALUE "２９".
           03  FILLER              PIC X(04)  VALUE "３０".
           03  FILLER              PIC X(04)  VALUE "３１".
       01  TBL-DAY-AREA-R          REDEFINES   TBL-DAY-AREA.
           03  TBL-DAY             PIC X(04)   OCCURS   31.
      *
       01  MAX-MEISAISU            PIC 9(07).
      *
      *    固定値
       01  CONST-AREA.
      *    手術日コメント
           03  CONS-SHUJUTU-COMMENT PIC X(09) VALUE "840000042".
      *    人工腎臓１
           03  CONS-JINZOU1         PIC X(09) VALUE "140036710".
      *    人工腎臓２
           03  CONS-JINZOU2         PIC X(09) VALUE "140007710".
      *    再診（４回目以降／人工腎臓）
           03  CONS-SAISHIN41       PIC X(09) VALUE "112009610".
           03  CONS-SAISHIN42       PIC X(09) VALUE "112009510".
           03  CONS-SAISHIN43       PIC X(09) VALUE "112012750".
           03  CONS-SAISHIN44       PIC X(09) VALUE "112706610".
      *    慢性とう痛疾患
           03  CONS-MANSEI          PIC X(09) VALUE "113006510".
      *    理学療法
           03  CONS-RIGA1-SHU1      PIC X(09) VALUE "180706910".
           03  CONS-RIGA1-SHU2      PIC X(09) VALUE "180022210".
           03  CONS-RIGA1-KO1       PIC X(09) VALUE "180706810".
           03  CONS-RIGA1-KO2       PIC X(09) VALUE "180022110".
           03  CONS-RIGA2-SHU1      PIC X(09) VALUE "180707110".
           03  CONS-RIGA2-SHU2      PIC X(09) VALUE "180022410".
           03  CONS-RIGA2-KO1       PIC X(09) VALUE "180707010".
           03  CONS-RIGA2-KO2       PIC X(09) VALUE "180022310".
           03  CONS-RIGA3-SHU1      PIC X(09) VALUE "180707310".
           03  CONS-RIGA3-SHU2      PIC X(09) VALUE "180022610".
           03  CONS-RIGA3-KO1       PIC X(09) VALUE "180707210".
           03  CONS-RIGA3-KO2       PIC X(09) VALUE "180022510".
           03  CONS-RIGA4-SHU1      PIC X(09) VALUE "180707510".
           03  CONS-RIGA4-SHU2      PIC X(09) VALUE "180022810".
           03  CONS-RIGA4-KO1       PIC X(09) VALUE "180707410".
           03  CONS-RIGA4-KO2       PIC X(09) VALUE "180022710".
           03  CONS-SAGYO1-SHU1     PIC X(09) VALUE "180708210".
           03  CONS-SAGYO1-SHU2     PIC X(09) VALUE "180023710".
           03  CONS-SAGYO1-KO1      PIC X(09) VALUE "180708110".
           03  CONS-SAGYO1-KO2      PIC X(09) VALUE "180023610".
           03  CONS-SAGYO2-SHU1     PIC X(09) VALUE "180708410".
           03  CONS-SAGYO2-SHU2     PIC X(09) VALUE "180023910".
           03  CONS-SAGYO2-KO1      PIC X(09) VALUE "180708310".
           03  CONS-SAGYO2-KO2      PIC X(09) VALUE "180023810".
           03  CONS-GENGO1-SHU      PIC X(09) VALUE "180024910".
           03  CONS-GENGO1-KO       PIC X(09) VALUE "180024810".
           03  CONS-GENGO2-SHU      PIC X(09) VALUE "180025110".
           03  CONS-GENGO2-KO       PIC X(09) VALUE "180025010".
      *     
      *
      *    パス名領域
       01  WRK-PATH                        PIC X(64).
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
      *    点数
           COPY    "CPTENSU.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    診療行為
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    算定履歴
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *     
      *    数値変換サブ
           COPY    "CPORCSNUM.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      ****************************************************************
       PROCEDURE           DIVISION
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
           PERFORM 200-MAIN-SEC
                   UNTIL   SPA-STS  =   2
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
           INITIALIZE                  SPA2-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
      *
      *    ファイルＯＰＥＮ処理
      *
           PERFORM 110-FILE-OPEN-SEC
           PERFORM 120-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0040"      TO  JOB-PGID
           MOVE    "コメント編集"    TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 990-RECE02-READ-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルＯＰＥＮ処理
      *****************************************************************
       110-FILE-OPEN-SEC          SECTION.
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
           MOVE    "RECE020"           TO  RECE01PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE01PARA-TERMID
      *
           MOVE    "RECE040"           TO  RECE04PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE04PARA-TERMID
      *
           MOVE    "RECE050"           TO  RECE05PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE05PARA-TERMID
      *
           MOVE    "RECE041"           TO  RECE041PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE041PARA-TERMID
      *
           MOVE    "RECE051"           TO  RECE051PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE051PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    INPUT               RECE02-FILE
      *
           OPEN    INPUT               RECE04-FILE
      *
           OPEN    INPUT               RECE05-FILE
      *
           OPEN    OUTPUT              RECE0441-FILE
           CLOSE                       RECE0441-FILE
      *
           OPEN    OUTPUT              RECE0551-FILE
           CLOSE                       RECE0551-FILE
      *
           OPEN    OUTPUT              RECE041-FILE
      *
           OPEN    OUTPUT              RECE051-FILE
      *
           .
       110-FILE-OPEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *
      *    人工腎臓の判定
           INITIALIZE                      RECE04-REC
           MOVE    RECE02-HOSPID       TO  RECE04-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE04-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE04-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE04-PTID
           MOVE    RECE02-RECEKA       TO  RECE04-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE04-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE04-RECESYUBETU
           MOVE    RECE02-HKNJANUM     TO  RECE04-HKNJANUM
           MOVE    RECE02-TEKSTYMD     TO  RECE04-TEKSTYMD
           MOVE    ZERO                TO  RECE04-ZAINUM
      *
           START   RECE04-FILE
               KEY IS    >=   RECE04-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE04
               NOT INVALID
                   PERFORM 990-RECE04-NEXT-SEC
           END-START
           MOVE    ZERO              TO      FLG-JINZOU-COMMENT
           INITIALIZE                        WRK-JINZOU-AREA
           INITIALIZE                        WRK-SAISHIN4-AREA
           INITIALIZE                        WRK-RIGAKU-AREA
           INITIALIZE                        WRK-TAIHI-ZAINUM
           PERFORM
               UNTIL  ( FLG-RECE04           =   1                   )
               OR     ( RECE02-HOSPID    NOT =   RECE04-HOSPID       )
               OR     ( RECE02-SRYYM     NOT =   RECE04-SRYYM        )
               OR     ( RECE02-NYUGAIKBN NOT =   RECE04-NYUGAIKBN    )
               OR     ( RECE02-PTID      NOT =   RECE04-PTID         )
               OR     ( RECE02-RECEKA    NOT =   RECE04-RECEKA       )
               OR     ( RECE02-TEISYUTUSAKI
                                         NOT =   RECE04-TEISYUTUSAKI )
               OR     ( RECE02-RECESYUBETU
                                         NOT =   RECE04-RECESYUBETU  )
               OR     ( RECE02-HKNJANUM  NOT =   RECE04-HKNJANUM     )
               OR     ( RECE02-TEKSTYMD  NOT =   RECE04-TEKSTYMD     )
      *
               MOVE          SPACE       TO      RECE041-REC
               INITIALIZE    RECE041-REC
               EVALUATE      RECE04-SRYKBN
                   WHEN      "12"
      *            （再診４回目のカウント）
                      PERFORM    2001-SAISHIN4-COUNT-SEC
                   WHEN      "40"
      *            （人工腎臓のカウント）
                      PERFORM    2001-JINZOU-COUNT-SEC
                   WHEN      "80"
                      PERFORM    2001-RIHA-COUNT-SEC
               END-EVALUATE
      *
               PERFORM 990-RECE04-NEXT-SEC
      *
           END-PERFORM
      *
           PERFORM    2001-JINZOU-HANTEI-SEC
           IF         FLG-JINZOU-COMMENT    =     1
                      PERFORM    2002-JINZOU-COMMENT-SEC
           END-IF
      *
      *    パラメータ０４ファイルより編集
           INITIALIZE                      RECE04-REC
           MOVE    RECE02-HOSPID       TO  RECE04-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE04-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE04-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE04-PTID
           MOVE    RECE02-RECEKA       TO  RECE04-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE04-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE04-RECESYUBETU
           MOVE    RECE02-HKNJANUM     TO  RECE04-HKNJANUM
           MOVE    RECE02-TEKSTYMD     TO  RECE04-TEKSTYMD
           MOVE    ZERO                TO  RECE04-ZAINUM
      *
           START   RECE04-FILE
               KEY IS    >=   RECE04-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE04
               NOT INVALID
                   PERFORM 990-RECE04-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE04           =   1                   )
               OR     ( RECE02-HOSPID    NOT =   RECE04-HOSPID       )
               OR     ( RECE02-SRYYM     NOT =   RECE04-SRYYM        )
               OR     ( RECE02-NYUGAIKBN NOT =   RECE04-NYUGAIKBN    )
               OR     ( RECE02-PTID      NOT =   RECE04-PTID         )
               OR     ( RECE02-RECEKA    NOT =   RECE04-RECEKA       )
               OR     ( RECE02-TEISYUTUSAKI
                                         NOT =   RECE04-TEISYUTUSAKI )
               OR     ( RECE02-RECESYUBETU
                                         NOT =   RECE04-RECESYUBETU  )
               OR     ( RECE02-HKNJANUM  NOT =   RECE04-HKNJANUM     )
               OR     ( RECE02-TEKSTYMD  NOT =   RECE04-TEKSTYMD     )
      *
               MOVE          SPACE       TO      RECE041-REC
               INITIALIZE    RECE041-REC
               EVALUATE      RECE04-SRYKBN
                   WHEN      "13"
                      PERFORM    2001-SHIDOU-HANTEI-SEC
                      IF      FLG-SHIDOU-COMMENT    =      1
                          PERFORM    2001-SHIDOU-COMMENT-SEC
                      ELSE
                          MOVE       RECE04-REC    TO   RECE041-REC
                          WRITE      RECE041-REC
                          ADD     1          TO      CNT-RECE04
                          PERFORM    2002-RECE05-TENSOU-SEC
                      END-IF         
                   WHEN      "50"
      *            （手術日のセット）
                      PERFORM    2001-SHUJUTSU-HANTEI-SEC
                      IF     (FLG-SHUJUTU-COMMENT   =      1)  AND
                             (RECE04-SYUTEN1    NOT =   ZERO)
                          PERFORM    2001-SHUJUTSU-COMMENT-SEC
                      ELSE
                          MOVE       RECE04-REC    TO   RECE041-REC
                          WRITE      RECE041-REC
                          ADD     1          TO      CNT-RECE04
                          PERFORM    2002-RECE05-TENSOU-SEC
                      END-IF
                   WHEN      "80"
      *            （リハビリのセット）
                      IF  RECE04-ZAINUM    =   WRK-RIGA1-SHU-ZAINUM OR
                                               WRK-RIGA1-KO-ZAINUM  OR
                                               WRK-RIGA2-SHU-ZAINUM OR
                                               WRK-RIGA2-KO-ZAINUM  OR
                                               WRK-RIGA3-SHU-ZAINUM OR
                                               WRK-RIGA3-KO-ZAINUM  OR
                                               WRK-RIGA4-SHU-ZAINUM OR
                                               WRK-RIGA4-KO-ZAINUM  OR
                                               WRK-SAGYO1-SHU-ZAINUM OR
                                               WRK-SAGYO1-KO-ZAINUM  OR
                                               WRK-SAGYO2-SHU-ZAINUM OR
                                               WRK-SAGYO2-KO-ZAINUM  OR
                                               WRK-GENGO1-SHU-ZAINUM OR
                                               WRK-GENGO1-KO-ZAINUM  OR
                                               WRK-GENGO2-SHU-ZAINUM OR
                                               WRK-GENGO2-KO-ZAINUM
                          PERFORM   2001-RIHA-COMMENT-SEC
                      ELSE
                          MOVE       RECE04-REC    TO   RECE041-REC
                          WRITE      RECE041-REC
                          ADD     1          TO      CNT-RECE04
                          PERFORM    2002-RECE05-TENSOU-SEC
                      END-IF
      *
                   WHEN   OTHER
                      MOVE       RECE04-REC    TO   RECE041-REC
                      WRITE      RECE041-REC
                      ADD     1          TO      CNT-RECE04
                      PERFORM    2002-RECE05-TENSOU-SEC
               END-EVALUATE
      *
               PERFORM 990-RECE04-NEXT-SEC
      *
           END-PERFORM
      *
      *
           PERFORM 990-RECE02-READ-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    再診４回目以降のカウント
      *****************************************************************
       2001-SAISHIN4-COUNT-SEC          SECTION.
      *
      *再診（４回目以降／人工腎臓）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAISHIN41    TO      SRY-SRYCD (1)
           MOVE    CONS-SAISHIN41    TO      SRY-SRYCD (2)
           MOVE    CONS-SAISHIN41    TO      SRY-SRYCD (3)
           MOVE    CONS-SAISHIN41    TO      SRY-SRYCD (4)
           MOVE    CONS-SAISHIN41    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-SAISHIN4(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *再診（４回目以降／１５才未満）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAISHIN42    TO      SRY-SRYCD (1)
           MOVE    CONS-SAISHIN42    TO      SRY-SRYCD (2)
           MOVE    CONS-SAISHIN42    TO      SRY-SRYCD (3)
           MOVE    CONS-SAISHIN42    TO      SRY-SRYCD (4)
           MOVE    CONS-SAISHIN42    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-SAISHIN4(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *再診（４回目以降／厚生大臣）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAISHIN43    TO      SRY-SRYCD (1)
           MOVE    CONS-SAISHIN43    TO      SRY-SRYCD (2)
           MOVE    CONS-SAISHIN43    TO      SRY-SRYCD (3)
           MOVE    CONS-SAISHIN43    TO      SRY-SRYCD (4)
           MOVE    CONS-SAISHIN43    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-SAISHIN4(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *再診（４回目以降／厚生大臣／老人）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAISHIN44    TO      SRY-SRYCD (1)
           MOVE    CONS-SAISHIN44    TO      SRY-SRYCD (2)
           MOVE    CONS-SAISHIN44    TO      SRY-SRYCD (3)
           MOVE    CONS-SAISHIN44    TO      SRY-SRYCD (4)
           MOVE    CONS-SAISHIN44    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-SAISHIN4(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-SAISHIN4-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    人工腎臓のカウント
      *****************************************************************
       2001-JINZOU-COUNT-SEC          SECTION.
      *
      *人工腎臓１について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-JINZOU1      TO      SRY-SRYCD (1)
           MOVE    CONS-JINZOU1      TO      SRY-SRYCD (2)
           MOVE    CONS-JINZOU1      TO      SRY-SRYCD (3)
           MOVE    CONS-JINZOU1      TO      SRY-SRYCD (4)
           MOVE    CONS-JINZOU1      TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    RECE04-REC        TO      WRK-RECE04-REC
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE   MCPDATA-REC    TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1"  TO  WRK-JINZOU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *人工腎臓２について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-JINZOU2      TO      SRY-SRYCD (1)
           MOVE    CONS-JINZOU2      TO      SRY-SRYCD (2)
           MOVE    CONS-JINZOU2      TO      SRY-SRYCD (3)
           MOVE    CONS-JINZOU2      TO      SRY-SRYCD (4)
           MOVE    CONS-JINZOU2      TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    RECE04-REC        TO      WRK-RECE04-REC
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE   MCPDATA-REC    TO  SRYACCT-REC
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1"  TO  WRK-JINZOU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-JINZOU-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    人工腎臓の判定
      *****************************************************************
       2001-JINZOU-HANTEI-SEC          SECTION.
      *
      *    人工腎臓と再診の突き合わせ
           MOVE       ZERO             TO     CNT-JINZOU
           PERFORM    VARYING    IDX   FROM   1   BY   1
                      UNTIL      IDX   >    31
                  IF   (WRK-JINZOU(IDX)    =   "1")  AND
                       (WRK-SAISHIN4(IDX)  =   "1")
                       ADD     1           TO   CNT-JINZOU
                  END-IF
           END-PERFORM
      *
           IF      CNT-JINZOU        NOT =      ZERO
               MOVE    1         TO      FLG-JINZOU-COMMENT
           END-IF
      *
           .
       2001-JINZOU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    人工腎臓のコメント編集
      *****************************************************************
       2002-JINZOU-COMMENT-SEC          SECTION.
      *
           INITIALIZE                      RECE041-REC
           MOVE    RECE02-HOSPID       TO  RECE041-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE041-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE041-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE041-PTID
           MOVE    RECE02-RECEKA       TO  RECE041-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE041-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE041-RECESYUBETU
           MOVE    RECE02-HKNJANUM     TO  RECE041-HKNJANUM
           MOVE    RECE02-TEKSTYMD     TO  RECE041-TEKSTYMD
           MOVE    ZERO                TO  RECE041-ZAINUM
           MOVE    WRK-RECE04-KOHBUNRI TO  RECE041-KOHBUNRI
           MOVE    WRK-RECE04-SRYKBN   TO  RECE041-SRYKBN
           
           WRITE   RECE041-REC
           ADD     1                   TO  CNT-RECE04
      *
           INITIALIZE                      RECE051-REC
           MOVE    RECE02-HOSPID       TO  RECE051-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE051-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE051-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE051-PTID
           MOVE    RECE02-RECEKA       TO  RECE051-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE051-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE051-RECESYUBETU
           MOVE    RECE02-HKNJANUM     TO  RECE051-HKNJANUM
           MOVE    RECE02-TEKSTYMD     TO  RECE051-TEKSTYMD
           MOVE    ZERO                TO  RECE051-ZAINUM
           MOVE    WRK-RECE04-SRYKBN   TO  RECE051-SRYKBN
      *    人工腎臓コメントの挿入
           ADD     1                    TO  IDX-RECE05
           MOVE    SPACE                TO  COM-RECE05-REC
           INITIALIZE                       COM-RECE05-REC
           MOVE    "810000001"          TO  COM-SRYCD(1)
           MOVE    ZERO                 TO  COM-SRYSURYO(1)
           MOVE    14                   TO  COM-YUKOKETA(1)
           MOVE    "再診４回目以降実施回数　　回"  TO COM-NAME(1)
           MOVE    CNT-JINZOU           TO  DAY-IDX
           MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(23:4)
           MOVE    COM-SRYACTINF(1)     TO  RECE051-SRYACTINF(1)
           MOVE    COM-NAMEINF(1)       TO  RECE051-NAMEINF(1)
           WRITE   RECE051-REC
           ADD     1                    TO  CNT-RECE05
      *
           .
       2002-JINZOU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    人工腎臓のコメント編集
      *****************************************************************
       2001-JINZOU-COMMENT-SEC          SECTION.
      *
           MOVE    RECE04-REC        TO      RECE041-REC
           ADD     1                 TO      RECE041-MEISAISU
           WRITE   RECE041-REC
           ADD     1                 TO      CNT-RECE04
      *
      *      ※明細が５以上の場合
             INITIALIZE                      RECE05-REC
             MOVE    RECE04-HOSPID       TO  RECE05-HOSPID
             MOVE    RECE04-SRYYM        TO  RECE05-SRYYM
             MOVE    RECE04-NYUGAIKBN    TO  RECE05-NYUGAIKBN
             MOVE    RECE04-PTID         TO  RECE05-PTID
             MOVE    RECE04-RECEKA       TO  RECE05-RECEKA
             MOVE    RECE04-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
             MOVE    RECE04-RECESYUBETU  TO  RECE05-RECESYUBETU
             MOVE    RECE04-HKNJANUM     TO  RECE05-HKNJANUM
             MOVE    RECE04-TEKSTYMD     TO  RECE05-TEKSTYMD
             MOVE    RECE04-ZAINUM       TO  RECE05-ZAINUM
             START   RECE05-FILE
                 KEY IS    >=   RECE05-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE05
                 NOT INVALID
                     PERFORM 990-RECE05-NEXT-SEC
                     MOVE    RECE05-REC  TO  WRK-RECE05-REC
             END-START
      *
      *      ＲＥＣＥ０５ファイルの内容をテーブルに退避
             MOVE    ZERO                 TO  IDX-RECE05
             MOVE    SPACE                TO  WRK-SRYACTINF-AREA
             INITIALIZE                       WRK-SRYACTINF-AREA
             MOVE    SPACE                TO  WRK-NAMEINF-AREA
             INITIALIZE                       WRK-NAMEINF-AREA
      *      人工腎臓コメントの挿入
             ADD     1                    TO  IDX-RECE05
             MOVE    SPACE                TO  COM-RECE05-REC
             INITIALIZE                       COM-RECE05-REC
             MOVE    "810000001"          TO  COM-SRYCD(1)
             MOVE    ZERO                 TO  COM-SRYSURYO(1)
             MOVE    14                   TO  COM-YUKOKETA(1)
             MOVE    "再診４回目以降実施回数　　回"  TO COM-NAME(1)
             MOVE    CNT-JINZOU           TO  DAY-IDX
             MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(23:4)
             MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
                                                   (IDX-RECE05)
             MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
                                                   (IDX-RECE05)
      *
             PERFORM
               UNTIL  ( FLG-RECE05           =   1                   )
               OR     ( RECE04-HOSPID    NOT =   RECE05-HOSPID       )
               OR     ( RECE04-SRYYM     NOT =   RECE05-SRYYM        )
               OR     ( RECE04-NYUGAIKBN NOT =   RECE05-NYUGAIKBN    )
               OR     ( RECE04-PTID      NOT =   RECE05-PTID         )
               OR     ( RECE04-RECEKA    NOT =   RECE05-RECEKA       )
               OR     ( RECE04-TEISYUTUSAKI
                                         NOT =   RECE05-TEISYUTUSAKI )
               OR     ( RECE04-RECESYUBETU
                                         NOT =   RECE05-RECESYUBETU  )
               OR     ( RECE04-HKNJANUM  NOT =   RECE05-HKNJANUM     )
               OR     ( RECE04-TEKSTYMD  NOT =   RECE05-TEKSTYMD     )
               OR     ( RECE04-ZAINUM    NOT =   RECE05-ZAINUM       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE05-SRYCD(IDX) =   SPACE )
                    ADD    1             TO      IDX-RECE05
                    MOVE   RECE05-SRYACTINF(IDX) TO
                                             WRK-SRYACTINF(IDX-RECE05)
                    MOVE   RECE05-NAMEINF(IDX)   TO
                                             WRK-NAMEINF(IDX-RECE05)     
               END-PERFORM 
      *
               PERFORM 990-RECE05-NEXT-SEC
      *
             END-PERFORM
      *
      *      腎臓コメントを含んだ内容で中間ファイルの再作成
             MOVE       ZERO             TO      FLG-WRKRECE05
             MOVE       ZERO             TO      IDX
             MOVE       ZERO             TO      IDX-RECE05
             MOVE       ZERO             TO      WRK-RENNUM
             PERFORM    UNTIL     FLG-WRKRECE05  =    1
                    INITIALIZE                        RECE051-REC
                    MOVE    WRK-RECE05-KEY       TO   RECE051-KEY
                    ADD     1                    TO   WRK-RENNUM
                    MOVE    WRK-RENNUM           TO   RECE051-RENNUM
                    MOVE    WRK-RECE05-KOHBUNRI  TO   RECE051-KOHBUNRI
                    MOVE    WRK-RECE05-PTNUM     TO   RECE051-PTNUM
                    MOVE    WRK-RECE05-SRYKA     TO   RECE051-SRYKA
                    MOVE    WRK-RECE05-SRYKBN    TO   RECE051-SRYKBN
                    MOVE    WRK-RECE05-SRYSYUKBN TO   RECE051-SRYSYUKBN
                    MOVE    WRK-RECE05-JIHIMONEY TO   RECE051-JIHIMONEY
                    PERFORM  VARYING   IDX   FROM   1   BY   1
                             UNTIL   (IDX       >    5)   OR
                                     (FLG-WRKRECE05   =   1)
                       ADD         1             TO    IDX-RECE05
                       IF  WK-RECE05-SRYCD(IDX-RECE05) = SPACE
                           MOVE    1             TO    FLG-WRKRECE05
                       ELSE
                           MOVE  WRK-SRYACTINF(IDX-RECE05)
                                            TO   RECE051-SRYACTINF(IDX)  
                           MOVE  WRK-NAMEINF(IDX-RECE05)
                                            TO   RECE051-NAMEINF(IDX)
                       END-IF  
                    END-PERFORM
                    WRITE   RECE051-REC
                    ADD     1                    TO  CNT-RECE05
             END-PERFORM     
      *
           .
       2001-JINZOU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    指導管理料のコメントがあるか判定
      *****************************************************************
       2001-SHIDOU-HANTEI-SEC          SECTION.
      *
           MOVE    ZERO              TO      FLG-SHIDOU-COMMENT
      *
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    "113006510"       TO      SRY-SRYCD (1)
           MOVE    "113006510"       TO      SRY-SRYCD (2)
           MOVE    "113006510"       TO      SRY-SRYCD (3)
           MOVE    "113006510"       TO      SRY-SRYCD (4)
           MOVE    "113006510"       TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                NOT  =  ZERO
               CONTINUE
           ELSE
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC   TO  SRYACT-REC
                   MOVE    1         TO      FLG-SHIDOU-COMMENT
               END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *
      ***  IF  RECE04-SRYYM       >=  "200210"
      *
      *      算定履歴検索
             INITIALIZE                  SANTEI-REC
             MOVE    RECE04-HOSPID       TO  SANTEI-HOSPID
             MOVE    RECE04-PTID         TO  SANTEI-PTID
             MOVE    RECE04-SRYYM        TO  SANTEI-SRYYM
             MOVE    "113006510"         TO  SANTEI-SRYCD
             MOVE    ZERO                TO  SANTEI-NYUGAIKBN
             MOVE    ZERO                TO  SANTEI-SRYKA
             MOVE    ZERO                TO  SANTEI-HKNCOMBINUM
             MOVE    SANTEI-REC          TO  MCPDATA-REC
             MOVE    "DBSELECT"          TO  MCP-FUNC
             MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
             CALL    "ORCMCPSUB"         USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
             IF      MCP-RC              =   ZERO
                  MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
                  PERFORM        SANTEI-READ-SEC
                  PERFORM   UNTIL   FLG-SANTEI  =   1
      *
                     IF     SANTEI-FSANTEIYMD(1:6)  =  RECE04-SRYYM   
                           CONTINUE
                     ELSE
                           MOVE    ZERO    TO      FLG-SHIDOU-COMMENT
                     END-IF
      * 
                     MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
                     PERFORM        SANTEI-READ-SEC
                  END-PERFORM
             END-IF
      *
             MOVE    "DBCLOSE"           TO  MCP-FUNC
             MOVE    "SANTEI-KEY"        TO  ORC-DBPATH
             CALL    "ORCMCPSUB"         USING
                                         MCPAREA
                                         ORCMCPAREA
                                         MCPDATA-REC
      *
      ***  END-IF
      *
           .
       2001-SHIDOU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日のコメントがあるか判定
      *****************************************************************
       2001-SHUJUTSU-HANTEI-SEC          SECTION.
      *
           MOVE    ZERO              TO      FLG-SHUJUTU-COMMENT
      *
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    "840000042"       TO      SRY-SRYCD (1)
           MOVE    "840000042"       TO      SRY-SRYCD (2)
           MOVE    "840000042"       TO      SRY-SRYCD (3)
           MOVE    "840000042"       TO      SRY-SRYCD (4)
           MOVE    "840000042"       TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                NOT  =  ZERO
               MOVE      1           TO      FLG-SHUJUTU-COMMENT
           ELSE
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC   TO  SRYACT-REC
               ELSE
                   MOVE    1         TO      FLG-SHUJUTU-COMMENT
               END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-SHUJUTSU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    指導管理料のコメント編集
      *****************************************************************
       2001-SHIDOU-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SHIDOU-DAY-SEC
      *
             MOVE       RECE04-REC    TO   RECE041-REC
             WRITE      RECE041-REC
             ADD     1          TO      CNT-RECE04
             INITIALIZE                      RECE05-REC
             MOVE    RECE04-HOSPID       TO  RECE05-HOSPID
             MOVE    RECE04-SRYYM        TO  RECE05-SRYYM
             MOVE    RECE04-NYUGAIKBN    TO  RECE05-NYUGAIKBN
             MOVE    RECE04-PTID         TO  RECE05-PTID
             MOVE    RECE04-RECEKA       TO  RECE05-RECEKA
             MOVE    RECE04-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
             MOVE    RECE04-RECESYUBETU  TO  RECE05-RECESYUBETU
             MOVE    RECE04-HKNJANUM     TO  RECE05-HKNJANUM
             MOVE    RECE04-TEKSTYMD     TO  RECE05-TEKSTYMD
             MOVE    RECE04-ZAINUM       TO  RECE05-ZAINUM
             START   RECE05-FILE
                 KEY IS    >=   RECE05-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE05
                 NOT INVALID
                     PERFORM 990-RECE05-NEXT-SEC
             END-START
      *
             MOVE    RECE05-REC       TO      RECE051-REC
             MOVE    RECE05-SRYACTINF(1)  TO  RECE051-SRYACTINF(1)
             MOVE    RECE05-SRYACTINF(2)  TO  RECE051-SRYACTINF(3)
             MOVE    RECE05-SRYACTINF(3)  TO  RECE051-SRYACTINF(4)
             MOVE    RECE05-SRYACTINF(4)  TO  RECE051-SRYACTINF(5)
             MOVE    RECE05-NAMEINF(1)    TO  RECE051-NAMEINF(1)
             MOVE    RECE05-NAMEINF(2)    TO  RECE051-NAMEINF(3)
             MOVE    RECE05-NAMEINF(3)    TO  RECE051-NAMEINF(4)
             MOVE    RECE05-NAMEINF(4)    TO  RECE051-NAMEINF(5)
      *
             MOVE    SPACE                TO  RECE051-SRYACTINF(2)
             INITIALIZE                       RECE051-SRYACTINF(2)
             MOVE    "810000001"          TO  RECE051-SRYCD(2)
             MOVE    ZERO                 TO  RECE051-SRYSURYO(2)
             MOVE    15                   TO  RECE051-YUKOKETA(2)
             MOVE    "慢性疼痛疾患管理算定日　　　日"
                                          TO  RECE051-NAME(2)
             MOVE     TB-SHUJUTSU-DAY(1)  TO  DAY-IDX
             MOVE     TBL-DAY(DAY-IDX)    TO  RECE051-NAME(2)(25:4)
             WRITE    RECE051-REC
             ADD      1                    TO  CNT-RECE05
      *    
      *
           .
       2001-SHIDOU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    手術日のコメント編集
      *****************************************************************
       2001-SHUJUTSU-COMMENT-SEC          SECTION.
      *
           PERFORM   2001-SHUJUTSU-DAY-SEC
      *
      **     MOVE    RECE04-REC        TO      RECE041-REC
      **     ADD     1                 TO      RECE041-MEISAISU
      **     WRITE   RECE041-REC
      **     ADD     1                 TO      CNT-RECE04
      *
      **     IF      RECE041-MEISAISU  <=      2
      **       INITIALIZE                      RECE05-REC
      **       MOVE    RECE04-HOSPID       TO  RECE05-HOSPID
      **       MOVE    RECE04-SRYYM        TO  RECE05-SRYYM
      **       MOVE    RECE04-NYUGAIKBN    TO  RECE05-NYUGAIKBN
      **       MOVE    RECE04-PTID         TO  RECE05-PTID
      **       MOVE    RECE04-RECEKA       TO  RECE05-RECEKA
      **       MOVE    RECE04-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
      **       MOVE    RECE04-RECESYUBETU  TO  RECE05-RECESYUBETU
      **       MOVE    RECE04-HKNJANUM     TO  RECE05-HKNJANUM
      **       MOVE    RECE04-TEKSTYMD     TO  RECE05-TEKSTYMD
      **       MOVE    RECE04-ZAINUM       TO  RECE05-ZAINUM
      **       START   RECE05-FILE
      **           KEY IS    >=   RECE05-KEY
      **           INVALID
      **               MOVE    1           TO  FLG-RECE05
      **           NOT INVALID
      **               PERFORM 990-RECE05-NEXT-SEC
      **       END-START
      *
      **       MOVE    RECE05-REC       TO      RECE051-REC
      **       MOVE    RECE05-SRYACTINF(1)  TO  RECE051-SRYACTINF(2)
      **       MOVE    RECE05-SRYACTINF(2)  TO  RECE051-SRYACTINF(3)
      **       MOVE    RECE05-SRYACTINF(3)  TO  RECE051-SRYACTINF(4)
      **       MOVE    RECE05-SRYACTINF(4)  TO  RECE051-SRYACTINF(5)
      **       MOVE    RECE05-NAMEINF(1)    TO  RECE051-NAMEINF(2)
      **       MOVE    RECE05-NAMEINF(2)    TO  RECE051-NAMEINF(3)
      **       MOVE    RECE05-NAMEINF(3)    TO  RECE051-NAMEINF(4)
      **       MOVE    RECE05-NAMEINF(4)    TO  RECE051-NAMEINF(5)
      *
      **       MOVE    SPACE                TO  RECE051-SRYACTINF(1)
      **       INITIALIZE                       RECE051-SRYACTINF(1)
      **       MOVE    "840000042"          TO  RECE051-SRYCD(1)
      **       MOVE    ZERO                 TO  RECE051-SRYSURYO(1)
      **       MOVE    6                    TO  RECE051-YUKOKETA(1)
      **       MOVE    "手術　　　日"       TO  RECE051-NAME(1)
      **       MOVE     TB-SHUJUTSU-DAY(1)  TO  DAY-IDX
      **       MOVE    TBL-DAY(DAY-IDX)    TO  RECE051-NAME(1)(7:4)
      **       WRITE   RECE051-REC
      **       ADD     1                    TO  CNT-RECE05
      *    
      **     ELSE
      *
      **     ※明細が５以上の場合
             INITIALIZE                      RECE05-REC
             MOVE    RECE04-HOSPID       TO  RECE05-HOSPID
             MOVE    RECE04-SRYYM        TO  RECE05-SRYYM
             MOVE    RECE04-NYUGAIKBN    TO  RECE05-NYUGAIKBN
             MOVE    RECE04-PTID         TO  RECE05-PTID
             MOVE    RECE04-RECEKA       TO  RECE05-RECEKA
             MOVE    RECE04-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
             MOVE    RECE04-RECESYUBETU  TO  RECE05-RECESYUBETU
             MOVE    RECE04-HKNJANUM     TO  RECE05-HKNJANUM
             MOVE    RECE04-TEKSTYMD     TO  RECE05-TEKSTYMD
             MOVE    RECE04-ZAINUM       TO  RECE05-ZAINUM
             START   RECE05-FILE
                 KEY IS    >=   RECE05-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE05
                 NOT INVALID
                     PERFORM 990-RECE05-NEXT-SEC
                     MOVE    RECE05-REC  TO  WRK-RECE05-REC
             END-START
      *
      *      ＲＥＣＥ０５ファイルの内容をテーブルに退避
             MOVE    ZERO                 TO  IDX-RECE05
             MOVE    SPACE                TO  WRK-SRYACTINF-AREA
             INITIALIZE                       WRK-SRYACTINF-AREA
             MOVE    SPACE                TO  WRK-NAMEINF-AREA
             INITIALIZE                       WRK-NAMEINF-AREA
      *        手術日コメントの挿入
             PERFORM  VARYING      IDX    FROM  1   BY   1
                      UNTIL       (IDX    >     10)      OR
                                  (TB-SHUJUTSU-DAY(IDX)  =  ZERO)
                 ADD     1                    TO  IDX-RECE05
                 MOVE    SPACE                TO  COM-RECE05-REC
                 INITIALIZE                       COM-RECE05-REC
                 MOVE    "840000042"          TO  COM-SRYCD(1)
                 MOVE    ZERO                 TO  COM-SRYSURYO(1)
                 MOVE    6                    TO  COM-YUKOKETA(1)
                 MOVE    "手術　　　日"       TO  COM-NAME(1)
                 MOVE    TB-SHUJUTSU-DAY(IDX) TO  DAY-IDX
                 MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(7:4)
                 MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
                                                       (IDX-RECE05)
                 MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
                                                       (IDX-RECE05)
             END-PERFORM
      *
             PERFORM
               UNTIL  ( FLG-RECE05           =   1                   )
               OR     ( RECE04-HOSPID    NOT =   RECE05-HOSPID       )
               OR     ( RECE04-SRYYM     NOT =   RECE05-SRYYM        )
               OR     ( RECE04-NYUGAIKBN NOT =   RECE05-NYUGAIKBN    )
               OR     ( RECE04-PTID      NOT =   RECE05-PTID         )
               OR     ( RECE04-RECEKA    NOT =   RECE05-RECEKA       )
               OR     ( RECE04-TEISYUTUSAKI
                                         NOT =   RECE05-TEISYUTUSAKI )
               OR     ( RECE04-RECESYUBETU
                                         NOT =   RECE05-RECESYUBETU  )
               OR     ( RECE04-HKNJANUM  NOT =   RECE05-HKNJANUM     )
               OR     ( RECE04-TEKSTYMD  NOT =   RECE05-TEKSTYMD     )
               OR     ( RECE04-ZAINUM    NOT =   RECE05-ZAINUM       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE05-SRYCD(IDX) =   SPACE )
                    ADD    1             TO      IDX-RECE05
                    MOVE   RECE05-SRYACTINF(IDX) TO
                                             WRK-SRYACTINF(IDX-RECE05)
                    MOVE   RECE05-NAMEINF(IDX)   TO
                                             WRK-NAMEINF(IDX-RECE05)     
               END-PERFORM 
      *
               PERFORM 990-RECE05-NEXT-SEC
      *
             END-PERFORM
      *
      *      手術日コメントを含んだ内容で中間ファイルの再作成
             MOVE       ZERO             TO      FLG-WRKRECE05
             MOVE       ZERO             TO      IDX
             MOVE       ZERO             TO      IDX-RECE05
             MOVE       ZERO             TO      WRK-RENNUM
             MOVE       ZERO             TO      WRK-CNT-MEISAI
             PERFORM    UNTIL     FLG-WRKRECE05  =    1
                    INITIALIZE                        RECE051-REC
                    MOVE    WRK-RECE05-KEY       TO   RECE051-KEY
                    ADD     1                    TO   WRK-RENNUM
                    MOVE    WRK-RENNUM           TO   RECE051-RENNUM
                    MOVE    WRK-RECE05-KOHBUNRI  TO   RECE051-KOHBUNRI
                    MOVE    WRK-RECE05-PTNUM     TO   RECE051-PTNUM
                    MOVE    WRK-RECE05-SRYKA     TO   RECE051-SRYKA
                    MOVE    WRK-RECE05-SRYKBN    TO   RECE051-SRYKBN
                    MOVE    WRK-RECE05-SRYSYUKBN TO   RECE051-SRYSYUKBN
                    MOVE    WRK-RECE05-JIHIMONEY TO   RECE051-JIHIMONEY
                    PERFORM  VARYING   IDX   FROM   1   BY   1
                             UNTIL   (IDX       >    5)   OR
                                     (FLG-WRKRECE05   =   1)
                       ADD         1             TO    IDX-RECE05
                       IF  WK-RECE05-SRYCD(IDX-RECE05) = SPACE
                           MOVE    1             TO    FLG-WRKRECE05
                       ELSE
                           MOVE  WRK-SRYACTINF(IDX-RECE05)
                                            TO   RECE051-SRYACTINF(IDX)  
                           MOVE  WRK-NAMEINF(IDX-RECE05)
                                            TO   RECE051-NAMEINF(IDX)
                           ADD   1          TO   WRK-CNT-MEISAI
                       END-IF  
                    END-PERFORM
                    WRITE   RECE051-REC
                    ADD     1                    TO  CNT-RECE05
             END-PERFORM     
      *
             MOVE    RECE04-REC        TO      RECE041-REC
             MOVE    WRK-CNT-MEISAI    TO      RECE041-MEISAISU
             WRITE   RECE041-REC
             ADD     1                 TO      CNT-RECE04
      *
      **     END-IF
      *
           .
       2001-SHUJUTSU-COMMENT-EXT.
           EXIT.
      *
      *****************************************************************
      *    指導管理算定日の確定
      *****************************************************************
       2001-SHIDOU-DAY-SEC          SECTION.
      *
           INITIALIZE                TBL-SHUJUTSU-DAY
      *
           INITIALIZE                        SRYACCT-REC
           MOVE    RECE04-HOSPID     TO      ACCT-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      ACCT-NYUGAIKBN
           MOVE    RECE04-PTID       TO      ACCT-PTID
           MOVE    RECE04-SRYKA      TO      ACCT-SRYKA
           MOVE    RECE04-SRYYM      TO      ACCT-SRYYM
           MOVE    RECE04-SRYKBN     TO      ACCT-SRYKBN
           MOVE    RECE04-ZAINUM     TO      ACCT-ZAINUM
      *
           MOVE    SRYACCT-REC       TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =  ZERO
               MOVE    "DBFETCH"      TO     MCP-FUNC
               MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
              IF      MCP-RC        =        ZERO
                   MOVE    ZERO          TO  DAY-IDX
                   MOVE    MCPDATA-REC   TO  SRYACCT-REC
                   PERFORM    VARYING    IDX  FROM   1   BY   1
                              UNTIL     (IDX      >   31)  OR
                                        (DAY-IDX  >   10)
                        IF    ACCT-DAY(1 IDX)  NOT =  ZERO
                              ADD   1     TO   DAY-IDX
                              MOVE  IDX   TO  TB-SHUJUTSU-DAY(DAY-IDX)
                        END-IF
                         CONTINUE
                   END-PERFORM
              END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-SHIDOU-DAY-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    手術日の確定
      *****************************************************************
       2001-SHUJUTSU-DAY-SEC          SECTION.
      *
           INITIALIZE                TBL-SHUJUTSU-DAY
      *
           INITIALIZE                        SRYACCT-REC
           MOVE    RECE04-HOSPID     TO      ACCT-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      ACCT-NYUGAIKBN
           MOVE    RECE04-PTID       TO      ACCT-PTID
           MOVE    RECE04-SRYKA      TO      ACCT-SRYKA
           MOVE    RECE04-SRYYM      TO      ACCT-SRYYM
           MOVE    RECE04-SRYKBN     TO      ACCT-SRYKBN
           MOVE    RECE04-ZAINUM     TO      ACCT-ZAINUM
      *
           MOVE    SRYACCT-REC       TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =  ZERO
               MOVE    "DBFETCH"      TO     MCP-FUNC
               MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
              IF      MCP-RC        =        ZERO
                   MOVE    ZERO          TO  DAY-IDX
                   MOVE    MCPDATA-REC   TO  SRYACCT-REC
                   PERFORM    VARYING    IDX  FROM   1   BY   1
                              UNTIL     (IDX      >   31)  OR
                                        (DAY-IDX  >   10)
                        IF    ACCT-DAY(1 IDX)  NOT =  ZERO
                              ADD   1     TO   DAY-IDX
                              MOVE  IDX   TO  TB-SHUJUTSU-DAY(DAY-IDX)
                        END-IF
                         CONTINUE
                   END-PERFORM
              END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-SHUJUTSU-DAY-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０５転送処理
      *****************************************************************
       2002-RECE05-TENSOU-SEC     SECTION.
      *
           INITIALIZE                      RECE05-REC
           MOVE    RECE04-HOSPID       TO  RECE05-HOSPID
           MOVE    RECE04-SRYYM        TO  RECE05-SRYYM
           MOVE    RECE04-NYUGAIKBN    TO  RECE05-NYUGAIKBN
           MOVE    RECE04-PTID         TO  RECE05-PTID
           MOVE    RECE04-RECEKA       TO  RECE05-RECEKA
           MOVE    RECE04-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
           MOVE    RECE04-RECESYUBETU  TO  RECE05-RECESYUBETU
           MOVE    RECE04-HKNJANUM     TO  RECE05-HKNJANUM
           MOVE    RECE04-TEKSTYMD     TO  RECE05-TEKSTYMD
           MOVE    RECE04-ZAINUM       TO  RECE05-ZAINUM
           START   RECE05-FILE
               KEY IS    >=   RECE05-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE05
               NOT INVALID
                   PERFORM 990-RECE05-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-RECE05           =   1                   )
               OR     ( RECE04-HOSPID    NOT =   RECE05-HOSPID       )
               OR     ( RECE04-SRYYM     NOT =   RECE05-SRYYM        )
               OR     ( RECE04-NYUGAIKBN NOT =   RECE05-NYUGAIKBN    )
               OR     ( RECE04-PTID      NOT =   RECE05-PTID         )
               OR     ( RECE04-RECEKA    NOT =   RECE05-RECEKA       )
               OR     ( RECE04-TEISYUTUSAKI
                                         NOT =   RECE05-TEISYUTUSAKI )
               OR     ( RECE04-RECESYUBETU
                                         NOT =   RECE05-RECESYUBETU  )
               OR     ( RECE04-HKNJANUM  NOT =   RECE05-HKNJANUM     )
               OR     ( RECE04-TEKSTYMD  NOT =   RECE05-TEKSTYMD     )
               OR     ( RECE04-ZAINUM    NOT =   RECE05-ZAINUM       )
      *
      *
               MOVE          RECE05-REC       TO      RECE051-REC
               WRITE         RECE051-REC
               ADD     1                 TO  CNT-RECE05
      *
               PERFORM 990-RECE05-NEXT-SEC
      *
           END-PERFORM
      *
           .
       2002-RECE05-TENSOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
               CLOSE   RECEERR-FILE
           ELSE
               OPEN    OUTPUT              RECEERR-FILE
      *
               MOVE    WRK-RECEERR         TO  RECEERR-REC
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
               CALL    "ORCSJOB"       USING
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
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *    ファイルＣＬＯＳＥ処理
           PERFORM 310-FILE-CLOSE-SEC
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
           DISPLAY "RECE02  IN  " CNT-RECE02 
           DISPLAY "RECE04  CNT " CNT-RECE04 
           DISPLAY "RECE05  CNT " CNT-RECE05 
           DISPLAY "*** ORCR0040 END ***"
      ***     ACCEPT  WRK-IN FROM CONSOLE 
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイルＣＬＯＳＥ処理
      *****************************************************************
       310-FILE-CLOSE-SEC              SECTION.
      *
           CLOSE                       RECE02-FILE
      *
           CLOSE                       RECE04-FILE
      *
           CLOSE                       RECE05-FILE
      *
           CLOSE                       RECE041-FILE     
           CLOSE                       RECE051-FILE     
      *
           .
       310-FILE-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト０２データ順検索処理
      *****************************************************************
       990-RECE02-READ-SEC           SECTION.
      *
           READ    RECE02-FILE         NEXT
               AT  END
                   MOVE    1           TO  FLG-END
                   MOVE    2           TO  SPA-STS
               NOT AT  END
                   ADD     1           TO  CNT-RECE02
                   MOVE    ZERO        TO  FLG-END
           END-READ
      *
           .
       990-RECE02-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０４データ読み
      ****************************************************************
       990-RECE04-NEXT-SEC           SECTION.
      *
           READ    RECE04-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE04
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE04
           END-READ
      *
           .
       990-RECE04-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０５データ読み
      ****************************************************************
       990-RECE05-NEXT-SEC           SECTION.
      *
           READ    RECE05-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE05
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE05
           END-READ
      *
           .
       990-RECE05-NEXT-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数マスター読込（キー）
      *****************************************************************
       900-TENSU-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "TENSU-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-TENSU
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
               ELSE
                   INITIALIZE                  TNS-TENSU-REC
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-TENSU-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数読込
      *****************************************************************
       TENSU-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  TNS-TENSU-REC
               MOVE    ZERO            TO  FLG-TENSU
           ELSE
               INITIALIZE                  TNS-TENSU-REC
               MOVE    1               TO  FLG-TENSU
           END-IF
      *
           .
       TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    算定歴マスタ読み込み
      *****************************************************************
       SANTEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SANTEI-REC
               MOVE    ZERO                TO  FLG-SANTEI
           ELSE
               INITIALIZE                      SANTEI-REC
               MOVE    1                   TO  FLG-SANTEI
           END-IF
      *
           .
       SANTEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソルクローズ処理
      *****************************************************************
       CSR-CLOSE-SEC            SECTION.
      *
           INITIALIZE                  MCPAREA
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-PATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       CSR-CLOSE-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       120-DBOPEN-SEC                SECTION.
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
      *
      *****************************************************************
      *    リハビリのカウント
      *****************************************************************
       2001-RIHA-COUNT-SEC          SECTION.
      *
      *理学療法（１）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA1-SHU1   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA1-SHU1   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA1-SHU1   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA1-SHU1   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA1-SHU1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA1-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA1-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA1-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（１）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA1-SHU2   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA1-SHU2   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA1-SHU2   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA1-SHU2   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA1-SHU2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA1-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA1-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA1-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（１）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA1-KO1    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA1-KO1    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA1-KO1    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA1-KO1    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA1-KO1    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA1-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA1-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA1-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（１）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA1-KO2    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA1-KO2    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA1-KO2    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA1-KO2    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA1-KO2    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA1-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA1-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA1-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（２）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA2-SHU1   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA2-SHU1   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA2-SHU1   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA2-SHU1   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA2-SHU1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA2-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA2-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA2-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（２）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA2-SHU2   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA2-SHU2   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA2-SHU2   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA2-SHU2   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA2-SHU2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA2-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA2-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA2-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（２）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA2-KO1    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA2-KO1    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA2-KO1    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA2-KO1    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA2-KO1    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA2-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA2-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA2-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（２）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA2-KO2    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA2-KO2    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA2-KO2    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA2-KO2    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA2-KO2    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA2-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA2-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA2-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（３）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA3-SHU1   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA3-SHU1   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA3-SHU1   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA3-SHU1   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA3-SHU1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA3-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA3-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA3-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（３）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA3-SHU2   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA3-SHU2   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA3-SHU2   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA3-SHU2   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA3-SHU2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA3-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA3-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA3-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（３）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA3-KO1    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA3-KO1    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA3-KO1    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA3-KO1    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA3-KO1    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA3-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA3-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA3-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（３）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA3-KO2    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA3-KO2    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA3-KO2    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA3-KO2    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA3-KO2    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA3-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA3-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA3-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（４）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA4-SHU1   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA4-SHU1   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA4-SHU1   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA4-SHU1   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA4-SHU1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA4-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA4-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA4-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（４）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA4-SHU2   TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA4-SHU2   TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA4-SHU2   TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA4-SHU2   TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA4-SHU2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA4-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA4-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA4-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（４）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA4-KO1    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA4-KO1    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA4-KO1    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA4-KO1    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA4-KO1    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA4-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA4-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA4-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *理学療法（４）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-RIGA4-KO2    TO      SRY-SRYCD (1)
           MOVE    CONS-RIGA4-KO2    TO      SRY-SRYCD (2)
           MOVE    CONS-RIGA4-KO2    TO      SRY-SRYCD (3)
           MOVE    CONS-RIGA4-KO2    TO      SRY-SRYCD (4)
           MOVE    CONS-RIGA4-KO2    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM  > WRK-RIGA4-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                  WRK-RIGA4-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                        MOVE  "1" TO WRK-RIGA4-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（１）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO1-SHU1  TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO1-SHU1  TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO1-SHU1  TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO1-SHU1  TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO1-SHU1  TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO1-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO1-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO1-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（１）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO1-SHU2  TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO1-SHU2  TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO1-SHU2  TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO1-SHU2  TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO1-SHU2  TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO1-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO1-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO1-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（２）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO2-SHU1  TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO2-SHU1  TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO2-SHU1  TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO2-SHU1  TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO2-SHU1  TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO2-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO2-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO2-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（２）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO2-SHU2  TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO2-SHU2  TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO2-SHU2  TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO2-SHU2  TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO2-SHU2  TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO2-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO2-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO2-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（１）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO1-KO1   TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO1-KO1   TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO1-KO1   TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO1-KO1   TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO1-KO1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO1-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO1-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO1-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（１）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO1-KO2   TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO1-KO2   TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO1-KO2   TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO1-KO2   TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO1-KO2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO1-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO1-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO1-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（２）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO2-KO1   TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO2-KO1   TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO2-KO1   TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO2-KO1   TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO2-KO1   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO2-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO2-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO2-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *作業療法（２）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-SAGYO2-KO2   TO      SRY-SRYCD (1)
           MOVE    CONS-SAGYO2-KO2   TO      SRY-SRYCD (2)
           MOVE    CONS-SAGYO2-KO2   TO      SRY-SRYCD (3)
           MOVE    CONS-SAGYO2-KO2   TO      SRY-SRYCD (4)
           MOVE    CONS-SAGYO2-KO2   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-SAGYO2-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-SAGYO2-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-SAGYO2-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *言語聴覚療法（１）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-GENGO1-SHU   TO      SRY-SRYCD (1)
           MOVE    CONS-GENGO1-SHU   TO      SRY-SRYCD (2)
           MOVE    CONS-GENGO1-SHU   TO      SRY-SRYCD (3)
           MOVE    CONS-GENGO1-SHU   TO      SRY-SRYCD (4)
           MOVE    CONS-GENGO1-SHU   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-GENGO1-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-GENGO1-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-GENGO1-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *言語聴覚療法（１）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-GENGO1-KO    TO      SRY-SRYCD (1)
           MOVE    CONS-GENGO1-KO    TO      SRY-SRYCD (2)
           MOVE    CONS-GENGO1-KO    TO      SRY-SRYCD (3)
           MOVE    CONS-GENGO1-KO    TO      SRY-SRYCD (4)
           MOVE    CONS-GENGO1-KO    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-GENGO1-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-GENGO1-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-GENGO1-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *言語聴覚療法（２）（集団療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-GENGO2-SHU   TO      SRY-SRYCD (1)
           MOVE    CONS-GENGO2-SHU   TO      SRY-SRYCD (2)
           MOVE    CONS-GENGO2-SHU   TO      SRY-SRYCD (3)
           MOVE    CONS-GENGO2-SHU   TO      SRY-SRYCD (4)
           MOVE    CONS-GENGO2-SHU   TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-GENGO2-SHU-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-GENGO2-SHU-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-GENGO2-SHU(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
      *言語聴覚療法（２）（個別療法）について検索
           INITIALIZE                        SRYACT-REC
           MOVE    RECE04-HOSPID     TO      SRY-HOSPID
           MOVE    RECE04-NYUGAIKBN  TO      SRY-NYUGAIKBN
           MOVE    RECE04-PTID       TO      SRY-PTID
           MOVE    RECE04-SRYYM      TO      SRY-SRYYM
           MOVE    RECE04-ZAINUM     TO      SRY-ZAINUM
           MOVE    CONS-GENGO2-KO    TO      SRY-SRYCD (1)
           MOVE    CONS-GENGO2-KO    TO      SRY-SRYCD (2)
           MOVE    CONS-GENGO2-KO    TO      SRY-SRYCD (3)
           MOVE    CONS-GENGO2-KO    TO      SRY-SRYCD (4)
           MOVE    CONS-GENGO2-KO    TO      SRY-SRYCD (5)
      *
           MOVE    SRYACT-REC        TO      MCPDATA-REC
           MOVE    "DBSELECT"        TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           IF  MCP-RC                =       ZERO
               MOVE    "DBFETCH"     TO      MCP-FUNC
               MOVE    "SRYACT-KEY8" TO      ORC-DBPATH
               CALL    "ORCMCPSUB"           USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
               IF      MCP-RC        =       ZERO
                   MOVE    MCPDATA-REC       TO      SRYACT-REC
                   INITIALIZE                        SRYACCT-REC
                   MOVE    SRY-HOSPID        TO      ACCT-HOSPID
                   MOVE    SRY-NYUGAIKBN     TO      ACCT-NYUGAIKBN
                   MOVE    SRY-PTID          TO      ACCT-PTID
                   MOVE    SRY-SRYKA         TO      ACCT-SRYKA
                   MOVE    SRY-SRYYM         TO      ACCT-SRYYM
                   MOVE    SRY-SRYKBN        TO      ACCT-SRYKBN
                   MOVE    SRY-ZAINUM        TO      ACCT-ZAINUM
                   MOVE    SRYACCT-REC       TO      MCPDATA-REC
                   MOVE    "DBSELECT"        TO      MCP-FUNC
                   MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
                   CALL    "ORCMCPSUB"       USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
                   IF      MCP-RC    =       ZERO
                       MOVE    "DBFETCH"     TO      MCP-FUNC
                       MOVE    "SRYACCT-KEY" TO      ORC-DBPATH
                       CALL    "ORCMCPSUB"           USING
                                                     MCPAREA
                                                     ORCMCPAREA
                                                     MCPDATA-REC
                       IF      MCP-RC        =       ZERO
                               MOVE  MCPDATA-REC  TO  SRYACCT-REC
                               IF  ACCT-ZAINUM > WRK-GENGO2-KO-ZAINUM
                                   MOVE  ACCT-ZAINUM  TO
                                                 WRK-GENGO2-KO-ZAINUM
                               END-IF
                               PERFORM  VARYING   IDX  FROM  1  BY  1
                                        UNTIL     IDX  >   31
                                   IF   ACCT-DAY(1 IDX)  NOT = ZERO
                                       MOVE  "1" TO WRK-GENGO2-KO(IDX)
                                   END-IF
                               END-PERFORM
                       END-IF
                   END-IF
           END-IF
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACT-KEY8"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           INITIALIZE                        MCPAREA
           MOVE    "DBCLOSE"         TO      MCP-FUNC
           MOVE    "SRYACCT-KEY"     TO      ORC-DBPATH
           CALL    "ORCMCPSUB"       USING
                                     MCPAREA
                                     ORCMCPAREA
                                     MCPDATA-REC
      *
           .
       2001-RIHA-COUNT-EXT.
           EXIT.
      *
      *****************************************************************
      *    リハビリのコメント編集
      *****************************************************************
       2001-RIHA-COMMENT-SEC          SECTION.
      *
           MOVE    RECE04-REC        TO      RECE041-REC
           ADD     1                 TO      RECE041-MEISAISU
           WRITE   RECE041-REC
           ADD     1                 TO      CNT-RECE04
      *
      *      ※明細が５以上の場合
             INITIALIZE                      RECE05-REC
             MOVE    RECE04-HOSPID       TO  RECE05-HOSPID
             MOVE    RECE04-SRYYM        TO  RECE05-SRYYM
             MOVE    RECE04-NYUGAIKBN    TO  RECE05-NYUGAIKBN
             MOVE    RECE04-PTID         TO  RECE05-PTID
             MOVE    RECE04-RECEKA       TO  RECE05-RECEKA
             MOVE    RECE04-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
             MOVE    RECE04-RECESYUBETU  TO  RECE05-RECESYUBETU
             MOVE    RECE04-HKNJANUM     TO  RECE05-HKNJANUM
             MOVE    RECE04-TEKSTYMD     TO  RECE05-TEKSTYMD
             MOVE    RECE04-ZAINUM       TO  RECE05-ZAINUM
             START   RECE05-FILE
                 KEY IS    >=   RECE05-KEY
                 INVALID
                     MOVE    1           TO  FLG-RECE05
                 NOT INVALID
                     PERFORM 990-RECE05-NEXT-SEC
                     MOVE    RECE05-REC  TO  WRK-RECE05-REC
             END-START
      *
      *      ＲＥＣＥ０５ファイルの内容をテーブルに退避
             MOVE    ZERO                 TO  IDX-RECE05
             MOVE    SPACE                TO  WRK-SRYACTINF-AREA
             INITIALIZE                       WRK-SRYACTINF-AREA
             MOVE    SPACE                TO  WRK-NAMEINF-AREA
             INITIALIZE                       WRK-NAMEINF-AREA
      *      リハビリコメントの挿入
      *      ADD     1                    TO  IDX-RECE05
             MOVE    SPACE                TO  COM-RECE05-REC
             INITIALIZE                       COM-RECE05-REC
             MOVE    "840000096"          TO  COM-SRYCD(1)
             MOVE    ZERO                 TO  COM-SRYSURYO(1)
             MOVE    7                    TO  COM-YUKOKETA(1)
             MOVE    "実施日数　　日"     TO  COM-NAME(1)
             MOVE    ZERO                 TO  CNT-RIHA
             EVALUATE   RECE04-ZAINUM
                 WHEN   WRK-RIGA1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-SHU(IDX) NOT = SPACE
                                ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA3-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA3-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-RIGA4-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-RIGA4-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-SAGYO2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-SAGYO2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-SHU-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-SHU(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO1-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO1-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   WRK-GENGO2-KO-ZAINUM
                        PERFORM  VARYING  IDX   FROM  1  BY  1
                                 UNTIL    IDX   >   31
                            IF   WRK-GENGO2-KO(IDX) NOT = SPACE
                                 ADD      1     TO  CNT-RIHA
                            END-IF
                        END-PERFORM
                 WHEN   OTHER
                        CONTINUE
             END-EVALUATE
             IF      CNT-RIHA             NOT =    ZERO
               MOVE    CNT-RIHA             TO  DAY-IDX
               MOVE    TBL-DAY(DAY-IDX)     TO  COM-NAME(1)(9:4)
               COMPUTE  MAX-MEISAISU        =   RECE04-MEISAISU  +  1
               MOVE    COM-SRYACTINF(1)     TO  WRK-SRYACTINF
                                                     (MAX-MEISAISU)
               MOVE    COM-NAMEINF(1)       TO  WRK-NAMEINF
                                                     (MAX-MEISAISU)
             END-IF
      *
             PERFORM
               UNTIL  ( FLG-RECE05           =   1                   )
               OR     ( RECE04-HOSPID    NOT =   RECE05-HOSPID       )
               OR     ( RECE04-SRYYM     NOT =   RECE05-SRYYM        )
               OR     ( RECE04-NYUGAIKBN NOT =   RECE05-NYUGAIKBN    )
               OR     ( RECE04-PTID      NOT =   RECE05-PTID         )
               OR     ( RECE04-RECEKA    NOT =   RECE05-RECEKA       )
               OR     ( RECE04-TEISYUTUSAKI
                                         NOT =   RECE05-TEISYUTUSAKI )
               OR     ( RECE04-RECESYUBETU
                                         NOT =   RECE05-RECESYUBETU  )
               OR     ( RECE04-HKNJANUM  NOT =   RECE05-HKNJANUM     )
               OR     ( RECE04-TEKSTYMD  NOT =   RECE05-TEKSTYMD     )
               OR     ( RECE04-ZAINUM    NOT =   RECE05-ZAINUM       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE05-SRYCD(IDX) =   SPACE )
                    ADD    1             TO      IDX-RECE05
                    MOVE   RECE05-SRYACTINF(IDX) TO
                                             WRK-SRYACTINF(IDX-RECE05)
                    MOVE   RECE05-NAMEINF(IDX)   TO
                                             WRK-NAMEINF(IDX-RECE05)     
               END-PERFORM 
      *
               PERFORM 990-RECE05-NEXT-SEC
      *
             END-PERFORM
      *
      *      リハビリコメントを含んだ内容で中間ファイルの再作成
             MOVE       ZERO             TO      FLG-WRKRECE05
             MOVE       ZERO             TO      IDX
             MOVE       ZERO             TO      IDX-RECE05
             MOVE       ZERO             TO      WRK-RENNUM
             PERFORM    UNTIL     FLG-WRKRECE05  =    1
                    INITIALIZE                        RECE051-REC
                    MOVE    WRK-RECE05-KEY       TO   RECE051-KEY
                    ADD     1                    TO   WRK-RENNUM
                    MOVE    WRK-RENNUM           TO   RECE051-RENNUM
                    MOVE    WRK-RECE05-KOHBUNRI  TO   RECE051-KOHBUNRI
                    MOVE    WRK-RECE05-PTNUM     TO   RECE051-PTNUM
                    MOVE    WRK-RECE05-SRYKA     TO   RECE051-SRYKA
                    MOVE    WRK-RECE05-SRYKBN    TO   RECE051-SRYKBN
                    MOVE    WRK-RECE05-SRYSYUKBN TO   RECE051-SRYSYUKBN
                    MOVE    WRK-RECE05-JIHIMONEY TO   RECE051-JIHIMONEY
                    PERFORM  VARYING   IDX   FROM   1   BY   1
                             UNTIL   (IDX       >    5)   OR
                                     (FLG-WRKRECE05   =   1)
                       ADD         1             TO    IDX-RECE05
                       IF  WK-RECE05-SRYCD(IDX-RECE05) = SPACE
                           MOVE    1             TO    FLG-WRKRECE05
                       ELSE
                           MOVE  WRK-SRYACTINF(IDX-RECE05)
                                            TO   RECE051-SRYACTINF(IDX)  
                           MOVE  WRK-NAMEINF(IDX-RECE05)
                                            TO   RECE051-NAMEINF(IDX)
                       END-IF  
                    END-PERFORM
                    WRITE   RECE051-REC
                    ADD     1                    TO  CNT-RECE05
             END-PERFORM     
      *
           .
       2001-RIHA-COMMENT-EXT.
           EXIT.
