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
000200 IDENTIFICATION          DIVISION.
000300 PROGRAM-ID.             ORCR0300.
000400*****************************************************************
000500*  システム名        : ＯＲＣＡ
000600*  サブシステム名    : レセプト
000700*  コンポーネント名  : レセプト電算ファイル作成（ＣＳＶ形式）
000800*  管理者            : 
000900*  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
001100*****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
001200*
001300 ENVIRONMENT             DIVISION.
001400 CONFIGURATION           SECTION.
001500 INPUT-OUTPUT            SECTION.
001600 FILE-CONTROL.
      *
      *    レセプト明細書  
           SELECT  RECE02-FILE     ASSIGN  RECE02PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE02-KEY
                                   FILE    STATUS  IS  STS-RECE02.
      *
      *    レセプト明細書（病名）  
           SELECT  RECE03-FILE     ASSIGN  RECE03PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE031-KEY
                                   FILE    STATUS  IS  STS-RECE03.
      *    レセプト０４データ
           SELECT  RECE041-FILE     ASSIGN  RECE04PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE041-KEY
                                   FILE    STATUS  IS  STS-RECE04.
      *    レセプト０５データ
           SELECT  RECE05-FILE     ASSIGN  RECE05PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  SEQUENTIAL
                                   RECORD  KEY     IS  RECE05-KEY
                                   FILE    STATUS  IS  STS-RECE05.
      *    レセプト電算ファイル  
           SELECT  RECE30-FILE     ASSIGN  "/var/tmp/RECE300.dat"
                                   ORGANIZATION    IS  LINE
                                                       SEQUENTIAL
                                   FILE    STATUS  IS  STS-RECE30.
006900*    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
006900*
007000 DATA                    DIVISION.
007100 FILE                    SECTION.
      *
      *    レセプト明細書  
       FD  RECE02-FILE.
       01  RECE02-REC. 
           COPY    "CPRCF002.INC".
      *
      *    レセプト明細書（病名）  
       FD  RECE03-FILE.
       01  RECE031-REC.
           COPY    "CPRCF0031.INC".
      *
      *    レセプト０４データ
       FD  RECE041-FILE.
       01  RECE041-REC.
           COPY    "CPRCF0041.INC".
      *
      *    レセプト０５データ
       FD  RECE05-FILE.
       01  RECE05-REC.
           COPY    "CPRCF005.INC".
      *
      *    レセプト電算ファイル  
       FD  RECE30-FILE.
       01  RECE30-R         PIC X(200).
      *     
006900*    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200). 
      *
010200 WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE02//.
      *
      *     レセプト明細ファイル（病名） 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE03//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE04//.
      *
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE05//.
      *
      *     レセプト電算ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE30//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03                      PIC X(04)   VALUE   ".dat".
      *
018000*    フラグ領域
       01  STS-AREA.
           03  STS-RECE30              PIC X(02).
           03  STS-RECE02              PIC X(02).
           03  STS-RECE03              PIC X(02).
           03  STS-RECE04              PIC X(02).
           03  STS-RECE05              PIC X(02).
           03  STS-RECEERR             PIC X(02).
      *
018100 01  FLG-AREA.
           03  FLG-END                 PIC 9(01).
           03  FLG-BYOMEI              PIC 9(01).
           03  FLG-TENSU               PIC 9(01).
           03  FLG-PTCOM               PIC 9(01).
           03  FLG-HKNCOMBI            PIC 9(01). 
018900     03  FLG-SYSKANRI            PIC 9(01).
           03  FLG-RECE30              PIC 9(01).
           03  FLG-RECE02              PIC 9(01).
           03  FLG-RECE03              PIC 9(01).
           03  FLG-RECE04              PIC 9(01).
           03  FLG-RECE05              PIC 9(01).
      *
           03  FLG-TEIGEN              PIC 9(01).
           03  FLG-YKZ20               PIC 9(01).     
020700*
020800*    カウント領域
020900 01  CNT-AREA.
021000     03  CNT-IN                  PIC 9(06).
           03  CNT-OUT                 PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDW                     PIC 9(03).
           03  IDX                     PIC 9(03). 
           03  IDY                     PIC 9(03). 
           03  IDZ                     PIC 9(03).
      *
       01  KEY-AREA                                VALUE   LOW-VALUE.
           03  KEY-NEW.
      *****    05  KEY-N-TEISYUTUSAKI  PIC 9(01).
               05  KEY-N-SRYKA         PIC X(02).
           03  KEY-OLD.
      *****    05  KEY-O-TEISYUTUSAKI  PIC 9(01).
               05  KEY-O-SRYKA         PIC X(02).      
      *
       01  SUM-AREA                                VALUE   ZERO.
           03  SUM-TOTALKENSU         PIC 9(06).
           03  SUM-TOTALTEN         PIC 9(10).
024000*
024100*    一時領域
024200 01  WRK-AREA.
      *    パラメタエリア
           03  WRK-PARA.
               05  WRK-PARA1.
                   07  WRK-PARA-SRYYM  PIC X(06).
                   07  WRK-PARA-TERMID PIC X(16).
                   07  WRK-PARA-SYSYMD PIC X(08).
               05  WRK-PARA-SKYYM      PIC X(06).
               05  WRK-PARA-TEISYUTUSAKI
                                       PIC X(01).
               05  WRK-PARA-JOBID      PIC 9(07).
               05  WRK-PARA-SHELLID    PIC X(08).
      *
           03  WRK-RECEERR             PIC X(200). 
      *     右ずめ編集用     
           03  WRK-HENKAN              PIC X(20).
           03  WRK-LENGTH              PIC 9(02).
           03  WRK-HENSYU              PIC X(20).
      *    出力データ編集用
           03  WRK-SRYKBN              PIC X(02).
           03  WRK-REC                 PIC X(200).
           03  WRK-REC-LENGTH          PIC 9(03).
           03  WRK-HENSYU-AREA.
               05  WRK-DATA            PIC X(80).
               05  WRK-NUM             PIC ZZZZZZZZZ9.999. 
               05  WRK-NAGASA          PIC 9(02).
               05  WRK-ST              PIC 9(02). 
               05  WRK-SYOSUU          PIC 9(01).
               05  WRK-END             PIC 9(01).
      *    傷病名レコード編集用
           03  WRK-BYOMEI-AREA.
               05  WRK-BYOMEICD        PIC X(07).
               05  WRK-RECECD-G.
                   07  WRK-RECECD      PIC X(04)   OCCURS  20.                            
      *    マルチボリューム識別情報     
           03  WRK-VOLNUM              PIC 9(06).
      *    給付割合 
           03  WRK-KYURATE             PIC 9(03).
      *    レセプト番号
           03  WRK-RECENUM             PIC 9(06).        
      *    請求年月（和暦）
           03  WRK-SEIYM               PIC 9(05).         
      *    診療年月（和暦）
           03  WRK-SRYYM               PIC 9(05).         
      *       
           03  WRK-IN                  PIC X(01).
      *
      *    1桁目:生保 2桁目:結核 3桁目:精神
           03  WRK-3SYU-KBN.
               05  WRK-3SYU            PIC X(03).
      *    生保 
           03  SEHIDX                  PIC 9(01).
      *    精神 
           03  SESIDX                  PIC 9(01).
      *    結核 
           03  KEKIDX                  PIC 9(01).
      *
           03  IDX1                    PIC 9(01).     
           03  IDX2                    PIC 9(01).     
           03  IDX3                    PIC 9(01).
      *
      *    摘要レコード編集用
           03  WRK-ZAIWMAX             PIC 9(03).
           03  WRK-TBLMAX1             PIC 9(03).
           03  WRK-TBLMAX6             PIC 9(03).
           03  WRK-TBLMAX7             PIC 9(03).
           03  WRK-TBLMAX8             PIC 9(03).
           03  WRK-SURYO               PIC 9(08).
           03  WRK-TENSU               PIC 9(07).
           03  WRK-KAISU               PIC 9(03).
           03  WRK-TANKA               PIC 9(07)V9(02).
           03  WRK-SRYSURYO            PIC 9(05)V9(03).
           03  WRK-FTNKBN-AREA.                            
               05  WRK-FTNKBN          PIC X(01).
               05  WRK-KOHNUM          PIC 9(01)
                                           OCCURS  3.
               05  WRK-SEHFLG          PIC 9(01).           
      *    日付変換用
           03  WRK-SYMD                PIC X(08).
      *
       01  WRK-HEN-AREA.
           03  WRK-HENYMDG             PIC 9(08).
           03  WRK-HENYMDGR            REDEFINES   WRK-HENYMDG.
               05  FILLER              PIC 9(01).
               05  WRK-HENYMD          PIC 9(07).
      *
      *    適用レコード用待避テーブル
       01  TBL-ZAIW-AREA.
           03  TBL-ZAIW-REC      OCCURS 100.
               05  TBL-ZAIW-SRYACTINF.
      *            診療コード/数量/回数
                   07  TBL-ZAIW-SRYCD           PIC  X(09).
                   07  TBL-ZAIW-SRYSURYO        PIC  9(05)V9(03).
      *            単位コード
                   07  TBL-ZAIW-TANICD          PIC  9(03).
      *            点数識別区分/点数
                   07  TBL-ZAIW-TENSIKIBETU     PIC  9(01).
                   07  TBL-ZAIW-TEN             PIC  9(09)V9(02).
      *
      *    コメントデータ用テーブル
       01  TBL-COMMENT-AREA.
           03  TBL-COMMENT-REC                  OCCURS  10.
               05  TBL-COMMENT-SRYCD            PIC  X(09).
               05  TBL-COMMENT-NAME             PIC  X(200).
      *
      *    診療行為データ用テーブル
       01  TBL-KOUI-AREA.
           03  TBL-KOUI-REC                     OCCURS  30.
      *        並び替え用ｋｅｙ      
               05  TBL-KOUI-KEY.
      *            告示等識別区分
                   07  TBL-KOUI-KOKUJISKBKBN1   PIC  9(01).
      *             表用番号
                   07  TBL-KOUI-CDKBN-SYO       PIC  9(01).
                   07  TBL-KOUI-CDKBN-BU        PIC  9(02).
                   07  TBL-KOUI-CDKBN-KBN       PIC  X(01).
                   07  TBL-KOUI-CDKBN-KBNNUM    PIC  9(03).
                   07  TBL-KOUI-CDKBN-KBNNUM-EDA
                                                PIC  9(02).
                   07  TBL-KOUI-CDKBN-KOUBAN    PIC  9(02).
                   07  TBL-KOUI-KOUHYOJUNNUM    PIC  9(09).
               05  TBL-KOUI-SRYACTINF.
      *            診療コード
                   07  TBL-KOUI-SRYCD           PIC  X(09).
      *            数量
                   07  TBL-KOUI-SRYSURYO        PIC  9(05)V9(03).
      *    並び替え用ワーク      
       01  TBL-KOUI-SORT                        PIC X(100).
      *  
       01  WRK-CONS-AREA.
      *    コンマ
           03  WRK-KUGIRI             PIC X(01)   VALUE   ",".
      *    改行コード
           03  WRK-KAIGYO             PIC X(01)   VALUE   X"0D".
      *    退職者保険番号
      *        組合
           03  WRK-CONS-HKNNUM1       PIC X(03)   VALUE  "063".
      *        国公
           03  WRK-CONS-HKNNUM2       PIC X(03)   VALUE  "072".
      *        地公
           03  WRK-CONS-HKNNUM3       PIC X(03)   VALUE  "073".
      *        警察
           03  WRK-CONS-HKNNUM4       PIC X(03)   VALUE  "074".
      *        公学・私学
           03  WRK-CONS-HKNNUM5       PIC X(03)   VALUE  "075".
      *        国保
           03  WRK-CONS-HKNNUM6       PIC X(03)   VALUE  "067".
      *    薬剤料逓減
           03  WRK-CONS-TEIGEN        PIC X(09)   VALUE   "630010002".
      *    内服薬２０５円以下
           03  WRK-CONS-NAI205        PIC X(09)   VALUE   "610010002".
      *    注射２０５円以下
           03  WRK-CONS-CHU205        PIC X(09)   VALUE   "640010002".
      *    外服薬２０５円以下
           03  WRK-CONS-GAI205        PIC X(09)   VALUE   "660010002".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    医療機関情報
           COPY  "CPSK1001.INC".
      *
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *
      *    点数
           COPY    "CPTENSU.INC".
      *
      *    患者コメント
       01  PTCOM-REC.
           COPY    "CPPTCOM.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *****************************************************************
      *    サブプロ用領域
      *****************************************************************
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
           COPY    "MCPAREA".
      *
      *
      ****************************************************************
       LINKAGE                 SECTION.
       01  COMMAND-PARAM.
           02  FILLER      PIC X(256).
      ****************************************************************
       PROCEDURE                   DIVISION
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
                                       FLG-AREA
      *
           UNSTRING    COMMAND-PARAM   DELIMITED  BY  ","
                                       INTO    WRK-PARA1
                                               WRK-PARA-SKYYM
                                               WRK-PARA-TEISYUTUSAKI
                                               WRK-PARA-JOBID
                                               WRK-PARA-SHELLID
           END-UNSTRING                                  
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0300"      TO  JOB-PGID
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           PERFORM 110-SYSKANRI-HENSYU-SEC
      *
           PERFORM 120-SKYYM-HENSYU-SEC
      *     
           MOVE    "RECE300"           TO  RECE30PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE30PARA-TERMID
      *
           MOVE    "RECE020"           TO  RECE02PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE02PARA-TERMID
      *
           MOVE    "RECE031"           TO  RECE03PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE03PARA-TERMID
      *
           MOVE    "RECE041"           TO  RECE04PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE04PARA-TERMID
      *
           MOVE    "RECE050"           TO  RECE05PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE05PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
           OPEN    OUTPUT             RECE30-FILE  
      *
           OPEN    I-O                RECE02-FILE  
      *
           OPEN    I-O                RECE03-FILE  
      *
           OPEN    I-O                RECE041-FILE  
      *
           OPEN    I-O                RECE05-FILE  
      *
           IF      FLG-END             =   ZERO
               PERFORM 900-RECE02-READ-SEC
           END-IF    
           .
       100-INIT-EXT.
           EXIT.
      * 
      *****************************************************************
      *    システム管理マスタ取得      
      *****************************************************************
       110-SYSKANRI-HENSYU-SEC      SECTION.
      *
      *    医療機関ＩＤ編集
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    WRK-PARA-SYSYMD     TO  ORC-DBYMD
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 910-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1001-REC
           ELSE
               MOVE    "*** ORCR0300 SYS1001 INVALID ***" 
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           END-IF
      *    
           .
       110-SYSKANRI-HENSYU-EXT.
           EXIT.
      * 
      *****************************************************************
      *    請求年月編集処理      
      *****************************************************************
       120-SKYYM-HENSYU-SEC      SECTION.
      *
           MOVE    WRK-PARA-SKYYM      TO  WRK-SYMD(1:6)
           MOVE    "01"                TO  WRK-SYMD(7:2)
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMD (1:5)    TO  WRK-SEIYM 
      *
           MOVE    WRK-PARA-SRYYM      TO  WRK-SYMD(1:6)
           MOVE    "01"                TO  WRK-SYMD(7:2)
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMD (1:5)    TO  WRK-SRYYM 
      *    
           .
       120-SKYYM-HENSYU-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           MOVE    ZERO            TO  WRK-VOLNUM
                                       WRK-RECENUM
                                       SUM-AREA
      *     
      *    医療機関情報レコード
           PERFORM     2001-HENSYU-SEC
      *
      *    審査支払機関・診療科別処理              
           MOVE    KEY-NEW         TO  KEY-OLD
           PERFORM                 UNTIL   FLG-END     =   1
                                   OR      KEY-NEW NOT =   KEY-OLD
      *
      *    三種公費併用のチェック
               MOVE    SPACE              TO  WRK-3SYU-KBN
               MOVE    ZERO               TO  SEHIDX
                                              KEKIDX
                                              SESIDX
      * 
               IF      RECE02-HKNNUM      =   SPACE      
                   PERFORM   VARYING   IDX  FROM    1   BY  1
                         UNTIL   ( IDX                >    4    )
                         OR      ( RECE02-KOHID(IDX)  =   SPACE )
      *                生保
                       IF  RECE02-KOHNUM (IDX)  =   "012"
                           MOVE    "1"          TO  WRK-3SYU (1:1)
                           MOVE    IDX          TO  SEHIDX 
                       END-IF
      *                結核
                       IF  RECE02-KOHNUM (IDX)  =   "010"  OR  "011"
                           MOVE    "1"          TO  WRK-3SYU (2:1)
                           MOVE    IDX          TO  KEKIDX 
                       END-IF
      *                精神
                       IF  RECE02-KOHNUM (IDX)  =   "020"  OR  "021"
                           MOVE    "1"          TO  WRK-3SYU (3:1)
                           MOVE    IDX          TO  SESIDX 
                       END-IF
                   END-PERFORM
               END-IF    
      *    実日数／合計点数等のＩＮＤＥＸ
               IF      WRK-3SYU-KBN           =   ALL "1" AND 
                       RECE02-HKNNUM          =   SPACE            
                   IF  KEKIDX             >   SESIDX
                       COMPUTE IDX2     =   SESIDX     +   1
                       COMPUTE IDX3     =   KEKIDX     +   1
                   ELSE
                       COMPUTE IDX2     =   KEKIDX     +   1
                       COMPUTE IDX3     =   SESIDX     +   1
                   END-IF
                   COMPUTE IDX1     =   SEHIDX     +   1
               ELSE
                   MOVE    1               TO  IDX1
                   MOVE    2               TO  IDX2
                   MOVE    3               TO  IDX3
               END-IF
      *
      *        総件数／総合計点数の集計      
               ADD     1                   TO  SUM-TOTALKENSU
               IF      RECE02-RJNHKNNUM    =   SPACE           
               AND     RECE02-HKNNUM       =   SPACE
                   IF      RECE02-KOHNUM (3)   NOT =   SPACE
                       MOVE    RECE02-TOTALTEN (1) TO  SUM-TOTALTEN
                   ELSE
                       MOVE    RECE02-TOTALTEN (2) TO  SUM-TOTALTEN
                   END-IF
               ELSE
                   MOVE    RECE02-TOTALTEN (1) TO  SUM-TOTALTEN
               END-IF
      *         
      *        レセプト共通レコード
               PERFORM     2002-HENSYU-SEC
      *        保険者レコード
               PERFORM     2003-HENSYU-SEC
      *        老人レコード
               PERFORM     2004-HENSYU-SEC
      *        公費レコード
               PERFORM     2005-HENSYU-SEC
      *        傷病名レコード
               PERFORM     2006-HENSYU-SEC
      *        適用レコード
               PERFORM     2007-HENSYU-SEC
      *
               PERFORM     900-RECE02-READ-SEC
           END-PERFORM
      *
      *        合計書レコード
           PERFORM     2008-HENSYU-SEC
           .
       200-MAIN-EXT.
           EXIT.             
      * 
      *****************************************************************
      *    医療機関情報レコード編集処理
      *****************************************************************
       2001-HENSYU-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-REC
           MOVE    ZERO                TO  WRK-REC-LENGTH
      *          
           MOVE    "IR,"               TO  WRK-REC
           MOVE    3                   TO  WRK-REC-LENGTH
      *     
           MOVE    RECE02-TEISYUTUSAKI TO  WRK-DATA
           MOVE    1                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *     
           MOVE    SYS-1001-PREFNUM    TO  WRK-DATA
           MOVE    2                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *     
           MOVE    SYS-1001-TENHYOKBN  TO  WRK-DATA
           MOVE    1                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *     
           MOVE    SYS-1001-HOSPCD     TO  WRK-DATA
           MOVE    7                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *     
           IF      RECE02-RECEKA       =   ZERO
              MOVE    SPACE                TO  WRK-DATA
           ELSE    
               MOVE    RECE02-RECEKA       TO  WRK-DATA
           END-IF
           MOVE    2                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *            
           MOVE    SYS-1001-HOSPNAME   TO  WRK-DATA
           MOVE    40                  TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *            
           MOVE    WRK-SEIYM           TO  WRK-DATA
           MOVE    5                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *            
           MOVE    WRK-VOLNUM          TO  WRK-DATA
           MOVE    2                   TO  WRK-NAGASA
           MOVE    1                   TO  WRK-END 
           PERFORM 5004-MOJI-HENSYU-SEC
      *
           PERFORM 5001-FILE-WRITE-SEC
           .
       2001-HENSYU-EXT.
           EXIT. 
      * 
      *****************************************************************
      *    レセプト共通レコード編集処理
      *****************************************************************
       2002-HENSYU-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-REC
           MOVE    ZERO                TO  WRK-REC-LENGTH
      *          
           MOVE    "RE,"               TO  WRK-REC
           MOVE    3                   TO  WRK-REC-LENGTH
      *    レセプト番号
           ADD     1                   TO  WRK-RECENUM
           MOVE    WRK-RECENUM         TO  WRK-NUM
           MOVE    6                   TO  WRK-NAGASA
           PERFORM 5005-NUM-HENSYU-SEC
      *    レセプト種別
           MOVE    RECE02-RECESYUBETU  TO  WRK-DATA
           MOVE    4                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *    診療年月
           MOVE    WRK-SRYYM           TO  WRK-DATA
           MOVE    5                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *    氏名
           MOVE    RECE02-NAME         TO  WRK-DATA
           MOVE    40                  TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *    性別
           MOVE    RECE02-SEX          TO  WRK-DATA
           MOVE    1                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *    生年月日
           MOVE    RECE02-BIRTHDAY     TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMD          TO  WRK-DATA
           MOVE    7                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *
      *    給付割合（国保OR退職者のみ）
           IF    ( RECE02-TEISYUTUSAKI =   "2"     AND
                   RECE02-RJNHKNNUM    =   SPACE                ) OR
                 ( RECE02-HKNNUM       =   WRK-CONS-HKNNUM1  OR
                                           WRK-CONS-HKNNUM2  OR
                                           WRK-CONS-HKNNUM3  OR
                                           WRK-CONS-HKNNUM4  OR
                                           WRK-CONS-HKNNUM5  OR
                                           WRK-CONS-HKNNUM6     )
               COMPUTE WRK-KYURATE =  (100 -   RECE02-KYURATE) 
               MOVE   WRK-KYURATE          TO  WRK-NUM
               MOVE    3                   TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC
      *    入院年月日
           PERFORM 5004-MOJI-HENSYU-SEC         
      *    病棟区分
           IF      RECE02-NYUGAIKBN    =   "1"
               MOVE    1               TO  IDZ                  
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       4
                   MOVE    RECE02-BYOTOKBN (IDX)
                                           TO  WRK-DATA (IDZ:2)
                   ADD     2               TO  IDZ
               END-PERFORM                            
               MOVE    8                   TO  WRK-NAGASA
           END-IF    
           PERFORM 5004-MOJI-HENSYU-SEC         
      *    一部負担金・食事療養費標準負担額区分
           PERFORM 5004-MOJI-HENSYU-SEC         
      *    特記事項
               MOVE    1               TO  IDZ                  
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       5
               MOVE    RECE02-TOKKI (IDX)  TO  WRK-DATA (IDZ:2)
                   ADD     2               TO  IDZ
           END-PERFORM
           MOVE    10                  TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC         
      *    病床数
           IF      SYS-1001-BEDSU      >   ZERO
               MOVE    SYS-1001-BEDSU      TO  WRK-NUM
               MOVE    3                   TO  WRK-NAGASA
           END-IF
           PERFORM 5005-NUM-HENSYU-SEC         
      *    カルテ番号等
           MOVE    RECE02-PTNUM        TO  WRK-DATA     
           MOVE    20                  TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC         
      *    割引点数単価
           PERFORM 5004-MOJI-HENSYU-SEC         
      *    自己負担区分
           PERFORM 5004-MOJI-HENSYU-SEC         
      *    処方せん交付区分
           MOVE    1                   TO  WRK-END 
           PERFORM 5004-MOJI-HENSYU-SEC         
      *
           PERFORM 5001-FILE-WRITE-SEC
           .
       2002-HENSYU-EXT.
           EXIT. 
      *            
      * 
      *****************************************************************
      *    保険者レコード編集処理
      *****************************************************************
       2003-HENSYU-SEC              SECTION.
      *
           IF      RECE02-HKNNUM           =   SPACE
           OR      RECE02-RJNHKNNUM    NOT =   SPACE 
               GO  TO  2003-HENSYU-EXT
           END-IF
      *
           MOVE    SPACE               TO  WRK-REC
           MOVE    ZERO                TO  WRK-REC-LENGTH
      *          
           MOVE    "HO,"               TO  WRK-REC
           MOVE    3                   TO  WRK-REC-LENGTH
      *    保険者番号
           IF  RECE02-TEISYUTUSAKI    =   "2"
               IF      RECE02-HKNJANUM (1:2)  =   "67"
                   MOVE    RECE02-HKNJANUM  TO  WRK-HENKAN
               ELSE
      *        国保の場合（６桁右詰に編集）
                   MOVE    RECE02-HKNJANUM(1:6)
                                            TO  WRK-HENKAN
               END-IF
           ELSE
               IF  RECE02-HKNNUM      =   "001"
      *            政府管掌の場合（４桁右詰に編集）
                   MOVE    RECE02-HKNJANUM(1:4)
                                         TO  WRK-HENKAN
               ELSE
      *            他の保険の場合（８桁）
                   MOVE    RECE02-HKNJANUM
                                         TO  WRK-HENKAN
               END-IF
           END-IF
           MOVE    8                     TO  WRK-LENGTH 
           PERFORM 5003-DATA-RIGHT-HENSYU-SEC
           MOVE    WRK-HENKAN            TO  WRK-DATA
           MOVE    8                     TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *    記号
           MOVE    RECE02-KIGO           TO  WRK-DATA
           MOVE    40                    TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *    番号
           MOVE    RECE02-NUM            TO  WRK-DATA
           MOVE    40                    TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *    診療実日数     
           MOVE    RECE02-JNISSU(IDX1)   TO  WRK-NUM
           MOVE    2                     TO  WRK-NAGASA
           PERFORM 5005-NUM-HENSYU-SEC
      *    合計点数     
           MOVE    RECE02-TOTALTEN(IDX1) TO  WRK-NUM
           MOVE    8                     TO  WRK-NAGASA
           PERFORM 5005-NUM-HENSYU-SEC
      *    薬剤一部負担金
           IF      RECE02-NYUGAIKBN      =   "2"
               MOVE    RECE02-YKZFTN(IDX1)   TO  WRK-NUM
               MOVE    5                     TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC
      *    食事療養費（日数）
           IF      RECE02-NYUGAIKBN      =   "1"
               MOVE    RECE02-SHOKUJINISSU(IDX1)
                                             TO  WRK-NUM
               MOVE    2                     TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC   
      *    食事療養費（合計金額）
           IF      RECE02-NYUGAIKBN      =   "1"
               MOVE    RECE02-SHOKUJIRYOYOHI(IDX1)
                                             TO  WRK-NUM
               MOVE    8                     TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC     
      *    職務上の事由
           IF      RECE02-HKNNUM       =   "002"
               MOVE    RECE02-HOJOKBN        TO  WRK-DATA
               MOVE    1                     TO  WRK-NAGASA
           END-IF    
           PERFORM 5004-MOJI-HENSYU-SEC     
      *    証明書番号（国保OR退職者のみ）
           IF    ( RECE02-TEISYUTUSAKI =   "2"     AND
                   RECE02-RJNHKNNUM    =   SPACE                ) OR
                 ( RECE02-HKNNUM       =   WRK-CONS-HKNNUM1  OR
                                           WRK-CONS-HKNNUM2  OR
                                           WRK-CONS-HKNNUM3  OR
                                           WRK-CONS-HKNNUM4  OR
                                           WRK-CONS-HKNNUM5  OR
                                           WRK-CONS-HKNNUM6     )
               MOVE    RECE02-CERTNUM      TO  WRK-NUM
               MOVE    3                   TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC     
      *    医療保険    
           PERFORM 5004-MOJI-HENSYU-SEC     
      *    国保減免区分                                 
           PERFORM 5004-MOJI-HENSYU-SEC     
      *    国保減額割合 
           PERFORM 5004-MOJI-HENSYU-SEC  
      *    国保減額金額 
           MOVE    1                   TO  WRK-END 
           PERFORM 5004-MOJI-HENSYU-SEC  
      *
           PERFORM 5001-FILE-WRITE-SEC
           .
       2003-HENSYU-EXT.
           EXIT. 
      *            
      *****************************************************************
      *    老人レコード編集処理
      *****************************************************************
       2004-HENSYU-SEC              SECTION.
      *
           IF      RECE02-RJNHKNNUM    =   SPACE
               GO  TO  2004-HENSYU-EXT
           END-IF
      *
           MOVE    SPACE               TO  WRK-REC
           MOVE    ZERO                TO  WRK-REC-LENGTH
      *          
           MOVE    "RO,"               TO  WRK-REC
           MOVE    3                   TO  WRK-REC-LENGTH
      *    保険者番号
           IF  RECE02-TEISYUTUSAKI    =   "2"
               IF      RECE02-HKNJANUM (1:2)  =   "67"
                   MOVE    RECE02-HKNJANUM  TO  WRK-HENKAN
               ELSE
      *        国保の場合（６桁右詰に編集）
                   MOVE    RECE02-HKNJANUM(1:6)
                                            TO  WRK-HENKAN
               END-IF
           ELSE
               IF  RECE02-HKNNUM      =   "001"
      *            政府管掌の場合（４桁右詰に編集）
                   MOVE    RECE02-HKNJANUM(1:4)
                                         TO  WRK-HENKAN
               ELSE
      *            他の保険の場合（８桁）
                   MOVE    RECE02-HKNJANUM
                                         TO  WRK-HENKAN
               END-IF
           END-IF
           MOVE    8                   TO  WRK-LENGTH
           PERFORM 5003-DATA-RIGHT-HENSYU-SEC
           MOVE    WRK-HENKAN          TO  WRK-DATA
           MOVE    8                     TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *    記号
           MOVE    RECE02-KIGO           TO  WRK-DATA
           MOVE    40                    TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *    番号
           MOVE    RECE02-NUM            TO  WRK-DATA
           MOVE    40                    TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *    診療実日数     
           MOVE    RECE02-JNISSU(IDX1)   TO  WRK-NUM
           MOVE    2                     TO  WRK-NAGASA
           PERFORM 5005-NUM-HENSYU-SEC
      *    合計点数     
           MOVE    RECE02-TOTALTEN(IDX1) TO  WRK-NUM
           MOVE    8                     TO  WRK-NAGASA
           PERFORM 5005-NUM-HENSYU-SEC
      *    予備
           PERFORM 5004-MOJI-HENSYU-SEC
      *    食事療養費（日数）
           IF      RECE02-NYUGAIKBN      =   "1"
               MOVE    RECE02-SHOKUJINISSU(IDX1)
                                             TO  WRK-NUM
               MOVE    2                     TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC   
      *    食事療養費（合計金額）
           IF      RECE02-NYUGAIKBN      =   "1"
               MOVE    RECE02-SHOKUJIRYOYOHI(IDX1)
                                             TO  WRK-NUM
               MOVE    8                     TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC     
      *    老人医療（市町村番号）
           MOVE    RECE02-RJNFTNJANUM  TO  WRK-DATA
           MOVE    8                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC     
      *    老人医療（受給者番号）
           MOVE    RECE02-RJNJKYSNUM   TO  WRK-DATA
           MOVE    7                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC  
      *    負担金額（老人減免区分）
           IF      RECE02-RJNGENMENKBN >   ZERO
           MOVE    RECE02-RJNGENMENKBN     TO  WRK-NUM
               MOVE    1                   TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC     
      *    老人医療（老人外来金額）
           IF      RECE02-NYUGAIKBN    =   "2"
               MOVE    RECE02-RJNGAIFTN    TO  WRK-NUM
               MOVE    6                   TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC     
      *    老人医療（老人入院金額）
           IF      RECE02-NYUGAIKBN    =   "1"
               MOVE    RECE02-RJNNYUFTN    TO  WRK-NUM
               MOVE    6                   TO  WRK-NAGASA
           END-IF    
           MOVE    1                   TO  WRK-END 
           PERFORM 5005-NUM-HENSYU-SEC     
      *
           PERFORM 5001-FILE-WRITE-SEC
           .
       2004-HENSYU-EXT.
           EXIT. 
      *            
      *****************************************************************
      *    公費レコード編集処理
      *****************************************************************
       2005-HENSYU-SEC              SECTION.
      *
           IF      RECE02-KOHNUM (1)   =   SPACE
               GO  TO  2005-HENSYU-EXT
           END-IF
      *
      *    三種公費併用のとき
           IF      WRK-3SYU-KBN           =   ALL "1" AND 
                   RECE02-HKNNUM          =   SPACE            
               COMPUTE IDY     =   IDX1    -   1
               MOVE    IDX1                TO  IDX                     
               PERFORM 20051-KOH-HENSYU-SEC
               COMPUTE IDY     =   IDX2    -   1
               MOVE    IDX2                TO  IDX                     
               PERFORM 20051-KOH-HENSYU-SEC
               COMPUTE IDY     =   IDX3    -   1
               MOVE    IDX3                TO  IDX                     
               PERFORM 20051-KOH-HENSYU-SEC
           ELSE
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       2
                       OR      RECE02-KOHNUM (IDY) =   SPACE
                   COMPUTE IDX     =   IDY     +   1
                   PERFORM 20051-KOH-HENSYU-SEC
               END-PERFORM                      
           END-IF                            
           .
       2005-HENSYU-EXT.
           EXIT. 
      *            
      *****************************************************************
      *    公費レコード編集処理
      *****************************************************************
       20051-KOH-HENSYU-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-REC
           MOVE    ZERO                TO  WRK-REC-LENGTH
      *          
           MOVE    "KO,"               TO  WRK-REC
           MOVE    3                   TO  WRK-REC-LENGTH
      *    負担者番号
           MOVE    RECE02-KOHFTNJANUM (IDY)
                                       TO  WRK-DATA
           MOVE    8                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC     
      *    受給者番号                             
           MOVE    RECE02-KOHJKYSNUM  (IDY)
                                       TO  WRK-DATA
           MOVE    7                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC
      *    任意給付区分                             
           IF    ( RECE02-TEISYUTUSAKI =   "2"     AND
                   RECE02-RJNHKNNUM    =   SPACE                ) 
           OR    ( RECE02-HKNNUM       =   WRK-CONS-HKNNUM1  OR
                                           WRK-CONS-HKNNUM2  OR
                                           WRK-CONS-HKNNUM3  OR
                                           WRK-CONS-HKNNUM4  OR
                                           WRK-CONS-HKNNUM5  OR
                                           WRK-CONS-HKNNUM6     )
               IF      RECE02-KOHNINIKYUKBN (IDY) NOT =   SPACE
                   MOVE    "1"             TO  WRK-DATA
                   MOVE    1               TO  WRK-NAGASA 
               END-IF         
           END-IF
           PERFORM 5004-MOJI-HENSYU-SEC
      *    診療実日数     
           MOVE    RECE02-JNISSU(IDX)     TO  WRK-NUM
           MOVE    2                      TO  WRK-NAGASA
           PERFORM 5005-NUM-HENSYU-SEC
      *    合計点数     
           MOVE    RECE02-TOTALTEN(IDX)   TO  WRK-NUM
           MOVE    8                      TO  WRK-NAGASA
           PERFORM 5005-NUM-HENSYU-SEC
      *    負担金額（公費）
           IF      RECE02-FTNMONEY(IDX)   >   ZERO     
               MOVE    RECE02-FTNMONEY(IDX)
                                              TO  WRK-NUM
               MOVE    8                      TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC
      *    負担金額（老人公費給付対象老人外来一部負担金）
           IF      RECE02-NYUGAIKBN      =   "2"
           AND     RECE02-RJNHKNNUM  NOT =   SPACE
      ****     MOVE                          TO  WRK-NUM
      ****     MOVE    6                     TO  WRK-NAGASA
               CONTINUE      
           END-IF
           PERFORM 5005-NUM-HENSYU-SEC
      *    負担金額（老人公費給付対象老人入院一部負担金）
           IF      RECE02-NYUGAIKBN      =   "1"
           AND     RECE02-RJNHKNNUM  NOT =   SPACE
      ****     MOVE                          TO  WRK-NUM
      ****     MOVE    6                     TO  WRK-NAGASA
               CONTINUE      
           END-IF
           PERFORM 5005-NUM-HENSYU-SEC
      *    薬剤一部負担金
           IF      RECE02-HKNNUM     NOT =   SPACE    
           AND     RECE02-NYUGAIKBN      =   "1"
               MOVE    RECE02-YKZFTN(IDX)    TO  WRK-NUM
               MOVE    5                     TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC
      *    食事療養費（日数）
           IF      RECE02-NYUGAIKBN      =   "1"
               MOVE    RECE02-SHOKUJINISSU(IDX)
                                             TO  WRK-NUM
               MOVE    2                     TO  WRK-NAGASA
           END-IF    
           PERFORM 5005-NUM-HENSYU-SEC    
      *    食事療養費（合計金額）
           IF      RECE02-NYUGAIKBN      =   "1"
               MOVE    RECE02-SHOKUJIRYOYOHI(IDX)
                                             TO  WRK-NUM
               MOVE    5                     TO  WRK-NAGASA
           END-IF    
           MOVE    1                   TO  WRK-END 
           PERFORM 5005-NUM-HENSYU-SEC
      *
           PERFORM 5001-FILE-WRITE-SEC
           .
       20051-KOH-HENSYU-EXT.
           EXIT. 
      *            
      * 
      *****************************************************************
      *    傷病名レコード編集処理
      *****************************************************************
       2006-HENSYU-SEC              SECTION.
      *     
      *    傷病名情報
           INITIALIZE                      RECE031-REC
           MOVE    RECE02-HOSPID       TO  RECE031-HOSPID
           MOVE    RECE02-SRYYM        TO  RECE031-SRYYM
           MOVE    RECE02-NYUGAIKBN    TO  RECE031-NYUGAIKBN
           MOVE    RECE02-PTID         TO  RECE031-PTID
           MOVE    RECE02-RECEKA       TO  RECE031-RECEKA
           MOVE    RECE02-TEISYUTUSAKI TO  RECE031-TEISYUTUSAKI
           MOVE    RECE02-RECESYUBETU  TO  RECE031-RECESYUBETU
           MOVE    RECE02-HKNJANUM     TO  RECE031-HKNJANUM
           MOVE    RECE02-TEKSTYMD     TO  RECE031-TEKSTYMD
      *
           START   RECE03-FILE
               KEY IS    >=   RECE031-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE03
               NOT INVALID
                   PERFORM 990-RECE03-NEXT-SEC
           END-START
      *     
           PERFORM UNTIL  ( FLG-RECE03   =   1                    )
                   OR     ( RECE02-HOSPID
                                     NOT =   RECE031-HOSPID       )
                   OR     ( RECE02-SRYYM
                                     NOT =   RECE031-SRYYM        )
                   OR     ( RECE02-NYUGAIKBN
                                     NOT =   RECE031-NYUGAIKBN    )
                   OR     ( RECE02-PTID
                                     NOT =   RECE031-PTID         )
                   OR     ( RECE02-RECEKA
                                     NOT =   RECE031-RECEKA       )
                   OR     ( RECE02-TEISYUTUSAKI
                                     NOT =   RECE031-TEISYUTUSAKI )
                   OR     ( RECE02-RECESYUBETU
                                     NOT =   RECE031-RECESYUBETU  )
                   OR     ( RECE02-HKNJANUM
                                     NOT =   RECE031-HKNJANUM     )
                   OR     ( RECE02-TEKSTYMD
                                     NOT =   RECE031-TEKSTYMD     )
      *        転帰区分:8(移行)以外 処理対象
               IF      RECE031-TENKIKBN     =   "8"
                   CONTINUE
               ELSE    
                   PERFORM 20061-BYOMEI-HENSYU-SEC
               END-IF
      *             
               PERFORM 990-RECE03-NEXT-SEC
           END-PERFORM       
           .
       2006-HENSYU-EXT.
           EXIT. 
      *            
      *
      *****************************************************************
      *    帳票編集<傷病名>処理
      *****************************************************************
       20061-BYOMEI-HENSYU-SEC         SECTION.
      *
      *    傷病名コード／修飾語コードの取得
           MOVE    SPACE               TO  WRK-BYOMEI-AREA
      *     
           IF      RECE031-BYOMEIHENFLG =   "1"
      *        編集病名のとき未傷病名コードにする
               MOVE    "0000999"            TO  WRK-BYOMEICD
           ELSE    
               MOVE    ZERO                TO  IDY
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       6
                       OR      RECE031-BYOMEICD(IDX)   =   SPACE
                   IF      RECE031-BYOMEICD(IDX)(1:3)  NOT =   "ZZZ"
                       IF      WRK-BYOMEICD                =   SPACE
                           MOVE    RECE031-BYOMEICD(IDX)
                                                   TO  WRK-BYOMEICD
                       END-IF    
                   ELSE            
                       ADD     1           TO  IDY
                       MOVE    RECE031-BYOMEICD(IDX)(4:)
                                           TO  WRK-RECECD(IDY)
                   END-IF    
               END-PERFORM
           END-IF    
      *
      *
           MOVE    SPACE               TO  WRK-REC
           MOVE    ZERO                TO  WRK-REC-LENGTH
      *          
           MOVE    "SY,"               TO  WRK-REC
           MOVE    3                   TO  WRK-REC-LENGTH
      *    傷病名コード
           MOVE    WRK-BYOMEICD        TO  WRK-DATA
           MOVE    7                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC    
      *    診療開始日
           MOVE    RECE031-SRYYMD      TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMD          TO  WRK-DATA
           MOVE    7                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC    
      *    転記区分
           EVALUATE    RECE031-TENKIKBN
               WHEN    "1"
                   MOVE    "2"         TO  WRK-DATA
               WHEN    "2"
                   MOVE    "3"         TO  WRK-DATA
               WHEN    "3"
                   MOVE    "4"         TO  WRK-DATA
               WHEN    SPACE
                   MOVE    "1"         TO  WRK-DATA
           END-EVALUATE        
           MOVE    1                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC    
      *    修飾語コード
           MOVE    WRK-RECECD-G        TO  WRK-DATA
           MOVE    80                  TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC    
      *    傷病名称
           IF      WRK-BYOMEICD        =   "0000999"
               MOVE    RECE031-BYOMEI      TO  WRK-DATA
               MOVE    40                  TO  WRK-NAGASA
           END-IF    
           MOVE    1                   TO  WRK-END 
           PERFORM 5004-MOJI-HENSYU-SEC  
      *
           PERFORM 5001-FILE-WRITE-SEC
           .
       20061-BYOMEI-HENSYU-EXT.
           EXIT.
      * 
      *****************************************************************
      *    摘要レコード編集処理
      *****************************************************************
       2007-HENSYU-SEC              SECTION.
      *                                        
      *    摘要情報
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
      *
           START   RECE041-FILE
               KEY IS    >=   RECE041-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE04
               NOT INVALID
                   PERFORM 990-RECE041-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-END              =   1                   )
               OR     ( FLG-RECE04           =   1                   )
               OR     ( RECE02-HOSPID    NOT =   RECE041-HOSPID       )
               OR     ( RECE02-SRYYM     NOT =   RECE041-SRYYM        )
               OR     ( RECE02-NYUGAIKBN NOT =   RECE041-NYUGAIKBN    )
               OR     ( RECE02-PTID      NOT =   RECE041-PTID         )
               OR     ( RECE02-RECEKA    NOT =   RECE041-RECEKA       )
               OR     ( RECE02-TEISYUTUSAKI
                                         NOT =   RECE041-TEISYUTUSAKI )
               OR     ( RECE02-RECESYUBETU
                                         NOT =   RECE041-RECESYUBETU  )
               OR     ( RECE02-HKNJANUM  NOT =   RECE041-HKNJANUM     )
               OR     ( RECE02-TEKSTYMD  NOT =   RECE041-TEKSTYMD     )
      *        負担区分編集処理
               PERFORM 20070-FTNKBN-HENSYU-SEC        
      *        明細テーブル退避処理
               PERFORM 20071-ZAI-TAIHI-SEC
      *       摘要データ編集処理
               IF      FLG-END           =   ZERO
      *****        PERFORM 20074-ZAI-KOUI-SORT-SEC
                   PERFORM 20072-ZAI-HENSYU-SEC
                   PERFORM 990-RECE041-NEXT-SEC
               END-IF     
           END-PERFORM
           .
       2007-HENSYU-EXT.
           EXIT. 
      *
      *****************************************************************
      *    負担区分編集処理
      *****************************************************************
       20070-FTNKBN-HENSYU-SEC    SECTION.
      *      
      *    主保険＋３種公費のとき該当の負担区分がないので
      *    ＋２種公費のときと同じ負担区分を編集する      
      *   
           INITIALIZE                 WRK-FTNKBN-AREA
      *
      *        保険組合せ読込み
           INITIALIZE                 HKNCOMBI-REC
           MOVE    RECE041-HOSPID  TO  COMB-HOSPID
           MOVE    RECE041-PTID    TO  COMB-PTID
           MOVE    RECE041-HKNCOMBI
                                  TO  COMB-HKNCOMBINUM 
           MOVE    HKNCOMBI-REC   TO  MCPDATA-REC
           PERFORM 910-HKNCOMBI-INV-SEC
           IF      FLG-HKNCOMBI   =   1
               DISPLAY "HKNCONBI INV"
               GO  TO  20070-FTNKBN-HENSYU-EXT
           END-IF
      *                                                      
      *    主保険のみ      
           IF      COMB-HKNNUM    NOT =   SPACE
           AND     COMB-KOH1HKNNUM    =   SPACE
               MOVE    "1"            TO  WRK-FTNKBN
           END-IF
      *         
      *    老人保険のみ     
           IF      COMB-HKNNUM    NOT =   SPACE
           AND     COMB-KOH1HKNNUM    =   "027"
           AND     COMB-KOH2HKNNUM    =   SPACE
               MOVE    "1"            TO  WRK-FTNKBN
           END-IF
      *     
      *    生保のみ（三種公費のとき）      
           IF      WRK-3SYU-KBN       =   ALL "1"  
           AND     RECE02-HKNNUM      =   SPACE            
               IF      COMB-KOH1HKNNUM    =   "012"
               AND     COMB-KOH2HKNNUM    =   SPACE
                   MOVE    "1"            TO  WRK-FTNKBN
               END-IF
           END-IF    
      *???
      **     DISPLAY "HKNNUM=" COMB-HKNNUM  "KOH1=" COMB-KOH1HKNNUM "##"
      **             "KOH2="   COMB-KOH2HKNNUM "##"        
      *???              
      *
           IF      WRK-FTNKBN     NOT =   SPACE
               GO  TO  20070-FTNKBN-HENSYU-EXT
           END-IF
      *
      *    公費の編集
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       3
                   OR      COMB-KOHHKNNUM  (IDX)   =   SPACE
               IF      COMB-KOHHKNNUM  (IDX)   =   "027"
                   CONTINUE
               ELSE        
                   PERFORM VARYING IDY FROM    1   BY  1
                           UNTIL   IDY >       3
                           OR      RECE02-KOHNUM(IDY)  =   SPACE
                       IF      COMB-KOHHKNNUM(IDX) =
                                                   RECE02-KOHNUM(IDY)
                           MOVE    1           TO  WRK-KOHNUM (IDY)
                           MOVE    3           TO  IDY                
                       END-IF
                   END-PERFORM
               END-IF    
           END-PERFORM
      *???
      **     DISPLAY "RECE02(1)=" RECE02-KOHNUM (1) "(2)=" RECE02-KOHNUM (2)
      **             "(3)=" RECE02-KOHNUM (3) "##"
      **     DISPLAY "(1)=" WRK-KOHNUM (1) "(2)=" WRK-KOHNUM (2)
      **             "(3)=" WRK-KOHNUM (3) "##"
      *???                  
      *                                                      
      *    主保険があるとき      
           IF      COMB-HKNNUM        NOT =   SPACE
               IF      COMB-KOH1HKNNUM    NOT =   "027"
                   EVALUATE    WRK-KOHNUM (1) ALSO    WRK-KOHNUM (2)
                       WHEN    1              ALSO    ZERO
                           MOVE    "2"            TO  WRK-FTNKBN
                       WHEN    ZERO           ALSO    1
                           MOVE    "3"            TO  WRK-FTNKBN
                       WHEN    1              ALSO    1
                           MOVE    "4"            TO  WRK-FTNKBN
                   END-EVALUATE
               ELSE
      *    老人保険があるとき     
                   EVALUATE    WRK-KOHNUM (1) ALSO    WRK-KOHNUM (2)
                       WHEN    1              ALSO    ZERO
                           MOVE    "3"            TO  WRK-FTNKBN
                       WHEN    ZERO           ALSO    1
                           MOVE    "8"            TO  WRK-FTNKBN
                       WHEN    1              ALSO    1
                           MOVE    "A"            TO  WRK-FTNKBN
                   END-EVALUATE
               END-IF    
           ELSE
      *     
      *        公費単独（三種公費）のとき      
               IF      WRK-3SYU-KBN       =   ALL "1"  
                   EVALUATE    WRK-KOHNUM (1) ALSO    WRK-KOHNUM (2)
                       WHEN    1              ALSO    ZERO
                           MOVE    2              TO  WRK-FTNKBN
                       WHEN    ZERO           ALSO    1
                           MOVE    3              TO  WRK-FTNKBN
                       WHEN    1              ALSO    1
                           MOVE    4              TO  WRK-FTNKBN
                   END-EVALUATE
               ELSE    
      *                                                      
      *        公費単独（三種公費以外）のとき      
                   EVALUATE    WRK-KOHNUM (1) ALSO    WRK-KOHNUM (2)
                       WHEN    1              ALSO    ZERO
                           MOVE    "5"            TO  WRK-FTNKBN
                       WHEN    ZERO           ALSO    1
                           MOVE    "6"            TO  WRK-FTNKBN
                       WHEN    1              ALSO    1
                           MOVE    "7"            TO  WRK-FTNKBN
                   END-EVALUATE
               END-IF
           END-IF
      *???  
           IF      WRK-FTNKBN    =   SPACE
               DISPLAY "DTNKBN ERR " RECE02-PTNUM "##"
           END-IF
      *???              
           .
       20070-FTNKBN-HENSYU-EXT.
           EXIT. 
      *
      *****************************************************************
      *    剤　明細テーブル退避処理
      *****************************************************************
       20071-ZAI-TAIHI-SEC    SECTION.
      *
           INITIALIZE                      TBL-ZAIW-AREA
                                           TBL-KOUI-AREA
                                           TBL-COMMENT-AREA
      *
           MOVE    ZERO                TO  WRK-ZAIWMAX
           MOVE    ZERO                TO  WRK-TBLMAX1
                                           WRK-TBLMAX6
                                           WRK-TBLMAX7
                                           WRK-TBLMAX8
                                           FLG-TEIGEN
                                           FLG-YKZ20
      *                                     
           MOVE    RECE041-SRYKBN      TO  WRK-SRYKBN                                
      *
           INITIALIZE                      RECE05-REC
           MOVE    RECE041-HOSPID       TO  RECE05-HOSPID
           MOVE    RECE041-SRYYM        TO  RECE05-SRYYM
           MOVE    RECE041-NYUGAIKBN    TO  RECE05-NYUGAIKBN
           MOVE    RECE041-PTID         TO  RECE05-PTID
           MOVE    RECE041-RECEKA       TO  RECE05-RECEKA
           MOVE    RECE041-TEISYUTUSAKI TO  RECE05-TEISYUTUSAKI
           MOVE    RECE041-RECESYUBETU  TO  RECE05-RECESYUBETU
           MOVE    RECE041-HKNJANUM     TO  RECE05-HKNJANUM
           MOVE    RECE041-TEKSTYMD     TO  RECE05-TEKSTYMD
           MOVE    RECE041-ZAINUM       TO  RECE05-ZAINUM
           START   RECE05-FILE
               KEY IS    >=   RECE05-KEY
               INVALID
                   MOVE    1           TO  FLG-RECE05
               NOT INVALID
                   PERFORM 990-RECE05-NEXT-SEC
           END-START
           PERFORM
               UNTIL  ( FLG-END              =   1                   )
               OR     ( FLG-RECE05           =   1                   )
               OR     ( RECE041-HOSPID    NOT =   RECE05-HOSPID       )
               OR     ( RECE041-SRYYM     NOT =   RECE05-SRYYM        )
               OR     ( RECE041-NYUGAIKBN NOT =   RECE05-NYUGAIKBN    )
               OR     ( RECE041-PTID      NOT =   RECE05-PTID         )
               OR     ( RECE041-RECEKA    NOT =   RECE05-RECEKA       )
               OR     ( RECE041-TEISYUTUSAKI
                                         NOT =   RECE05-TEISYUTUSAKI )
               OR     ( RECE041-RECESYUBETU
                                         NOT =   RECE05-RECESYUBETU  )
               OR     ( RECE041-HKNJANUM  NOT =   RECE05-HKNJANUM     )
               OR     ( RECE041-TEKSTYMD  NOT =   RECE05-TEKSTYMD     )
               OR     ( RECE041-ZAINUM    NOT =   RECE05-ZAINUM       )
      *
               PERFORM   VARYING   IDX   FROM    1   BY  1
                         UNTIL   ( IDX               >   5     )
                         OR      ( RECE05-SRYCD(IDX) =   SPACE )
                         OR      ( FLG-END           =   1     ) 
      *
                   EVALUATE    RECE05-SRYCD (IDX) (1:1)
                       WHEN    "0"
                       WHEN    "8"
                           PERFORM 200711-COMMENT-TAIHI-SEC
                       WHEN    "1"
                           PERFORM 200711-KOUI-TAIHI-SEC
                       WHEN    "6" 
                           PERFORM 200711-YKZ-TAIHI-SEC
                       WHEN    OTHER
                           PERFORM 200711-ELSE-TAIHI-SEC
                   END-EVALUATE
               END-PERFORM
      *
               PERFORM 990-RECE05-NEXT-SEC
           END-PERFORM
      *
           .
       20071-TBL-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    摘要データ（コメント）退避処理
      *****************************************************************
       200711-COMMENT-TAIHI-SEC       SECTION.
      *
      *    診療行為コード＝'０'のとき対象外出力しない
           IF      RECE05-SRYCD (IDX) (1:1) =   "0"
               IF      RECE05-SRYCD (IDX)(1:3)  =   "001"   OR  "002"
                   CONTINUE
               ELSE
                   GO  TO  200711-COMMENT-TAIHI-EXT
               END-IF
           END-IF    
      *
           ADD     1                   TO  WRK-TBLMAX8
      *               
           IF      WRK-TBLMAX8         >   10
               MOVE    "*** ORCR0300 COMMENT TABLE  OVER  ***"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           ELSE
               MOVE    RECE05-SRYCD (IDX)  TO
                                   TBL-COMMENT-SRYCD (WRK-TBLMAX8)
               MOVE    RECE05-NAME  (IDX)  TO
                                   TBL-COMMENT-NAME  (WRK-TBLMAX8)
      *                             
               IF      RECE05-SRYCD (IDX) (1:1) =   "0"
      *            部位／薬剤
                   MOVE    "810000001"     TO  
                                   TBL-COMMENT-SRYCD (WRK-TBLMAX8)
               ELSE 
                   IF      RECE05-INPUTNUM(IDX)    NOT =   ZERO
                       MOVE    RECE02-HOSPID           TO  PTCOM-HOSPID
                       MOVE    RECE02-PTID             TO  PTCOM-PTID
                       MOVE    RECE05-ZAINUM           TO  PTCOM-ZAINUM
                       MOVE    RECE05-SRYCD   (IDX)    TO  PTCOM-SRYCD
                       MOVE    RECE05-INPUTNUM(IDX)    TO  PTCOM-RENNUM
                       PERFORM 950-PTCOM-READ-SEC
                       MOVE    SPACE               TO
                                       TBL-COMMENT-NAME (WRK-TBLMAX8)  
                       STRING  PTCOM-INPUTCHI1     DELIMITED  BY  SPACE
                               PTCOM-INPUTCHI2     DELIMITED  BY  SPACE
                               PTCOM-INPUTCHI3     DELIMITED  BY  SPACE
                               PTCOM-INPUTCHI4     DELIMITED  BY  SPACE
                               INTO    TBL-COMMENT-NAME (WRK-TBLMAX8)
                       END-STRING
                   END-IF    
               END-IF
           END-IF
           .
       200711-COMMENT-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    摘要データ（診療行為／告示等識別区分による並びかえ）退避処理
      *****************************************************************
       200711-KOUI-TAIHI-SEC          SECTION.
      *
           ADD     1                   TO  WRK-TBLMAX1
      *     
           IF      WRK-TBLMAX1         >   30
               MOVE    "*** ORCR0300 KOUI TABLE OVER  ***"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
           ELSE
               MOVE    RECE05-SRYCD    (IDX)   TO
                                   TBL-KOUI-SRYCD   (WRK-TBLMAX1)
               MOVE    RECE05-SRYSURYO (IDX)   TO
                                   TBL-KOUI-SRYSURYO(WRK-TBLMAX1)
               INITIALIZE                  TNS-TENSU-REC
               MOVE    RECE05-SRYCD (IDX)      TO  TNS-SRYCD
               PERFORM 900-TENSU-READ-SEC
               IF      FLG-TENSU           =   ZERO
                   MOVE    TNS-KOKUJISKBKBN1   TO
                                   TBL-KOUI-KOKUJISKBKBN1(WRK-TBLMAX1)
                   MOVE    TNS-CDKBN-SYO       TO
                                   TBL-KOUI-CDKBN-SYO    (WRK-TBLMAX1)
                   MOVE    TNS-CDKBN-BU        TO
                                   TBL-KOUI-CDKBN-BU     (WRK-TBLMAX1)
                   MOVE    TNS-CDKBN-KBN       TO
                                   TBL-KOUI-CDKBN-KBN    (WRK-TBLMAX1)
                   MOVE    TNS-CDKBN-KBNNUM    TO
                                   TBL-KOUI-CDKBN-KBNNUM (WRK-TBLMAX1)
                   MOVE    TNS-CDKBN-KBNNUM-EDA TO
                               TBL-KOUI-CDKBN-KBNNUM-EDA (WRK-TBLMAX1)
                   MOVE    TNS-CDKBN-KOUBAN    TO
                                   TBL-KOUI-CDKBN-KOUBAN (WRK-TBLMAX1)
                   MOVE    TNS-KOUHYOJYUNNUM   TO
                                   TBL-KOUI-KOUHYOJUNNUM (WRK-TBLMAX1)
               END-IF                    
           END-IF
           .
       200711-KOUI-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    摘要データ（薬剤）退避処理
      *****************************************************************
       200711-YKZ-TAIHI-SEC          SECTION.
      *
      *    20点以下の場合編集しない
           IF      FLG-YKZ20          =   1
               CONTINUE
           ELSE    
      *        --- 薬剤点数20点以下の場合 ---（投薬／注射）
               IF    (     ( RECE041-SRYKBN =   "21"  OR  "22"  OR
                                                         "23"     )
                       AND ( FLG-TEIGEN    =   ZERO               )
                       AND ( RECE041-ZAITEN <=  20                 ) )
               OR    (     ( RECE041-SRYKBN =   "31"  OR  "32"  OR
                                                         "33"     )
                       AND ( RECE041-ZAITEN <=  20                 ) )
                   MOVE    1               TO  FLG-YKZ20
               END-IF
               PERFORM 200711-ELSE-TAIHI-SEC    
           END-IF    
           .
       200711-YKZ-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    摘要データ（その他）退避処理
      *****************************************************************
       200711-ELSE-TAIHI-SEC          SECTION.
      *                                   
           ADD     1                   TO  WRK-ZAIWMAX
      *
           IF      WRK-ZAIWMAX         =   1
               IF      RECE05-SRYCD (WRK-ZAIWMAX)
                                       =   WRK-CONS-TEIGEN
                   MOVE    1               TO  FLG-TEIGEN
               END-IF
           END-IF
      *     
           IF      WRK-ZAIWMAX         >   100
               MOVE    "*** ORCR0300 TABLE 100 OVER  ***"
                                           TO  WRK-RECEERR
               PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
           ELSE
               IF      RECE05-SRYCD (IDX)(1:1) =   "6"
               AND     FLG-YKZ20               =   1
                   IF      RECE041-SRYKBN =   "21"  OR  "22" 
                       MOVE    WRK-CONS-NAI205         TO
                                   TBL-ZAIW-SRYCD      (WRK-ZAIWMAX)
                   END-IF                
                   IF      RECE041-SRYKBN =   "23" 
                       MOVE    WRK-CONS-GAI205         TO
                                   TBL-ZAIW-SRYCD      (WRK-ZAIWMAX)
                   END-IF                
                   IF      RECE041-SRYKBN (1:1)    =   "3" 
                       MOVE    WRK-CONS-CHU205         TO
                                   TBL-ZAIW-SRYCD      (WRK-ZAIWMAX)
                   END-IF                
               ELSE    
                   MOVE    RECE05-SRYCD      (IDX) TO
                                   TBL-ZAIW-SRYCD      (WRK-ZAIWMAX)
                   MOVE    RECE05-SRYSURYO   (IDX) TO
                                   TBL-ZAIW-SRYSURYO   (WRK-ZAIWMAX)
                   MOVE    RECE05-TANICD     (IDX) TO
                                   TBL-ZAIW-TANICD     (WRK-ZAIWMAX)
                   MOVE    RECE05-TENSIKIBETU(IDX) TO
                                   TBL-ZAIW-TENSIKIBETU(WRK-ZAIWMAX)
                   MOVE    RECE05-TEN        (IDX) TO
                                   TBL-ZAIW-TEN        (WRK-ZAIWMAX)
               END-IF                            
           END-IF
      *
           EVALUATE    TBL-ZAIW-SRYCD (WRK-ZAIWMAX) (1:1)
               WHEN    "6"
                   MOVE    WRK-ZAIWMAX      TO  WRK-TBLMAX6
               WHEN    "7"
                   MOVE    WRK-ZAIWMAX      TO  WRK-TBLMAX7
           END-EVALUATE 
           .
       200711-ELSE-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    摘要データ（診療行為）並び替え処理
      *****************************************************************
       20074-ZAI-KOUI-SORT-SEC          SECTION.
      *
           IF      WRK-TBLMAX1          =   1
               GO  TO  20074-ZAI-KOUI-SORT-EXT
           END-IF
      *              
      *    診療行為データの編集
           COMPUTE IDY     =   WRK-TBLMAX1   -   1
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       IDY     
               COMPUTE IDZ     =   IDX     +   1
               PERFORM VARYING IDW FROM    IDZ   BY  1
                       UNTIL   IDW >       WRK-TBLMAX1     
                   IF      TBL-KOUI-KEY (IDX)    >   TBL-KOUI-KEY (IDW)
                       MOVE    TBL-KOUI-REC (IDX)    TO
                                             TBL-KOUI-SORT
                       MOVE    TBL-KOUI-REC (IDW)    TO
                                             TBL-KOUI-REC (IDX)
                       MOVE    TBL-KOUI-SORT         TO
                                             TBL-KOUI-REC (IDW)
                   END-IF
               END-PERFORM                              
           END-PERFORM
           .
       20074-ZAI-KOUI-SORT-EXT.
           EXIT.
      *
      *****************************************************************
      *    摘要データ編集処理
      *****************************************************************
       20072-ZAI-HENSYU-SEC          SECTION.
      *     
      *    コメントデータの編集
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       WRK-TBLMAX8     
      *
               MOVE    SPACE               TO  WRK-REC
               MOVE    ZERO                TO  WRK-REC-LENGTH
      *          
               MOVE    "CO,"               TO  WRK-REC
               MOVE    3                   TO  WRK-REC-LENGTH
      *        診療識別
               IF      IDX                 =   1
               AND     WRK-SRYKBN      NOT =   SPACE     
                   MOVE    WRK-SRYKBN          TO  WRK-DATA
                   MOVE    2                   TO  WRK-NAGASA
                   MOVE    SPACE               TO  WRK-SRYKBN
               END-IF    
               PERFORM 5004-MOJI-HENSYU-SEC  
      *        負担区分
               MOVE    WRK-FTNKBN          TO  WRK-DATA
               MOVE    1                   TO  WRK-NAGASA
               PERFORM 5004-MOJI-HENSYU-SEC  
      *        コメントコード
               MOVE    TBL-COMMENT-SRYCD (IDX)
                                           TO  WRK-DATA
               MOVE    9                   TO  WRK-NAGASA
               PERFORM 5004-MOJI-HENSYU-SEC  
      *        文字データ
               MOVE    TBL-COMMENT-NAME(IDX)
                                           TO  WRK-DATA
               MOVE    76                  TO  WRK-NAGASA
               MOVE    1                   TO  WRK-END 
               PERFORM 5004-MOJI-HENSYU-SEC  
      *
               PERFORM 5001-FILE-WRITE-SEC
           END-PERFORM
      *     
      *    診療行為データの編集
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       WRK-TBLMAX1     
      *
               MOVE    SPACE               TO  WRK-REC
               MOVE    ZERO                TO  WRK-REC-LENGTH
      *          
               MOVE    "SI,"               TO  WRK-REC
               MOVE    3                   TO  WRK-REC-LENGTH
      *        診療識別
               IF      IDX                 =   1
               AND     WRK-SRYKBN      NOT =   SPACE     
                   MOVE    WRK-SRYKBN          TO  WRK-DATA
                   MOVE    2                   TO  WRK-NAGASA
                   MOVE    SPACE               TO  WRK-SRYKBN
               END-IF    
               PERFORM 5004-MOJI-HENSYU-SEC  
      *        負担区分
               MOVE    WRK-FTNKBN          TO  WRK-DATA
               MOVE    1                   TO  WRK-NAGASA
               PERFORM 5004-MOJI-HENSYU-SEC  
      *        診療行為コード
               MOVE    TBL-KOUI-SRYCD (IDX)
                                           TO  WRK-DATA
               MOVE    9                   TO  WRK-NAGASA
               PERFORM 5004-MOJI-HENSYU-SEC  
      *        数量
               IF      RECE041-SRYKBN(1:1)     =   "1" OR  "2" OR "3"
               AND     TBL-KOUI-SRYSURYO (IDX) <=  1   
                   CONTINUE
               ELSE    
                   IF      TBL-KOUI-SRYSURYO (IDX)  >   ZERO
                       MOVE    TBL-KOUI-SRYSURYO (IDX)
                                                TO  WRK-SURYO
                       MOVE    WRK-SURYO        TO  WRK-NUM
                       MOVE    8                TO  WRK-NAGASA
                   END-IF
               END-IF    
               PERFORM 5005-NUM-HENSYU-SEC  
      *        点数 
               IF      IDX               =   WRK-TBLMAX1
                   IF      RECE041-SYUTEN1       >   ZERO
                       MOVE    RECE041-SYUTEN1   TO  WRK-TENSU
                       MOVE    WRK-TENSU         TO  WRK-NUM
                       MOVE    7                 TO  WRK-NAGASA
                   END-IF
               END-IF    
               PERFORM 5005-NUM-HENSYU-SEC  
      *        回数
               IF      IDX               =   WRK-TBLMAX1
                   IF      RECE041-ZAIKAISU      >   ZERO
                       MOVE    RECE041-ZAIKAISU  TO  WRK-KAISU
                       MOVE    WRK-KAISU         TO  WRK-NUM
                       MOVE    3                 TO  WRK-NAGASA
                   END-IF
               END-IF    
               MOVE    1                   TO  WRK-END 
               PERFORM 5005-NUM-HENSYU-SEC  
      *
               PERFORM 5001-FILE-WRITE-SEC
           END-PERFORM
      *
      *    医薬品／特定機材データの編集                 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       WRK-ZAIWMAX
               EVALUATE    TBL-ZAIW-SRYCD (IDX)(1:1)
                   WHEN    "6"
                       PERFORM 200722-YKZ-HENSYU-SEC
                   WHEN    "7"
                       PERFORM 200723-KIZAI-HENSYU-SEC
               END-EVALUATE
           END-PERFORM            
           .
       20072-ZAI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    摘要データ（医薬品）編集処理
      *****************************************************************
       200722-YKZ-HENSYU-SEC         SECTION.
      *
           MOVE    SPACE               TO  WRK-REC
           MOVE    ZERO                TO  WRK-REC-LENGTH
      *          
           MOVE    "IY,"               TO  WRK-REC
           MOVE    3                   TO  WRK-REC-LENGTH
      *    診療識別
           IF      IDX                 =   1
           AND     WRK-SRYKBN      NOT =   SPACE     
               MOVE    WRK-SRYKBN          TO  WRK-DATA
               MOVE    2                   TO  WRK-NAGASA
               MOVE    SPACE               TO  WRK-SRYKBN
           END-IF    
           PERFORM 5004-MOJI-HENSYU-SEC  
      *    負担区分
           MOVE    WRK-FTNKBN          TO  WRK-DATA
           MOVE    1                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC  
      *    医薬品コード
           MOVE    TBL-ZAIW-SRYCD (IDX)
                                       TO  WRK-DATA
           MOVE    9                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC  
      *    使用量
           IF      TBL-ZAIW-SRYSURYO (IDX) >   ZERO
               MOVE    TBL-ZAIW-SRYSURYO (IDX) TO  WRK-SRYSURYO
               MOVE    WRK-SRYSURYO            TO  WRK-NUM
               MOVE    9                       TO  WRK-NAGASA
               MOVE    3                       TO  WRK-SYOSUU     
           END-IF        
           PERFORM 5005-NUM-HENSYU-SEC  
      *    点数 
           IF      IDX                 =   WRK-TBLMAX6
               IF      RECE041-YKZTEN      >   ZERO
                   MOVE    RECE041-YKZTEN      TO  WRK-NUM
                   MOVE    7                   TO  WRK-NAGASA
               END-IF
           END-IF        
           PERFORM 5005-NUM-HENSYU-SEC  
      *    回数
           IF      IDX                 =   WRK-TBLMAX6
               IF      RECE041-ZAIKAISU    >   ZERO
                   MOVE    RECE041-ZAIKAISU    TO  WRK-KAISU
                   MOVE    WRK-KAISU           TO  WRK-NUM
                   MOVE    3                   TO  WRK-NAGASA
               END-IF
           END-IF        
           MOVE    1                   TO  WRK-END 
           PERFORM 5005-NUM-HENSYU-SEC  
      *
           PERFORM 5001-FILE-WRITE-SEC
           .
       200722-YKZ-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    摘要データ（特定機材）編集処理
      *****************************************************************
       200723-KIZAI-HENSYU-SEC         SECTION.
      *
           MOVE    SPACE               TO  WRK-REC
           MOVE    ZERO                TO  WRK-REC-LENGTH
      *          
           MOVE    "TO,"               TO  WRK-REC
           MOVE    3                   TO  WRK-REC-LENGTH
      *    診療識別
           IF      IDX                 =   1
           AND     WRK-SRYKBN      NOT =   SPACE     
               MOVE    WRK-SRYKBN          TO  WRK-DATA
               MOVE    2                   TO  WRK-NAGASA
               MOVE    SPACE               TO  WRK-SRYKBN
           END-IF    
           PERFORM 5004-MOJI-HENSYU-SEC  
      *    負担区分
           MOVE    WRK-FTNKBN          TO  WRK-DATA
           MOVE    1                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC  
      *    特定器材コード
           MOVE    TBL-ZAIW-SRYCD (IDX)
                                       TO  WRK-DATA
           MOVE    9                   TO  WRK-NAGASA
           PERFORM 5004-MOJI-HENSYU-SEC  
      *    使用量
           IF      TBL-ZAIW-SRYSURYO (IDX)     >   ZERO
               MOVE    TBL-ZAIW-SRYSURYO (IDX) TO  WRK-SRYSURYO
               MOVE    WRK-SRYSURYO            TO  WRK-NUM
               MOVE    9                       TO  WRK-NAGASA
               MOVE    3                       TO  WRK-SYOSUU
           END-IF        
           PERFORM 5005-NUM-HENSYU-SEC  
      *    点数 
           IF      IDX                     =   WRK-TBLMAX7
               IF      RECE041-KIZAITEN    >   ZERO
                   MOVE    RECE041-KIZAITEN    TO  WRK-TENSU
                   MOVE    WRK-TENSU           TO  WRK-NUM
                   MOVE    7                   TO  WRK-NAGASA
               END-IF
           END-IF        
           PERFORM 5005-NUM-HENSYU-SEC  
      *    回数
           IF      IDX                     =   WRK-TBLMAX7
               IF      RECE041-ZAIKAISU    >   ZERO
                   MOVE    RECE041-ZAIKAISU    TO  WRK-NUM
                   MOVE    3                   TO  WRK-NAGASA
               END-IF
           END-IF        
           PERFORM 5005-NUM-HENSYU-SEC
      *    単位コード
           IF      TBL-ZAIW-TANICD (IDX)       >   ZERO
               MOVE    TBL-ZAIW-TANICD (IDX)   TO  WRK-NUM
               MOVE    3                       TO  WRK-NAGASA
           END-IF        
           PERFORM 5005-NUM-HENSYU-SEC  
      *    単価
           IF      TBL-ZAIW-TENSIKIBETU (IDX)  =   1       
               IF      TBL-ZAIW-TEN (IDX)  >   ZERO
                   MOVE    TBL-ZAIW-TEN(IDX)   TO  WRK-TANKA
                   MOVE    WRK-TANKA           TO  WRK-NUM
                   MOVE    10                  TO  WRK-NAGASA
                   MOVE    2                   TO  WRK-SYOSUU
               END-IF
           END-IF        
           PERFORM 5005-NUM-HENSYU-SEC  
      *    特定器材名称
           MOVE    1                   TO  WRK-END 
           PERFORM 5004-MOJI-HENSYU-SEC
      *
           PERFORM 5001-FILE-WRITE-SEC
           .
       200723-KIZAI-HENSYU-EXT.
           EXIT.
      * 
      *****************************************************************
      *    合計レコード編集処理
      *****************************************************************
       2008-HENSYU-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-REC
           MOVE    ZERO                TO  WRK-REC-LENGTH
      *          
           MOVE    "GO,"               TO  WRK-REC
           MOVE    3                   TO  WRK-REC-LENGTH
      *
           MOVE    SUM-TOTALKENSU      TO  WRK-NUM
           MOVE    6                   TO  WRK-NAGASA
           PERFORM 5005-NUM-HENSYU-SEC
      *
           MOVE    SUM-TOTALTEN        TO  WRK-NUM
           MOVE    10                  TO  WRK-NAGASA
           PERFORM 5005-NUM-HENSYU-SEC
      *
           MOVE    99                  TO  WRK-DATA
           MOVE    2                   TO  WRK-NAGASA
           MOVE    1                   TO  WRK-END 
           PERFORM 5004-MOJI-HENSYU-SEC
      *
           PERFORM 5001-FILE-WRITE-SEC
           .
       2008-HENSYU-EXT.
           EXIT. 
057400*
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   RECE30-FILE
                   RECE02-FILE
                   RECE03-FILE
                   RECE041-FILE
                   RECE05-FILE
      *
           IF      CNT-OUT            =   ZERO
               IF      WRK-PARA-TEISYUTUSAKI  =   "1"  
                   MOVE    "社保レセ電の対象データがありませんでした"
                                          TO  WRK-RECEERR
               ELSE                           
                   MOVE    "国保レセ電の対象データがありませんでした"
                                          TO  WRK-RECEERR
               END-IF                           
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
           DISPLAY "RECE02  CNT " CNT-IN  
           DISPLAY "RECE30  CNT " CNT-OUT  
           DISPLAY "*** ORCR0300 END ***"
      *     ACCEPT  WRK-IN FROM CONSOLE 
      *
           .
       300-TERM-EXT.
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
           .
       500-ERR-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    ファイル出力処理
      *****************************************************************
       5001-FILE-WRITE-SEC        SECTION.
      *
      *    改行コード編集 
           STRING  WRK-REC(1:WRK-REC-LENGTH) DELIMITED  BY  SIZE
                   WRK-KAIGYO                DELIMITED  BY  SIZE
                   INTO        WRK-REC
           END-STRING        
      *
           MOVE    WRK-REC             TO  RECE30-R         
           WRITE   RECE30-R
           ADD     1                   TO  CNT-OUT
           .
       5001-FILE-WRITE-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   SPACE
               MOVE    ZERO                TO  WRK-SYMD
           END-IF    
      *
           IF      WRK-SYMD            =   ALL "9"  OR   ZERO
               MOVE    WRK-SYMD            TO  WRK-HENYMDG
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY1-AREA
               MOVE    "11"                TO  LNK-DAY1-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY1-YMD
               CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                                   LNK-DAY1-AREA
               MOVE    LNK-DAY1-YMD        TO  WRK-HENYMDG
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    右ずめ編集処理
      *****************************************************************
       5003-DATA-RIGHT-HENSYU-SEC          SECTION.
      *
           MOVE    SPACE          TO  WRK-HENSYU
      *              
           IF      WRK-HENKAN     =   SPACE
               CONTINUE
           ELSE    
               PERFORM VARYING IDX FROM    WRK-LENGTH  BY  -1
                       UNTIL   IDX <       1
                   IF      WRK-HENKAN (IDX:1)  NOT =   SPACE
                       COMPUTE IDZ     =   WRK-LENGTH  -   IDX +   1
                       MOVE    WRK-HENKAN (1:IDX)
                                           TO  WRK-HENSYU (IDZ:)
                       MOVE    WRK-HENSYU  TO  WRK-HENKAN                            
                       MOVE    1           TO  IDX
                   END-IF
               END-PERFORM
           END-IF    
      *
           .
       5003-DATA-RIGHT-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    出力レコード処理（文字）
      *****************************************************************
       5004-MOJI-HENSYU-SEC          SECTION.
      *
           IF      WRK-DATA        =   SPACE
               CONTINUE
           ELSE                   
               PERFORM VARYING IDW FROM    WRK-NAGASA  BY  -1
                       UNTIL   IDW <       1
                   IF      WRK-DATA (IDW:1)   NOT =   SPACE
                       STRING  WRK-REC(1:WRK-REC-LENGTH) DELIMITED
                                                             BY  SIZE
                               WRK-DATA(1:IDW)           DELIMITED
                                                             BY  SIZE
                               INTO        WRK-REC
                       END-STRING
                       ADD     IDW                 TO  WRK-REC-LENGTH        
                       MOVE    1                   TO  IDW
                   END-IF
               END-PERFORM
           END-IF
      *     
           IF      WRK-END         =   ZERO
               STRING  WRK-REC(1:WRK-REC-LENGTH) DELIMITED  BY  SIZE
                       WRK-KUGIRI                DELIMITED  BY  SIZE
                       INTO        WRK-REC
               END-STRING        
               ADD     1                   TO  WRK-REC-LENGTH
           END-IF    
      *
           INITIALIZE                      WRK-HENSYU-AREA
           .
       5004-MOJI-HENSYU-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    出力レコード処理（数字）ZZZZZZZZZ9.999の編集
      *****************************************************************
       5005-NUM-HENSYU-SEC          SECTION.
      *
           IF      WRK-NAGASA          =   ZERO
               CONTINUE
           ELSE                   
      *        開始位置
               COMPUTE WRK-ST  =   11      -   WRK-NAGASA
               IF      WRK-SYOSUU          >   ZERO
                   COMPUTE WRK-ST  =   WRK-ST  +   WRK-SYOSUU
                                               +   1
               END-IF                                
      *     
               PERFORM VARYING IDW FROM    WRK-ST    BY  1
                       UNTIL   IDW >       10
                   IF      WRK-NUM (IDW:1)   NOT =   SPACE
                        COMPUTE IDZ     =    11  +   WRK-SYOSUU
                                                 -   IDW       
                        IF      WRK-SYOSUU       >   ZERO
                            ADD     1                TO  IDZ
                        END-IF     
                        STRING  WRK-REC(1:WRK-REC-LENGTH)
                                                 DELIMITED  BY  SIZE
                               WRK-NUM(IDW:IDZ)  DELIMITED  BY  SIZE
                               INTO        WRK-REC
                       END-STRING
                       COMPUTE WRK-REC-LENGTH    =   WRK-REC-LENGTH   +
                                                     IDZ                  
                       MOVE    10                TO  IDW
                   END-IF
               END-PERFORM
           END-IF    
      *     
           IF      WRK-END         =   ZERO
               STRING  WRK-REC(1:WRK-REC-LENGTH) DELIMITED  BY  SIZE
                       WRK-KUGIRI                DELIMITED  BY  SIZE
                       INTO        WRK-REC
               END-STRING        
               ADD     1                   TO  WRK-REC-LENGTH
           END-IF    
      *
           INITIALIZE                      WRK-HENSYU-AREA
           .
       5005-NUM-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスタ読込
      *****************************************************************
       910-HKNCOMBI-INV-SEC         SECTION.
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
                   MOVE    ZERO                TO  FLG-HKNCOMBI
                   MOVE    MCPDATA-REC         TO  HKNCOMBI-REC
               ELSE
                   MOVE    1                   TO  FLG-HKNCOMBI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-HKNCOMBI
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *????
           IF      FLG-HKNCOMBI        =   1
               DISPLAY "HKNCOMBI INV " COMB-HOSPID " " COMB-PTID " "
                                       COMB-HKNCOMBINUM " "    
           END-IF
      *???? 
      *
           .
       910-HKNCOMBI-INV-EXT.
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
      *****************************************************************
      *    病名マスター読込
      *****************************************************************
       900-BYOMEI-READ-SEC         SECTION.
      *
      *
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "BYOMEI-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "BYOMEI-KEY"           TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  BYOMEI-REC
                   MOVE    ZERO                TO  FLG-BYOMEI
               ELSE
                   MOVE    1                   TO  FLG-BYOMEI
                   INITIALIZE                  BYOMEI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-BYOMEI
               INITIALIZE                  BYOMEI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "BYOMEI-KEY"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-BYOMEI-READ-EXT.
           EXIT.
      *****************************************************************
      *    点数マスタ検索処理
      *****************************************************************
       900-TENSU-READ-SEC               SECTION.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           MOVE    WRK-PARA-SYSYMD     TO  ORC-DBYMD
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
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
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
      *
       900-TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者コメントマスタ読み込み
      *****************************************************************
       950-PTCOM-READ-SEC           SECTION.
      *
           MOVE    PTCOM-REC           TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTCOM-REC
                   MOVE    ZERO                TO  FLG-PTCOM
               ELSE
                   MOVE    1                   TO  FLG-PTCOM
                   INITIALIZE                  PTCOM-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTCOM
               INITIALIZE                  PTCOM-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTCOM-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       950-PTCOM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト明細書読込
      *****************************************************************
       900-RECE02-READ-SEC             SECTION.
      *
           READ    RECE02-FILE     NEXT
               AT  END
                   MOVE    1           TO  FLG-END
                   MOVE    HIGH-VALUE  TO KEY-NEW
               NOT AT  END
                   IF      RECE02-TEISYUTUSAKI
                                       NOT =   WRK-PARA-TEISYUTUSAKI
                   OR      RECE02-PTNUM    =   SPACE
                   OR      RECE02-RECESYUBETU
                                           =   ZERO                  
                           GO  TO  900-RECE02-READ-SEC
                   END-IF                       
                   ADD     1           TO  CNT-IN
      *************MOVE    RECE02-TEISYUTUSAKI
      *************                    TO  KEY-N-TEISYUTUSAKI
                   MOVE    RECE02-RECEKA 
                                       TO  KEY-N-SRYKA
           END-READ
           .
       910-RECE02-READ-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０３１データ読み
      ****************************************************************
       990-RECE03-NEXT-SEC           SECTION.
      *
           READ    RECE03-FILE      NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE03
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE03
           END-READ
      *
           .
       990-RECE03-NEXT-EXT.
           EXIT.
      *
      ****************************************************************
      *    レセプト０４データ読み
      ****************************************************************
       990-RECE041-NEXT-SEC           SECTION.
      *
           READ    RECE041-FILE       NEXT
               AT  END
                   MOVE    1         TO  FLG-RECE04
               NOT AT  END
                   MOVE    ZERO      TO  FLG-RECE04
           END-READ
      *
           .
       990-RECE041-NEXT-EXT.
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
