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
       PROGRAM-ID.             ORCR0830.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : レセプト入院（労災・自賠責）
      *  コンポーネント名  : 診療実日数編集
      *  管理者            : 
      *  作成日付    作業者        記述
      *  03/06/17    NaCl−門脇    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION           SECTION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
           SELECT  RECE82-FILE     ASSIGN  RECE82PARA
                                   ORGANIZATION    IS  INDEXED
                                   ACCESS  MODE    IS  DYNAMIC
                                   RECORD  KEY     IS  RECE82-KEY
                                   FILE    STATUS  IS  STS-RECE82.
      *    エラーファイル
           SELECT  RECEERR-FILE    ASSIGN  RECEERR
                                   FILE    STATUS  IS  STS-RECEERR.
      *
       DATA                    DIVISION.
       FILE                    SECTION.
      *
       FD  RECE82-FILE.
       01  RECE82-REC.
           COPY    "CPRCF082.INC".
      *
      *    エラーファイル
       FD  RECEERR-FILE.
       01  RECEERR-REC             PIC X(200).
      *
       WORKING-STORAGE             SECTION.
      *
      *     レセプト明細ファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01//
                                   BY         //RECE82//.
      *
      *    エラーファイル 名称領域 
           COPY    "CPCOMMONDAT2.INC"
                                   REPLACING  //RECE01PARA//
                                   BY         //RECEERR//.
           03  FILLER              PIC X(04)   VALUE   ".dat".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-RECE82                              PIC X(02).
           03  STS-RECEERR                             PIC X(02).
      *
       01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
           03  FLG-SHOSAISIN                           PIC 9(01).
           03  FLG-NYUINACCT                           PIC 9(01).
           03  FLG-NYUINACT                            PIC 9(01).
           03  FLG-SRYACCT                             PIC 9(01).
           03  FLG-SRYACT                              PIC 9(01).
           03  FLG-NYUKHN                              PIC 9(01).
           03  FLG-TENSU                               PIC 9(01).
           03  FLG-ARI                                 PIC 9(01).
           03  FLG-SYSKANRI                            PIC 9(01).
           03  FLG-NYURYAKUSHO                         PIC 9(01).
           03  FLG-GAIHAKU                             PIC 9(01).
           03  FLG-MIJISI-GENSAN                       PIC 9(01).
           03  FLG-MIJISI-INNAI                        PIC 9(01).
           03  FLG-MIJISI-IRYO                         PIC 9(01).
           03  FLG-MIJISI-JYOKU                        PIC 9(01).
           03  FLG-KYUKYU                              PIC 9(01).
           03  FLG-SET                                 PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-IN                                  PIC 9(06).
           03  CNT-MOD                                 PIC 9(06).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                                     PIC 9(03).
           03  IDY                                     PIC 9(03).
           03  IDX1                                    PIC 9(03).
           03  IDX2                                    PIC 9(03).
           03  NYUINACT-IDX                            PIC 9(03).
           03  NYUINACT-IDX2                           PIC 9(03).
           03  SRYACT-IDX                              PIC 9(03).
           03  ID1                                     PIC 9(03).
           03  GENSAN-IDX                              PIC 9(03).
           03  SYSKAN-IDX                              PIC 9(03).
      *
      *    実日数カウント用領域
       01  TBL-JNISSU.
           03  TBL-JNISSU-DAY                          PIC X(01)
                                                       OCCURS   31.
      *    合計点数（診療行為）集計用領域
       01  TOTAL-ACCT.
           03  TOTALTEN-ACCT                           PIC S9(08).
           03  TOTALKIN-ACCT                           PIC  9(08).
           03  TOTALKIN2-ACCT                          PIC  9(08).
      *
      *    手技点・薬剤等点数用領域
       01  TBL-TENSUG-JI.
           03  TBL-TENSU-JI                            OCCURS   31.
              05  TBL-SYUTEN-JI                        PIC  9(09).
              05  TBL-YKZTEN-JI                        PIC  9(09).
      *
       01  WRK-DAY-TABLE.
           03  WRK-DAY-T                               OCCURS   31.
               05  WRK-DAY1                            PIC 9(04).
               05  WRK-DAY1-NYUTENTTLKBN               PIC 9(03).
               05  WRK-DAY2                            PIC 9(04).
               05  WRK-DAY4                            PIC 9(04).
               05  WRK-DAY41                           PIC 9(04).
               05  WRK-DAY5                            PIC 9(04).
               05  WRK-DAY6                            PIC 9(04).
               05  WRK-DAY6-ZAITEN                     PIC 9(08).
               05  WRK-ACCT90                          PIC 9(08).
               05  WRK-ACCT-KASAN                      PIC S9(08).
               05  WRK-ROUNYUIN-JOUSU-KBN              PIC X(01).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-PARA.
               05  WRK-PARA-SRYYM                      PIC  X(06).
               05  WRK-PARA-TERMID                     PIC  X(16).
               05  WRK-PARA-SYSYMD                     PIC  X(08).
               05  WRK-PARA-JOBID                      PIC  9(07).
               05  WRK-PARA-SHELLID                    PIC  X(08).
      *
           03  WRK-SYS-SRYYMD                          PIC  X(08).
           03  WRK-KEISAN                              PIC  9(09).
      *
           03  WRK-TAIHI-FLG                           PIC  9(01).
           03  WRK-TAIHI-SRYYMD.
               05  WRK-TAIHI-SRYYM                     PIC  9(06).
               05  WRK-TAIHI-SRYD                      PIC  9(02).
      *
           03  WRK-TEN                                 PIC  9(09).
           03  WRK-KIN                                 PIC  9(09).
           03  WRK-KIN2                                PIC  9(09).
      *
           03  WRK-SINDAN-TUU                          PIC  9(02).
           03  WRK-SINDAN-KIN                          PIC  9(09).
           03  WRK-MEISAI-TUU                          PIC  9(02).
           03  WRK-MEISAI-KIN                          PIC  9(09).
      *
           03  WRK-KSNRATE                             PIC  9V99.
           03  WRK-TAXKBN                              PIC  X(01).
           03  WRK-TANKA                               PIC  9(02)V99.
      *    消費税端数区分
           03  WRK-TAX1001-KBN                         PIC  X(01).
      *
           03  WRK-ZAIKAISU-JI                         PIC  9(03).
           03  WRK-KEISAN-JI                           PIC  9(09).
           03  WRK-TEN-JI                              PIC  9(09).
      *
           03  WRK-KOYOMI-YMD                          PIC  9(08).
           03  WRK-KOYOMI2-YMD.
               05  WRK-KOYOMI2-YYMM                    PIC  9(06).
               05  WRK-KOYOMI2-DD                      PIC  9(02).
      *
       01  WRK-TENTEK.
           03  WRK-TENTEK-SYUTEN                       PIC 9(07).
           03  WRK-TENTEK-ZAIKAISU                     PIC 9(04).
           03  WRK-TENTEK-YKZTEN                       PIC 9(07).
           03  WRK-TENTEK-YKZTEN2                      PIC 9(07)
                                                       OCCURS   31.
           03  WRK-TENTEK-KIZAITEN                     PIC 9(07).
           03  WRK-TENTEK-KIZAITEN2                    PIC 9(07)
                                                       OCCURS   31.
           03  WRK-TENTEK-FLG                          PIC 9(01).
           03  WRK-TENTEK-FLG2                         PIC 9(01).
      *
       01  WRK-CONS-AREA.
      *    固定端末ＩＤ
           03  WRK-CONS-TERMID     PIC X(64)   VALUE
                                   "0100007FZZZZZZZZZZZZZZZZZZZZZZZZ".
      *
           03  WRK-RECEERR                             PIC X(200).
      *
      *    入院点数算定用ワークエリア
       01  WRK-NYUIN-TENSU-AREA.
           03  WRK-KHNTEN                              PIC 9(08).
           03  WRK-KHNTEN2                             PIC 9(08).
           03  WRK-KSNTEN                              PIC S9(08).
           03  WRK-NYUTENTTLKBN                        PIC 9(03).
           03  WRK-NYUKHNRYO                           PIC 9(09).
           03  WRK-NYUTOKRYO                           PIC 9(09).
           03  WRK-MIJISI                              PIC 9(09).
           03  WRK-SHOKUJIRYOYO                        PIC 9(01).
           03  WRK-TOKUKANRIKASAN                      PIC 9(01).
           03  WRK-SRYCD                               PIC 9(09).
           03  WRK-RYAKUSHO                            PIC X(14).
           03  WRK-SRYYMD                              PIC X(08).
           03  WRK-SRYYMD-TAIHI                        PIC X(08).
           03  WRK-GAIHAKU-SRYCD                       PIC X(09).
           03  WRK-GAIHAKU-KHNTEN                      PIC 9(08).
      *
      *    シスカン（５０００）退避用領域
       01  TBL-SYS5000-T.
           03  TBL-SYS5000-OCC     OCCURS  10.
               05  TBL-SYS5000                         PIC X(610).
      *
      *---------------------------------------------------------------
      *    固定値
       01  CONST-AREA.
           03  CONS-ROUSAI1    PIC X(09)   VALUE   "101110010".
           03  CONS-ROUSAI2    PIC X(09)   VALUE   "101110020".
           03  CONS-ROUSAI3    PIC X(09)   VALUE   "101130010".
           03  CONS-ROUSAI4    PIC X(09)   VALUE   "101130020".
           03  CONS-ROUSAI5    PIC X(09)   VALUE   "101130030".
           03  CONS-ROUSAI6    PIC X(09)   VALUE   "101130040".
           03  CONS-ROUSAI7    PIC X(09)   VALUE   "101130050".
           03  CONS-ROUSAI8    PIC X(09)   VALUE   "101130060".
           03  CONS-ROUSAI9    PIC X(09)   VALUE   "101130070".
           03  CONS-ROUSAI10   PIC X(09)   VALUE   "101130080".
           03  CONS-ROUSAI11   PIC X(09)   VALUE   "101130090".
           03  CONS-ROUSAI12   PIC X(09)   VALUE   "101130100".
      *
           03  CONS-ROUSAI13   PIC X(09)   VALUE   "101910010".
           03  CONS-ROUSAI14   PIC X(09)   VALUE   "101910020".
           03  CONS-ROUSAI15   PIC X(09)   VALUE   "101910030".
           03  CONS-ROUSAI16   PIC X(09)   VALUE   "101910040".
           03  CONS-ROUSAI17   PIC X(09)   VALUE   "101910070".
           03  CONS-ROUSAI18   PIC X(09)   VALUE   "101910080".
           03  CONS-ROUSAI19   PIC X(09)   VALUE   "101910090".
           03  CONS-ROUSAI20   PIC X(09)   VALUE   "101910100".
      *
      *    腰部固定帯加算
           03  CONS-YOUBUKASAN PIC X(09)   VALUE   "140037490".
      *    療養担当手当（入院）
           03  CONS-RYOYOTEATE PIC X(09)   VALUE   "199000510".
      *---------------------------------------------------------------
      *
           COPY    "MCPAREA".
      *
           COPY    "COMMON-SPA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *    医療機関情報−基本
           COPY    "CPSK1001.INC".
      *    労災自賠医療機関情報
           COPY    "CPSK4001.INC".
      *
           COPY    "CPSK5000.INC".
      *
      *    ジョブ管理マスタ
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      *    入院会計
       01  NYUINACCT-REC.
           COPY    "CPNYUINACCT.INC".
      *
      *    入院診療行為
       01  NYUINACT-REC.
           COPY    "CPNYUINACT.INC".
      *
      *    診療会計
       01  SRYACCT-REC.
           COPY    "CPSRYACCT.INC".
      *
      *    診療行為
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    点数
           COPY    "CPTENSU.INC".
      *
      *    入院略称
       01  NYURYAKUSHO-REC.
           COPY    "CPNYUINRYAKUSHO.INC".
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
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
      *
      *    入院点滴一括更新サブ
           COPY    "CPORCSTENTEK.INC".
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
      *
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
      *
           MOVE    ZERO                TO  FLG-END
      *
           MOVE    COMMAND-PARAM       TO  WRK-PARA
      *
           PERFORM 100-DBOPEN-SEC
      *
      *    ステップ管理開始処理
           MOVE    "STS"           TO  SJOBKANRI-MODE
           INITIALIZE                  JOBKANRI-REC
           MOVE    WRK-PARA-JOBID  TO  JOB-JOBID
           MOVE    WRK-PARA-SHELLID
                                   TO  JOB-SHELLID
           MOVE    "ORCR0830"      TO  JOB-PGID
           MOVE    "診療実日数編集（労災・自賠責）"
                                   TO  JOB-SHELLMSG
           CALL    "ORCSJOB"       USING
                                   ORCSJOBKANRIAREA  
                                   JOBKANRI-REC
      *
           MOVE    "RECE820"           TO  RECE82PARA-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECE82PARA-TERMID
      *
           MOVE    "RECEERR"           TO  RECEERR-FILE-ID
           MOVE    WRK-PARA-TERMID     TO  RECEERR-TERMID
      *
      *
           IF   WRK-PARA-SRYYM    NOT =  ZERO
      *
      *      医療機関減算の取得（システム管理テーブルより）
             MOVE     ZERO               TO  WRK-SHOKUJIRYOYO
                                             WRK-TOKUKANRIKASAN
      *
             MOVE     ZERO               TO  FLG-MIJISI-INNAI             
                                             FLG-MIJISI-IRYO              
                                             FLG-MIJISI-JYOKU      
      *
             INITIALIZE                      SYSKANRI-REC
             MOVE    "5000"              TO  SYS-KANRICD
             MOVE    "*"                 TO  SYS-KBNCD
             MOVE    WRK-PARA-SRYYM      TO  ORC-DBYMD (1:6)
             MOVE    "01"                TO  ORC-DBYMD (7:2)
             MOVE    SYSKANRI-REC        TO  MCPDATA-REC
             MOVE    "DBSELECT"          TO  MCP-FUNC
             MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
             CALL    "ORCMCPSUB"             USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
             IF      MCP-RC              =   ZERO
                 MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
                 PERFORM  SYSKANRI-READ-SEC
      *
                 PERFORM  110-SYSKAN-HENSYU-SEC
      *
             END-IF
      *
             MOVE    "DBCLOSE"               TO  MCP-FUNC
             MOVE    "SYSKANRI-KEY"          TO  ORC-DBPATH
             CALL    "ORCMCPSUB"             USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
      *
           ELSE
      *
             MOVE     ZERO               TO  SYSKAN-IDX
             MOVE     SPACE              TO  TBL-SYS5000-T
             INITIALIZE                      TBL-SYS5000-T
      *
             INITIALIZE                      SYSKANRI-REC
             MOVE    "5000"              TO  SYS-KANRICD
             MOVE    "*"                 TO  SYS-KBNCD
             MOVE    SYSKANRI-REC        TO  MCPDATA-REC
             MOVE    "DBSELECT"          TO  MCP-FUNC
             MOVE    "SYSKANRI-KEY8"     TO  ORC-DBPATH
             CALL    "ORCMCPSUB"             USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
             IF      MCP-RC              =   ZERO
                 MOVE    "SYSKANRI-KEY8" TO  ORC-DBPATH
                 PERFORM  SYSKANRI-READ-SEC
                 PERFORM  UNTIL  (FLG-SYSKANRI  =    1)
      *
                   ADD     1            TO  SYSKAN-IDX
                   MOVE   SYS-5000-REC  TO  TBL-SYS5000(SYSKAN-IDX)
      *
                   MOVE    "SYSKANRI-KEY8" TO  ORC-DBPATH
                   PERFORM  SYSKANRI-READ-SEC
      *
                 END-PERFORM
      *
             END-IF
      *
             MOVE    "DBCLOSE"               TO  MCP-FUNC
             MOVE    "SYSKANRI-KEY8"         TO  ORC-DBPATH
             CALL    "ORCMCPSUB"             USING
                                             MCPAREA
                                             ORCMCPAREA
                                             MCPDATA-REC
      *
           END-IF
      *
      *    医療機関情報−基本
           INITIALIZE                      SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    WRK-PARA-SRYYM      TO  ORC-DBYMD (1:6)
           MOVE    "01"                TO  ORC-DBYMD (7:2)
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               PERFORM  SYSKANRI-READ-SEC
               MOVE     SYS-1001-TAX-HASU-KBN
                                       TO  WRK-TAX1001-KBN
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
      *    システム管理マスタ（４００１）から点数単価の取得
           INITIALIZE                         SYS-4001-REC
           MOVE    "4001"               TO    SYS-4001-KANRICD
           MOVE    "*"                  TO    SYS-4001-KBNCD
           MOVE    WRK-PARA-SRYYM       TO    ORC-DBYMD (1:6)
           MOVE    "01"                 TO    ORC-DBYMD (7:2)
           MOVE    SYS-4001-REC         TO    MCPDATA-REC
           MOVE    "DBSELECT"           TO    MCP-FUNC
           MOVE    "SYSKANRI-KEY"       TO    ORC-DBPATH
           CALL    "ORCMCPSUB"                USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY"   TO    ORC-DBPATH
               PERFORM  SYSKANRI-READ-SEC
               EVALUATE  SYS-4001-TENKBN
                   WHEN  "1"
                       MOVE     11.5    TO    WRK-TANKA
                   WHEN  "2"
                       MOVE     12.0    TO    WRK-TANKA
               END-EVALUATE
               MOVE   SYS-4001-TAXKBN   TO    WRK-TAXKBN                
           END-IF
      *
           MOVE    "DBCLOSE"            TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"       TO  ORC-DBPATH
           CALL    "ORCMCPSUB"              USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
      *
           OPEN    I-O                 RECE82-FILE
      *
           PERFORM    RECE82-READ-SEC
      *
          .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    シスカンの編集
      *****************************************************************
       110-SYSKAN-HENSYU-SEC                SECTION.
      *
           PERFORM  VARYING   GENSAN-IDX  FROM  1  BY  1
                    UNTIL     GENSAN-IDX   >   4
                IF    SYS-5000-GENKBN(GENSAN-IDX)   =   "2"    
                    EVALUATE  GENSAN-IDX
                        WHEN  2
                            MOVE    1     TO    FLG-MIJISI-INNAI    
                        WHEN  3
                            MOVE    1     TO    FLG-MIJISI-IRYO     
                        WHEN  4
                            MOVE    1     TO    FLG-MIJISI-JYOKU    
                    END-EVALUATE
                END-IF
           END-PERFORM
      *
           IF  SYS-5000-SHOKUJIRYOYOCD   =  "197000110"
                  MOVE     1         TO   WRK-SHOKUJIRYOYO
                  IF  SYS-5000-SHOKUKBN(1) =  "1"
                       MOVE  ZERO    TO   WRK-TOKUKANRIKASAN
                  ELSE
                       MOVE  1       TO   WRK-TOKUKANRIKASAN
                  END-IF
           ELSE
                  MOVE     2         TO   WRK-SHOKUJIRYOYO
           END-IF
      *
           .
       110-SYSKAN-HENSYU-EXT.
           EXIT.
      * 
      *****************************************************************
      *    主処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           PERFORM    210-HENSYU-SEC
      *
           PERFORM    RECE82-READ-SEC
      *
           .
       200-MAIN-EXT.
           EXIT.
      * 
      *****************************************************************
      *    編集処理
      *****************************************************************
       210-HENSYU-SEC                   SECTION.
      *
           MOVE       SPACE             TO     TBL-JNISSU
           INITIALIZE                          TBL-JNISSU
      *
           MOVE       SPACE             TO     TBL-TENSUG-JI
           INITIALIZE                          TBL-TENSUG-JI
      *
           MOVE       SPACE             TO     TOTAL-ACCT
           INITIALIZE                          TOTAL-ACCT
      *
           MOVE       SPACE             TO     WRK-DAY-TABLE
           INITIALIZE                          WRK-DAY-TABLE
      *
           MOVE       ZERO              TO     FLG-MIJISI-GENSAN
      *
           MOVE       ZERO              TO     WRK-TAIHI-FLG
      *
           MOVE       ZERO              TO     WRK-SINDAN-TUU
                                               WRK-SINDAN-KIN
                                               WRK-MEISAI-TUU
                                               WRK-MEISAI-KIN
      *
           PERFORM     220-RECE82-HENSYU-SEC
           PERFORM     230-RECE82-HENSYU2-SEC
           PERFORM     240-RECE82-HENSYU3-SEC
           PERFORM     250-RECE82-HENSYU4-SEC
           PERFORM     260-RECE82-HENSYU9-SEC
      *
           PERFORM     270-JNISSU-SET-SEC
      *
           PERFORM     RECE82-REWRITE-SEC
           .
       210-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの編集（Ｆ００２）
      *****************************************************************
       220-RECE82-HENSYU-SEC                SECTION.
      *
           INITIALIZE                            NYUINACCT-REC
           MOVE    RECE82-HOSPID         TO      NACCT-HOSPID
           MOVE    RECE82-NYUGAIKBN      TO      NACCT-NYUGAIKBN
           MOVE    RECE82-PTID           TO      NACCT-PTID
           MOVE    RECE82-SRYYM          TO      NACCT-SRYYM
           MOVE    NYUINACCT-REC         TO      MCPDATA-REC
           MOVE    "DBSELECT"            TO      MCP-FUNC
           MOVE    "NYUINACCT-KEY7"      TO      ORC-DBPATH
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           IF      MCP-RC             =       ZERO
      *
               MOVE    "NYUINACCT-KEY7"  TO      ORC-DBPATH
               PERFORM  NYUINACCT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                 IF     NACCT-ZAISKBKBN    =    "1"  OR  "2"  OR  
                                                "4"  OR  "5"  OR
                                                "6"   
                       PERFORM    2201-NYUIN-DAY-TAIHI-SEC
                 END-IF
      *
                 MOVE          "NYUINACCT-KEY7"  TO   ORC-DBPATH
                 PERFORM        NYUINACCT-READ-SEC
               END-PERFORM
      *
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY7"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           PERFORM  VARYING  IDY    FROM    1   BY  1
                          UNTIL   IDY     >       31
      *
                 IF        WRK-DAY5(IDY)   =   RECE82-HKNCOMBI
                      MOVE    ZERO            TO    FLG-SHOSAISIN
                      IF   WRK-DAY1(IDY)   NOT =    ZERO    
                               MOVE    1      TO    FLG-SHOSAISIN
                      END-IF
                      PERFORM   2201-RECE82-TENSOU11-SEC
                 END-IF
      *
           END-PERFORM
      *
      *+++
      *
           INITIALIZE                           SRYACCT-REC
           MOVE    RECE82-HOSPID        TO      ACCT-HOSPID
           MOVE    RECE82-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    RECE82-PTID          TO      ACCT-PTID
           MOVE    RECE82-SRYYM         TO      ACCT-SRYYM
           MOVE    RECE82-HKNCOMBI      TO      ACCT-HKNCOMBI
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACCT-KEY22"      TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING   MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACCT-KEY22"  TO      ORC-DBPATH
               PERFORM  SRYACCT-READ-SEC
               PERFORM  UNTIL
                  (FLG-SRYACCT        =    1)
                   IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                        (ACCT-ZAIKAISU  NOT =    ZERO)
                        MOVE    ZERO     TO    FLG-SHOSAISIN
                                               FLG-KYUKYU
                        IF   ACCT-SRYKBN  =  "11"  OR
                                             "13"  OR  "14"
                            PERFORM   2201-SHOSAISIN-HANTEI-SEC
                        END-IF
                        IF   ACCT-SRYKBN  =  "11"   
                            PERFORM   2201-KYUKYU-HANTEI-SEC
                        END-IF
                        PERFORM   2201-RECE82-TENSOU12-SEC
                   END-IF
                   IF   (ACCT-ZAITEN    =        ZERO)    AND
                        (ACCT-ZAIKAISU  NOT =    ZERO)
                        MOVE    ZERO     TO    FLG-SHOSAISIN
                                               FLG-KYUKYU
                        IF   ACCT-SRYKBN  =  "11"  OR  "99" 
                            PERFORM   2201-SHOSAISIN-HANTEI-SEC
                        END-IF
                        PERFORM   2201-RECE82-TENSOU12-SEC
                   END-IF
                   IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                        (ACCT-ZAIKAISU  NOT =    ZERO)
                        IF   ACCT-SRYKBN  =  "90" OR "92"   
                            PERFORM   2201-NYUINRYO-TAIHI-SEC
                        END-IF
                   END-IF
                   MOVE     "SRYACCT-KEY22"  TO   ORC-DBPATH
                   PERFORM   SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACCT-KEY22"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       220-RECE82-HENSYU-EXT.
           EXIT.
      *
      ******************************************************************
      *    会計フラグ退避処理                                          *
      ******************************************************************
       2201-NYUIN-DAY-TAIHI-SEC         SECTION.
      *
           PERFORM    VARYING   IDY   FROM   1   BY   1
                                    UNTIL    IDY    >    31
      *
             IF       NACCT-DAY(IDY)   NOT =  ZERO 
      *
               IF     NACCT-ZAISKBKBN    =    "1"  
                  IF     NACCT-SRYCDTOTAL    =    099999916
                    CONTINUE
                  ELSE
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY1(IDY) 
                    IF  NACCT-SRYKBN  =  "90"                           
                       MOVE   903  TO  WRK-DAY1-NYUTENTTLKBN(IDY)       
                    ELSE                                                
                       MOVE   920  TO  WRK-DAY1-NYUTENTTLKBN(IDY)       
                    END-IF
                  END-IF
               END-IF 
      *
               IF     NACCT-ZAISKBKBN    =    "2"  
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY2(IDY) 
               END-IF 
      *
               IF     NACCT-ZAISKBKBN    =    "4"  
                 IF    NACCT-SRYCDTOTAL  =    197000570 
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY41(IDY) 
                 ELSE 
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY4(IDY) 
                 END-IF
               END-IF 
      *
               IF     NACCT-ZAISKBKBN    =    "5"  
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY5(IDY) 
               END-IF 
      *
               IF     NACCT-ZAISKBKBN    =    "6"  
                    MOVE   NACCT-DAY(IDY)   TO  WRK-DAY6(IDY) 
                    IF  NACCT-SRYCDTOTAL  =  190080470   OR             
                                             190799670   OR             
                                             190080570   OR             
                                             190799770   OR             
                                             190111690   OR             
                                             190809090   OR             
                                             190111790   OR             
                                             190809190                  
                      CONTINUE                                          
                    ELSE                                                
                      ADD    NACCT-ZAITEN   TO  WRK-DAY6-ZAITEN(IDY)
                    END-IF
               END-IF 
      *
             END-IF
      *
           END-PERFORM.
      *
       2201-NYUIN-DAY-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       2201-RECE82-TENSOU11-SEC                 SECTION.
      *
           IF   FLG-SHOSAISIN        =       1
                       MOVE    "1"   TO   TBL-JNISSU-DAY(IDY)
           END-IF
           .
       2201-RECE82-TENSOU11-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計テーブルの内容から診療行為テーブルを読み込み、
      *    診療実日数のカウントを行える剤であるかの判定
      *****************************************************************
       2201-SHOSAISIN-HANTEI-SEC                 SECTION.
      *
           INITIALIZE                           SRYACT-REC
           MOVE    ACCT-HOSPID          TO      SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN       TO      SRY-NYUGAIKBN
           MOVE    ACCT-PTID            TO      SRY-PTID
           MOVE    ACCT-SRYYM           TO      SRY-SRYYM
           MOVE    ACCT-ZAINUM          TO      SRY-ZAINUM
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACT-KEY9"        TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING   MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACT-KEY9"    TO      ORC-DBPATH
               PERFORM  SRYACT-READ-SEC
               PERFORM  UNTIL  FLG-SRYACT    =    1
                   PERFORM   VARYING   SRYACT-IDX  FROM  1   BY   1
                             UNTIL    (SRYACT-IDX    >   5)  OR
                                      (SRY-SRYCD(SRYACT-IDX)
                                                         =   SPACE)  OR
                                      (FLG-SHOSAISIN     =    1)
                       MOVE    SPACE         TO   TNS-TENSU-REC
                       INITIALIZE                 TNS-TENSU-REC
                       MOVE    SRY-SRYCD(SRYACT-IDX) TO   TNS-SRYCD
                       MOVE    ACCT-SRYYM         TO  ORC-DBYMD(1:6)
                       MOVE    "01"               TO  ORC-DBYMD(7:2)
                       PERFORM  TENSU-READ-SEC
                       IF       FLG-TENSU      =    ZERO
                         IF ( (TNS-JITUDAY    =     2)    AND
                              (TNS-DAYCNT     =     1   OR   2) ) OR
                            (  SRY-SRYCD(SRYACT-IDX) =  "099409901" OR
                                                        "099999902" OR
                                                        "099110001" OR
                                                        "099120001")
                             MOVE    1      TO    FLG-SHOSAISIN
                         END-IF
                       END-IF
                       MOVE    "DBCLOSE"          TO  MCP-FUNC
                       MOVE    "TENSU-KEY"        TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"        USING
                                                  MCPAREA
                                                  ORCMCPAREA
                                                  MCPDATA-REC
                   END-PERFORM
                   MOVE     "SRYACT-KEY9"    TO   ORC-DBPATH
                   PERFORM   SRYACT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACT-KEY9"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
      *
       2201-SHOSAISIN-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計テーブルの内容から診療行為テーブルを読み込み、
      *    救急管理加算があるかの判定
      *****************************************************************
       2201-KYUKYU-HANTEI-SEC                 SECTION.
      *
           INITIALIZE                           SRYACT-REC
           MOVE    ACCT-HOSPID          TO      SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN       TO      SRY-NYUGAIKBN
           MOVE    ACCT-PTID            TO      SRY-PTID
           MOVE    ACCT-SRYYM           TO      SRY-SRYYM
           MOVE    ACCT-ZAINUM          TO      SRY-ZAINUM
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACT-KEY9"        TO      ORC-DBPATH
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACT-KEY9"    TO      ORC-DBPATH
               PERFORM  SRYACT-READ-SEC
               PERFORM  UNTIL  FLG-SRYACT    =    1
      *
                   PERFORM   VARYING   SRYACT-IDX  FROM  1   BY   1
                             UNTIL    (SRYACT-IDX    >   5)  OR
                                      (SRY-SRYCD(SRYACT-IDX)
                                                         =   SPACE)  OR
                                      (FLG-KYUKYU        =    1)
                       IF  SRY-SRYCD(SRYACT-IDX) =  CONS-ROUSAI2
                             MOVE    1      TO    FLG-KYUKYU
                       END-IF
                   END-PERFORM
      *
                   MOVE     "SRYACT-KEY9"    TO   ORC-DBPATH
                   PERFORM   SRYACT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACT-KEY9"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           .
      *
       2201-KYUKYU-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       2201-RECE82-TENSOU12-SEC                 SECTION.
      *
           IF   FLG-SHOSAISIN        =       1
              PERFORM    VARYING   IDY   FROM   1    BY   1
                           UNTIL    IDY   >      31
                  IF  ACCT-DAY(1 IDY)   NOT =    ZERO
                       MOVE   "1"  TO  TBL-JNISSU-DAY(IDY)
                  END-IF
              END-PERFORM
           END-IF
           IF   FLG-KYUKYU           =       1
              PERFORM    VARYING   IDY   FROM   1    BY   1
                     UNTIL  ( IDY                  >    31 )  OR
                            ( WRK-TAIHI-FLG        =     1 )
                  IF  ACCT-DAY(1 IDY)   NOT =    ZERO
                      MOVE   RECE82-SRYYM  TO  WRK-TAIHI-SRYYM
                      MOVE   IDY           TO  WRK-TAIHI-SRYD
                      MOVE   1             TO  WRK-TAIHI-FLG
                  END-IF
              END-PERFORM
           END-IF
           .
       2201-RECE82-TENSOU12-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計の入院料等の退避処理
      *****************************************************************
       2201-NYUINRYO-TAIHI-SEC                 SECTION.
      *
           IF        ACCT-SRYCDTOTAL    =    101910050
                                        OR   101910060
                                        OR   101920010
                CONTINUE
           ELSE
             IF      ACCT-SRYCDTOTAL    =    190080470
                                        OR   190799670
                                        OR   190080570
                                        OR   190799770
                                        OR   190111690
                                        OR   190809090
                                        OR   190111790
                                        OR   190809190
                PERFORM    VARYING   IDY   FROM   1    BY   1
                                 UNTIL    IDY   >      31
                   IF  ACCT-DAY(1 IDY)   NOT =    ZERO
                         COMPUTE  WRK-ACCT-KASAN(IDY) = 
                                  WRK-ACCT-KASAN(IDY) -
                                 (ACCT-ZAITEN * ACCT-DAY(1 IDY))
                   END-IF
                END-PERFORM
             ELSE
      *         日常生活障害加算・痴呆加算
                IF   ACCT-SRYCDTOTAL    =    190109170
                                        OR   190807570
                                        OR   190109270
                                        OR   190808670
                   PERFORM    VARYING   IDY   FROM   1    BY   1
                                    UNTIL    IDY   >      31
                      IF  ACCT-DAY(1 IDY)   NOT =    ZERO
                            COMPUTE  WRK-ACCT-KASAN(IDY) = 
                                     WRK-ACCT-KASAN(IDY) +
                                    (ACCT-ZAITEN * ACCT-DAY(1 IDY))
                      END-IF
                   END-PERFORM
                ELSE
                   PERFORM    VARYING   IDY   FROM   1    BY   1
                                    UNTIL    IDY   >      31
                      IF  ACCT-DAY(1 IDY)   NOT =    ZERO
                            COMPUTE  WRK-ACCT90(IDY) = 
                                     WRK-ACCT90(IDY) +
                                    (ACCT-ZAITEN * ACCT-DAY(1 IDY))
                      END-IF
                   END-PERFORM
                END-IF
             END-IF
           END-IF
      *
           .
       2201-NYUINRYO-TAIHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの編集（Ｆ００２）
      *****************************************************************
       230-RECE82-HENSYU2-SEC                SECTION.
      *
           PERFORM      2301-ROSAIJYOSU-GET-SEC
      *
           PERFORM      2301-MIJISI-GET-SEC
      *
           INITIALIZE                            NYUINACCT-REC
           MOVE    RECE82-HOSPID         TO      NACCT-HOSPID
           MOVE    RECE82-NYUGAIKBN      TO      NACCT-NYUGAIKBN
           MOVE    RECE82-PTID           TO      NACCT-PTID
           MOVE    RECE82-SRYYM          TO      NACCT-SRYYM
           MOVE    NYUINACCT-REC         TO      MCPDATA-REC
           MOVE    "DBSELECT"            TO      MCP-FUNC
           MOVE    "NYUINACCT-KEY7"      TO      ORC-DBPATH
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           IF      MCP-RC             =       ZERO
      *
               MOVE    "NYUINACCT-KEY7"  TO      ORC-DBPATH
               PERFORM  NYUINACCT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                 IF     NACCT-ZAISKBKBN          =    "1"  
                 AND    NACCT-SRYCDTOTAL   NOT   =    099999916
      *
      *            入院基本料と加減算点数の取得
                   PERFORM   2301-NYUINKHN-GET-SEC
      *
                   PERFORM  VARYING  IDY    FROM    1   BY  1
                                  UNTIL   IDY     >       31
      *
                         IF  WRK-DAY5(IDY)  =  RECE82-HKNCOMBI
                              IF   NACCT-ZAITEN    NOT =    ZERO  
                              AND  NACCT-DAY(IDY)  NOT =    ZERO  
                                   PERFORM      2301-NYUINACCT-GET-SEC
                              END-IF
                         END-IF
      *
                   END-PERFORM
      *
                 END-IF
      *
                 IF     NACCT-ZAISKBKBN    =    "6"  
      *
                   PERFORM  VARYING  IDY    FROM    1   BY  1
                                  UNTIL   IDY     >       31
      *
                         IF  WRK-DAY5(IDY)  =  RECE82-HKNCOMBI
                              IF   (NACCT-ZAITEN    NOT =    ZERO)  
                              AND  (NACCT-DAY(IDY)  NOT =    ZERO)  
                              AND  (WRK-DAY2(IDY)  =    ZERO  OR  4)
                                   PERFORM      2301-NYUINACCT-GET2-SEC
                              END-IF
                         END-IF
      *
                   END-PERFORM
      *
                 END-IF
      *
                 MOVE          "NYUINACCT-KEY7"  TO   ORC-DBPATH
                 PERFORM        NYUINACCT-READ-SEC
               END-PERFORM
      *
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY7"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
      *+++
      *
           INITIALIZE                           SRYACCT-REC
           MOVE    RECE82-HOSPID        TO      ACCT-HOSPID
           MOVE    RECE82-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    RECE82-PTID          TO      ACCT-PTID
           MOVE    RECE82-SRYYM         TO      ACCT-SRYYM
           MOVE    RECE82-HKNCOMBI      TO      ACCT-HKNCOMBI
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACCT-KEY22"      TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING   MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACCT-KEY22"  TO      ORC-DBPATH
               PERFORM  SRYACCT-READ-SEC
               PERFORM  UNTIL
                  (FLG-SRYACCT        =    1)
                   IF   (ACCT-ZAITEN    NOT =    ZERO)
                   AND  (ACCT-ZAIKAISU  NOT =    ZERO)
                        IF   ACCT-SRYKBN  =  "90" OR "92"  
                            PERFORM  2301-RECE82-TENSOU23-SEC
                        END-IF
                   END-IF
                   MOVE     "SRYACCT-KEY22"  TO   ORC-DBPATH
                   PERFORM   SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACCT-KEY22"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       230-RECE82-HENSYU2-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院基本料労災乗数取得
      *****************************************************************
       2301-ROSAIJYOSU-GET-SEC                 SECTION.
      *
           MOVE    ZERO                TO  WRK-KOYOMI-YMD
                                           WRK-KOYOMI2-YMD
      *
      *    初回入院年月日から２週間目を算定
           INITIALIZE                      STS-AREA-DAY
           INITIALIZE                      LNK-DAY6-AREA
           MOVE    "61"                TO  LNK-DAY6-IRAI
           MOVE    RECE82-NYUINYMD     TO  LNK-DAY6-KIJUN
           MOVE    "1"                 TO  LNK-DAY6-ZOGENPTN
           MOVE    14                  TO  LNK-DAY6-ZOGEN
           CALL    "ORCSDAY"           USING   STS-AREA-DAY
                                               LNK-DAY6-AREA
      *
           MOVE    LNK-DAY6-KOYOMI     TO  WRK-KOYOMI-YMD
      *
      *    労災乗数区分セット
           PERFORM    VARYING   IDY   FROM   1   BY   1
                       UNTIL    IDY    >    31
      *
              MOVE    RECE82-SRYYM     TO  WRK-KOYOMI2-YYMM
              MOVE    IDY              TO  WRK-KOYOMI2-DD
              IF      WRK-KOYOMI2-YMD  <=  WRK-KOYOMI-YMD
                   MOVE    "1"    TO   WRK-ROUNYUIN-JOUSU-KBN(IDY)
              ELSE
                   MOVE    "2"    TO   WRK-ROUNYUIN-JOUSU-KBN(IDY)
              END-IF
           END-PERFORM
      *
           .
       2301-ROSAIJYOSU-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    未実施減算額取得
      *****************************************************************
       2301-MIJISI-GET-SEC                 SECTION.
      *
           MOVE     ZERO               TO  WRK-MIJISI
      *
           IF   FLG-MIJISI-INNAI  =   1
      *
               MOVE    SPACE         TO   TNS-TENSU-REC
               INITIALIZE                 TNS-TENSU-REC
               MOVE    "190080570"   TO   TNS-SRYCD
               MOVE    RECE82-SRYYM       TO  ORC-DBYMD(1:6)
               MOVE    "01"               TO  ORC-DBYMD(7:2)
               PERFORM  TENSU-READ-SEC
               IF       FLG-TENSU      =    ZERO
                  COMPUTE   WRK-MIJISI   =   WRK-MIJISI
                                         +   TNS-TEN
               END-IF
               MOVE    "DBCLOSE"          TO  MCP-FUNC
               MOVE    "TENSU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"        USING
                                          MCPAREA
                                          ORCMCPAREA
                                          MCPDATA-REC
      *
           END-IF
      *
           IF   FLG-MIJISI-IRYO   =   1
      *
               MOVE    SPACE         TO   TNS-TENSU-REC
               INITIALIZE                 TNS-TENSU-REC
               MOVE    "190111690"   TO   TNS-SRYCD
               MOVE    RECE82-SRYYM       TO  ORC-DBYMD(1:6)
               MOVE    "01"               TO  ORC-DBYMD(7:2)
               PERFORM  TENSU-READ-SEC
               IF       FLG-TENSU      =    ZERO
                  COMPUTE   WRK-MIJISI   =   WRK-MIJISI
                                         +   TNS-TEN
               END-IF
               MOVE    "DBCLOSE"          TO  MCP-FUNC
               MOVE    "TENSU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"        USING
                                          MCPAREA
                                          ORCMCPAREA
                                          MCPDATA-REC
      *
           END-IF
      *
           IF   FLG-MIJISI-JYOKU  =   1
      *
               MOVE    SPACE         TO   TNS-TENSU-REC
               INITIALIZE                 TNS-TENSU-REC
               MOVE    "190111790"   TO   TNS-SRYCD
               MOVE    RECE82-SRYYM       TO  ORC-DBYMD(1:6)
               MOVE    "01"               TO  ORC-DBYMD(7:2)
               PERFORM  TENSU-READ-SEC
               IF       FLG-TENSU      =    ZERO
                  COMPUTE   WRK-MIJISI   =   WRK-MIJISI
                                         +   TNS-TEN
               END-IF
               MOVE    "DBCLOSE"          TO  MCP-FUNC
               MOVE    "TENSU-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"        USING
                                          MCPAREA
                                          ORCMCPAREA
                                          MCPDATA-REC
      *
           END-IF
      *
           .
       2301-MIJISI-GET-EXT.
           EXIT.
      *
      **************************************************************
      *    入院基本料と加減算点数の計算
      **************************************************************
       2301-NYUINACCT-GET-SEC           SECTION.
      *
      *    入院料と外泊を比較して点数算定
      *
           EVALUATE   WRK-NYUTENTTLKBN
               WHEN   903
                  MOVE      ZERO   TO  WRK-NYUKHNRYO
                  EVALUATE   WRK-DAY2(IDY)
                       WHEN   ZERO
                         COMPUTE  WRK-KEISAN  =  WRK-KHNTEN
                                              -  WRK-MIJISI
                                              +  WRK-ACCT-KASAN(IDY)
                         EVALUATE  WRK-ROUNYUIN-JOUSU-KBN(IDY)
                           WHEN  "1"
                            COMPUTE  WRK-KEISAN  = (WRK-KEISAN * 1.30)
                                                 +  0.5
                           WHEN  "2"
                            COMPUTE  WRK-KEISAN  = (WRK-KEISAN * 1.01)
                                                 +  0.5
                         END-EVALUATE
                         COMPUTE  WRK-NYUKHNRYO  =  WRK-KEISAN
                                                 +  WRK-KSNTEN
                       WHEN   1
                       WHEN   4
                         IF   WRK-KHNTEN2  NOT =  ZERO
                           COMPUTE  WRK-KEISAN =
                                 (WRK-KHNTEN2  *  0.15)  +  0.5
                         ELSE
                           COMPUTE  WRK-KEISAN =
                                 (WRK-KHNTEN   *  0.15)  +  0.5
                         END-IF
      *>                 COMPUTE    WRK-KEISAN =  WRK-KEISAN
      *>                                       +  WRK-ACCT-KASAN(IDY)
                         EVALUATE  WRK-ROUNYUIN-JOUSU-KBN(IDY)
                           WHEN  "1"
                             COMPUTE  WRK-NYUKHNRYO  = 
                                     (WRK-KEISAN * 1.30)  +  0.5
                           WHEN  "2"
                             COMPUTE  WRK-NYUKHNRYO  = 
                                     (WRK-KEISAN * 1.01)  +  0.5
                         END-EVALUATE
                       WHEN   2
                         IF   WRK-KHNTEN2  NOT =  ZERO
                           COMPUTE  WRK-KEISAN =
                                 (WRK-KHNTEN2  *  0.3)  +  0.5
                         ELSE
                           COMPUTE  WRK-KEISAN =
                                 (WRK-KHNTEN   *  0.3)  +  0.5
                         END-IF
      *>                 COMPUTE    WRK-KEISAN =  WRK-KEISAN
      *>                                       +  WRK-ACCT-KASAN(IDY)
                         EVALUATE  WRK-ROUNYUIN-JOUSU-KBN(IDY)
                           WHEN  "1"
                             COMPUTE  WRK-NYUKHNRYO  = 
                                     (WRK-KEISAN * 1.30)  +  0.5
                           WHEN  "2"
                             COMPUTE  WRK-NYUKHNRYO  = 
                                     (WRK-KEISAN * 1.01)  +  0.5
                         END-EVALUATE
                  END-EVALUATE
                  EVALUATE   WRK-DAY2(IDY)
                     WHEN   ZERO
                         MOVE     1      TO    FLG-MIJISI-GENSAN        
                  END-EVALUATE
                  MOVE     ZERO     TO    FLG-ARI
                  PERFORM  VARYING  ID1    FROM    1   BY  1
                                UNTIL   ID1                   > 10
                                  OR    RECE82-NYUKHNNISSU(ID1)
                                                              = ZERO
                                  OR    FLG-ARI               = 1
                      IF  RECE82-NYUKHNRYO(ID1)  =  WRK-NYUKHNRYO
                            ADD   1   TO   RECE82-NYUKHNNISSU(ID1)
                            ADD   WRK-NYUKHNRYO
                                      TO   RECE82-NYUKHNKEI(ID1)
                            MOVE  1   TO   FLG-ARI
                      END-IF
                  END-PERFORM  
                  IF  FLG-ARI  =  ZERO  
                      ADD        1           TO  RECE82-NYUKHNNISSU(ID1)
                      MOVE   WRK-NYUKHNRYO   TO  RECE82-NYUKHNRYO(ID1)
                      ADD    WRK-NYUKHNRYO   
                                       TO  RECE82-NYUKHNKEI(ID1)
                  END-IF
               WHEN   920
                  MOVE      ZERO   TO  WRK-NYUTOKRYO
                  MOVE      ZERO   TO  FLG-GAIHAKU
                  EVALUATE   WRK-DAY2(IDY)
                       WHEN   ZERO
                         COMPUTE  WRK-KEISAN  =  WRK-KHNTEN
                                              -  WRK-MIJISI
                                              +  WRK-ACCT-KASAN(IDY)
                         EVALUATE  WRK-ROUNYUIN-JOUSU-KBN(IDY)
                           WHEN  "1"
                            COMPUTE  WRK-KEISAN  = (WRK-KEISAN * 1.30)
                                                 +  0.5
                           WHEN  "2"
                            COMPUTE  WRK-KEISAN  = (WRK-KEISAN * 1.01)
                                                 +  0.5
                         END-EVALUATE
                         COMPUTE  WRK-NYUTOKRYO  =  WRK-KEISAN
                                                 +  WRK-KSNTEN
                       WHEN   1
                       WHEN   4
                         IF   WRK-KHNTEN2  NOT =  ZERO
                           COMPUTE  WRK-KEISAN =
                                 (WRK-KHNTEN2  *  0.15)  +  0.5
                         ELSE
                           COMPUTE  WRK-KEISAN =
                                 (WRK-KHNTEN   *  0.15)  +  0.5
                         END-IF
      *>                 COMPUTE    WRK-KEISAN =  WRK-KEISAN
      *>                                       +  WRK-ACCT-KASAN(IDY)
                         EVALUATE  WRK-ROUNYUIN-JOUSU-KBN(IDY)
                           WHEN  "1"
                             COMPUTE  WRK-NYUTOKRYO  = 
                                     (WRK-KEISAN * 1.30)  +  0.5
                           WHEN  "2"
                             COMPUTE  WRK-NYUTOKRYO  = 
                                     (WRK-KEISAN * 1.01)  +  0.5
                         END-EVALUATE
                         MOVE   1   TO   FLG-GAIHAKU
                       WHEN   2
                         IF   WRK-KHNTEN2  NOT =  ZERO
                           COMPUTE  WRK-KEISAN =
                                 (WRK-KHNTEN2  *  0.3)  +  0.5
                         ELSE
                           COMPUTE  WRK-KEISAN =
                                 (WRK-KHNTEN   *  0.3)  +  0.5
                         END-IF
      *>                 COMPUTE    WRK-KEISAN =  WRK-KEISAN
      *>                                       +  WRK-ACCT-KASAN(IDY)
                         EVALUATE  WRK-ROUNYUIN-JOUSU-KBN(IDY)
                           WHEN  "1"
                             COMPUTE  WRK-NYUTOKRYO  = 
                                     (WRK-KEISAN * 1.30)  +  0.5
                           WHEN  "2"
                             COMPUTE  WRK-NYUTOKRYO  = 
                                     (WRK-KEISAN * 1.01)  +  0.5
                         END-EVALUATE
                         MOVE   1   TO   FLG-GAIHAKU
                  END-EVALUATE
                  EVALUATE   WRK-DAY2(IDY)
                     WHEN   ZERO
                         MOVE     1      TO    FLG-MIJISI-GENSAN        
                  END-EVALUATE
                  IF  (WRK-DAY6(IDY)          NOT =  ZERO)
                  AND (WRK-DAY6-ZAITEN(IDY)   NOT =  ZERO)
                  AND (WRK-DAY2(IDY)              =  ZERO  OR  4)
                      COMPUTE  WRK-NYUTOKRYO = WRK-NYUTOKRYO
                                             + WRK-DAY6-ZAITEN(IDY)
                  END-IF
                  IF  WRK-ACCT90(IDY)        NOT =  ZERO
                      COMPUTE  WRK-NYUTOKRYO = WRK-NYUTOKRYO
                                             + WRK-ACCT90(IDY)
                  END-IF
                  IF     FLG-GAIHAKU  =  ZERO
                    MOVE     ZERO     TO    FLG-ARI
                    PERFORM  VARYING  ID1    FROM    1   BY  1
                        UNTIL ( ID1                          > 10    )  
                          OR  ( RECE82-NYUTOKNISSU(ID1)      = ZERO  )
                          OR  ( FLG-ARI                      = 1     )
                      IF  RECE82-NYUTOKRYO-RYAKU(ID1)  =  WRK-RYAKUSHO
                            ADD   1   TO   RECE82-NYUTOKNISSU(ID1)
                            ADD   WRK-NYUTOKRYO
                                      TO   RECE82-NYUTOKKEI(ID1)
                            MOVE  1   TO   FLG-ARI
                      END-IF
                    END-PERFORM  
                    IF  FLG-ARI  =  ZERO  
                      ADD        1           TO  RECE82-NYUTOKNISSU(ID1)
                      MOVE   WRK-RYAKUSHO    TO  RECE82-NYUTOKRYO-RYAKU
                                                                   (ID1)
      ***             略称が空白の場合の為の処置
                      MOVE   99999999        TO  RECE82-NYUTOKRYO(ID1)
      *
                      ADD    WRK-NYUTOKRYO   
                                       TO  RECE82-NYUTOKKEI(ID1)
                    END-IF
                  ELSE
                    MOVE     ZERO     TO    FLG-ARI
                    PERFORM  VARYING  ID1    FROM    1   BY  1
                        UNTIL ( ID1                          > 10    )  
                          OR  ( RECE82-NYUTOKNISSU(ID1)      = ZERO  )
                          OR  ( FLG-ARI                      = 1     )
                      IF  RECE82-NYUTOKRYO(ID1)  =  WRK-NYUTOKRYO
                            ADD   1   TO   RECE82-NYUTOKNISSU(ID1)
                            ADD   WRK-NYUTOKRYO
                                      TO   RECE82-NYUTOKKEI(ID1)
                            MOVE  1   TO   FLG-ARI
                      END-IF
                    END-PERFORM  
                    IF  FLG-ARI  =  ZERO  
                      ADD        1           TO  RECE82-NYUTOKNISSU(ID1)
      ***             点数がゼロの場合の為の処置
                      MOVE   "９９９９９"    TO  RECE82-NYUTOKRYO-RYAKU
                                                                   (ID1)
      *
                      MOVE   WRK-NYUTOKRYO   TO  RECE82-NYUTOKRYO(ID1)
                      ADD    WRK-NYUTOKRYO   
                                       TO  RECE82-NYUTOKKEI(ID1)
                    END-IF
                  END-IF
           END-EVALUATE
      *
           .
       2301-NYUINACCT-GET-EXT.
           EXIT.
      *
      **************************************************************
      *    入院基本料加減算点数の計算
      **************************************************************
       2301-NYUINACCT-GET2-SEC           SECTION.
      *
           IF  NACCT-SRYCDTOTAL       =  190080470   OR                 
                                         190799670   OR                 
                                         190080570   OR                 
                                         190799770   OR                 
                                         190111690   OR                 
                                         190809090   OR                 
                                         190111790   OR                 
                                         190809190                      
              CONTINUE                                                  
           ELSE                                                         
      *
              EVALUATE   WRK-DAY1-NYUTENTTLKBN(IDY)
                 WHEN   903
                    COMPUTE  RECE82-NYUKHNKEI2  =
                             RECE82-NYUKHNKEI2  +  NACCT-ZAITEN
              END-EVALUATE
      *
           END-IF
      *
           .
       2301-NYUINACCT-GET2-EXT.
           EXIT.
      *
      **************************************************************
      *    入院基本料と加減算点数の取得
      **************************************************************
       2301-NYUINKHN-GET-SEC           SECTION.
      *
           IF   NACCT-SRYKBN  =  "90"                                   
                 MOVE   903   TO  WRK-NYUTENTTLKBN                      
           ELSE                                                         
                 MOVE   920   TO  WRK-NYUTENTTLKBN                      
           END-IF                                                       
      *
           MOVE    ZERO               TO   WRK-KHNTEN
           MOVE    ZERO               TO   WRK-KHNTEN2
           MOVE    SPACE              TO   WRK-RYAKUSHO
           MOVE    ZERO               TO   NYUINACT-IDX2
           MOVE    ZERO               TO   WRK-KSNTEN
           MOVE    SPACE              TO   WRK-GAIHAKU-SRYCD
           MOVE    ZERO               TO   WRK-GAIHAKU-KHNTEN
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPID       TO   NSRY-HOSPID
           MOVE    NACCT-NYUGAIKBN    TO   NSRY-NYUGAIKBN
           MOVE    NACCT-PTID         TO   NSRY-PTID
           MOVE    NACCT-SRYYM        TO   NSRY-SRYYM
           MOVE    NACCT-ZAINUM       TO   NSRY-ZAINUM
           MOVE    NYUINACT-REC       TO   MCPDATA-REC
           MOVE    "DBSELECT"         TO   MCP-FUNC
           MOVE    "NYUINACT-KEY9"    TO   ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC             =    ZERO
               MOVE    "NYUINACT-KEY9"     TO   ORC-DBPATH
               PERFORM NYUINACT-READ-SEC
           ELSE
               MOVE    1              TO   FLG-NYUINACT
           END-IF
      *
           IF      FLG-NYUINACT        =   ZERO
      *
               MOVE      ZERO          TO  FLG-NYUKHN  
               PERFORM   VARYING  NYUINACT-IDX  FROM 1  BY  1
                 UNTIL  (FLG-NYUKHN         =   1)    OR
                        (NYUINACT-IDX       >   5)    OR
                        (NSRY-SRYCD(NYUINACT-IDX)  =  SPACE)
                     MOVE    SPACE         TO   TNS-TENSU-REC
                     INITIALIZE                 TNS-TENSU-REC
                     MOVE    NSRY-SRYCD(NYUINACT-IDX) TO   TNS-SRYCD
                     MOVE    NACCT-SRYYM        TO  ORC-DBYMD(1:6)
                     MOVE    "01"               TO  ORC-DBYMD(7:2)
                     PERFORM  TENSU-READ-SEC
                     IF       FLG-TENSU      =    ZERO
                         IF   TNS-DATAKBN    =    1
                              MOVE   TNS-TEN   TO   WRK-KHNTEN
      *                       初期加算（及び長期減算）の点数取得
                              COMPUTE   WRK-KSNTEN  =  NACCT-ZAITEN
                                                    -  WRK-KHNTEN
      *                       看護比率基準未達時の入院基本点数の取得
                              PERFORM  23011-GAIHAKU-NYUINKHN-SET-SEC
                              IF   WRK-GAIHAKU-KHNTEN  NOT =  ZERO
                                 MOVE   WRK-GAIHAKU-KHNTEN
                                               TO   WRK-KHNTEN2
                              END-IF
                              MOVE   NYUINACT-IDX
                                               TO   NYUINACT-IDX2
                              MOVE   1         TO   FLG-NYUKHN
                         END-IF
                     END-IF                  
                     MOVE    "DBCLOSE"          TO  MCP-FUNC
                     MOVE    "TENSU-KEY"        TO  ORC-DBPATH
                     CALL    "ORCMCPSUB"        USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
               END-PERFORM
      *
               IF    WRK-NYUTENTTLKBN     =   920  
               AND   NYUINACT-IDX2    NOT =   ZERO
      *
                 MOVE    SPACE         TO   NYURYAKUSHO-REC
                 INITIALIZE                 NYURYAKUSHO-REC
                 MOVE    NSRY-SRYCD(NYUINACT-IDX2) 
                                       TO   NYURYAKUSHO-SRYCD
                 MOVE    NACCT-SRYYM   TO   ORC-DBYMD(1:6)
                 MOVE    "01"          TO   ORC-DBYMD(7:2)
                 PERFORM  NYURYAKUSHO-READ-SEC
                 IF       FLG-NYURYAKUSHO    =    ZERO
                   MOVE     NYURYAKUSHO-RYAKUSHO
                                       TO  WRK-RYAKUSHO
                 END-IF                  
                 MOVE    "DBCLOSE"               TO  MCP-FUNC
                 MOVE    "NYUINRYAKUSHO-KEY"     TO  ORC-DBPATH
                 CALL    "ORCMCPSUB"             USING
                                                 MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
      *
               END-IF 
      *
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "NYUINACT-KEY9"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       2301-NYUINKHN-GET-EXT.
           EXIT.
      *
      **************************************************************
      *    外泊時の入院基本料取得
      **************************************************************
       23011-GAIHAKU-NYUINKHN-SET-SEC           SECTION.
      *
           EVALUATE  TNS-SRYCD
               WHEN  "190078210"
                     MOVE  "190077410"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078310"
                     MOVE  "190077510"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078410"
                     MOVE  "190077610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078510"
                     MOVE  "190077710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078610"
                     MOVE  "190077810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078710"
                     MOVE  "190077910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078810"
                     MOVE  "190078010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190078910"
                     MOVE  "190078110"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190082410"
                     MOVE  "190081710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082510"
                     MOVE  "190081810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082610"
                     MOVE  "190081910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082710"
                     MOVE  "190082010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082810"
                     MOVE  "190082110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190082910"
                     MOVE  "190082210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190083010"
                     MOVE  "190082310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190084310"
                     MOVE  "190083610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084410"
                     MOVE  "190083710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084510"
                     MOVE  "190083810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084610"
                     MOVE  "190083910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084710"
                     MOVE  "190084010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084810"
                     MOVE  "190084110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190084910"
                     MOVE  "190084210"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190087410"
                     MOVE  "190085910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087510"
                     MOVE  "190086010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087610"
                     MOVE  "190086110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087710"
                     MOVE  "190086210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087810"
                     MOVE  "190086310"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190087910"
                     MOVE  "190086410"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088010"
                     MOVE  "190086510"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088110"
                     MOVE  "190086610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088210"
                     MOVE  "190086710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088310"
                     MOVE  "190086810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088410"
                     MOVE  "190086910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088510"
                     MOVE  "190087010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088610"
                     MOVE  "190087110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088710"
                     MOVE  "190087210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190088810"
                     MOVE  "190087310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190094710"
                     MOVE  "190093710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190094810"
                     MOVE  "190093810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190094910"
                     MOVE  "190093910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190095010"
                     MOVE  "190094010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190095110"
                     MOVE  "190094110"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190797410"
                     MOVE  "190796610"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797510"
                     MOVE  "190796710"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797610"
                     MOVE  "190796810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797710"
                     MOVE  "190796910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797810"
                     MOVE  "190797010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190797910"
                     MOVE  "190797110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190798010"
                     MOVE  "190797210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190798110"
                     MOVE  "190797310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190803510"
                     MOVE  "190802810"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803610"
                     MOVE  "190802910"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803710"
                     MOVE  "190803010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803810"
                     MOVE  "190803110"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190803910"
                     MOVE  "190803210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190804010"
                     MOVE  "190803310"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190804110"
                     MOVE  "190803410"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190091210"
                     MOVE  "190090210"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190091310"
                     MOVE  "190090310"      TO   WRK-GAIHAKU-SRYCD
      *
               WHEN  "190109670"
                     MOVE  "190097010"      TO   WRK-GAIHAKU-SRYCD
               WHEN  "190808870"
                     MOVE  "190805710"      TO   WRK-GAIHAKU-SRYCD
           END-EVALUATE
      *
           IF    WRK-GAIHAKU-SRYCD    NOT =   SPACE
               MOVE    SPACE         TO   TNS-TENSU-REC
               INITIALIZE                 TNS-TENSU-REC
               MOVE    WRK-GAIHAKU-SRYCD  TO  TNS-SRYCD
               MOVE    NACCT-SRYYM        TO  ORC-DBYMD(1:6)
               MOVE    "01"               TO  ORC-DBYMD(7:2)
               PERFORM  TENSU-READ-SEC
               IF       FLG-TENSU      =    ZERO
                        MOVE   TNS-TEN    TO  WRK-GAIHAKU-KHNTEN
               END-IF                  
           END-IF
      *
           .
       23011-GAIHAKU-NYUINKHN-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       2301-RECE82-TENSOU23-SEC                 SECTION.
      *
           PERFORM    VARYING   IDY   FROM   1    BY   1
                      UNTIL    IDY   >      31
                  IF  ACCT-DAY(1 IDY)   NOT =    ZERO
                      PERFORM      23011-SRYACCT-GET-SEC
                  END-IF
           END-PERFORM
      *
           .
       2301-RECE82-TENSOU23-EXT.
           EXIT.
      *
      **************************************************************
      *    診療会計の入院基本料加減算点数の計算
      **************************************************************
       23011-SRYACCT-GET-SEC           SECTION.
      *
           EVALUATE   WRK-DAY1-NYUTENTTLKBN(IDY)
              WHEN   903
                 IF        ACCT-SRYCDTOTAL    =    101910050
                                              OR   101910060
                                              OR   101920010
                      COMPUTE  RECE82-NYUTOKKEI2  =
                               RECE82-NYUTOKKEI2  +
                               (ACCT-ZAITEN * ACCT-DAY(1 IDY))
                 ELSE
                    IF     ACCT-SRYCDTOTAL    =    190080470
                                              OR   190799670
                                              OR   190080570
                                              OR   190799770
                                              OR   190111690
                                              OR   190809090
                                              OR   190111790
                                              OR   190809190
      *
                                              OR   190109170
                                              OR   190807570
                                              OR   190109270
                                              OR   190808670
                      CONTINUE 
                    ELSE
                      COMPUTE  RECE82-NYUKHNKEI2  =
                               RECE82-NYUKHNKEI2  +
                               (ACCT-ZAITEN * ACCT-DAY(1 IDY))
                    END-IF
                 END-IF
              WHEN   920
                 IF        ACCT-SRYCDTOTAL    =    101910050
                                              OR   101910060
                                              OR   101920010
                    COMPUTE  RECE82-NYUTOKKEI2  =
                             RECE82-NYUTOKKEI2  +
                             (ACCT-ZAITEN * ACCT-DAY(1 IDY))
                 END-IF
           END-EVALUATE
      *
           .
       23011-SRYACCT-GET-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの編集（Ｆ００２）
      *****************************************************************
       240-RECE82-HENSYU3-SEC                SECTION.
      *
           INITIALIZE                            NYUINACCT-REC
           MOVE    RECE82-HOSPID         TO      NACCT-HOSPID
           MOVE    RECE82-NYUGAIKBN      TO      NACCT-NYUGAIKBN
           MOVE    RECE82-PTID           TO      NACCT-PTID
           MOVE    RECE82-SRYYM          TO      NACCT-SRYYM
           MOVE    NYUINACCT-REC         TO      MCPDATA-REC
           MOVE    "DBSELECT"            TO      MCP-FUNC
           MOVE    "NYUINACCT-KEY7"      TO      ORC-DBPATH
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           IF      MCP-RC             =       ZERO
      *
               MOVE    "NYUINACCT-KEY7"  TO      ORC-DBPATH
               PERFORM  NYUINACCT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                 IF     NACCT-ZAISKBKBN          =    "1"  
                 AND    NACCT-SRYCDTOTAL   NOT   =    099999916
      *
                   PERFORM  VARYING  IDY    FROM    1   BY  1
                                  UNTIL   IDY     >       31
      *
                         IF  WRK-DAY5(IDY)  =  RECE82-HKNCOMBI
                              IF   WRK-DAY1-NYUTENTTLKBN(IDY) = 903
                              AND  NACCT-ZAITEN    NOT =    ZERO  
                              AND  NACCT-DAY(IDY)  NOT =    ZERO  
                                   PERFORM   2401-NYUINKHN-GET3-SEC
                                   MOVE    31    TO    IDY
                              END-IF
                         END-IF
      *
                   END-PERFORM
      *
                 END-IF
      *
                 MOVE          "NYUINACCT-KEY7"  TO   ORC-DBPATH
                 PERFORM        NYUINACCT-READ-SEC
               END-PERFORM
      *
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY7"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
      *
           INITIALIZE                            NYUINACCT-REC
           MOVE    RECE82-HOSPID         TO      NACCT-HOSPID
           MOVE    RECE82-NYUGAIKBN      TO      NACCT-NYUGAIKBN
           MOVE    RECE82-PTID           TO      NACCT-PTID
           MOVE    RECE82-SRYYM          TO      NACCT-SRYYM
           MOVE    NYUINACCT-REC         TO      MCPDATA-REC
           MOVE    "DBSELECT"            TO      MCP-FUNC
           MOVE    "NYUINACCT-KEY7"      TO      ORC-DBPATH
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           IF      MCP-RC             =       ZERO
      *
               MOVE    "NYUINACCT-KEY7"  TO      ORC-DBPATH
               PERFORM  NYUINACCT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                 IF     NACCT-ZAISKBKBN    =    "6"  
      *
                   PERFORM  VARYING  IDY    FROM    1   BY  1
                                  UNTIL   IDY     >       31
      *
                         IF  WRK-DAY5(IDY)  =  RECE82-HKNCOMBI
                              IF   (NACCT-ZAITEN    NOT =    ZERO)  
                              AND  (NACCT-DAY(IDY)  NOT =    ZERO)  
                              AND  (WRK-DAY2(IDY)  =    ZERO  OR  4)
                                   PERFORM   2401-NYUINKHN-GET3-SEC
                                   MOVE    31    TO    IDY
                              END-IF
                         END-IF
      *
                   END-PERFORM
      *
                 END-IF
      *
                 MOVE          "NYUINACCT-KEY7"  TO   ORC-DBPATH
                 PERFORM        NYUINACCT-READ-SEC
               END-PERFORM
      *
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY7"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
      *+++
      *
           INITIALIZE                           SRYACCT-REC
           MOVE    RECE82-HOSPID        TO      ACCT-HOSPID
           MOVE    RECE82-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    RECE82-PTID          TO      ACCT-PTID
           MOVE    RECE82-SRYYM         TO      ACCT-SRYYM
           MOVE    RECE82-HKNCOMBI      TO      ACCT-HKNCOMBI
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACCT-KEY22"      TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING   MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACCT-KEY22"  TO      ORC-DBPATH
               PERFORM  SRYACCT-READ-SEC
               PERFORM  UNTIL
                  (FLG-SRYACCT        =    1)
                   IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                        (ACCT-ZAIKAISU  NOT =    ZERO)
                     IF   ACCT-SRYKBN  =  "90" OR "92"  
                       PERFORM VARYING IDY FROM 1 BY 1
                          UNTIL    IDY    >   31
                          IF  ACCT-DAY(1 IDY) NOT = ZERO
                                PERFORM   2401-ACCTKHN-GET3-SEC
                                MOVE  31  TO  IDY
                          END-IF
                       END-PERFORM
                     END-IF
                   END-IF
                   MOVE     "SRYACCT-KEY22"  TO   ORC-DBPATH
                   PERFORM   SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACCT-KEY22"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
      *    未実施減算（システム管理設定分）
      *
           IF   FLG-MIJISI-GENSAN   =   1
      *
               IF   FLG-MIJISI-INNAI   =   1
                 MOVE    190080570         TO   WRK-SRYCD
                 MOVE    WRK-SRYYMD-TAIHI  TO   WRK-SRYYMD
      *
                 PERFORM   24011-RYAKUSYO-HENSYU-SEC
               END-IF
      *
               IF   FLG-MIJISI-IRYO    =   1
                 MOVE    190111690         TO   WRK-SRYCD
                 MOVE    WRK-SRYYMD-TAIHI  TO   WRK-SRYYMD
      *
                 PERFORM   24011-RYAKUSYO-HENSYU-SEC
               END-IF
      *
               IF   FLG-MIJISI-JYOKU   =   1
                 MOVE    190111790         TO   WRK-SRYCD
                 MOVE    WRK-SRYYMD-TAIHI  TO   WRK-SRYYMD
      *
                 PERFORM   24011-RYAKUSYO-HENSYU-SEC
               END-IF
      *
           END-IF
      *
           .
       240-RECE82-HENSYU3-EXT.
           EXIT.
      *
      **************************************************************
      *    入院略称の取得
      **************************************************************
       2401-NYUINKHN-GET3-SEC           SECTION.
      *
           INITIALIZE                      NYUINACT-REC
           MOVE    NACCT-HOSPID       TO   NSRY-HOSPID
           MOVE    NACCT-NYUGAIKBN    TO   NSRY-NYUGAIKBN
           MOVE    NACCT-PTID         TO   NSRY-PTID
           MOVE    NACCT-SRYYM        TO   NSRY-SRYYM
           MOVE    NACCT-ZAINUM       TO   NSRY-ZAINUM
           MOVE    NYUINACT-REC       TO   MCPDATA-REC
           MOVE    "DBSELECT"         TO   MCP-FUNC
           MOVE    "NYUINACT-KEY9"    TO   ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC             =       ZERO
      *
               MOVE    "NYUINACT-KEY9"  TO      ORC-DBPATH
               PERFORM  NYUINACT-READ-SEC
               PERFORM  UNTIL  (FLG-NYUINACT  =    "1")
      *
                 PERFORM   VARYING  NYUINACT-IDX  FROM 1  BY  1
                      UNTIL  (NYUINACT-IDX       >   5)    OR
                             (NSRY-SRYCD(NYUINACT-IDX)  =  SPACE)
      *
                       MOVE    NSRY-SRYCD(NYUINACT-IDX) 
                                              TO  WRK-SRYCD
                       MOVE    NACCT-SRYYM    TO  WRK-SRYYMD-TAIHI(1:6)
                       MOVE    "01"           TO  WRK-SRYYMD-TAIHI(7:2)
                       MOVE    NACCT-SRYYM    TO  WRK-SRYYMD(1:6)
                       MOVE    "01"           TO  WRK-SRYYMD(7:2)
      *
                       PERFORM   24011-RYAKUSYO-HENSYU-SEC
      *
                       MOVE    "DBCLOSE"               TO  MCP-FUNC
                       MOVE    "NYUINRYAKUSHO-KEY"     TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"             USING
                                                       MCPAREA
                                                       ORCMCPAREA
                                                       MCPDATA-REC
                 END-PERFORM
      *
                 MOVE          "NYUINACT-KEY9"  TO   ORC-DBPATH
                 PERFORM        NYUINACT-READ-SEC
               END-PERFORM
      *
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "NYUINACT-KEY9"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       2401-NYUINKHN-GET3-EXT.
           EXIT.
      *
      **************************************************************
      *    入院略称の取得（診療会計）
      **************************************************************
       2401-ACCTKHN-GET3-SEC           SECTION.
      *
           INITIALIZE                           SRYACT-REC
           MOVE    ACCT-HOSPID          TO      SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN       TO      SRY-NYUGAIKBN
           MOVE    ACCT-PTID            TO      SRY-PTID
           MOVE    ACCT-SRYYM           TO      SRY-SRYYM
           MOVE    ACCT-ZAINUM          TO      SRY-ZAINUM
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACT-KEY9"        TO      ORC-DBPATH
           CALL    "ORCMCPSUB"          USING   MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACT-KEY9"    TO      ORC-DBPATH
               PERFORM  SRYACT-READ-SEC
               PERFORM  UNTIL  FLG-SRYACT    =    1
                   PERFORM   VARYING   SRYACT-IDX  FROM  1   BY   1
                             UNTIL    (SRYACT-IDX    >   5)  OR
                                      (SRY-SRYCD(SRYACT-IDX)
                                                         =   SPACE)
      *
                       MOVE    SRY-SRYCD(SRYACT-IDX)
                                                  TO  WRK-SRYCD
                       MOVE    ACCT-SRYYM         TO  WRK-SRYYMD(1:6)
                       MOVE    "01"               TO  WRK-SRYYMD(7:2)
      *
                       PERFORM   24011-RYAKUSYO-HENSYU-SEC
      *
                       MOVE    "DBCLOSE"               TO  MCP-FUNC
                       MOVE    "NYUINRYAKUSHO-KEY"     TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"             USING
                                                       MCPAREA
                                                       ORCMCPAREA
                                                       MCPDATA-REC
                   END-PERFORM
                   MOVE     "SRYACT-KEY9"    TO   ORC-DBPATH
                   PERFORM   SRYACT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACT-KEY9"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       2401-ACCTKHN-GET3-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院略称の編集
      *****************************************************************
       24011-RYAKUSYO-HENSYU-SEC                SECTION.
      *
           MOVE    SPACE         TO   NYURYAKUSHO-REC
           INITIALIZE                 NYURYAKUSHO-REC
      *
           MOVE    WRK-SRYCD     TO   NYURYAKUSHO-SRYCD
           MOVE    WRK-SRYYMD    TO   ORC-DBYMD
           PERFORM  NYURYAKUSHO-READ-SEC
           IF       FLG-NYURYAKUSHO    =    ZERO
              MOVE     ZERO     TO    FLG-ARI
              PERFORM  VARYING  ID1    FROM    1   BY  1
                    UNTIL   ID1                   > 20
                      OR    RECE82-NYUSYUBETU(ID1) = SPACE
                      OR    FLG-ARI                = 1 
                 IF  RECE82-NYUSYUBETU(ID1)  
                            =  NYURYAKUSHO-RYAKUSHO
                     MOVE  1   TO   FLG-ARI
                 END-IF
              END-PERFORM  
              IF  FLG-ARI  =  ZERO  
                     MOVE   NYURYAKUSHO-RYAKUSHO
                               TO   RECE82-NYUSYUBETU(ID1)
              END-IF
      *
              IF   WRK-SRYCD  =  "190109670"  OR  "190808870"
      *
                 MOVE     ZERO     TO    FLG-ARI
                 PERFORM  VARYING  ID1    FROM    1   BY  1
                       UNTIL   ID1                   > 20
                         OR    RECE82-NYUSYUBETU(ID1) = SPACE
                         OR    FLG-ARI                = 1 
                    IF  RECE82-NYUSYUBETU(ID1)(1:4)   =   "有看"
                        MOVE  1   TO   FLG-ARI
                    END-IF
                 END-PERFORM  
                 IF  FLG-ARI  =  ZERO  
                        MOVE   "有看"
                                  TO   RECE82-NYUSYUBETU(ID1)(1:4)
                 END-IF
      *
              END-IF
      *
           END-IF                  
      *
           .
       24011-RYAKUSYO-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの編集（Ｆ００２）
      *****************************************************************
       250-RECE82-HENSYU4-SEC                SECTION.
      *
           PERFORM  VARYING  IDY    FROM    1   BY  1
                          UNTIL   IDY     >       31
      *
                 IF  WRK-DAY5(IDY)  =  RECE82-HKNCOMBI
                      IF   (WRK-DAY4(IDY)   NOT =    ZERO)  
                      AND  (WRK-DAY2(IDY)  =    ZERO  OR  4)
                           PERFORM   2501-NYUINKHN-GET4-SEC
                      END-IF
                 END-IF
      *
           END-PERFORM
      *
           .
       250-RECE82-HENSYU4-EXT.
           EXIT.
      *
      **************************************************************
      *    食事略称の取得
      **************************************************************
       2501-NYUINKHN-GET4-SEC           SECTION.
      *
           EVALUATE   WRK-DAY4(IDY)
             WHEN  1
                EVALUATE   WRK-SHOKUJIRYOYO
                  WHEN  1
                     MOVE    "197000110"  TO  WRK-SRYCD
                     PERFORM  25011-NYUINKHN-SET4-SEC
                     IF    WRK-TOKUKANRIKASAN  =  1
                        MOVE    "197000270"  TO  WRK-SRYCD
                        PERFORM  25011-NYUINKHN-SET4-SEC
                     END-IF
                     IF    WRK-DAY41(IDY)  =  1
                        MOVE    "197000570"  TO  WRK-SRYCD
                        PERFORM  25011-NYUINKHN-SET4-SEC
                     END-IF
                  WHEN  2
                     MOVE    "197000710"  TO  WRK-SRYCD
                     PERFORM  25011-NYUINKHN-SET4-SEC
                END-EVALUATE
             WHEN  2
             WHEN  3
             WHEN  4
                     MOVE    "197000110"  TO  WRK-SRYCD
                     PERFORM  25011-NYUINKHN-SET4-SEC
                     IF    WRK-TOKUKANRIKASAN  =  1
                        MOVE    "197000270"  TO  WRK-SRYCD
                        PERFORM  25011-NYUINKHN-SET4-SEC
                     END-IF
                     IF    WRK-DAY41(IDY)  =  1
                        MOVE    "197000570"  TO  WRK-SRYCD
                        PERFORM  25011-NYUINKHN-SET4-SEC
                     END-IF
           END-EVALUATE
      *
           .
       2501-NYUINKHN-GET4-EXT.
           EXIT.
      *
      **************************************************************
      *    食事略称のセット
      **************************************************************
       25011-NYUINKHN-SET4-SEC           SECTION.
      *
           MOVE    SPACE          TO   NYURYAKUSHO-REC
           INITIALIZE                  NYURYAKUSHO-REC
           MOVE    WRK-SRYCD      TO   NYURYAKUSHO-SRYCD
           MOVE    RECE82-SRYYM   TO   ORC-DBYMD(1:6)
           MOVE    "01"           TO   ORC-DBYMD(7:2)
           PERFORM  NYURYAKUSHO-READ-SEC
           IF       FLG-NYURYAKUSHO    =    ZERO
                MOVE     ZERO     TO    FLG-ARI
                PERFORM  VARYING  ID1    FROM    1   BY  1
                       UNTIL   ID1                   > 3
                         OR    RECE82-SHOKUJISYUBETU(ID1) = SPACE
                         OR    FLG-ARI                = 1 
                    IF  RECE82-SHOKUJISYUBETU(ID1)  
                               =  NYURYAKUSHO-RYAKUSHO
                        MOVE  1   TO   FLG-ARI
                    END-IF
                END-PERFORM  
                IF  FLG-ARI  =  ZERO  
                    MOVE   NYURYAKUSHO-RYAKUSHO
                             TO   RECE82-SHOKUJISYUBETU(ID1)
                END-IF
           END-IF                  
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "NYUINRYAKUSHO-KEY"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       25011-NYUINKHN-SET4-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの編集（Ｆ００２）
      *****************************************************************
       260-RECE82-HENSYU9-SEC                SECTION.
      *
      *     点滴薬剤（器材）まとめ処理
           PERFORM    2601-TENTEK-MATOME-SEC
      *
           MOVE       ZERO              TO      WRK-TENTEK-FLG
                                                WRK-TENTEK-FLG2
      *
           INITIALIZE                           SRYACCT-REC
           MOVE    RECE82-HOSPID        TO      ACCT-HOSPID
           MOVE    RECE82-NYUGAIKBN     TO      ACCT-NYUGAIKBN
           MOVE    RECE82-PTID          TO      ACCT-PTID
           MOVE    RECE82-SRYYM         TO      ACCT-SRYYM
           MOVE    RECE82-HKNCOMBI      TO      ACCT-HKNCOMBI
           MOVE    SRYACCT-REC          TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACCT-KEY22"      TO      ORC-DBPATH
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACCT-KEY22"  TO      ORC-DBPATH
               PERFORM  SRYACCT-READ-SEC
               PERFORM  UNTIL
                  (FLG-SRYACCT        =    1)
                   IF   (ACCT-ZAITEN    NOT =    ZERO)    AND
                        (ACCT-ZAIKAISU  NOT =    ZERO)
                       MOVE    ZERO     TO    WRK-TEN
                                              WRK-KIN
                                              WRK-KIN2
                       PERFORM   2601-ENDATE-HANTEI-SEC
                       IF    RECE82-HKNKBN   =   "4"
                         IF   ACCT-SRYKBN  =  "80"
                             PERFORM   2601-SINDAN-HANTEI-SEC
                         END-IF
      *
                         IF  WRK-TENTEK-FLG2  =   ZERO
                           PERFORM VARYING IDY FROM 1  BY 1
                                       UNTIL    IDY     >    31
                             COMPUTE  TBL-YKZTEN-JI(IDY)  =
                                      TBL-YKZTEN-JI(IDY)  +
                                      WRK-TENTEK-YKZTEN2(IDY) +
                                      WRK-TENTEK-KIZAITEN2(IDY)
                           END-PERFORM
                           MOVE  1        TO   WRK-TENTEK-FLG2
                         END-IF
      *
                         PERFORM VARYING IDY FROM 1  BY 1
                                   UNTIL    IDY     >    31
                           IF  ACCT-DAY(1 IDY)   NOT =  ZERO
                                MOVE  ACCT-DAY(1 IDY)  
                                       TO  WRK-ZAIKAISU-JI
                                PERFORM  2601-SYUGITEN-HANTEI-SEC
                           END-IF
                         END-PERFORM
                       END-IF
                       PERFORM   2601-RECE82-TENSOU9-SEC
                   END-IF
                   MOVE     "SRYACCT-KEY22"  TO   ORC-DBPATH
                   PERFORM   SRYACCT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACCT-KEY22"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       260-RECE82-HENSYU9-EXT.
           EXIT.
      *
      *****************************************************************
      *    点滴注射の薬剤（器材）点数算定
      *****************************************************************
       2601-TENTEK-MATOME-SEC                    SECTION.
      *
           INITIALIZE                  WRK-TENTEK
      *
           INITIALIZE                  ORCSTENTEKAREA
           MOVE    "2"                 TO  ORCSTEN-KBN
           MOVE    RECE82-PTID         TO  ORCSTEN-PTID
           MOVE    RECE82-SRYYM        TO  ORCSTEN-SRYYM
           MOVE    RECE82-HKNCOMBI     TO  ORCSTEN-HKNCOMBI
           MOVE    RECE82-HOSPID       TO  SPA-HOSPID
           CALL    "ORCSTENTEK"        USING
                                       SPA-AREA
                                       ORCSTENTEKAREA
      *    薬剤点数と器材点数
           PERFORM  VARYING  IDX1    FROM    1   BY  1
                      UNTIL  IDX1     >       31
      *
              IF  ORCSTEN-ZAITEN(IDX1)  NOT =  ZERO
                 ADD  ORCSTEN-ZAITEN(IDX1)  TO  WRK-TENTEK-YKZTEN
                 ADD  ORCSTEN-ZAITEN(IDX1)  TO  WRK-TENTEK-YKZTEN2
                                                             (IDX1)
              END-IF
      *
           END-PERFORM
      *
           PERFORM  VARYING  IDX1    FROM    1   BY  1
                      UNTIL  IDX1     >       50
                       OR    ORCSTEN-KIZ-ZAITEN(IDX1)  =  ZERO
      *
                MOVE    ZERO   TO   WRK-TENTEK-ZAIKAISU
                PERFORM  VARYING  IDX2    FROM    1   BY  1
                      UNTIL   IDX2     >       31
                  ADD    ORCSTEN-KIZ-DAY(IDX1 IDX2)  
                                     TO  WRK-TENTEK-ZAIKAISU
                END-PERFORM
      *
                COMPUTE  WRK-TENTEK-KIZAITEN  =
                         WRK-TENTEK-KIZAITEN  +
                         ( ORCSTEN-KIZ-ZAITEN(IDX1) *
                           WRK-TENTEK-ZAIKAISU ) 
      **
                MOVE    ZERO   TO   WRK-TENTEK-ZAIKAISU
                PERFORM  VARYING  IDX2    FROM    1   BY  1
                      UNTIL   IDX2     >       31
                  ADD    ORCSTEN-KIZ-DAY(IDX1 IDX2)  
                                     TO  WRK-TENTEK-ZAIKAISU
                  COMPUTE  WRK-TENTEK-KIZAITEN2(IDX2)  =
                           WRK-TENTEK-KIZAITEN2(IDX2)  +
                         ( ORCSTEN-KIZ-ZAITEN(IDX1) *
                           WRK-TENTEK-ZAIKAISU ) 
                END-PERFORM
      *
           END-PERFORM
      *
           .
       2601-TENTEK-MATOME-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計テーブルの内容から診療行為テーブルを読み込み、
      *    円建て項目等であるかの判定
      *****************************************************************
       2601-ENDATE-HANTEI-SEC                 SECTION.
      *
           INITIALIZE                           SRYACT-REC
           MOVE    ACCT-HOSPID          TO      SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN       TO      SRY-NYUGAIKBN
           MOVE    ACCT-PTID            TO      SRY-PTID
           MOVE    ACCT-SRYYM           TO      SRY-SRYYM
           MOVE    ACCT-ZAINUM          TO      SRY-ZAINUM
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACT-KEY9"        TO      ORC-DBPATH
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACT-KEY9"    TO      ORC-DBPATH
               PERFORM  SRYACT-READ-SEC
               PERFORM  UNTIL  FLG-SRYACT    =    1
      *
                 PERFORM   VARYING   SRYACT-IDX  FROM  1   BY   1
                           UNTIL    (SRYACT-IDX    >   5)  OR
                                    (SRY-SRYCD(SRYACT-IDX)
                                                       =   SPACE)
      *
                   MOVE    SPACE         TO   TNS-TENSU-REC
                   INITIALIZE                 TNS-TENSU-REC
                   MOVE    SRY-SRYCD(SRYACT-IDX) TO   TNS-SRYCD
                   MOVE    ACCT-SRYYM         TO  ORC-DBYMD(1:6)
                   MOVE    "01"               TO  ORC-DBYMD(7:2)
                   PERFORM  TENSU-READ-SEC
                   IF       FLG-TENSU      =    ZERO
      *
                     IF    RECE82-HKNKBN   =   "4"
                         IF  SRY-SRYCD(SRYACT-IDX) =  CONS-ROUSAI1  OR
                                                      CONS-ROUSAI2
                            ADD    TNS-TEN      TO    WRK-KIN
                         END-IF
                         IF  SRY-SRYCD(SRYACT-IDX) =  CONS-ROUSAI3  OR
                                                      CONS-ROUSAI4  OR
                                                      CONS-ROUSAI5  OR
                                                      CONS-ROUSAI6  OR
                                                      CONS-ROUSAI7  OR
                                                      CONS-ROUSAI8  OR
                                                      CONS-ROUSAI9  OR
                                                      CONS-ROUSAI10 OR
                                                      CONS-ROUSAI11 OR
                                                      CONS-ROUSAI12 OR
                                                      CONS-ROUSAI13 OR
                                                      CONS-ROUSAI14 OR
                                                      CONS-ROUSAI15 OR
                                                      CONS-ROUSAI16 OR
                                                      CONS-ROUSAI17 OR
                                                      CONS-ROUSAI18 OR
                                                      CONS-ROUSAI19 OR
                                                      CONS-ROUSAI20
                            ADD    TNS-TEN      TO    WRK-KIN2
                         END-IF
                         IF  ( ACCT-SRYKBN                =  "80"    ) 
                         AND ( SRY-SRYCD(SRYACT-IDX)(1:5) =  "09593" ) 
                            ADD    TNS-TEN      TO    WRK-KIN2
                         END-IF
      *                 自賠責・療養担当手当用特例処理
      *                （自賠責の場合、１０点を１２０円に読み替える）
      *                （療養担当手当：１月１回の算定）
                         IF   SRY-SRYCD(SRYACT-IDX) =  CONS-RYOYOTEATE
                            ADD    120          TO    WRK-KIN2
                         END-IF
                     ELSE 
                         IF  SRY-SRYCD(SRYACT-IDX) =  CONS-ROUSAI1  OR
                                                      CONS-ROUSAI2  OR
                                                      CONS-ROUSAI3  OR
                                                      CONS-ROUSAI4  OR
                                                      CONS-ROUSAI5  OR
                                                      CONS-ROUSAI6  OR
                                                      CONS-ROUSAI7  OR
                                                      CONS-ROUSAI8  OR
                                                      CONS-ROUSAI9  OR
                                                      CONS-ROUSAI10 OR
                                                      CONS-ROUSAI11 OR
                                                      CONS-ROUSAI12 OR
                                                      CONS-ROUSAI13 OR
                                                      CONS-ROUSAI14 OR
                                                      CONS-ROUSAI15 OR
                                                      CONS-ROUSAI16 OR
                                                      CONS-ROUSAI17 OR
                                                      CONS-ROUSAI18 OR
                                                      CONS-ROUSAI19 OR
                                                      CONS-ROUSAI20
                            ADD    TNS-TEN      TO    WRK-KIN
                            COMPUTE  WRK-TEN  =   WRK-TEN   +
                                     ( TNS-TEN / 10)
                         END-IF
                     END-IF
      *
                   END-IF
      *
                   MOVE    "DBCLOSE"          TO  MCP-FUNC
                   MOVE    "TENSU-KEY"        TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"        USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
      *
                 END-PERFORM
      *
                 MOVE     "SRYACT-KEY9"    TO   ORC-DBPATH
                 PERFORM   SRYACT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACT-KEY9"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           .
      *
       2601-ENDATE-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計テーブルの内容から診療行為テーブルを読み込み、
      *    自賠責の診断書料・明細書料であるかの判定
      *****************************************************************
       2601-SINDAN-HANTEI-SEC                 SECTION.
      *
           INITIALIZE                           SRYACT-REC
           MOVE    ACCT-HOSPID          TO      SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN       TO      SRY-NYUGAIKBN
           MOVE    ACCT-PTID            TO      SRY-PTID
           MOVE    ACCT-SRYYM           TO      SRY-SRYYM
           MOVE    ACCT-ZAINUM          TO      SRY-ZAINUM
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACT-KEY9"        TO      ORC-DBPATH
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACT-KEY9"    TO      ORC-DBPATH
               PERFORM  SRYACT-READ-SEC
               PERFORM  UNTIL  FLG-SRYACT    =    1
      *
                   PERFORM   VARYING   SRYACT-IDX  FROM  1   BY   1
                             UNTIL    (SRYACT-IDX    >   5)  OR
                                      (SRY-SRYCD(SRYACT-IDX)
                                                         =   SPACE)
      *
                     MOVE    SPACE         TO   TNS-TENSU-REC
                     INITIALIZE                 TNS-TENSU-REC
                     MOVE    SRY-SRYCD(SRYACT-IDX) TO   TNS-SRYCD
                     MOVE    ACCT-SRYYM         TO  ORC-DBYMD(1:6)
                     MOVE    "01"               TO  ORC-DBYMD(7:2)
                     PERFORM  TENSU-READ-SEC
                     IF       FLG-TENSU      =    ZERO
      *
                        IF   SRY-SRYCD(SRYACT-IDX)(1:5) =  "09591"
      *
                          COMPUTE  WRK-SINDAN-TUU = WRK-SINDAN-TUU +
                                                    ACCT-ZAIKAISU
                          COMPUTE  WRK-SINDAN-KIN = WRK-SINDAN-KIN +
                                       ( TNS-TEN  *  ACCT-ZAIKAISU )         
      *
                        END-IF
      *
                        IF   SRY-SRYCD(SRYACT-IDX)(1:5) =  "09592"
      *
      *
                          COMPUTE  WRK-MEISAI-TUU = WRK-MEISAI-TUU +
                                                    ACCT-ZAIKAISU
                          COMPUTE  WRK-MEISAI-KIN = WRK-MEISAI-KIN +
                                       ( TNS-TEN  *  ACCT-ZAIKAISU )         
      *
                        END-IF
      *
                     END-IF
      *
                     MOVE    "DBCLOSE"          TO  MCP-FUNC
                     MOVE    "TENSU-KEY"        TO  ORC-DBPATH
                     CALL    "ORCMCPSUB"        USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
                   END-PERFORM
      *
                   MOVE     "SRYACT-KEY9"    TO   ORC-DBPATH
                   PERFORM   SRYACT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACT-KEY9"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           .
      *
       2601-SINDAN-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計テーブルの内容から診療行為テーブルを読み込み、
      *    日単位の手技点・薬剤点等をセット
      *****************************************************************
       2601-SYUGITEN-HANTEI-SEC                 SECTION.
      *
           INITIALIZE                           SRYACT-REC
           MOVE    ACCT-HOSPID          TO      SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN       TO      SRY-NYUGAIKBN
           MOVE    ACCT-PTID            TO      SRY-PTID
           MOVE    ACCT-SRYYM           TO      SRY-SRYYM
           MOVE    ACCT-ZAINUM          TO      SRY-ZAINUM
           MOVE    SRYACT-REC           TO      MCPDATA-REC
           MOVE    "DBSELECT"           TO      MCP-FUNC
           MOVE    "SRYACT-KEY9"        TO      ORC-DBPATH
           CALL    "ORCMCPSUB"           USING   MCPAREA
                                                 ORCMCPAREA
                                                 MCPDATA-REC
           IF      MCP-RC               =       ZERO
               MOVE    "SRYACT-KEY9"    TO      ORC-DBPATH
               PERFORM  SRYACT-READ-SEC
               PERFORM  UNTIL  FLG-SRYACT    =    1
      *
                 IF    SRY-RENNUM     =     1
      *
                   IF    ACCT-SRYKBN       =  "90"  OR  "92"  OR
                                              "95"  OR  "96"  OR  "97"
                         CONTINUE
                   ELSE
                     IF        ACCT-SRYCDTOTAL    =    630010002
                         COMPUTE  TBL-YKZTEN-JI(IDY)  =
                                  TBL-YKZTEN-JI(IDY)  -
                                 ( WRK-ZAIKAISU-JI * ACCT-ZAITEN   )
                     ELSE 
                      IF    ACCT-SRYKBN  =  "33"
                         EVALUATE  SRY-SRYSYUKBN
                            WHEN  "330"
                            WHEN  "331"
                              COMPUTE  TBL-SYUTEN-JI(IDY)  =
                                       TBL-SYUTEN-JI(IDY)  +
                                      (WRK-ZAIKAISU-JI * ACCT-SYUTEN1)
                            WHEN  "340"
                              COMPUTE  TBL-SYUTEN-JI(IDY)  =
                                       TBL-SYUTEN-JI(IDY)  +
                                      (WRK-ZAIKAISU-JI * ACCT-SYUTEN1)
                              COMPUTE  WRK-KEISAN-JI = 
                                       ACCT-KIZAITEN + ACCT-YKZTEN
                              COMPUTE  TBL-YKZTEN-JI(IDY)  =
                                       TBL-YKZTEN-JI(IDY)  +
                                      (WRK-ZAIKAISU-JI * WRK-KEISAN-JI)
                         END-EVALUATE
                      ELSE
                       IF   ACCT-SRYKBN  =  "70"
                         COMPUTE  WRK-KEISAN-JI   =  ACCT-SYUTEN1
                                                  -  ACCT-SYUTEN2
                         COMPUTE  TBL-SYUTEN-JI(IDY)  =
                                  TBL-SYUTEN-JI(IDY)  +
                                 ( WRK-ZAIKAISU-JI * WRK-KEISAN-JI )
                         COMPUTE  WRK-KEISAN-JI   =  ACCT-SYUTEN2   +
                                                     ACCT-KIZAITEN  +
                                                     ACCT-YKZTEN
                         COMPUTE  TBL-YKZTEN-JI(IDY)  =
                                  TBL-YKZTEN-JI(IDY)  +
                                 ( WRK-ZAIKAISU-JI * WRK-KEISAN-JI )
                       ELSE
                         COMPUTE  TBL-SYUTEN-JI(IDY)  =
                                  TBL-SYUTEN-JI(IDY)  +
                                 ( WRK-ZAIKAISU-JI * ACCT-SYUTEN1  )
                         COMPUTE  WRK-KEISAN-JI   =  ACCT-KIZAITEN  +
                                                     ACCT-YKZTEN
                         COMPUTE  TBL-YKZTEN-JI(IDY)  =
                                  TBL-YKZTEN-JI(IDY)  +
                                 ( WRK-ZAIKAISU-JI * WRK-KEISAN-JI )
                       END-IF
                      END-IF
                     END-IF
                   END-IF
      *
                 END-IF
      *
                 PERFORM   VARYING   SRYACT-IDX   FROM   1   BY   1
                         UNTIL    (SRYACT-IDX            >       5)  OR
                                  (SRY-SRYCD(SRYACT-IDX) =   SPACE)  
      *
                     MOVE    SPACE         TO   TNS-TENSU-REC
                     INITIALIZE                 TNS-TENSU-REC
                     MOVE    SRY-SRYCD(SRYACT-IDX) TO   TNS-SRYCD
                     MOVE    ACCT-SRYYM         TO  ORC-DBYMD(1:6)
                     MOVE    "01"               TO  ORC-DBYMD(7:2)
                     PERFORM  TENSU-READ-SEC
                     IF       FLG-TENSU      =    ZERO
      *
                       IF   SRY-SRYCD(SRYACT-IDX) =  CONS-ROUSAI1  OR
                                                     CONS-ROUSAI2  OR
                                                     CONS-ROUSAI3  OR
                                                     CONS-ROUSAI4  OR
                                                     CONS-ROUSAI5  OR
                                                     CONS-ROUSAI6  OR
                                                     CONS-ROUSAI7  OR
                                                     CONS-ROUSAI8  OR
                                                     CONS-ROUSAI9  OR
                                                     CONS-ROUSAI10 OR
                                                     CONS-ROUSAI11 OR
                                                     CONS-ROUSAI12 OR
                                                     CONS-ROUSAI13 OR
                                                     CONS-ROUSAI14 OR
                                                     CONS-ROUSAI15 OR
                                                     CONS-ROUSAI16 OR
                                                     CONS-ROUSAI17 OR
                                                     CONS-ROUSAI18 OR
                                                     CONS-ROUSAI19 OR
                                                     CONS-ROUSAI20
      *
                            COMPUTE  WRK-TEN-JI   =  TNS-TEN / 10
                            COMPUTE  TBL-SYUTEN-JI(IDY)  =
                                     TBL-SYUTEN-JI(IDY)  -
                              ( WRK-ZAIKAISU-JI * WRK-TEN-JI )
      *
                       END-IF
      *
                       IF  ( ACCT-SRYKBN         =  "80"    ) AND
                           ( SRY-SRYCD(SRYACT-IDX)(1:5) =  "09591" 
                                                        OR "09592" 
                                                        OR "09593" )
                               COMPUTE  WRK-TEN-JI   =  TNS-TEN / 10
                               COMPUTE  TBL-SYUTEN-JI(IDY)  =
                                        TBL-SYUTEN-JI(IDY)  -
                                 ( WRK-ZAIKAISU-JI * WRK-TEN-JI )
                       END-IF
      *
                       IF   SRY-SRYCD(SRYACT-IDX) =  CONS-YOUBUKASAN
                            COMPUTE  TBL-SYUTEN-JI(IDY)  =
                                     TBL-SYUTEN-JI(IDY)  -
                                    ( WRK-ZAIKAISU-JI * TNS-TEN )
                            COMPUTE  TBL-YKZTEN-JI(IDY)  =
                                     TBL-YKZTEN-JI(IDY)  +
                                    ( WRK-ZAIKAISU-JI * TNS-TEN )
                       END-IF
      *
                       IF   SRY-SRYCD(SRYACT-IDX) =  CONS-RYOYOTEATE
                            COMPUTE  TBL-SYUTEN-JI(IDY)  =
                                     TBL-SYUTEN-JI(IDY)  -
                                    ( WRK-ZAIKAISU-JI * TNS-TEN )
                       END-IF
      *
                     END-IF
      *
                     MOVE    "DBCLOSE"          TO  MCP-FUNC
                     MOVE    "TENSU-KEY"        TO  ORC-DBPATH
                     CALL    "ORCMCPSUB"        USING
                                                MCPAREA
                                                ORCMCPAREA
                                                MCPDATA-REC
      *
                 END-PERFORM
      *
                 MOVE     "SRYACT-KEY9"    TO   ORC-DBPATH
                 PERFORM   SRYACT-READ-SEC
               END-PERFORM
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACT-KEY9"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           .
      *
       2601-SYUGITEN-HANTEI-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト中間ファイルの項目転送（Ｆ００２）
      *****************************************************************
       2601-RECE82-TENSOU9-SEC                 SECTION.
      *
           IF        ACCT-SRYKBN   =    "90" OR "92" OR "95"  
                                             OR "96" OR "97"
               CONTINUE
           ELSE
               IF        ACCT-SRYCDTOTAL    =    630010002
                 COMPUTE   TOTALTEN-ACCT =
                           TOTALTEN-ACCT -
                           (ACCT-ZAITEN  *
                            ACCT-ZAIKAISU)
               ELSE
                 IF        WRK-TENTEK-FLG  =   ZERO
                     COMPUTE   TOTALTEN-ACCT        =
                               TOTALTEN-ACCT        +
                               WRK-TENTEK-YKZTEN    +
                               WRK-TENTEK-KIZAITEN
                     MOVE  1        TO   WRK-TENTEK-FLG
                 END-IF
                 IF        ACCT-SRYKBN     =    "33"
                     PERFORM   26011-TENTEK-SYUTEN-SEC
                     COMPUTE   TOTALTEN-ACCT =  
                               TOTALTEN-ACCT +
                               WRK-TENTEK-SYUTEN
                 ELSE
                     COMPUTE   TOTALTEN-ACCT =  
                               TOTALTEN-ACCT +
                               (ACCT-ZAITEN  *  
                                ACCT-ZAIKAISU)
                     IF  ( WRK-KIN  NOT =  ZERO )
                     OR  ( WRK-KIN2 NOT =  ZERO )
                     OR  ( WRK-TEN  NOT =  ZERO )                       
                       COMPUTE  TOTALTEN-ACCT  =  TOTALTEN-ACCT  -
                                                   (WRK-TEN    *
                                                    ACCT-ZAIKAISU)
      *
                       IF    RECE82-HKNKBN   =   "4"
                         COMPUTE  TOTALKIN-ACCT  =  TOTALKIN-ACCT  +
                                                     (WRK-KIN    *
                                                      ACCT-ZAIKAISU)
                         COMPUTE  TOTALKIN2-ACCT =  TOTALKIN2-ACCT +
                                                     (WRK-KIN2   *
                                                      ACCT-ZAIKAISU)

                       ELSE
                         COMPUTE  TOTALKIN-ACCT  =  TOTALKIN-ACCT  +
                                                     (WRK-KIN    *
                                                      ACCT-ZAIKAISU)
                       END-IF
                     END-IF 
                 END-IF
               END-IF
           END-IF
           .
       2601-RECE82-TENSOU9-EXT.
           EXIT.
      *
      *****************************************************************
      *    点滴注射の手技点数算定
      *****************************************************************
       26011-TENTEK-SYUTEN-SEC                    SECTION.
      *
      *診療行為テーブルから診療種別区分の取得
           INITIALIZE                      SRYACT-REC
           MOVE    ACCT-HOSPID        TO   SRY-HOSPID
           MOVE    ACCT-NYUGAIKBN     TO   SRY-NYUGAIKBN
           MOVE    ACCT-PTID          TO   SRY-PTID
           MOVE    ACCT-SRYYM         TO   SRY-SRYYM
           MOVE    ACCT-ZAINUM        TO   SRY-ZAINUM
           MOVE    SRYACT-REC         TO   MCPDATA-REC
           MOVE    "DBSELECT"         TO   MCP-FUNC
           MOVE    "SRYACT-KEY9"      TO   ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC             =    ZERO
                 MOVE    "SRYACT-KEY9"    TO   ORC-DBPATH
                 PERFORM  SRYACT-READ-SEC
           ELSE
                 MOVE    1                TO   FLG-SRYACT
           END-IF
      *
           MOVE    ZERO                   TO   WRK-TENTEK-SYUTEN
      *
           IF   FLG-SRYACT   =    ZERO
                EVALUATE  SRY-SRYSYUKBN
                    WHEN  "330"
                    WHEN  "331"
                       COMPUTE WRK-TENTEK-SYUTEN = WRK-TENTEK-SYUTEN +
                               (ACCT-SYUTEN1 * ACCT-ZAIKAISU)
                    WHEN  "340"
                       COMPUTE WRK-TENTEK-SYUTEN = WRK-TENTEK-SYUTEN +
                               (ACCT-ZAITEN  * ACCT-ZAIKAISU)
                END-EVALUATE
           END-IF
      *
           MOVE    "DBCLOSE"               TO  MCP-FUNC
           MOVE    "SRYACT-KEY9"           TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
           .
       26011-TENTEK-SYUTEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    実日数の項目転送（Ｆ００２）
      *****************************************************************
       270-JNISSU-SET-SEC                    SECTION.
      *
           PERFORM    VARYING    IDY    FROM    1   BY   1
                          UNTIL      IDY    >     31
                IF    TBL-JNISSU-DAY(IDY)  NOT =  SPACE
                          ADD    1      TO    RECE82-JNISSU
                END-IF
           END-PERFORM
      *
           IF       RECE82-JNISSU   =    ZERO  
                     MOVE     999       TO    RECE82-JNISSU
           END-IF
      *
           IF     WRK-TAIHI-FLG       =   1
                MOVE   WRK-TAIHI-FLG       TO  RECE82-KYUKYU-PRTKBN
                MOVE   WRK-TAIHI-SRYYMD    TO  RECE82-KYUKYUYMD
           END-IF
      *
           IF     WRK-SINDAN-TUU      =   ZERO                          
                CONTINUE                                                
           ELSE                                                         
                MOVE   WRK-SINDAN-TUU      TO  RECE82-SINDAN-TUU        
                IF    WRK-TAXKBN      =   "2"                           
                  IF  WRK-TAX1001-KBN =   "1"
                     COMPUTE  WRK-SINDAN-KIN  =  
                             (WRK-SINDAN-KIN  *  1.05)  +  0.5          
                  ELSE
                     COMPUTE  WRK-SINDAN-KIN  =  
                              WRK-SINDAN-KIN  *  1.05                   
                  END-IF
                END-IF                                                  
                MOVE   WRK-SINDAN-KIN      TO  RECE82-SINDAN-KIN        
           END-IF
      *
           IF     WRK-MEISAI-TUU      =   ZERO                          
                CONTINUE                                                
           ELSE                                                         
                MOVE   WRK-MEISAI-TUU      TO  RECE82-MEISAI-TUU        
                IF    WRK-TAXKBN      =   "2"                           
                  IF  WRK-TAX1001-KBN =   "1"
                     COMPUTE  WRK-MEISAI-KIN  =  
                             (WRK-MEISAI-KIN  *  1.05)  +  0.5          
                  ELSE
                     COMPUTE  WRK-MEISAI-KIN  =  
                              WRK-MEISAI-KIN  *  1.05                   
                  END-IF
                END-IF                                                  
                MOVE   WRK-MEISAI-KIN      TO  RECE82-MEISAI-KIN
           END-IF                                                       
      *
           IF    RECE82-HKNKBN   =   "4"
      *
              PERFORM    VARYING    IDX    FROM   1   BY   1
                      UNTIL      IDX    >      10
                    COMPUTE  RECE82-TOTALTEN  = 
                             RECE82-TOTALTEN  + 
                             RECE82-NYUKHNKEI(IDX)
                    COMPUTE  RECE82-TOTALTEN  = 
                             RECE82-TOTALTEN  + 
                             RECE82-NYUTOKKEI(IDX)
              END-PERFORM
      *
              COMPUTE  RECE82-TOTALTEN  = 
                       RECE82-TOTALTEN  + 
                       RECE82-NYUKHNKEI2
              COMPUTE  RECE82-TOTALTEN  = 
                       RECE82-TOTALTEN  + 
                       RECE82-NYUTOKKEI2
      *
              MOVE     RECE82-TOTALTEN   TO   RECE82-NYUTOTALTEN
      *
              PERFORM    VARYING    IDY    FROM    1   BY   1              
                          UNTIL      IDY    >     31                    
      *
                  MOVE  TBL-SYUTEN-JI(IDY)  TO  RECE82-SYUTEN-JI(IDY)     
                  ADD   TBL-SYUTEN-JI(IDY)  TO  RECE82-TOTALTEN
                  MOVE  TBL-YKZTEN-JI(IDY)  TO  RECE82-YKZTEN-JI(IDY)     
                  ADD   TBL-YKZTEN-JI(IDY)  TO  RECE82-TOTALTEN-YAK
      *
              END-PERFORM                                                  
      *
              COMPUTE   WRK-KSNRATE     =  RECE82-KSNRATE  /  100
      *
              COMPUTE   RECE82-TOTALKIN   =  
                  (RECE82-TOTALTEN  *  WRK-TANKA  *  WRK-KSNRATE) 
                                                  +  0.5
      *
              COMPUTE   RECE82-TOTALKIN-YAK =  
                  (RECE82-TOTALTEN-YAK  *  WRK-TANKA)  
                                                  +  0.5
      *
              MOVE     TOTALKIN-ACCT   TO   RECE82-KINGAKU2-SYO
      *
              MOVE     TOTALKIN2-ACCT  TO   RECE82-KINGAKU3-SYO
      *
              COMPUTE  RECE82-TOTALKIN2     =  
                  (RECE82-KINGAKU2-SYO  *  WRK-KSNRATE)  +  0.5  
      *
           ELSE
      *
              PERFORM    VARYING    IDX    FROM   1   BY   1
                      UNTIL      IDX    >      10
                    COMPUTE  RECE82-TOTALTEN  = 
                             RECE82-TOTALTEN  + 
                             RECE82-NYUKHNKEI(IDX)
                    COMPUTE  RECE82-TOTALTEN  = 
                             RECE82-TOTALTEN  + 
                             RECE82-NYUTOKKEI(IDX)
              END-PERFORM
      *
              COMPUTE  RECE82-TOTALTEN  = 
                       RECE82-TOTALTEN  + 
                       RECE82-NYUKHNKEI2
              COMPUTE  RECE82-TOTALTEN  = 
                       RECE82-TOTALTEN  + 
                       RECE82-NYUTOKKEI2
      *
              ADD      TOTALTEN-ACCT    TO   RECE82-TOTALTEN
      *
              COMPUTE  RECE82-TOTALKIN   =   RECE82-TOTALTEN   *
                                             WRK-TANKA    
      *
              MOVE     TOTALKIN-ACCT    TO   RECE82-KINGAKU2-SYO
      *
           END-IF                                                       
      *
      *
           PERFORM    VARYING    IDX    FROM   1   BY   1
                      UNTIL      IDX    >      10
                 IF   RECE82-NYUTOKRYO(IDX)  =  99999999
                    MOVE    ZERO    TO   RECE82-NYUTOKRYO(IDX)
                 END-IF
                 IF   RECE82-NYUTOKRYO-RYAKU(IDX)  
                                             =  "９９９９９"
                    MOVE    SPACE   TO   RECE82-NYUTOKRYO-RYAKU(IDX)
                 END-IF
           END-PERFORM
      *
           .
       270-JNISSU-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    データ更新処理（Ｆ００２）
      *****************************************************************
       RECE82-REWRITE-SEC                SECTION.
      *
           REWRITE   RECE82-REC
      *
           ADD     1                   TO  CNT-MOD
      *
           .
       RECE82-WRITE-EXT.
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
      *    終了処理
      *****************************************************************
       300-TERM-SEC                SECTION.
      *
           CLOSE   RECE82-FILE
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
           DISPLAY "RECE820 IN  :" CNT-IN
           DISPLAY "        MOD :" CNT-MOD
           DISPLAY "*** ORCR0830 END ***"
           .
       300-TERM-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院会計マスター読込
      *****************************************************************
       NYUINACCT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  NYUINACCT-REC
               MOVE    ZERO            TO  FLG-NYUINACCT
           ELSE
               INITIALIZE                  NYUINACCT-REC
               MOVE    1               TO  FLG-NYUINACCT
           END-IF
      *
           .
       NYUINACCT-READ-EXT.
           EXIT.
      *
      **************************************************************
      *    入院診療行為マスター読込
      **************************************************************
       NYUINACT-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  NYUINACT-REC
               MOVE    ZERO            TO  FLG-NYUINACT
           ELSE
               INITIALIZE                  NYUINACT-REC
               MOVE    1               TO  FLG-NYUINACT
           END-IF
      *
           .
       NYUINACT-ERAD-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療会計読込
      *****************************************************************
       SRYACCT-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACCT-REC
               MOVE    ZERO            TO  FLG-SRYACCT
           ELSE
               INITIALIZE                  SRYACCT-REC
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           .
       SRYACCT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為読込
      *****************************************************************
       SRYACT-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACT-REC
               MOVE    ZERO            TO  FLG-SRYACT
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           .
       SRYACT-READ-EXT.
           EXIT.
      *     
      *****************************************************************
      *    点数マスター読込（主キー）
      *****************************************************************
       TENSU-READ-SEC         SECTION.
      *
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
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
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
                   MOVE    ZERO                TO  FLG-TENSU
               ELSE
                   MOVE    1                   TO  FLG-TENSU
                   INITIALIZE                  TNS-TENSU-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TENSU
               INITIALIZE                  TNS-TENSU-REC
           END-IF
      *
           .
       TENSU-READ-EXT.
           EXIT.
      *     
      *****************************************************************
      *    入院略称マスター読込（主キー）
      *****************************************************************
       NYURYAKUSHO-READ-SEC        SECTION.
      *
           MOVE    NYURYAKUSHO-REC     TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "NYUINRYAKUSHO-KEY" TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "NYUINRYAKUSHO-KEY" TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  NYURYAKUSHO-REC
                   MOVE    ZERO                TO  FLG-NYURYAKUSHO
               ELSE
                   MOVE    1                   TO  FLG-NYURYAKUSHO
                   INITIALIZE                  NYURYAKUSHO-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-NYURYAKUSHO
               INITIALIZE                  NYURYAKUSHO-REC
           END-IF
      *
           .
       NYURYAKUSHO-READ-EXT.
           EXIT.
      *
      **************************************************************
      *    システム管理マスタ読み込み処理
      **************************************************************
       SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SYSKANRI-REC
                                           SYS-1001-REC
                                           SYS-4001-REC
                                           SYS-5000-REC
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                  SYSKANRI-REC
                                           SYS-1001-REC
                                           SYS-4001-REC
                                           SYS-5000-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       SYSKANRI-READ-EXT.
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
       900-DBDISCONNECT-EXT.
           EXIT.
      *
      *****************************************************************
      *    中間ファイルＲＥＡＤ処理
      *****************************************************************
       RECE82-READ-SEC            SECTION.
      *
           READ    RECE82-FILE   NEXT
               AT  END
                   MOVE    1     TO    FLG-END
               NOT  AT  END
                   ADD     1     TO    CNT-IN
                   IF   WRK-PARA-SRYYM    NOT =  ZERO
                      CONTINUE
                   ELSE
      *               医療機関減算の取得（システム管理テーブルより）
                      MOVE     ZERO      TO  WRK-SHOKUJIRYOYO
                                             WRK-TOKUKANRIKASAN
      *
                      MOVE     ZERO      TO  FLG-MIJISI-INNAI
                                             FLG-MIJISI-IRYO
                                             FLG-MIJISI-JYOKU
      *
                      MOVE  ZERO         TO  FLG-SET
                      MOVE  RECE82-SRYYM TO  WRK-SYS-SRYYMD(1:6)
                      MOVE  "01"         TO  WRK-SYS-SRYYMD(7:2)
                      PERFORM  VARYING  SYSKAN-IDX  FROM  1  BY  1
                           UNTIL  ( SYSKAN-IDX              >  10   )
                            OR    ( TBL-SYS5000(SYSKAN-IDX) = SPACE )
                            OR    ( FLG-SET                 =   1   )
      *
                       MOVE  TBL-SYS5000(SYSKAN-IDX)  TO  SYS-5000-REC
                       IF   ( SYS-5000-STYUKYMD  <=  WRK-SYS-SRYYMD    )
                       AND  ( WRK-SYS-SRYYMD     <=  SYS-5000-EDYUKYMD )
                          MOVE     1       TO    FLG-SET
                          PERFORM  110-SYSKAN-HENSYU-SEC
                       END-IF
      *
                      END-PERFORM
                   END-IF
           END-READ
           .
       RECE82-READ-EXT.
           EXIT.
      *
