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
       PROGRAM-ID.             ORCBD005.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 日次帳票
      *  コンポーネント名  : 収納一覧表（ＨＣＭ０８）入院
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/03/06    NACL-森脇     新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  00.00.01    NACL-太田    03/04/25  病棟・病室名の編集を追加
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      * 
      *    収納明細処理ファイル（初期化／読込用）
           SELECT  BD00501-FILE   ASSIGN   ORCBD005PARA
                                  ORGANIZATION    IS  INDEXED
                                  ACCESS  MODE    IS  SEQUENTIAL
                                  RECORD  KEY     IS  BD00501-ISAM-KEY
                                  FILE    STATUS  IS  STS-BD00501.
      *
      *    収納明細ファイル（書込用）
           SELECT  BD00502-FILE   ASSIGN   ORCBD005PARA
                                  ORGANIZATION    IS  INDEXED
                                  ACCESS  MODE    IS  DYNAMIC
                                  RECORD  KEY     IS  BD00502-ISAM-KEY
                                  FILE    STATUS  IS  STS-BD00502.
      * 
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                            SECTION.
006900*    
       FD  BD00501-FILE.
       01  BD00501-REC.
           02  BD00501-ISAM-KEY.
               03  BD00501-ISAM-KEY-BTUNUM     PIC X(02).
               03  BD00501-ISAM-KEY-BRMNUM     PIC X(08).
               03  BD00501-ISAM-KEY-SRYKA      PIC X(02).
               03  BD00501-ISAM-KEY-PTNUM      PIC X(20).
               03  BD00501-ISAM-KEY-DENPNUM    PIC 9(07).
               03  BD00501-ISAM-KEY-DENPEDANUM PIC 9(02).
           02  BD00501-SYU-DATA-AREA.
               03  BD00501-SYU-CREATEKBN       PIC X(01).
           02  BD00501-SMEI-DATA-AREA.
           COPY    "CPSYUMEI.INC"  REPLACING   //SMEI//
                                   BY          //BD00501-SMEI//.
      *
       FD  BD00502-FILE.
       01  BD00502-REC.
           02  BD00502-ISAM-KEY.
               03  BD00502-ISAM-KEY-BTUNUM     PIC X(02).
               03  BD00502-ISAM-KEY-BRMNUM     PIC X(08).
               03  BD00502-ISAM-KEY-SRYKA      PIC X(02).
               03  BD00502-ISAM-KEY-PTNUM      PIC X(20).
               03  BD00502-ISAM-KEY-DENPNUM    PIC 9(07).
               03  BD00502-ISAM-KEY-DENPEDANUM PIC 9(02).
           02  BD00502-SYU-DATA-AREA.
               03  BD00502-SYU-CREATEKBN       PIC X(01).
           02  BD00502-SMEI-DATA-AREA.
           COPY    "CPSYUMEI.INC"  REPLACING   //SMEI//
                                   BY          //BD00502-SMEI//.
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *    収納明細処理ファイル
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING   //RECE01//
                                   BY          //ORCBD005//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING   //RECE01PARA//
                                   BY          //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
           COPY    "HCM08.INC".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-RECEERR         PIC X(02).
           03  STS-BD00501         PIC X(02).
           03  STS-BD00502         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-SYU             PIC 9(01).
           03  FLG-SMEI            PIC 9(01).
           03  FLG-SMEI2           PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-PTNUM           PIC 9(01).
           03  FLG-NEXTPAGE        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE            PIC 9(02).
           03  CNT-PAGE            PIC 9(06).
           03  CNT-DENP            PIC 9(06).
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
           03  IDZ                 PIC 9(04).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
           03  WRK-PARA-HOSPID     PIC X(24).
           03  WRK-PARA-DENPPRTYMD PIC X(08).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-RECEERR         PIC X(200).
      *
           03  WRK-SYSYMD.
               05  WRK-SYSYY       PIC 9(04).
               05  WRK-SYSMM       PIC 9(02).
               05  WRK-SYSDD       PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-HENYMDG         PIC X(22).
           03  WRK-HYYMMDD         PIC X(09).
      *
           03  WRK-Z9              PIC ----,---,--9.
      *
           03  WRK-SYORIYMD        PIC X(24).
           03  WRK-PAGE            PIC ZZ9.
           03  WRK-HJYOTAI         PIC X(16).
           03  WRK-MAX             PIC 9(02).
      *
           03  WRK-NAI-TBL.
               05  WRK-NAI-G       OCCURS  30.
                 07  WRK-BTUNAME   PIC X(10).
                 07  WRK-BRMNUM    PIC X(06).
                 07  WRK-SRYKA     PIC X(08).
                 07  WRK-PTNUM     PIC X(20).
                 07  WRK-NAME      PIC X(36).
                 07  WRK-SEX       PIC X(2).
                 07  WRK-BIRTHDAY  PIC X(22).
                 07  WRK-DENPNUM   PIC 9(07).
                 07  WRK-SEIKYU    PIC S9(07).
                 07  WRK-RYOSYU    PIC S9(07).
                 07  WRK-MISYU     PIC S9(07).
                 07  WRK-JYOTAI    PIC X(16).
      *
           03  WRK-SUM-TBL         OCCURS  4.
               05  WRK-GSEIKYU     PIC S9(08).
               05  WRK-GRYOSYU     PIC S9(08).
               05  WRK-GMISYU      PIC S9(08).
           03  WRK-SPTID-PTNUM     PIC X(20).
           03  WRK-SPTID-PTID      PIC 9(10).
           03  WRK-BRM-NUM-IN                      PIC X(06).
           03  WRK-BRM-NUM-EDT                     PIC X(06).
           03  WRK-STR1                            PIC X(20).
           03  WRK-STR2                            PIC X(20).
           03  WRK-IDX1                            PIC 9(05).
           03  WRK-IDX2                            PIC 9(05).
      *
       01  KEY-AREA.
           03  KEY-BTUNUM          PIC X(02).
           03  KEY-BRMNUM          PIC X(08).
           03  KEY-SRYKA           PIC X(02).
           03  KEY-PTID            PIC 9(10).
           03  KEY-DENPNUM         PIC 9(07).
      *
           COPY    "CPSHELLTBL.INC".
      *
           COPY    "ORCA-DBPATH".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    医療機関情報情報
           COPY    "CPSK1001.INC".
      *
      *    患者番号構成情報
           COPY    "CPSK1009.INC".
      *
      *    診療科目情報情報
           COPY    "CPSK1005.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY    "CPSK1031.INC".
      *
      *    病棟情報
           COPY    "CPSK5001.INC".
      *
      *    収納マスタ
       01  SYU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    収納明細マスタ
       01  SMEI-REC.
           COPY    "CPSYUMEI.INC".
      *
      *    収納明細履歴マスタ
       01  SMEI2-REC.
           COPY    "CPSYUMEI.INC"  REPLACING   //SMEI//
                                   BY          //SMEI2//.
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    患者番号変換マスタ
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
       01  PRTKANRI-REC.
           COPY    "CPPRTKANRI.INC".
      *
       01  PRTDATA-REC.
           COPY    "CPPRTDATA.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      ****************************************************************
       LINKAGE                     SECTION.
       01  COMMAND-PARAM.
           02  FILLER              PIC X(256).
      *
      ****************************************************************
       PROCEDURE               DIVISION
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
                   UNTIL   FLG-END     =   1
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
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  KEY-AREA
           INITIALIZE                  SPA-AREA
      *
           PERFORM 100-DBOPEN-SEC
      *
           UNSTRING   COMMAND-PARAM    DELIMITED  BY  ","
                                       INTO    LNK-PRTKANRI-RENNUM
                                               LNK-PRTKANRI-TBL-KEY
                                               LNK-PRTKANRI-TBL-GROUP
                                               LNK-PRTKANRI-SHORI-RENNUM
                                               LNK-PRTKANRI-SRYYM
                                               LNK-PRTKANRI-SKYYMD
                                               LNK-PRTKANRI-SHELLID
                                               LNK-PRTKANRI-PRIORITY
                                               LNK-PRTKANRI-TERMID
                                               LNK-PRTKANRI-OPID
                                               LNK-PRTKANRI-PRTNM
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
                                               WRK-PARA-HOSPID
                                               WRK-PARA-DENPPRTYMD
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCBD004"      TO  JOB-PGID
           MOVE    "収納一覧表（入院）"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           MOVE    "RECEERR"       TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  RECEERR-TERMID
      *
      *    収納明細処理ファイル名
           MOVE    "BD00501"       TO  ORCBD005PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  ORCBD005PARA-TERMID
      *
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
      *
      *    対象収納明細ファイル出力処理
           PERFORM 110-SMEI-OUT-SEC
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       110-PARA-HENSYU-SEC         SECTION.
      *
      *    システム日付セット
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  WRK-SYSYMD
      *
      *    対象年月日編集
           MOVE    WRK-PARA-DENPPRTYMD
                                   TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG     TO  WRK-SYORIYMD(1:22)
           MOVE    "分"            TO  WRK-SYORIYMD(23:2)
      *
      *    医療機関ＩＤ編集
           MOVE    SPACE           TO  SYS-1001-REC
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"          TO  SYS-1001-KANRICD
           MOVE    "*"             TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC    TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1001-REC
               MOVE    SYS-1001-HOSPID TO  WRK-PARA-HOSPID
           ELSE
               MOVE    "医療機関ＩＤが取得できませんでした。"
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  100-INIT-EXT
           END-IF
      *
      *    患者番号構成管理情報編集
           INITIALIZE                  SYS-1009-REC
           MOVE    "1009"              TO  SYS-1009-KANRICD
           MOVE    "*"                 TO  SYS-1009-KBNCD
           MOVE    SYS-1009-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
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
                                       TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               GO  TO  100-INIT-EXT
           END-IF
      *
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイル出力処理
      *****************************************************************
       110-SMEI-OUT-SEC            SECTION.
      *
      *    定期請求収納ファイル初期化
           OPEN    OUTPUT              BD00501-FILE
           CLOSE   BD00501-FILE
      *
           OPEN    OUTPUT              BD00502-FILE
      *
      *    収納明細をソートする為、一度ファイルに退避する
           MOVE    ZERO            TO  FLG-SMEI
           PERFORM 900-DBSELECT-SEC
      *
           PERFORM UNTIL ( FLG-SMEI    =   1 )
      *
      *        収納データ取得
               PERFORM 1101-SYUNOU-GET-SEC
               MOVE    SYU-BYOTONUM    TO  BD00502-ISAM-KEY-BTUNUM
               MOVE    SYU-ROOMNUM     TO  BD00502-ISAM-KEY-BRMNUM
               MOVE    SYU-SRYKA       TO  BD00502-ISAM-KEY-SRYKA
      *
               MOVE    SMEI-PTID       TO  WRK-SPTID-PTID
               PERFORM 1101-PTNUM-GET-SEC
               MOVE    WRK-SPTID-PTNUM TO  BD00502-ISAM-KEY-PTNUM
      *
               MOVE    SMEI-DENPNUM    TO  BD00502-ISAM-KEY-DENPNUM
               MOVE    SMEI-DENPEDANUM TO  BD00502-ISAM-KEY-DENPEDANUM
      *
               MOVE    SYU-CREATEKBN   TO  BD00502-SYU-CREATEKBN
               MOVE    SMEI-REC        TO  BD00502-SMEI-DATA-AREA
      *
               WRITE   BD00502-REC
      *
               PERFORM 900-DBFETCH-SEC
      *
           END-PERFORM
      *
           PERFORM 900-DBCLOSE-SEC
      *
           CLOSE   BD00502-FILE
      *
           .
       110-SMEI-OUT-EXT.
           EXIT.
      *****************************************************************
      *    収納データ取得処理
      *****************************************************************
       1101-SYUNOU-GET-SEC             SECTION.
      *
      *    収納読み込み
           INITIALIZE                  SYU-REC
           MOVE    SMEI-HOSPID     TO  SYU-HOSPID
           MOVE    SMEI-NYUGAIKBN  TO  SYU-NYUGAIKBN
           MOVE    SMEI-PTID       TO  SYU-PTID
           MOVE    SMEI-DENPNUM    TO  SYU-DENPNUM
           PERFORM 900-SYU-READ-SEC
      *
           .
       1101-SYUNOU-GET-EXT.
           EXIT.
      *****************************************************************
      *    患者番号取得処理
      *****************************************************************
       1101-PTNUM-GET-SEC              SECTION.
      *
           MOVE    SPACE           TO  WRK-SPTID-PTNUM
      *
      *    患者番号を取得
           INITIALIZE                  ORCSPTIDAREA
           MOVE    WRK-PARA-HOSPID TO  SPTID-HOSPID
           MOVE    WRK-SPTID-PTID  TO  SPTID-PTID
           CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                           SPA-1009-TBL
           IF    ( SPTID-RC            =   ZERO )
               MOVE    SPTID-PTNUM TO  WRK-SPTID-PTNUM
           END-IF
      *
           .
       1101-PTNUM-GET-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    LOW-VALUE       TO  KEY-BTUNUM
                                       KEY-BRMNUM
                                       KEY-SRYKA
                                       KEY-PTID
                                       KEY-DENPNUM
      *
           MOVE    ZERO            TO  FLG-NEXTPAGE
      *
           OPEN    INPUT           BD00501-FILE
      *
           MOVE    ZERO            TO  FLG-SMEI
           PERFORM 900-BD00501-READ-SEC
      *
           PERFORM UNTIL   FLG-END     =   1
      *        帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-SEC
      *        帳票編集<明細>処理
               PERFORM 320-BODY-HEN-SEC
      *        帳票編集<合計>処理
               PERFORM 330-TERM-HEN-SEC
      *        帳票印刷処理
               PERFORM 390-PRINT-OUT-SEC
           END-PERFORM
      *
           CLOSE   BD00501-FILE
      *
      
      *    ファイル削除
           MOVE    ZERO        TO  IF-RESULT
           MOVE    ORCBD005PARA
	                       TO  IF-FILENAME
           CALL    "orcfiledel"    USING
                                       ORCSFDELAREA
      *
           .
      *
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<ヘッダー部>処理
      *****************************************************************
       310-HEAD-HEN-SEC            SECTION.
      *
           INITIALIZE                  WRK-SUM-TBL(1)
      *
           MOVE    ZERO            TO  CNT-LINE
           ADD     1               TO  CNT-PAGE
      *
           MOVE    SPACE           TO  HCM08
      *
           MOVE    WRK-SYORIYMD    TO  HCM08-SYORIYMD
      *
           MOVE    CNT-PAGE        TO  WRK-PAGE
           MOVE    WRK-PAGE        TO  HCM08-PAGE
           .
       310-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       320-BODY-HEN-SEC            SECTION.
      *
           PERFORM UNTIL ( FLG-END         =   1 )
                   OR    ( CNT-LINE       >=   30 )
      *
               PERFORM 3202-BODY-MAIN-HEN-SEC
      *
           END-PERFORM
      *
           .
       320-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       3202-BODY-MAIN-HEN-SEC          SECTION.
      *
           IF    ( CNT-LINE        =   ZERO )
            OR   ( KEY-BTUNUM  NOT =   BD00501-ISAM-KEY-BTUNUM )
               PERFORM 3200-BODY-BTUNAME-HEN-SEC
           END-IF
      *
           IF    ( CNT-LINE        =   ZERO )
            OR   ( KEY-BTUNUM  NOT =   BD00501-ISAM-KEY-BTUNUM )
            OR   ( KEY-BRMNUM  NOT =   BD00501-ISAM-KEY-BRMNUM )
               PERFORM 3200-BODY-BRMNUM-HEN-SEC
           END-IF
      *
           IF    ( CNT-LINE        =   ZERO )
            OR   ( KEY-BTUNUM  NOT =   BD00501-ISAM-KEY-BTUNUM )
            OR   ( KEY-BRMNUM  NOT =   BD00501-ISAM-KEY-BRMNUM )
            OR   ( KEY-SRYKA   NOT =   BD00501-ISAM-KEY-SRYKA )
               PERFORM 3200-BODY-SRYKA-HEN-SEC
           END-IF
      *
           IF    ( CNT-LINE        =   ZERO )
            OR   ( KEY-BTUNUM  NOT =   BD00501-ISAM-KEY-BTUNUM )
            OR   ( KEY-BRMNUM  NOT =   BD00501-ISAM-KEY-BRMNUM )
            OR   ( KEY-SRYKA   NOT =   BD00501-ISAM-KEY-SRYKA )
            OR   ( KEY-PTID    NOT =   SMEI-PTID )
               PERFORM 3201-BODY-PTID-HEN-SEC
           END-IF
      *
           IF    ( FLG-NEXTPAGE    =   1 )
               PERFORM 3203-BODY-NAIYO-SET-SEC
               MOVE    ZERO            TO  FLG-NEXTPAGE
           END-IF
      *
           MOVE    ZERO                TO  CNT-DENP
           INITIALIZE                      WRK-SUM-TBL(4)
      *
      *    伝票履歴チェック
           MOVE    ZERO                TO  FLG-SMEI2
           PERFORM 900-SMEI2-SELECT-SEC
           PERFORM UNTIL    FLG-SMEI2  =   1
               COMPUTE WRK-GSEIKYU(4)  =   WRK-GSEIKYU(4)
                                       +   SMEI2-SKYMONEY
               COMPUTE WRK-GRYOSYU(4)  =   WRK-GRYOSYU(4)
                                       +   SMEI2-NYUHEN-MONEY
               PERFORM 900-SMEI2-FETCH-SEC
           END-PERFORM
           PERFORM 900-SMEI2-CLOSE-SEC
      *
      *    キーを設定
           MOVE    BD00501-ISAM-KEY-BTUNUM
                                       TO  KEY-BTUNUM
           MOVE    BD00501-ISAM-KEY-BRMNUM
                                       TO  KEY-BRMNUM
           MOVE    BD00501-ISAM-KEY-SRYKA
                                       TO  KEY-SRYKA
           MOVE    SMEI-PTID           TO  KEY-PTID
           MOVE    BD00501-ISAM-KEY-DENPNUM
                                       TO  KEY-DENPNUM
      *
           PERFORM
               UNTIL ( FLG-SMEI        =   1 )
               OR    ( KEY-BTUNUM  NOT =   BD00501-ISAM-KEY-BTUNUM )
               OR    ( KEY-BRMNUM  NOT =   BD00501-ISAM-KEY-BRMNUM )
               OR    ( KEY-SRYKA   NOT =   BD00501-ISAM-KEY-SRYKA )
               OR    ( KEY-PTID    NOT =   SMEI-PTID )
               OR    ( KEY-DENPNUM NOT =   BD00501-ISAM-KEY-DENPNUM )
               OR    ( CNT-DENP           >=   30 )
      *
               ADD     1               TO  CNT-DENP
      *
      *        伝票番号
               MOVE    SMEI-DENPNUM    TO  WRK-DENPNUM(CNT-DENP)
      *
      *        処理区分
               EVALUATE    SMEI-JOUTAIKBN
               WHEN    SPACE
                   MOVE    "請求なし"  TO  WRK-HJYOTAI
                   MOVE    9           TO  WRK-MAX
               WHEN    "1"
                   MOVE    "請求・入金"
                                       TO  WRK-HJYOTAI
                   MOVE    11          TO  WRK-MAX
               WHEN    "2"
                   MOVE    "入金"      TO  WRK-HJYOTAI
                   MOVE    5           TO  WRK-MAX
               WHEN    "3"
                   MOVE    "再計算"    TO  WRK-HJYOTAI
                   MOVE    7           TO  WRK-MAX
               WHEN    "4"
                   MOVE    "返金"      TO  WRK-HJYOTAI
                   MOVE    5           TO  WRK-MAX
               WHEN    "5"
                   MOVE    "請求取消"  TO  WRK-HJYOTAI
                   MOVE    9           TO  WRK-MAX
               WHEN    "6"
                   MOVE    "入金取消"  TO  WRK-HJYOTAI
                   MOVE    9           TO  WRK-MAX
               WHEN    "8"
                   MOVE    "診療訂正"  TO  WRK-HJYOTAI
                   MOVE    9           TO  WRK-MAX
               WHEN    "9"
                   MOVE    "請求"      TO  WRK-HJYOTAI
                   MOVE    5           TO  WRK-MAX
               WHEN    OTHER
                   MOVE    SPACE       TO  WRK-HJYOTAI
                   MOVE    1           TO  WRK-MAX
               END-EVALUATE
      *
               EVALUATE    BD00501-SYU-CREATEKBN
               WHEN    "1"
                   MOVE    "（退）"    TO  WRK-HJYOTAI(WRK-MAX:6)
               WHEN    "2"
                   MOVE    "（定）"    TO  WRK-HJYOTAI(WRK-MAX:6)
               END-EVALUATE
      *
               MOVE    WRK-HJYOTAI     TO  WRK-JYOTAI(CNT-DENP)
      *
               ADD     SMEI-SKYMONEY       TO  WRK-GSEIKYU(4)
      *
               ADD     SMEI-NYUHEN-MONEY   TO  WRK-GRYOSYU(4)
      *
               COMPUTE WRK-GMISYU(4)       =   WRK-GSEIKYU(4)
                                           -   WRK-GRYOSYU(4)
      *        請求金額
               MOVE    SMEI-SKYMONEY       TO  WRK-SEIKYU(CNT-DENP)
      *
      *        領収金額
               MOVE    SMEI-NYUHEN-MONEY   TO  WRK-RYOSYU(CNT-DENP)
      *
      *        未収金額
               MOVE    WRK-GMISYU(4)       TO  WRK-MISYU(CNT-DENP)
      *
               PERFORM 900-BD00501-READ-SEC
           END-PERFORM
      *
           COMPUTE IDY         =   30  -   CNT-LINE
           IF        ( CNT-DENP    >  IDY )
               MOVE    30          TO  CNT-LINE
               MOVE    1           TO  FLG-NEXTPAGE
           ELSE
               PERFORM 3203-BODY-NAIYO-SET-SEC
           END-IF
      *
           .
       3202-BODY-MAIN-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    病棟名称編集処理
      *****************************************************************
       3200-BODY-BTUNAME-HEN-SEC      SECTION.
      *
      *    病棟情報
           INITIALIZE                  SYS-5001-REC
           MOVE    "5001"          TO  SYS-5001-KANRICD
           MOVE    BD00501-ISAM-KEY-BTUNUM
                                   TO  SYS-5001-KBNCD
           MOVE    SYS-5001-REC    TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-5001-REC
               MOVE    SYS-5001-BTU-TANNAME
                                       TO  WRK-BTUNAME(1)
           END-IF
      *
           .
       3200-BODY-BTUNAME-HEN-EXT.
           EXIT.
      *****************************************************************
      *    病室名称編集処理
      *****************************************************************
       3200-BODY-BRMNUM-HEN-SEC        SECTION.
      *
           MOVE   BD00501-ISAM-KEY-BRMNUM ( 3 : )
                                       TO  WRK-BRM-NUM-IN
           IF    ( WRK-BRM-NUM-IN (1 : 1)  =   SPACE )
               MOVE    SPACE           TO  WRK-STR1
               MOVE    1               TO  WRK-IDX1
               UNSTRING    WRK-BRM-NUM-IN
                   DELIMITED   BY  ALL SPACE
                   INTO    WRK-STR1
                   WITH    POINTER WRK-IDX1
               END-UNSTRING
               MOVE    WRK-BRM-NUM-IN (WRK-IDX1 : )
                                       TO  WRK-BRM-NUM-EDT
           ELSE
               MOVE    WRK-BRM-NUM-IN  TO  WRK-BRM-NUM-EDT
           END-IF
      *
           PERFORM VARYING WRK-IDX1    FROM    6   BY  -1
               UNTIL     ( WRK-IDX1    <   1 )
                 OR      ( WRK-BRM-NUM-EDT (WRK-IDX1 : 1)
                                   NOT =   SPACE )
               CONTINUE
           END-PERFORM
      *
           IF    ( WRK-IDX1    <   1 )
               MOVE    WRK-BRM-NUM-EDT TO  WRK-BRMNUM (1)
               GO  TO  3200-BODY-BRMNUM-HEN-EXT
           END-IF
      *
      *    病室番号が数字の場合前ゼロをとる
           IF    ( WRK-BRM-NUM-EDT ( 1 : WRK-IDX1 )
                                       IS  NUMERIC )
               IF    ( WRK-BRM-NUM-EDT ( 1 : 1 )
                                       =   ZERO )
                   MOVE    1               TO  WRK-IDX2
                   MOVE    SPACE           TO  WRK-STR1
                   UNSTRING    WRK-BRM-NUM-EDT
                       DELIMITED BY  ALL ZERO
                   INTO    WRK-STR1
                   WITH    POINTER WRK-IDX2
                   END-UNSTRING
                   MOVE    WRK-BRM-NUM-EDT (WRK-IDX2 : )
                                           TO  WRK-BRMNUM (1)
               ELSE
                   MOVE    WRK-BRM-NUM-EDT TO  WRK-BRMNUM (1)
               END-IF
           ELSE
                   MOVE    WRK-BRM-NUM-EDT TO  WRK-BRMNUM (1)
           END-IF
      *
           .
       3200-BODY-BRMNUM-HEN-EXT.
           EXIT.
      *****************************************************************
      *    診療科編集処理
      *****************************************************************
       3200-BODY-SRYKA-HEN-SEC      SECTION.
      *
      *    診療科情報
           INITIALIZE                  SYS-1005-REC
           MOVE    "1005"          TO  SYS-1005-KANRICD
           MOVE    BD00501-ISAM-KEY-SRYKA
                                   TO  SYS-1005-KBNCD
           MOVE    SYS-1005-REC    TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC     TO  SYS-1005-REC
               MOVE    SYS-1005-SRYKANAME
                                       TO  WRK-SRYKA(1)
           END-IF
      *
           .
       3200-BODY-SRYKA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者情報編集処理
      *****************************************************************
       3201-BODY-PTID-HEN-SEC      SECTION.
      *
      *    患者情報読み込み
           INITIALIZE                  PTINF-REC
           MOVE    SMEI-HOSPID     TO  PTINF-HOSPID
           MOVE    SMEI-PTID
                                   TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
      *
      *    患者番号
           MOVE    BD00501-ISAM-KEY-PTNUM
                                   TO  WRK-PTNUM(1)
      *
      *    氏名
           MOVE    PTINF-NAME      TO  WRK-NAME(1)
      *
      *    性別
           EVALUATE    PTINF-SEX
               WHEN    "1"
                   MOVE    "男"    TO  WRK-SEX(1)
               WHEN    "2"
                   MOVE    "女"    TO  WRK-SEX(1)
           END-EVALUATE
      *
      *    生年月日
           MOVE    PTINF-BIRTHDAY  TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HYYMMDD     TO  WRK-BIRTHDAY(1)
      *
           .
       3201-BODY-PTID-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細>処理
      *****************************************************************
       3203-BODY-NAIYO-SET-SEC     SECTION.
      *
           MOVE    ZERO            TO  IDZ
      *
           PERFORM UNTIL   IDZ     =   CNT-DENP
               ADD     1                   TO  IDZ
               ADD     1                   TO  CNT-LINE
               MOVE    WRK-BTUNAME (IDZ)   TO  HCM08-BTUNAME (CNT-LINE)
               MOVE    WRK-BRMNUM  (IDZ)   TO  HCM08-BRMNUM  (CNT-LINE)
               MOVE    WRK-SRYKA(IDZ)      TO  HCM08-SRYKA(CNT-LINE)
               IF    ( WRK-PTNUM(IDZ) ( 11 : ) =   SPACE )
                   MOVE    WRK-PTNUM(IDZ)  TO  HCM08-PTNUM (CNT-LINE)
               ELSE
                   MOVE    WRK-PTNUM(IDZ)  TO  HCM08-PTNUM2(CNT-LINE)
               END-IF
               MOVE    WRK-NAME(IDZ)       TO  HCM08-NAME(CNT-LINE)
               MOVE    WRK-SEX(IDZ)        TO  HCM08-SEX(CNT-LINE)
               MOVE    WRK-BIRTHDAY(IDZ)   TO  HCM08-BIRTHDAY(CNT-LINE)
               MOVE    WRK-DENPNUM(IDZ)    TO  HCM08-DENPNUM(CNT-LINE)
               MOVE    WRK-SEIKYU(IDZ)     TO  WRK-Z9
               MOVE    WRK-Z9              TO  HCM08-SEIKYU(CNT-LINE)
               MOVE    WRK-RYOSYU(IDZ)     TO  WRK-Z9
               MOVE    WRK-Z9              TO  HCM08-RYOSYU(CNT-LINE)
               MOVE    WRK-MISYU(IDZ)      TO  WRK-Z9
               MOVE    WRK-Z9              TO  HCM08-MISYU(CNT-LINE)
               MOVE    WRK-JYOTAI(IDZ)     TO  HCM08-JYOTAI(CNT-LINE)
      *
               COMPUTE WRK-GSEIKYU (1)
                   =   WRK-GSEIKYU (1)     +   WRK-SEIKYU(IDZ)
               COMPUTE WRK-GSEIKYU (3)
                   =   WRK-GSEIKYU (3)     +   WRK-SEIKYU(IDZ)
               COMPUTE WRK-GRYOSYU (1)
                   =   WRK-GRYOSYU (1)     +   WRK-RYOSYU(IDZ)
               COMPUTE WRK-GRYOSYU (3)
                   =   WRK-GRYOSYU (3)     +   WRK-RYOSYU(IDZ)
           END-PERFORM
      *
           COMPUTE WRK-GMISYU (1)
               =   WRK-GMISYU (1)      +   WRK-GMISYU(4)
           COMPUTE WRK-GMISYU (3)
               =   WRK-GMISYU (3)      +   WRK-GMISYU(4)
      *
           MOVE    ZERO            TO  CNT-DENP
           INITIALIZE                  WRK-NAI-TBL
      *
           .
       3203-BODY-NAIYO-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<合計>処理
      *****************************************************************
       330-TERM-HEN-SEC            SECTION.
      *
           MOVE    1               TO  IDX
           PERFORM 331-TOTAL-HENSYU-SEC
      *
           IF      FLG-END             =   1
               MOVE    3               TO  IDX
               PERFORM 331-TOTAL-HENSYU-SEC
           END-IF
           .
       330-TERM-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集処理
      *****************************************************************
       331-TOTAL-HENSYU-SEC        SECTION.
      *
           EVALUATE    IDX
               WHEN    1
                   MOVE    "頁内合計"      TO  HCM08-TTLMSG(1)
               WHEN    3
                   MOVE    "総合計"        TO  HCM08-TTLMSG(3)
           END-EVALUATE
      *
           MOVE    WRK-GSEIKYU(IDX)    TO  WRK-Z9
           MOVE    WRK-Z9              TO  HCM08-SEIKYUTTL(IDX)
           MOVE    WRK-GRYOSYU(IDX)    TO  WRK-Z9
           MOVE    WRK-Z9              TO  HCM08-RYOSYUTTL(IDX)
           MOVE    WRK-GMISYU(IDX)     TO  WRK-Z9
           MOVE    WRK-Z9              TO  HCM08-MISYUTTL(IDX)
           .
       331-TOTAL-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC           SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
           MOVE    "INS"           TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM
                                   TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                   TO  SPRT-TBL-KEY
           MOVE    LNK-PRTKANRI-TBL-GROUP
                                   TO  SPRT-TBL-GROUP
           MOVE    LNK-PRTKANRI-SRYYM
                                   TO  SPRT-SRYYM
           MOVE    LNK-PRTKANRI-SKYYMD
                                   TO  SPRT-SKYYMD
           MOVE    LNK-PRTKANRI-SHELLID
                                   TO  SPRT-SHELLID
           MOVE    LNK-PRTKANRI-SHORI-RENNUM
                                   TO  SPRT-SHORI-RENNUM
           MOVE    LNK-PRTKANRI-PRIORITY
                                   TO  SPRT-PRIORITY
           MOVE   "HCM08.red"      TO  SPRT-PRTID
           MOVE    "収納一覧表(入院)"    TO  SPRT-TITLE
           MOVE    HCM08           TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID
                                   TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID
                                   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM
                                   TO  SPRT-PRTNM
           MOVE    "1"             TO  SPRT-SITEKBN
           CALL    "ORCSPRT"           USING
                                       ORCSPRTAREA
           IF      SPRT-RETURN         =   ZERO
               CONTINUE
           ELSE
               MOVE    "印刷ＤＢに更新できませんでした"
                                   TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
           .
       390-PRINT-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       31012-SEIWA-HEN-SEC         SECTION.
      *
           INITIALIZE                  STS-AREA-DAY
           INITIALIZE                  LNK-DAY2-AREA
           MOVE    "21"            TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD        TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD1
                                   TO  WRK-HYYMMDD
           MOVE    LNK-DAY2-EDTYMD3
                                   TO  WRK-HENYMDG
           INSPECT WRK-HENYMDG     REPLACING  ALL "  "  BY  "　"
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
057400*
      *****************************************************************
      *    エラー出力処理
      *****************************************************************
       500-ERR-HENSYU-SEC          SECTION.
      *
           OPEN    INPUT   RECEERR-FILE
           IF      STS-RECEERR         =   ZERO
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
               MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
               MOVE    WRK-PARA-SHELLID
                                       TO  JOB-SHELLID
               MOVE    WRK-RECEERR     TO  JOB-YOBI
               MOVE    "9999"          TO  JOB-ERRCD
               CALL    "ORCSJOB"           USING
                                           ORCSJOBKANRIAREA
                                           JOBKANRI-REC
           END-IF
      *
           MOVE    1               TO  FLG-END
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-PAGE        TO  JOB-UPDCNT
           CALL    "ORCSJOB"           USING
                                       ORCSJOBKANRIAREA
                                       JOBKANRI-REC
      *
           PERFORM 900-DBDISCONNECT-SEC
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納明細検索処理
      *****************************************************************
       900-DBSELECT-SEC            SECTION.
      *
           INITIALIZE                  SMEI-REC
           MOVE    WRK-PARA-HOSPID TO  SMEI-HOSPID
           MOVE    "1"             TO  SMEI-NYUGAIKBN
           MOVE    WRK-PARA-DENPPRTYMD
                                   TO  SMEI-NYUHEN-YMD
           MOVE    SMEI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYUMEI-KEY4"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               PERFORM 900-DBFETCH-SEC
           ELSE
               MOVE    1               TO  FLG-SMEI
           END-IF
      *
           .
       900-DBSELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納明細読込処理
      *****************************************************************
       900-DBFETCH-SEC             SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           MOVE    "SYUMEI-KEY4"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SMEI
               MOVE    MCPDATA-REC     TO  SMEI-REC
           ELSE
               MOVE    1               TO  FLG-SMEI
               INITIALIZE                  SMEI-REC
           END-IF
           .
       900-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納明細クローズ処理
      *****************************************************************
       900-DBCLOSE-SEC             SECTION.
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "SYUMEI-KEY4"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-DBCLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納明細処理ファイル読込処理
      *****************************************************************
       900-BD00501-READ-SEC            SECTION.
      *
           READ    BD00501-FILE NEXT
           AT END
               MOVE    1               TO FLG-SMEI
               MOVE    1               TO FLG-END
           NOT AT  END
               MOVE    BD00501-SMEI-DATA-AREA
                                       TO SMEI-REC
           END-READ
           .
      *
       900-BD00501-READ-EXT.
           EXIT.
      *****************************************************************
      *    収納明細マスター読込処理
      *****************************************************************
       900-SMEI2-SELECT-SEC        SECTION.
      *
           INITIALIZE                  SMEI2-REC
           MOVE    SMEI-HOSPID     TO  SMEI2-HOSPID
           MOVE    SMEI-NYUGAIKBN  TO  SMEI2-NYUGAIKBN
           MOVE    SMEI-DENPNUM    TO  SMEI2-DENPNUM
           MOVE    SMEI-DENPEDANUM TO  SMEI2-DENPEDANUM
           MOVE    SMEI2-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYUMEI-KEY5"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               PERFORM 900-SMEI2-FETCH-SEC
           ELSE
               MOVE    1               TO  FLG-SMEI2
           END-IF
           .
       900-SMEI2-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *     収納明細を検索処理
      *****************************************************************
       900-SMEI2-FETCH-SEC         SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
           MOVE    "SYUMEI-KEY5"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SMEI2
               MOVE    MCPDATA-REC     TO  SMEI2-REC
           ELSE
               MOVE    1               TO  FLG-SMEI2
           END-IF
           .
       900-SMEI2-FETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　クローズ処理
      *****************************************************************
       900-SMEI2-CLOSE-SEC         SECTION.
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "SYUMEI-KEY5"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-SMEI2-CLOSE-EXT.
           EXIT.
      *
      *****************************************************************
      *    収納マスター読込処理
      *****************************************************************
       900-SYU-READ-SEC            SECTION.
      *
           MOVE    SYU-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "SYUNOU-KEY"    TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  SYU-REC
                   MOVE    ZERO            TO  FLG-SYU
               ELSE
                   MOVE    1               TO  FLG-SYU
                   INITIALIZE                  SYU-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYU
               INITIALIZE                  SYU-REC
           END-IF
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "SYUNOU-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-SYU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込処理
      *****************************************************************
       900-PTINF-READ-SEC          SECTION.
      *
           MOVE    PTINF-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "PTINF-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "PTINF-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  PTINF-REC
                   MOVE    ZERO            TO  FLG-PTINF
               ELSE
                   MOVE    1               TO  FLG-PTINF
                   INITIALIZE                  PTINF-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTINF
               INITIALIZE                  PTINF-REC
           END-IF
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "PTINF-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号変換マスター読込処理
      *****************************************************************
       900-PTNUM-READ-SEC          SECTION.
      *
           MOVE    PTNUM-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "PTNUM-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "PTNUM-KEY"     TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  PTNUM-REC
                   MOVE    ZERO            TO  FLG-PTNUM
               ELSE
                   MOVE    1               TO  FLG-PTNUM
                   INITIALIZE                  PTNUM-REC
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTNUM
               INITIALIZE                  PTNUM-REC
           END-IF
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "PTNUM-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-PTNUM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC       SECTION.
      *
           MOVE    WRK-SYSYMD      TO  ORC-DBYMD
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "DBCLOSE"       TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       800-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　オープン処理
      *****************************************************************
       100-DBOPEN-SEC              SECTION.
      *
           MOVE    "DBOPEN"        TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBSTART"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
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
       900-DBDISCONNECT-SEC        SECTION.
      *
           MOVE    "DBCOMMIT"      TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
      *
           MOVE    "DBDISCONNECT"  TO  MCP-FUNC.
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC.
           .
       900-DBCLOSE-EXT.
           EXIT.
