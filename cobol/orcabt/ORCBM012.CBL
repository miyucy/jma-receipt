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
       PROGRAM-ID.             ORCBM012.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 月次帳票
      *  コンポーネント名  : 国保・総括表（ＨＣ０４１）用集計処理
      *                      （給付割合別）         
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02/01/30  数字の編集をすべてZに変更
      *  01.00.02    MCC-藤原     02/04/15  印刷管理・印刷ＤＢの追加
      *  01.00.03    MCC-藤原     02/05/22  テスト患者は処理しない     
      *  01.00.04    NACL-藤原    02/08/25  住所を１５から２５に変更
      *
      *  01.01.01    NACL-藤原    02/09/17  県内県外区分・県番号・
      *                                     年齢・給付割合の追加
      *  01.01.02    NACL-藤原    02/09/18  保険者番号の追加
      *  01.01.03    NACL-藤原    02/10/10  サイト区分追加
      *  01.01.04    NACL-藤原    02/10/11  ２００２年１０月改正対応
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.

      *    集計ファイル  
           SELECT  MF01-FILE     ASSIGN    MF01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  MF01-KEY
                                   FILE    STATUS  IS  STS-MF01.
006900*
           SELECT  MF011-FILE    ASSIGN    MF01PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  MF011-KEY
                                   FILE    STATUS  IS  STS-MF01.
      *
006900*    請求ＤＢ更新用ファイル
           SELECT  UPD-FILE        ASSIGN  RECEUPD
                                   ORGANIZATION    IS  LINE
                                                       SEQUENTIAL 
                                   FILE    STATUS  IS  STS-RECEUPD.
      *
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *    集計ファイル  
       FD  MF01-FILE.
       01  MF01-REC. 
           COPY    "CPRMF001.INC".
      *
       FD  MF011-FILE.
       01  MF011-REC. 
           COPY    "CPRMF001.INC"  REPLACING  //MF01//
                                   BY         //MF011//.
      *
006900*    請求ＤＢ更新用ファイル
       FD  UPD-FILE.
           COPY    "CPRCF010.INC"  REPLACING  //RECE10//
                                   BY         //RECE10X//.
      *
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
       WORKING-STORAGE             SECTION.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //MF01//.
      *
006900*    請求ＤＢ更新用ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEUPD//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *     
      *    シェル用領域
      *****COPY    "CPCOMMONSHELL.INC".
      *
           COPY    "HC041.INC".
      *
      *    スパ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
           03  STS-MF01            PIC X(02).
           03  STS-RECE10          PIC X(02). 
           03  STS-RECEERR         PIC X(02).
           03  STS-RECEUPD         PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-MF01            PIC 9(01). 
           03  FLG-MF01-END        PIC 9(01).
           03  FLG-RECE10          PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01). 
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-HKNJAINF        PIC 9(01).
           03  FLG-UPD             PIC 9(01).
           03  FLG-UPDFILE         PIC 9(01).
           03  FLG-SEIKYU          PIC 9(01). 
           03  FLG-PTINF           PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDZ                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDX5                PIC 9(04).
      *
      *    パラメタ領域
       01  WRK-PARA.
           COPY    "CPORCSPRTLNK.INC".
           03  WRK-PARA1.
      *********05  WRK-PARA-SKYYM  PIC X(06).
      *********05  WRK-PARA-TERMID PIC X(16).
      *********05  WRK-PARA-SYSYMD PIC X(08).
           03  WRK-PARA-HOSPID     PIC X(24).
           03  WRK-PARA-JOBID      PIC 9(07).
           03  WRK-PARA-SHELLID    PIC X(08).
      *
      *    一時領域
       01  WRK-AREA.
      *****03  WRK-IN              PIC X(01).
      *
           03  WRK-SEIYMD        PIC X(08).
           03  WRK-SEIYMDWH      PIC X(22).
           03  WRK-SRYYMWH       PIC X(16).
           03  WRK-SRYYMD        PIC X(08).
           03  WRK-KBN               PIC X(01).
           03  WRK-MF01-AREA.
               05  WRK-MF01-KEY.
                   07  WRK-MF01-KBN  PIC X(01).
                   07                PIC X(12). 
      *  
           03  WRK-SYMD.
               05  WRK-SYY           PIC 9(04).
               05  WRK-SMM           PIC 9(02).
               05  WRK-SDD           PIC 9(02).
           03  WRK-HENYMDG           PIC X(22).
      *
           03  WRK-Z9                PIC ZZZZZ.
           03  WRK-ZZ9               PIC ZZZ,ZZZ,ZZZ.
           03  WRK-ZZZ9              PIC Z,ZZZ,ZZZ,ZZZ.
      *
           03  WRK-KOHKBN.
               05  WRK-KOHNUM        PIC X(03).
               05  WRK-HKNNAME       PIC X(20). 
      *
           03  WRK-RECEERR           PIC X(200). 
      *     
           03  WRK-HC01PARA-CNT      PIC  9(06).
      * 
      *    カウント領域
       01  CNT-AREA.
           03  CNT-LINE              PIC 9(02).
           03  CNT-PAGE              PIC 9(03).
           03  CNT-RECE10            PIC 9(06).
           03  CNT-UPDFILE           PIC 9(06).
           03  CNT-IN PIC 9(02).
      *
      *    集計領域
       01  SUM-AREA.
           03  SUM-TBL               OCCURS  3.
               05  SUM-TBL-G         OCCURS  2.
                   07  SUM-TBL-OCC   OCCURS  2.
                       09  SUM-KENSU       PIC  9(06).
                       09  SUM-NISSU       PIC  9(06).
                       09  SUM-TOTALTEN    PIC  9(10).
                       09  SUM-FTNMONEY    PIC  9(10).
                       09  SUM-YKZFTN      PIC  9(10).
                   07  SUM-SHOKUJIKENSU    PIC  9(06).
                   07  SUM-SHOKUJINISSU    PIC  9(06).
                   07  SUM-SHOKUJIRYOYOHI  PIC  9(10).
                   07  SUM-SHOKUJIFTN      PIC  9(10).
           03  SUM-ROU-TBL.    
               05  SUM-ROU-G         OCCURS  2.
                   07  SUM-ROU-KENSU       PIC  9(06).
                   07  SUM-ROU-NISSU       PIC  9(06).
                   07  SUM-ROU-TOTALTEN    PIC  9(10).
                   07  SUM-ROU-FTNMONEY    PIC  9(10).
                   07  SUM-ROU-YKZFTN      PIC  9(10).
               05  SUM-ROU-SHOKUJIKENSU    PIC  9(06).
               05  SUM-ROU-SHOKUJINISSU    PIC  9(06).
               05  SUM-ROU-SHOKUJIRYOYOHI  PIC  9(10).
               05  SUM-ROU-SHOKUJIFTN      PIC  9(10).
      *
       01  KEY-AREA                         VALUE   LOW-VALUE.
           03  KEY-NEW.
               05  KEY-N-HKNJANUM    PIC X(08).
           03  KEY-OLD.
               05  KEY-O-HKNJANUM    PIC X(08). 
      *
           COPY    "CPSHELLTBL.INC".
      *     
           COPY    "ORCA-DBPATH".
      *
       01  WRK-CONS-AREA.
      *    表示給付割合
           03  WRK-CONS-KYURATE          PIC 9(02)   VALUE   7.
           03  WRK-CONS-KYURATE2         PIC 9(02)   VALUE   8.
      *     
      *    ２００２年１０月改正
           03  WRK-CONS-SRYYM        PIC X(06)   VALUE   "200210".              
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
       01  HKNJAINF-REC.
           COPY    "CPHKNJAINF.INC".
      *
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    医療機関情報情報
           COPY    "CPSK1001.INC".
      *
      *    医療機関情報−所在地、連絡先 
           COPY    "CPSK1002.INC".
      *
           COPY    "CPRCF010.INC".
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
      ******************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    印刷ＤＢ更新サブ
           COPY    "CPORCSPRT.INC".          
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      *
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
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC
                   UNTIL       FLG-END     =   1
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
           INITIALIZE                  WRK-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  SUM-AREA
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
      *****************************************WRK-PARA1
                                               WRK-PARA-HOSPID
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCBM012"      TO  JOB-PGID
           MOVE    "国保総括表"    TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "MF01ZZZ"           TO  MF01PARA-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  MF01PARA-TERMID
      *
           MOVE    "RECEUPD"           TO  RECEUPD-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEUPD-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    LNK-PRTKANRI-TERMID TO  RECEERR-TERMID
      *
           MOVE    LNK-PRTKANRI-SRYYM  TO  WRK-SRYYMD (1:6)
           MOVE    "01"                TO  WRK-SRYYMD (7:2)
           MOVE    LNK-PRTKANRI-SRYYM  TO  WRK-SYMD (1:6)
           MOVE    "01"                TO  WRK-SYMD (7:2)
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG(1:16)   TO  WRK-SRYYMWH 
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    LNK-PRTKANRI-SKYYMD TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           IF      STS-DAY-RC1         =   ZERO 
               MOVE    LNK-DAY2-EDTYMD3    TO  WRK-SEIYMDWH
           END-IF
      *
      *    医療機関ＩＤ編集
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
               IF      SYS-1001-HOSPNAME   =   LOW-VALUE
                   MOVE    SPACE               TO  SYS-1001-HOSPNAME
               END-IF    
               IF      SYS-1001-KAISETUNAME    =   LOW-VALUE
                   MOVE    SPACE               TO  SYS-1001-KAISETUNAME
               END-IF    
           ELSE
               MOVE    "医療機関情報が取得できませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
           END-IF
      *
      *    医療機関情報−所在地、連絡先
           INITIALIZE                  SYS-1002-REC
           MOVE    "1002"              TO  SYS-1002-KANRICD
           MOVE    "*"                 TO  SYS-1002-KBNCD
           MOVE    SYS-1002-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC        TO  SYS-1002-REC
               IF      SYS-1002-ADRS       =   LOW-VALUE
                   MOVE    SPACE               TO  SYS-1002-ADRS
               END-IF    
           ELSE
               MOVE    "医療機関情報（所在地）が取得できませんでした"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
           END-IF 
      *
           OPEN    OUTPUT  UPD-FILE
      *  
           PERFORM 900-SEIKYU-SELECT-SEC 
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           INITIALIZE                  SUM-AREA
      *
           OPEN    OUTPUT              MF011-FILE
           CLOSE                       MF011-FILE
      *
           OPEN    I-O                 MF01-FILE
      *
           MOVE    KEY-NEW             TO  KEY-OLD      
           PERFORM             UNTIL   FLG-END     =   1
                               OR      KEY-NEW NOT =   KEY-OLD
               PERFORM 2001-SYUKEI-SEC
           END-PERFORM
      *
           CLOSE   MF01-FILE
      *
           IF      FLG-UPD     =   1
               PERFORM 2002-PRINT-HENSYU-SEC
           END-IF
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者番号別集計処理
      *****************************************************************
       2001-SYUKEI-SEC                SECTION.
      * 
           MOVE    ZERO                    TO  IDX-AREA
                                               FLG-UPD
      *    入外区分
           EVALUATE    RECE10-NYUGAIKBN
               WHEN    "1"
                   MOVE    1                 TO  IDX3
               WHEN    "2"
                   MOVE    2                 TO  IDX3
           END-EVALUATE           
      *
      *        老人保健
           IF      RECE10-RJNHKNNUM    NOT =   SPACE
               MOVE    4                       TO  IDX
           ELSE
      *        国民健康保険
               EVALUATE    RECE10-HKNNUM-S
                       WHEN    "060"
                           MOVE    1               TO  IDX
                       WHEN    "067"
                           IF      RECE10-HONKZKKBN        =   "1"
                               MOVE    2               TO  IDX
                           ELSE
                               MOVE    3               TO  IDX
                           END-IF
               END-EVALUATE
           END-IF
      *    給付割合（老人以外）
           IF      IDX                       =   4
               CONTINUE
           ELSE
             EVALUATE  IDX ALSO   IDX3
                 WHEN  1   ALSO   ANY
                 WHEN  3   ALSO   2          
      *************IF      RECE10-SHOKUJINISSU (1) = WRK-CONS-KYURATE
                   IF      RECE10-KYURATE          = WRK-CONS-KYURATE
                       MOVE    2                 TO  IDX5
                   ELSE
                       MOVE    1                 TO  IDX5
                   END-IF
                 WHEN  OTHER
      *************IF      RECE10-SHOKUJINISSU (1) = WRK-CONS-KYURATE2
                   IF      RECE10-KYURATE          = WRK-CONS-KYURATE2
                       MOVE    2                 TO  IDX5
                   ELSE
                       MOVE    1                 TO  IDX5
                   END-IF
             END-EVALUATE    
           END-IF
      *             
           PERFORM 210-HKN-SYUKEI-SEC
      *
      *    公費負担分     
           IF      RECE10-KOHNUM (1)   NOT =   SPACE
               MOVE    "1"                     TO  WRK-KBN
               PERFORM 220-KOH-SYUKEI-SEC
           END-IF
      *
      *    集計の対象にならなかったとき                
           IF      FLG-UPD             =   1
               PERFORM 230-UPD-FILE-HENSYU-SEC
      *
      *********MOVE    "SEIKYU-KEY4"       TO  ORC-DBPATH
               MOVE    "SEIKYU-KEY11"      TO  ORC-DBPATH
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
               MOVE    SPACE               TO  WRK-RECEERR
               STRING "集計対象外　患者番号＝"     DELIMITED  BY  SIZE
                       RECE10-PTNUM                DELIMITED  BY  SPACE
                       " 診療年月＝"               DELIMITED  BY  SIZE
                       RECE10-SRYYM                DELIMITED  BY  SIZE
                       " レセ種別＝"               DELIMITED  BY  SIZE
                       RECE10-RECESYUBETU          DELIMITED  BY  SIZE
                                           INTO    WRK-RECEERR
               END-STRING                                
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
           END-IF
           .
       2001-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療保険・老人保健分集計処理
      *****************************************************************
       210-HKN-SYUKEI-SEC          SECTION.
      *
           IF      IDX             =   ZERO
               GO  TO  210-HKN-SYUKEI-EXT
           END-IF
      *
      *    医療保険・老人保健分
           MOVE    1                         TO  IDX1
           MOVE    IDX                       TO  IDX2
           PERFORM 2101-HKN-SYUKEI-01-SEC
      *
           .
       210-HKN-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    医療保険・老人保健分集計処理
      *****************************************************************
       2101-HKN-SYUKEI-01-SEC      SECTION.
      *
           IF      IDX2            =   4    
      *    件数
               ADD     1               TO  SUM-ROU-KENSU (IDX3)
      *
      *    療養の給付 
               ADD     RECE10-JNISSU   (IDX1) TO 
                                   SUM-ROU-NISSU      (IDX3)
               ADD     RECE10-TOTALTEN (IDX1) TO
                                   SUM-ROU-TOTALTEN   (IDX3)
               ADD     RECE10-YKZFTN   (IDX1) TO
                                   SUM-ROU-YKZFTN     (IDX3)
               ADD     RECE10-FTNMONEY (IDX1) TO
                                   SUM-ROU-FTNMONEY   (IDX3)
      *    食事療養
               IF      IDX3                   =   1 
                   IF      RECE10-SHOKUJINISSU(IDX1)   >   ZERO
                       ADD     1              TO
                                              SUM-ROU-SHOKUJIKENSU 
                   END-IF
                   ADD     RECE10-SHOKUJINISSU   (IDX1)
                                          TO  SUM-ROU-SHOKUJINISSU   
                   ADD     RECE10-SHOKUJIRYOYOHI (IDX1)
                                          TO  SUM-ROU-SHOKUJIRYOYOHI 
                   ADD     RECE10-SHOKUJIFTN     (IDX1)
                                          TO  SUM-ROU-SHOKUJIFTN     
               END-IF
           ELSE                        
      *    件数
               ADD     1               TO  SUM-KENSU (IDX2 IDX3 IDX5)
      *
      *    療養の給付 
               ADD     RECE10-JNISSU   (IDX1) TO 
                                   SUM-NISSU      (IDX2 IDX3 IDX5)
               ADD     RECE10-TOTALTEN (IDX1) TO
                                   SUM-TOTALTEN   (IDX2 IDX3 IDX5)
               ADD     RECE10-YKZFTN   (IDX1) TO
                                   SUM-YKZFTN     (IDX2 IDX3 IDX5)
               ADD     RECE10-FTNMONEY (IDX1) TO
                                   SUM-FTNMONEY   (IDX2 IDX3 IDX5)
      *        食事療養
               IF      IDX3                   =   1 
                   IF      RECE10-SHOKUJINISSU(IDX1)   >   ZERO
                       ADD     1              TO
                                   SUM-SHOKUJIKENSU (IDX2 IDX5)
                   END-IF
                   ADD     RECE10-SHOKUJINISSU   (IDX1)
                                          TO
                                   SUM-SHOKUJINISSU   (IDX2 IDX5)
                   ADD     RECE10-SHOKUJIRYOYOHI (IDX1)
                                          TO
                                   SUM-SHOKUJIRYOYOHI (IDX2 IDX5)
                   ADD     RECE10-SHOKUJIFTN     (IDX1)
                                          TO
                                   SUM-SHOKUJIFTN     (IDX2 IDX5)
               END-IF
           END-IF      
      *
           MOVE    1               TO  FLG-UPD 
           .
 
       2101-HKN-SYUKEI-01-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費負担分集計処理
      *****************************************************************
       220-KOH-SYUKEI-SEC        SECTION.
      *
           PERFORM VARYING IDZ     FROM    1   BY  1
                   UNTIL   IDZ     >       4
                   OR  RECE10-KOHNUM (IDZ) =   SPACE
               INITIALIZE                      MF01-REC
               MOVE    WRK-KBN             TO  MF01-KBN
               MOVE    RECE10-KOHNUM (IDZ) TO  MF01-KOHNUM (1)
               PERFORM 900-MF01-READ-SEC
               IF      FLG-MF01            =   1
                   INITIALIZE                  MF01-REC
                   MOVE    WRK-KBN             TO  MF01-KBN
                   MOVE    RECE10-KOHNUM (IDZ) TO  MF01-KOHNUM (1)
               END-IF
      *
               ADD     1                   TO  MF01-KENSU    (IDX3)
               COMPUTE IDY     =   IDZ     +   1
               ADD     RECE10-JNISSU     (IDY) TO  MF01-NISSU    (IDX3)
               ADD     RECE10-TOTALTEN   (IDY) TO  MF01-TOTALTEN (IDX3)
               ADD     RECE10-YKZFTN     (IDY) TO  MF01-YKZFTN   (IDX3)
               ADD     RECE10-FTNMONEY   (IDY) TO  MF01-FTNMONEY (IDX3)
      *        食事療養
               IF      IDX3                    =   1       
                   IF      RECE10-SHOKUJINISSU   (IDY) >   ZERO
                       ADD     1               TO  MF01-SHOKUJIKENSU
                       ADD     RECE10-SHOKUJINISSU   (IDY)
                                               TO  MF01-SHOKUJINISSU 
                       ADD     RECE10-SHOKUJIRYOYOHI (IDY)
                                               TO  MF01-SHOKUJIRYOYOHI 
                       ADD     RECE10-SHOKUJIFTN     (IDY)
                                               TO  MF01-SHOKUJIFTN
                   END-IF
               END-IF
      *
               IF      FLG-MF01                =   1
                   WRITE   MF01-REC
               ELSE
                   REWRITE MF01-REC
               END-IF               
           END-PERFORM        
      *
           MOVE    1               TO  FLG-UPD 
      *
           .
       220-KOH-SYUKEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求ＤＢ更新用ファイル出力処理
      *****************************************************************
       230-UPD-FILE-HENSYU-SEC         SECTION.
      *
           MOVE    RECE10-REC          TO  RECE10X-REC
           WRITE   RECE10X-REC
           ADD     1                   TO  CNT-UPDFILE
           .
       230-UPD-FILE-HENSYU-EXT.
           EXIT.
057400*
      *****************************************************************
      *    帳票ファイル出力処理
      *****************************************************************
       2002-PRINT-HENSYU-SEC                SECTION.
      *
           OPEN    INPUT               MF011-FILE
      *
      *    帳票編集<見出し>処理
           PERFORM 310-HEAD-HEN-SEC
      *    帳票編集<明細>処理
           PERFORM 320-BODY-HEN-SEC
      *    帳票印刷処理
           PERFORM 390-PRINT-OUT-SEC
      *
           CLOSE   MF011-FILE
      *
           .
       2002-PRINT-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<ヘッダー部>処理
      *****************************************************************
       310-HEAD-HEN-SEC          SECTION.
      *
           ADD     1                   TO  CNT-PAGE
      *
           INITIALIZE                      HC041      
      *
           MOVE    WRK-SEIYMDWH        TO  HC041-SEIYMD
      *
           MOVE    WRK-SRYYMWH         TO  HC041-PRTYM
      *
      *    医療機関住所
           MOVE    SYS-1002-ADRS       TO  HC041-ADRS
      *    医療機関名
           MOVE    SYS-1001-HOSPNAME   TO  HC041-HOSPNAME
      *    
           MOVE    SYS-1001-KAISETUNAME
                                       TO  HC041-KAISETUNAME
      *    
           MOVE    SYS-1001-HOSPCDN    TO  HC041-HOSPCD
      *
           MOVE    SPACE               TO  HKNJAINF-REC
           INITIALIZE                      HKNJAINF-REC
           MOVE    SYS-1001-HOSPID     TO  HKNJA-HOSPID
           MOVE    KEY-O-HKNJANUM      TO  HKNJA-HKNJANUM
           MOVE    HKNJAINF-REC        TO  MCPDATA-REC
           PERFORM 900-HKNJAINF-INV-SEC
           IF      FLG-HKNJAINF        =   ZERO
               MOVE    HKNJA-HKNJANAME     TO  HC041-HOKENJYANAME
      *****ELSE
      *****    MOVE    KEY-O-HKNJANUM      TO  HC041-HOKENJYANAME
           END-IF                                
           MOVE    KEY-O-HKNJANUM      TO  HC041-HKNJANUM
      *
           .
       310-HEAD-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<明細行>処理
      *****************************************************************
       320-BODY-HEN-SEC      SECTION.
      *
      *    国民健康保険
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       3
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       2
                   PERFORM VARYING IDZ FROM    1   BY  1
                           UNTIL   IDZ >       2
                       IF      IDZ             =   2
                         EVALUATE   IDX   ALSO  IDY
                             WHEN   1     ALSO  1 
                             WHEN   1     ALSO  2 
                             WHEN   3     ALSO  2 
                               MOVE    WRK-CONS-KYURATE (2:1)
                                       TO  HC041-KYURATE(IDX IDY IDZ)
                             WHEN  OTHER
                               MOVE    WRK-CONS-KYURATE2(2:1)
                                       TO  HC041-KYURATE(IDX IDY IDZ)
                         END-EVALUATE
                       END-IF    
                       MOVE    SUM-KENSU   (IDX IDY IDZ)
                                           TO  WRK-Z9
                       MOVE    WRK-Z9      TO  HC041-KENSU (IDX IDY IDZ)
                       MOVE    SUM-NISSU   (IDX IDY IDZ)
                                           TO  WRK-Z9 
                       MOVE    WRK-Z9      TO  HC041-NISSU (IDX IDY IDZ) 
                       MOVE    SUM-TOTALTEN(IDX IDY IDZ)
                                           TO  WRK-ZZ9
                       MOVE    WRK-ZZ9     TO  HC041-TENSU (IDX IDY IDZ)
                       IF      IDY                 =   1
                           CONTINUE
                       ELSE
                           MOVE    SUM-YKZFTN  (IDX IDY IDZ)
                                       TO  WRK-ZZ9
                           MOVE    WRK-ZZ9(3:)
                                       TO  HC041-YKZFTN(IDX IDY IDZ)
                       END-IF
                       MOVE    SUM-FTNMONEY    (IDX IDY IDZ)
                                           TO  WRK-ZZ9
                       MOVE    WRK-ZZ9(2:) TO  HC041-ITBFTN
                                                          (IDX IDY IDZ)
                   END-PERFORM
                   MOVE    SUM-SHOKUJIKENSU(IDX IDY)
                                           TO  WRK-Z9
                   MOVE    WRK-Z9          TO  HC041-SYOKENSU (IDX IDY) 
                   MOVE    SUM-SHOKUJINISSU(IDX IDY)
                                           TO  WRK-Z9
                   MOVE    WRK-Z9          TO  HC041-SYONISSU (IDX IDY)
                   MOVE    SUM-SHOKUJIRYOYOHI(IDX IDY) 
                                           TO     WRK-ZZZ9
                   MOVE    WRK-ZZZ9        TO  HC041-SYOKINGAK(IDX IDY)
                   MOVE    SUM-SHOKUJIFTN   (IDX IDY)
                                           TO  WRK-ZZ9
                   MOVE    WRK-ZZ9 (3:)    TO  HC041-SYOFTNGAK(IDX IDY)
               END-PERFORM     
           END-PERFORM
      *
      *    老人保健分編集処理
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       2
               MOVE    SUM-ROU-KENSU   (IDX)
                                       TO  WRK-Z9
               MOVE    WRK-Z9          TO  HC041-ROUKENSU (IDX)
               MOVE    SUM-ROU-NISSU   (IDX)
                                       TO  WRK-Z9 
               MOVE    WRK-Z9          TO  HC041-ROUNISSU (IDX) 
               MOVE    SUM-ROU-TOTALTEN(IDX)
                                       TO  WRK-ZZ9
               MOVE    WRK-ZZ9         TO  HC041-ROUTENSU (IDX)
               IF      IDX                     =   1
                   CONTINUE
               ELSE
                   MOVE    SUM-ROU-YKZFTN  (IDX)
                                           TO  WRK-ZZ9
                   MOVE    WRK-ZZ9(3:) TO  HC041-ROUYKZFTN(IDX)
               END-IF
               MOVE    SUM-ROU-FTNMONEY    (IDX)
                                       TO  WRK-ZZ9
               MOVE    WRK-ZZ9 (2:)    TO  HC041-ROUITBFTN(IDX)
           END-PERFORM     
           MOVE    SUM-ROU-SHOKUJIKENSU    TO  WRK-Z9
           MOVE    WRK-Z9                  TO  HC041-ROUSYOKENSU
           MOVE    SUM-ROU-SHOKUJINISSU    TO  WRK-Z9
           MOVE    WRK-Z9                  TO  HC041-ROUSYONISSU 
           MOVE    SUM-ROU-SHOKUJIRYOYOHI  TO  WRK-ZZZ9
           MOVE    WRK-ZZZ9                TO  HC041-ROUSYOKINGAK
           MOVE    SUM-ROU-SHOKUJIFTN      TO  WRK-ZZ9
           MOVE    WRK-ZZ9 (3:)            TO  HC041-ROUSYOFTNGAK
      *
      *    公費負担分編集処理
           INITIALIZE                      WRK-MF01-AREA
           MOVE    "1"                     TO  WRK-MF01-KBN
           MOVE    ZERO                    TO  FLG-MF01-END 
      * 
           PERFORM 3201-KOH-HENSYU-SEC
                                   UNTIL   FLG-MF01-END   =   1
      *
           .
       320-BODY-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票編集<公費負担分>処理
      *****************************************************************
      *    
       3201-KOH-HENSYU-SEC         SECTION.
      *
           MOVE    ZERO                TO  IDY
      *
           MOVE    WRK-MF01-KEY        TO  MF011-KEY
           START   MF011-FILE   KEY IS  >  MF011-KEY
      *****START   MF011-FILE   KEY IS  >= MF011-KEY
               INVALID
                   MOVE    1               TO  FLG-MF01
               NOT INVALID
                   PERFORM 900-MF01-READ-N-SEC
           END-START     
      *
           MOVE    WRK-MF01-KBN        TO  WRK-KBN    
           MOVE    SPACE               TO  WRK-MF01-KEY 
           PERFORM UNTIL   FLG-MF01        =   1
                   OR      MF011-KBN   NOT =   WRK-KBN
                   OR      IDY             >   2
               ADD     1                   TO  IDY
      *
               IF      IDY                 =   3
                   MOVE    MF011-KEY       TO  WRK-MF01-KEY 
               ELSE
                   PERFORM 3202-HKNNUM-HENSYU-SEC     
                   PERFORM VARYING IDZ FROM    1   BY  1
                           UNTIL   IDZ >       2
                       MOVE    MF011-KENSU  (IDZ)
                                           TO  WRK-Z9
                       MOVE    WRK-Z9      TO  HC041-KOHKENSU (IDY IDZ)
                       MOVE    MF011-NISSU  (IDZ)
                                           TO  WRK-Z9
                       MOVE    WRK-Z9      TO  HC041-KOHNISSU (IDY IDZ)
                       MOVE    MF011-TOTALTEN(IDZ)
                                           TO  WRK-ZZ9
                       MOVE    WRK-ZZ9     TO  HC041-KOHTENSU (IDY IDZ)
                       IF      IDZ                 =   2
                           MOVE    MF011-YKZFTN (IDZ)
                                           TO  WRK-ZZ9
                           MOVE    WRK-ZZ9 (3:)
                                           TO  HC041-KOHYKZFTN(IDY IDZ)
                       END-IF          
                       MOVE    MF011-FTNMONEY(IDZ)
                                           TO  WRK-ZZ9
                       MOVE    WRK-ZZ9(2:) TO  HC041-KOHITBFTN(IDY IDZ)
                   END-PERFORM  
                   MOVE    MF011-SHOKUJIKENSU
                                           TO  WRK-Z9
                   MOVE    WRK-Z9          TO  HC041-KOHSYOKENSU (IDY)
                   MOVE    MF011-SHOKUJINISSU
                                           TO  WRK-Z9
                   MOVE    WRK-Z9          TO  HC041-KOHSYONISSU (IDY)
                   MOVE    MF011-SHOKUJIRYOYOHI
                                           TO  WRK-ZZZ9
                   MOVE    WRK-ZZZ9        TO  HC041-KOHSYOKINGAK(IDY)
                   MOVE    MF011-SHOKUJIFTN
                                           TO  WRK-ZZ9
                   MOVE    WRK-ZZ9 (3:)    TO  HC041-KOHSYOFTNGAK(IDY)
      *      
                   PERFORM 900-MF01-READ-N-SEC
               END-IF
           END-PERFORM
      *
           IF      WRK-MF01-KEY           =   SPACE
               MOVE    1                      TO  FLG-MF01-END
           ELSE
      *    帳票印刷処理
               PERFORM 390-PRINT-OUT-SEC
      *    帳票編集<見出し>処理
               PERFORM 310-HEAD-HEN-SEC
           END-IF     
      *
           .
       3201-KOH-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費保険区分編集処理
      *****************************************************************
      *    
       3202-HKNNUM-HENSYU-SEC         SECTION.
      *
           MOVE    SPACE               TO  WRK-KOHKBN
      *
           MOVE    MF011-KOHNUM (1)    TO  WRK-Z9
           MOVE    WRK-Z9 (3:3)        TO  WRK-KOHNUM
      *        保険番号読込み  
           INITIALIZE                      HKNNUM-REC
           MOVE   SYS-1001-HOSPID      TO    HKN-HOSPID
           MOVE   MF011-KOHNUM (1)     TO    HKN-HKNNUM
           MOVE   HKNNUM-REC           TO    MCPDATA-REC
           MOVE   "DBSELECT"           TO    MCP-FUNC
           MOVE   "HKNNUM-KEY2"        TO    ORC-DBPATH
           CALL   "ORCMCPSUB"           USING MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH
               PERFORM 900-HKNNUM-READ-SEC
           ELSE
               MOVE    1                  TO  FLG-HKNNUM
           END-IF
      *
           PERFORM UNTIL       FLG-HKNNUM      =   1
               IF      HKN-TEKSTYMD            <=  WRK-SRYYMD
               AND     HKN-TEKEDYMD            >=  WRK-SRYYMD
                   IF     MF011-KOHNUM (1)     =   "027"
                       IF      SYS-1001-HOSPSBT    =   HKN-PAYKBN (1:1)
                       AND     SYS-1001-ROUPAYKBN  =   HKN-PAYKBN (2:1)
                           MOVE    HKN-TANSEIDONAME    TO   WRK-HKNNAME
                           MOVE    1                   TO  FLG-HKNNUM   
                       END-IF
                   ELSE
                       MOVE    HKN-TANSEIDONAME    TO   WRK-HKNNAME
                       MOVE    1                   TO  FLG-HKNNUM   
                   END-IF     
               END-IF
      *
               IF      FLG-HKNNUM           =   ZERO
                   MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH
                   PERFORM 900-HKNNUM-READ-SEC
               END-IF 
115900     END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY2"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           INSPECT WRK-HKNNAME      REPLACING   ALL "（" BY  "・"
                                                ALL "）" BY  "　"  
      *****MOVE    WRK-KOHNUM          TO  HC041-KOHNUM (IDY)
           MOVE    WRK-HKNNAME         TO  HC041-KOHNAME(IDY)
           .
       3202-HKNNUM-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    帳票印刷処理
      *****************************************************************
       390-PRINT-OUT-SEC                SECTION.
      *
           INITIALIZE                  ORCSPRTAREA
           MOVE    "INS"               TO  SPRT-MODE
           MOVE    LNK-PRTKANRI-RENNUM TO  SPRT-RENNUM
           MOVE    LNK-PRTKANRI-TBL-KEY
                                       TO  SPRT-TBL-KEY
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
      *****MOVE   "HC041"              TO  SPRT-PRTID
      *****MOVE   "HC041V01"           TO  SPRT-PRTID
      *****MOVE   "HC041V02"           TO  SPRT-PRTID
           MOVE   "HC041V03"           TO  SPRT-PRTID
           MOVE    "国保総括表"        TO  SPRT-TITLE
           MOVE    HC041               TO  SPRT-PRTDATA
           MOVE    LNK-PRTKANRI-TERMID TO  SPRT-TERMID
           MOVE    LNK-PRTKANRI-OPID   TO  SPRT-OPID
           MOVE    LNK-PRTKANRI-PRTNM  TO  SPRT-PRTNM
           MOVE    "1"                 TO  SPRT-SITEKBN
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
057400*
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
           CLOSE   UPD-FILE
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
      *****MOVE    "SEIKYU-KEY4"       TO  ORC-DBPATH
           MOVE    "SEIKYU-KEY11"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *
           IF      CNT-RECE10            =   ZERO 
               CONTINUE
           ELSE
               IF      FLG-UPD        =   1
                   IF      CNT-UPDFILE    >   ZERO
                       PERFORM 310-SEIKYU-UPD-SEC
                   END-IF
               END-IF     
           END-IF    
      *
           DISPLAY "*** ORCBM012 IN  "  CNT-RECE10 
           DISPLAY "*** ORCBM012 END ***"
      *     
      *    ステップ管理終了処理
           MOVE    "STE"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    CNT-PAGE        TO  JOB-UPDCNT                        
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *                              
      *
           PERFORM 900-DBDISCONNECT-SEC
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *   請求管理ＤＢ更新処理
      *****************************************************************
       310-SEIKYU-UPD-SEC              SECTION.
      *
           OPEN    INPUT    UPD-FILE
      *
           PERFORM 900-UPD-FILE-READ-SEC
           PERFORM             UNTIL   FLG-UPDFILE    =   1
               MOVE    RECE10X-KEY         TO  RECE10-KEY
               MOVE    RECE10-REC          TO  MCPDATA-REC
               PERFORM 910-SEIKYU-INV-SEC
               IF      FLG-SEIKYU          =   ZERO
                   MOVE    "2"             TO  RECE10-SKYKBN
                   MOVE    LNK-PRTKANRI-SRYYM
                                           TO  RECE10-SKYYM
                   MOVE    LNK-PRTKANRI-SKYYMD
                                           TO  RECE10-UPDYMD  
                   MOVE    RECE10-REC      TO  MCPDATA-REC
                   MOVE    "DBUPDATE"      TO  MCP-FUNC
                   MOVE    "SEIKYU-KEY"    TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"      USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
                   IF      MCP-RC          =   ZERO
                       PERFORM 900-UPD-FILE-READ-SEC
                   ELSE
                       DISPLAY "UPD ERR KEY="  RECE10-KEY 
                       MOVE  "*** ORCBM001 SEIKYU UPD ERR ***"
                                           TO  WRK-RECEERR
                       MOVE    RECE10-KEY  TO  WRK-RECEERR(33:)
                       PERFORM 500-ERR-HENSYU-SEC
                       MOVE    1           TO  FLG-UPDFILE
                   END-IF
               ELSE
                       DISPLAY "INV ERR KEY="  RECE10-KEY 
                   MOVE  "*** ORCBM001 SEIKYU INVALID ***"
                                           TO  WRK-RECEERR
                   MOVE    RECE10-KEY      TO  WRK-RECEERR(33:)
                   PERFORM 500-ERR-HENSYU-SEC
                   MOVE    1               TO  FLG-UPDFILE
               END-IF
           END-PERFORM  
      *
           CLOSE   UPD-FILE
           .
       310-SEIKYU-UPD-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    西暦日本語変換処理
      *****************************************************************
       31012-SEIWA-HEN-SEC        SECTION.
      *
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY2-AREA
           MOVE    "21"                TO  LNK-DAY2-IRAI
           MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY2-AREA
           MOVE    LNK-DAY2-EDTYMD3    TO  WRK-HENYMDG
           INSPECT WRK-HENYMDG    REPLACING  ALL "  "  BY  "　"
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理読込
      *****************************************************************
       900-SEIKYU-SELECT-SEC             SECTION.
      *
      *    請求管理ＤＢ検索
           INITIALIZE                  RECE10-REC
           MOVE    SYS-1001-HOSPID     TO  RECE10-HOSPID
           MOVE    LNK-PRTKANRI-SRYYM      TO  RECE10-SKYYM
           MOVE    WRK-CONS-SRYYM      TO  RECE10-SRYYM
           MOVE    RECE10-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
      *****MOVE    "SEIKYU-KEY4"       TO  ORC-DBPATH
           MOVE    "SEIKYU-KEY11"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
      *****    MOVE    "SEIKYU-KEY4"       TO  ORC-DBPATH
               MOVE    "SEIKYU-KEY11"      TO  ORC-DBPATH
               PERFORM 900-SEIKYU-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-END
               MOVE    HIGH-VALUE      TO  KEY-NEW
           END-IF
           .
       900-SEIKYU-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求マスター読込
      *****************************************************************
       900-SEIKYU-READ-SEC           SECTION.
      *
      *****MOVE    "SEIKYU-KEY4"       TO  ORC-DBPATH
           MOVE    "SEIKYU-KEY11"      TO  ORC-DBPATH
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-END
               MOVE    MCPDATA-REC         TO  RECE10-REC
      *
      *        テスト患者のときは読み飛ばす
               MOVE    SPACE               TO  PTINF-REC
               INITIALIZE                      PTINF-REC
               MOVE    RECE10-HOSPID       TO  PTINF-HOSPID
               MOVE    RECE10-PTID         TO  PTINF-PTID
               MOVE    PTINF-REC           TO  MCPDATA-REC
               PERFORM 800-PTINF-READ-SEC
               IF      FLG-PTINF           =   ZERO
               AND     PTINF-TSTPTNUMKBN   =   "1"
                   GO  TO  900-SEIKYU-READ-SEC
               END-IF
      *         
               MOVE    RECE10-HKNJANUM-S   TO  KEY-N-HKNJANUM
               ADD     1                   TO  CNT-RECE10   
           ELSE
               MOVE    HIGH-VALUE      TO  KEY-NEW
               MOVE    1               TO  FLG-END
           END-IF
      *
           .
       900-SEIKYU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスタ読込
      *****************************************************************
       800-PTINF-READ-SEC         SECTION.
      *
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
                   MOVE    ZERO                TO  FLG-PTINF
                   MOVE    MCPDATA-REC         TO  PTINF-REC
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
       800-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    集計ファイル読み込み
      *****************************************************************
       900-MF01-READ-SEC             SECTION.
      *
      *
           READ    MF01-FILE
               INVALID
                   MOVE    1           TO  FLG-MF01
               NOT INVALID
                   MOVE    ZERO        TO  FLG-MF01
           END-READ
           .
       900-MF01-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    集計ファイル読込
      *****************************************************************
       900-MF01-READ-N-SEC             SECTION.
      *
           READ    MF011-FILE   NEXT
               AT  END
                   MOVE    1           TO  FLG-MF01
               NOT AT  END
                   MOVE    ZERO        TO  FLG-MF01
           END-READ
           .
       900-MF01-READ-N-EXT.
           EXIT.
      *
      *****************************************************************
      *    請求管理ＤＢ更新用ファイル読込
      *****************************************************************
       900-UPD-FILE-READ-SEC             SECTION.
      *
           READ    UPD-FILE
               AT  END
                   MOVE    1           TO  FLG-UPDFILE
               NOT AT  END
                   MOVE    ZERO        TO  FLG-UPDFILE
           END-READ
           .
       900-UPD-FILE-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       910-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    LNK-PRTKANRI-SKYYMD TO  ORC-DBYMD
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
      *****************************************************************
      *    請求管理マスタ読込
      *****************************************************************
       910-SEIKYU-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SEIKYU
                   MOVE    MCPDATA-REC         TO  RECE10-REC
               ELSE
                   MOVE    1                   TO  FLG-SEIKYU
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SEIKYU
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SEIKYU-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-SEIKYU-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号マスター読込
      *****************************************************************
       900-HKNNUM-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE                  HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
      *
           .
       900-HKNNUM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-HKNJAINF-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-HKNJAINF
                   MOVE    MCPDATA-REC         TO  HKNJAINF-REC
               ELSE
                   MOVE    1                   TO  FLG-HKNJAINF
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNJAINF
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-HKNJAINF-INV-EXT.
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
