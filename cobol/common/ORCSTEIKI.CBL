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
       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         ORCSTEIKI.
      ****************************************************************
      *    OS           LINUX                                         
      *                                                               
      *    PROGRAM      ORCSTEIKI  /  定期請求用収納作成サブ               
      *                                （入院用）                     
      *  管理者            : 
      *  作成日付    作業者        記述
      *  02/12/16    NACL−小豆沢  新規作成
      ****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
       ENVIRONMENT         DIVISION.
       CONFIGURATION       SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                DIVISION.
       FILE                        SECTION.
      *
       WORKING-STORAGE SECTION.
      *
       01  WRK-AREA.
           03  WRK-EDYMD                   PIC X(08).
      *
       01  WRK-SKYYM-TABLE.
           02  WRK-SKYYM-TBL     OCCURS    2.
              03   WRK-SKYYM               PIC X(06).
              03   WRK-HI-ST               PIC 9(02).
              03   WRK-HI-ED               PIC 9(02).
      *
       01  WRK-DAY-TABLE.
           02  WRK-DAY-TBL       OCCURS    2.
              03 WRK-DAY-T       OCCURS   31.
                 04   WRK-DAY1             PIC 9(04).
                 04   WRK-DAY5             PIC 9(04).
      *
       01  WRK-HANBETU-TABLE.
           02  WRK-HANBETU-TBL OCCURS   10.
              03 WRK-HANBETU-SKYYM         PIC X(06).
              03 WRK-HANBETU-HKNCOMBINUM   PIC 9(04).
              03 WRK-HANBETU-DAY           PIC X(01)   OCCURS   31.
              03 WRK-HANBETU-KAISHI        PIC X(02).
              03 WRK-HANBETU-SYURYO        PIC X(02).
      *
       01  WRK-HANBETU2-TABLE.
           02  WRK-HANBETU2-TBL OCCURS   10.
              03 WRK-HANBETU2-SKYYM        PIC X(06).
              03 WRK-HANBETU2-HKNCOMBINUM  PIC 9(04).
              03 WRK-HANBETU2-DAY          PIC X(01)   OCCURS   31.
      *
       01  WRK-HANBETU-DATA                PIC X(45).
      *
      *    入院点数算定用ワークエリア
       01  WRK-NYUIN-TENSU-AREA.
           03  WRK-KHNTEN                  PIC  9(08). 
           03  WRK-KSNTEN                  PIC  S9(08).
           03  NYUIN-COUNT                 PIC  9(02). 
           03  SINRYO-COUNT                PIC  9(02). 
      *
       01  FLG-AREA.
           03  FLG-HANBETU                 PIC 9(01).
      *
           03  FLG-NYUINACCT               PIC 9(01).
           03  FLG-NYUINACT                PIC 9(01).
           03  FLG-SRYACCT                 PIC 9(01).
           03  FLG-SRYACT                  PIC 9(01).
           03  FLG-HKNCOMBI                PIC 9(01).
           03  FLG-TENSU                   PIC 9(01).
           03  FLG-SYSKANRI                PIC 9(01).
           03  FLG-GAIHAKU-SET             PIC 9(01).
           03  FLG-NYUKHN                  PIC 9(01).
      *
      * 室料差額退避用テーブル     
       01  TABLE-RMSAGAKU.
           03  TBL-RMSAGAKU                PIC 9(05)   OCCURS  50.
      *
      * 外泊退避用テーブル     
       01  TABLE-GAIHAKU.
           03  TBL-GAIHAKU                 PIC 9(01)   OCCURS  31.
      *
      * 保険適用外金額退避用テーブル
       01  HKNTEKGAI-TABLE.
           03  HKNTEKGAI-TBL               OCCURS 11.
               05  TBL-TGMONEY             PIC 9(08).
               05  TBL-TGMONEY-TAX         PIC 9(08).
      *
      * 自費退避用テーブル
       01  JIHI-TABLE.
           03  JIHI-TBL                    OCCURS 5.
               05  TBL-JIHI-TAXNASI        PIC 9(08).
               05  TBL-JIHI-TAXARI         PIC 9(08).
      *
      *    パス名領域
       01  WK-PATH                         PIC X(20).
      *
      *    添え字領域
       01  IDX-AREA.
           03  IDX                         PIC 9(02).
           03  IDY                         PIC 9(02).
           03  IDZ                         PIC 9(02).
           03  SYU-IDX                     PIC 9(02).
           03  NYUINACT-IDX                PIC 9(02).
           03  RMSAGAKU-IDX                PIC 9(02).
           03  GENSAN-IDX                  PIC 9(02).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY                  PIC 9(02).
               05  SYS-MM                  PIC 9(02).
               05  SYS-DD                  PIC 9(02).
           03  WRK-SYSYMD.
               05  WRK-SYSYY               PIC 9(04).
               05  WRK-SYSMM               PIC 9(02).
               05  WRK-SYSDD               PIC 9(02).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK5000.INC".
      *
           COPY    "CPSK5113.INC".
      *
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    ワーク収納マスター
       01  WRK-SYUNOU-REC-T.
         02 WRK-SYUNOU-REC     OCCURS 10.
           COPY    "CPSYUNOU.INC" REPLACING  //SYU-// BY //WRK-SYU-//.
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
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    点数
           COPY    "CPTENSU.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    負担金額計算用パラメタ
       01  WRK-ORCS02-REC.
           COPY    "CPORCS02.INC"   REPLACING  //LNK-// BY //WRK-//.
      *
      *    日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      /
      ***
       LINKAGE             SECTION.
           COPY  "MCPAREA". 
       01  LNK-ORCS02-REC.
           COPY  "CPORCS02.INC".
       01  LNK-SYUNOU-REC-T.
         02 LNK-SYUNOU-REC     OCCURS 10.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //LNK-SYU-//.
      /
       PROCEDURE           DIVISION  USING
                                     MCPAREA
                                     LNK-ORCS02-REC
                                     LNK-SYUNOU-REC-T.
      ******************************************************************
      *        依頼制御処理
      ******************************************************************
       MAIN-RTN            SECTION.
       MAIN-000.
      *
           ACCEPT  SYS-YMD         FROM    DATE.
           COMPUTE WRK-SYSYY       =   SYS-YY      +   2000.
           MOVE    SYS-MM          TO  WRK-SYSMM.
           MOVE    SYS-DD          TO  WRK-SYSDD.
      *
           MOVE    ZERO            TO  LNK-S02-RC.
      *
           INITIALIZE    LNK-SYUNOU-REC-T.
      *
           INITIALIZE    WRK-SYUNOU-REC-T.
      *
           INITIALIZE    WRK-AREA
                         WRK-SKYYM-TABLE
                         WRK-DAY-TABLE
                         WRK-HANBETU-TABLE
                         WRK-HANBETU2-TABLE
                         FLG-AREA.
      *
           PERFORM       NYUIN-HANBETU-SEC.
      *
           PERFORM       SYUNOU-SET-SEC.
      *
      *    入院会計から収納エリアへのセット
           PERFORM    VARYING   IDX    FROM   1   BY   1
                      UNTIL  (IDX            >    10)
                        OR   (LNK-SYU-SKYSTYMD(IDX) =  SPACE)
                      PERFORM       NYUIN-KAIKEI-SET-SEC
           END-PERFORM.
      *
      *    診療会計から収納エリアへのセット
           PERFORM    VARYING   IDX    FROM   1   BY   1
                      UNTIL  (IDX            >    10)
                        OR   (LNK-SYU-SKYSTYMD(IDX) =  SPACE)
                      PERFORM       SINRYO-KAIKEI-SET-SEC
           END-PERFORM.
      *
      *
           PERFORM    VARYING   IDX    FROM   1   BY   1
                              UNTIL  (IDX            >    10)
                                OR   (LNK-SYU-SKYSTYMD(IDX) =  SPACE)
                                OR   (LNK-S02-RC        NOT =  ZERO )
      *
                MOVE     LNK-ORCS02-REC       TO  WRK-ORCS02-REC
                MOVE     LNK-SYUNOU-REC(IDX)  TO  SYUNOU-REC
      *
                IF       IDX   >   1
                   PERFORM    VARYING   IDY    FROM   1   BY   1
                                 UNTIL  IDY    >    IDX - 1
      *
                      MOVE  LNK-SYUNOU-REC(IDY) TO WRK-SYUNOU-REC(IDY)  
      *
                   END-PERFORM
                END-IF
      *
                CALL     "ORCS02"     USING    MCPAREA
                                               WRK-ORCS02-REC
                                               SYUNOU-REC
                                               WRK-SYUNOU-REC-T
      *
                MOVE     SYUNOU-REC           TO  LNK-SYUNOU-REC(IDX)
                MOVE     WRK-ORCS02-REC       TO  LNK-ORCS02-REC 
      *
           END-PERFORM.
      *
       MAIN-EXT.
           EXIT PROGRAM
           STOP RUN.
      *
      *****************************************************************
      *    月別保険別判別処理
      *****************************************************************
       NYUIN-HANBETU-SEC           SECTION.
      *
           PERFORM    SKYYM-TABLE-SET-SEC.
      *
           PERFORM    NYUINKAIKEI-SYORI-SEC.
      *
           PERFORM    SINRYOKAIKEI-SYORI-SEC.
      *
           PERFORM    KAISHISYURYO-SYORI-SEC.
      *
           PERFORM    NARABIKAE-SYORI-SEC.
      *
       NYUIN-HANBETU-EXT.
           EXIT.
      *
      ******************************************************************
      *    請求年月別の開始日・終了日セット                            *
      ******************************************************************
       SKYYM-TABLE-SET-SEC         SECTION.
      *
           MOVE          LNK-S02-SKYSTYMD(1:6)  TO  WRK-SKYYM(1).
      *     
           INITIALIZE                               STS-AREA-DAY.
           INITIALIZE                               LNK-DAY7-AREA.
           MOVE          "71"                   TO  LNK-DAY7-IRAI.
           MOVE          LNK-S02-SKYSTYMD(1:6)  TO  LNK-DAY7-YM.
           CALL          "ORCSDAY"          USING   STS-AREA-DAY
                                                    LNK-DAY7-AREA.
           MOVE          LNK-DAY7-KOYOMI        TO  WRK-EDYMD. 
      *
           MOVE          LNK-S02-SKYSTYMD(7:2)  TO  WRK-HI-ST(1).
      *    IF      LNK-S02-SKYEDYMD(5:2) > LNK-S02-SKYSTYMD(5:2)
           IF      LNK-S02-SKYEDYMD(1:6) > LNK-S02-SKYSTYMD(1:6)
              MOVE       WRK-EDYMD(7:2)         TO  WRK-HI-ED(1) 
           ELSE
              MOVE       LNK-S02-SKYEDYMD(7:2)  TO  WRK-HI-ED(1)
           END-IF.
      *
      *    IF      LNK-S02-SKYEDYMD(5:2) > LNK-S02-SKYSTYMD(5:2)
           IF      LNK-S02-SKYEDYMD(1:6) > LNK-S02-SKYSTYMD(1:6)
              MOVE       LNK-S02-SKYEDYMD(1:6)  TO  WRK-SKYYM(2)
              MOVE       1                      TO  WRK-HI-ST(2)
              MOVE       LNK-S02-SKYEDYMD(7:2)  TO  WRK-HI-ED(2)
           END-IF.
      *
       SKYYM-TABLE-SET-EXT.
           EXIT.
      *
      ******************************************************************
      *    入院会計処理                                                *
      ******************************************************************
       NYUINKAIKEI-SYORI-SEC         SECTION.
      *
           PERFORM    VARYING   IDX    FROM   1   BY   1
                              UNTIL    (IDX            >     2)
                                OR     (WRK-SKYYM(IDX) =  SPACE)
      *
              INITIALIZE                            NYUINACCT-REC
              MOVE    LNK-S02-HOSPID        TO      NACCT-HOSPID
              MOVE    LNK-S02-NYUGAIKBN     TO      NACCT-NYUGAIKBN
              MOVE    LNK-S02-PTID          TO      NACCT-PTID
              MOVE    "00"                  TO      NACCT-SRYKA
              MOVE    WRK-SKYYM(IDX)        TO      NACCT-SRYYM
              MOVE    NYUINACCT-REC         TO      MCPDATA-REC
              MOVE    "DBSELECT"            TO      MCP-FUNC
              MOVE    "NYUINACCT-KEY2"      TO      ORC-DBPATH
              CALL    "ORCMCPSUB"           USING   MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
              IF      MCP-RC             =       ZERO
      *
                  MOVE    "NYUINACCT-KEY2"  TO      ORC-DBPATH
                  PERFORM  NYUINACCT-READ-SEC
                  PERFORM  UNTIL  (FLG-NYUINACCT  =    "1")
      *
                    IF     NACCT-ZAISKBKBN    =    "1"  OR  "5"   
                          PERFORM    NYUIN-DAY-TAIHI-SEC
                    END-IF
      * 
                    MOVE          "NYUINACCT-KEY2"  TO   ORC-DBPATH
                    PERFORM        NYUINACCT-READ-SEC
                  END-PERFORM
      *
              END-IF
      *
              MOVE    "DBCLOSE"               TO  MCP-FUNC
              MOVE    "NYUINACCT-KEY2"        TO  ORC-DBPATH
              CALL    "ORCMCPSUB"             USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
      *
           END-PERFORM.
      *
           PERFORM    VARYING   IDX    FROM   1   BY   1
                              UNTIL    (IDX            >     2)
                                OR     (WRK-SKYYM(IDX) =  SPACE)
      *
              PERFORM    VARYING   IDY   FROM   WRK-HI-ST(IDX)   BY   1
                                    UNTIL    IDY    >    WRK-HI-ED(IDX)
      *
               IF      ( WRK-DAY1(IDX IDY)   NOT =  ZERO ) 
               AND     ( WRK-DAY5(IDX IDY)   NOT =  ZERO )
      * 
                  MOVE   ZERO     TO    FLG-HANBETU
                  PERFORM    VARYING   IDZ  FROM   1   BY   1
                               UNTIL ( IDZ    >    10 )
                                 OR  ( WRK-HANBETU-SKYYM(IDZ) = SPACE )
                   IF   (WRK-HANBETU-SKYYM(IDZ)    = WRK-SKYYM(IDX)) 
                   AND  (WRK-HANBETU-HKNCOMBINUM(IDZ)
                                                   = WRK-DAY5(IDX IDY))
                     MOVE "1"                TO WRK-HANBETU-DAY(IDZ IDY)
                     MOVE  1                 TO FLG-HANBETU
                     MOVE  10                TO IDZ
                   END-IF
                  END-PERFORM
      *
                  IF   FLG-HANBETU   =   ZERO
                     MOVE WRK-SKYYM(IDX)     TO WRK-HANBETU-SKYYM(IDZ)
                     MOVE WRK-DAY5(IDX IDY)  TO  
                                          WRK-HANBETU-HKNCOMBINUM(IDZ)
                     MOVE "1"                TO WRK-HANBETU-DAY(IDZ IDY)
                  END-IF
      *
               END-IF
      *
              END-PERFORM
      *
           END-PERFORM.
      *
       NYUINKAIKEI-SYORI-EXT.
           EXIT.
      *
      ******************************************************************
      *    会計フラグ退避処理                                          *
      ******************************************************************
       NYUIN-DAY-TAIHI-SEC         SECTION.
      *
           PERFORM    VARYING   IDY   FROM   WRK-HI-ST(IDX)   BY   1
                                    UNTIL    IDY    >    WRK-HI-ED(IDX)
      *
             IF       NACCT-DAY(IDY)   NOT =  ZERO 
      *
               IF     NACCT-ZAISKBKBN    =    "1"  
                    MOVE   NACCT-DAY(IDY)  TO   WRK-DAY1(IDX IDY) 
               END-IF 
      *
               IF     NACCT-ZAISKBKBN    =    "5"  
                    MOVE   NACCT-DAY(IDY)  TO   WRK-DAY5(IDX IDY) 
               END-IF 
      *
             END-IF
      *
           END-PERFORM.
      *
       NYUIN-DAY-TAIHI-EXT.
           EXIT.
      *
      ******************************************************************
      *    診療会計処理                                                *
      ******************************************************************
       SINRYOKAIKEI-SYORI-SEC         SECTION.
      *
           PERFORM    VARYING   IDX    FROM   1   BY   1
                              UNTIL    (IDX            >     2)
                                OR     (WRK-SKYYM(IDX) =  SPACE)
      *
              INITIALIZE                            SRYACCT-REC
              MOVE    LNK-S02-HOSPID        TO      ACCT-HOSPID
              MOVE    LNK-S02-NYUGAIKBN     TO      ACCT-NYUGAIKBN
              MOVE    LNK-S02-PTID          TO      ACCT-PTID
              MOVE    WRK-SKYYM(IDX)        TO      ACCT-SRYYM
              MOVE    SRYACCT-REC           TO      MCPDATA-REC
              MOVE    "DBSELECT"            TO      MCP-FUNC
              MOVE    "SRYACCT-KEY7"        TO      ORC-DBPATH
              CALL    "ORCMCPSUB"           USING   MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
              IF      MCP-RC             =       ZERO
      *
                  MOVE    "SRYACCT-KEY7"    TO      ORC-DBPATH
                  PERFORM  SRYACCT-READ-SEC
                  PERFORM  UNTIL  (FLG-SRYACCT  =    "1")
      *
                    PERFORM    NYUIN-DAY-TAIHI2-SEC
      *
                    MOVE          "SRYACCT-KEY7"  TO   ORC-DBPATH
                    PERFORM        SRYACCT-READ-SEC
      *
                  END-PERFORM
      *
              END-IF
      *
              MOVE    "DBCLOSE"               TO  MCP-FUNC
              MOVE    "SRYACCT-KEY7"          TO  ORC-DBPATH
              CALL    "ORCMCPSUB"             USING
                                              MCPAREA
                                              ORCMCPAREA
                                              MCPDATA-REC
      *
           END-PERFORM.
      *
      *
           PERFORM    VARYING   IDX    FROM   1   BY   1
                              UNTIL  (IDX            >    10)
                                OR   (WRK-HANBETU2-SKYYM(IDX) =  SPACE)
      *
             MOVE       ZERO     TO       FLG-HANBETU
      *
             PERFORM    VARYING   IDY   FROM   1   BY   1
                              UNTIL  (IDY            >    10)
                                OR   (WRK-HANBETU-SKYYM(IDY)  =  SPACE)
      *
               IF  (WRK-HANBETU2-SKYYM(IDX) 
                                       = WRK-HANBETU-SKYYM(IDY))
               AND (WRK-HANBETU2-HKNCOMBINUM(IDX)
                                       = WRK-HANBETU-HKNCOMBINUM(IDY)) 
      *
                   PERFORM    VARYING   IDZ   FROM   1   BY   1
                                         UNTIL    IDZ    >    31
      *
                     IF    WRK-HANBETU2-DAY(IDX IDZ)   NOT =  SPACE 
                        IF  WRK-HANBETU-DAY(IDY IDZ) = SPACE
                           MOVE   "2"   TO   WRK-HANBETU-DAY(IDY IDZ)
                        END-IF
                     END-IF
      *
                   END-PERFORM
      *
                   MOVE       1      TO       FLG-HANBETU
                   MOVE      10      TO       IDY 
      *
               END-IF
      *
             END-PERFORM
      *
             IF   FLG-HANBETU   =   ZERO
      *
                   MOVE  WRK-HANBETU2-SKYYM(IDX)
                                 TO  WRK-HANBETU-SKYYM(IDY)
                   MOVE  WRK-HANBETU2-HKNCOMBINUM(IDX)
                                 TO  WRK-HANBETU-HKNCOMBINUM(IDY)
                   PERFORM    VARYING   IDZ   FROM   1   BY   1
                                         UNTIL    IDZ    >    31
                      IF    WRK-HANBETU2-DAY(IDX IDZ)   NOT =  SPACE 
                          MOVE  "2"     TO  WRK-HANBETU-DAY(IDY IDZ)
                      END-IF 
                   END-PERFORM
      *
             END-IF
      *
           END-PERFORM.
      *
       SINRYOKAIKEI-SYORI-EXT.
           EXIT.
      *
      ******************************************************************
      *    会計フラグ退避２処理                                         *
      ******************************************************************
       NYUIN-DAY-TAIHI2-SEC         SECTION.
      *
           PERFORM    VARYING   IDY   FROM   WRK-HI-ST(IDX)   BY   1
                                    UNTIL    IDY    >    WRK-HI-ED(IDX)
      *
             IF        ACCT-DAY(1 IDY)   NOT =  ZERO 
                 MOVE   ZERO     TO    FLG-HANBETU
                 PERFORM    VARYING   IDZ  FROM   1   BY   1
                              UNTIL  ( IDZ    >    10 )
                                OR   ( WRK-HANBETU2-SKYYM(IDZ) = SPACE )
                   IF    WRK-HANBETU2-SKYYM(IDZ)    = WRK-SKYYM(IDX) 
                   AND   WRK-HANBETU2-HKNCOMBINUM(IDZ)
                                                    = ACCT-HKNCOMBI
                     MOVE   "2"        TO  WRK-HANBETU2-DAY(IDZ IDY)
                     MOVE    1         TO  FLG-HANBETU
                     MOVE    10        TO  IDZ
                   END-IF
                 END-PERFORM
                 IF   FLG-HANBETU   =   ZERO
                     MOVE   WRK-SKYYM(IDX) 
                                       TO  WRK-HANBETU2-SKYYM(IDZ)
                     MOVE   ACCT-HKNCOMBI      
                                       TO  WRK-HANBETU2-HKNCOMBINUM(IDZ)
                     MOVE   "2"        TO  WRK-HANBETU2-DAY(IDZ IDY)
                 END-IF
             END-IF
      *
           END-PERFORM.
      *
       NYUIN-DAY-TAIHI2-EXT.
           EXIT.
      *
      ******************************************************************
      *    データ別開始・終了日セット                                  *
      ******************************************************************
       KAISHISYURYO-SYORI-SEC        SECTION.
      *
           PERFORM    VARYING   IDX    FROM   1   BY   1
                              UNTIL  (IDX            >    10)
                                OR   (WRK-HANBETU-SKYYM(IDX) =  SPACE)
      *
              PERFORM    VARYING   IDY   FROM   1   BY   1
                                         UNTIL    IDY    >    31
      *
                IF        WRK-HANBETU-DAY(IDX IDY)   NOT =  SPACE 
                   MOVE   IDY     TO    WRK-HANBETU-KAISHI(IDX)
                   MOVE   31      TO    IDY
                END-IF
      *
              END-PERFORM
      *
              PERFORM    VARYING   IDY   FROM  31   BY  -1
                                         UNTIL    IDY    <    1
      *
                IF        WRK-HANBETU-DAY(IDX IDY)   NOT =  SPACE 
                   MOVE   IDY     TO    WRK-HANBETU-SYURYO(IDX)
                   MOVE   1       TO    IDY
                END-IF
      *
              END-PERFORM
      *
           END-PERFORM.
      *
       KAISHISYURYO-SYORI-EXT.
           EXIT.
      *
      ******************************************************************
      *    データを請求年月順に並び替え                                *
      ******************************************************************
       NARABIKAE-SYORI-SEC        SECTION.
      *
           PERFORM    VARYING   IDX    FROM   1   BY   1
                              UNTIL  (IDX            >    10)
                                OR   (WRK-HANBETU-SKYYM(IDX) =  SPACE)
      *
              COMPUTE    IDZ  =  IDX  +  1
      *
              PERFORM    VARYING   IDY   FROM   IDZ   BY   1
                              UNTIL  (IDY            >    10)
                                OR   (WRK-HANBETU-SKYYM(IDY) =  SPACE)
      *
                IF       WRK-HANBETU-SKYYM(IDX)   >
                                                 WRK-HANBETU-SKYYM(IDY) 
                   MOVE  WRK-HANBETU-TBL(IDX)  TO  WRK-HANBETU-DATA
                   MOVE  WRK-HANBETU-TBL(IDY)  TO  WRK-HANBETU-TBL(IDX)
                   MOVE  WRK-HANBETU-DATA      TO  WRK-HANBETU-TBL(IDY)
                END-IF
      *
              END-PERFORM
      *
           END-PERFORM.
      *
       NARABIKAE-SYORI-EXT.
           EXIT.
      *
      ******************************************************************
      *    ワーク収納レコードセット処理                                *
      ******************************************************************
       SYUNOU-SET-SEC         SECTION.
      *
           PERFORM    VARYING   IDX    FROM   1   BY   1
                              UNTIL  (IDX            >    10)
                                OR   (WRK-HANBETU-SKYYM(IDX) =  SPACE)
      *
      *       保険組合せマスタの検索
              INITIALIZE                           HKNCOMBI-REC
              MOVE    LNK-S02-HOSPID       TO      COMB-HOSPID
              MOVE    LNK-S02-PTID         TO      COMB-PTID
              MOVE    WRK-HANBETU-HKNCOMBINUM(IDX)
                                           TO      COMB-HKNCOMBINUM
              MOVE    HKNCOMBI-REC         TO      MCPDATA-REC
              MOVE    "DBSELECT"           TO      MCP-FUNC
              MOVE    "HKNCOMBI-KEY"       TO      ORC-DBPATH
              CALL    "ORCMCPSUB"          USING   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
      *
              IF      MCP-RC               =       ZERO
                  MOVE    "HKNCOMBI-KEY"   TO      ORC-DBPATH 
                  PERFORM   HKNCOMBI-READ-SEC
              END-IF
      *
              MOVE    "DBCLOSE"            TO      MCP-FUNC
              MOVE    "HKNCOMBI-KEY"       TO      ORC-DBPATH
              CALL    "ORCMCPSUB"           USING   MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
      *
              MOVE LNK-S02-HOSPID     TO LNK-SYU-HOSPID(IDX)
              MOVE LNK-S02-NYUGAIKBN  TO LNK-SYU-NYUGAIKBN(IDX)
              MOVE LNK-S02-PTID       TO LNK-SYU-PTID(IDX)
              MOVE WRK-HANBETU-SKYYM(IDX)
                                      TO LNK-SYU-SRYYMD(IDX)(1:6)
              MOVE WRK-HANBETU-KAISHI(IDX)
                                      TO LNK-SYU-SRYYMD(IDX)(7:2)
      *       定期請求時は無条件に未収状態で作成
              MOVE "2"                TO LNK-SYU-DENPJTIKBN(IDX)
              MOVE WRK-SYSYMD         TO LNK-SYU-DENPPRTYMD(IDX)
              MOVE WRK-HANBETU-SKYYM(IDX)
                                      TO LNK-SYU-SKYSTYMD(IDX)(1:6)
              MOVE WRK-HANBETU-KAISHI(IDX)
                                      TO LNK-SYU-SKYSTYMD(IDX)(7:2)
              MOVE WRK-HANBETU-SKYYM(IDX)
                                      TO LNK-SYU-SKYEDYMD(IDX)(1:6)
              MOVE WRK-HANBETU-SYURYO(IDX)
                                      TO LNK-SYU-SKYEDYMD(IDX)(7:2)
              MOVE WRK-HANBETU-HKNCOMBINUM(IDX)
                                      TO LNK-SYU-HKNCOMBINUM(IDX)
              MOVE COMB-HKNNUM        TO LNK-SYU-SYUHKNNUM(IDX)
              MOVE COMB-KOH1HKNNUM    TO LNK-SYU-KOH1HKNNUM(IDX)
              MOVE COMB-KOH2HKNNUM    TO LNK-SYU-KOH2HKNNUM(IDX)
              MOVE COMB-KOH3HKNNUM    TO LNK-SYU-KOH3HKNNUM(IDX)
              MOVE COMB-KOH4HKNNUM    TO LNK-SYU-KOH4HKNNUM(IDX)
              MOVE COMB-NYU-KFTNRATE  TO LNK-SYU-PTFTNRATE(IDX)
              PERFORM    VARYING   IDY    FROM   1   BY   1
                             UNTIL  IDY            >    31
                   MOVE  WRK-HANBETU-DAY(IDX IDY) 
                                      TO LNK-SYU-DAY(IDX IDY)
              END-PERFORM
      *
           END-PERFORM. 
      *
       SYUNOU-SET-EXT.
           EXIT.
      *
      ******************************************************************
      *    入院会計セット処理                                *
      ******************************************************************
       NYUIN-KAIKEI-SET-SEC         SECTION.
      *
           MOVE    LNK-SYUNOU-REC(IDX) TO  SYUNOU-REC
      *
      *外泊情報の取得
           MOVE    ZERO                TO  FLG-NYUINACCT
           INITIALIZE                      NYUINACCT-REC
           MOVE    SYU-HOSPID          TO  NACCT-HOSPID
           MOVE    "1"                 TO  NACCT-NYUGAIKBN
           MOVE    SYU-PTID            TO  NACCT-PTID
           MOVE    SYU-SKYSTYMD (1:6)  TO  NACCT-SRYYM
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY9"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "NYUINACCT-KEY9"  TO  ORC-DBPATH
               PERFORM  NYUINACCT-READ-SEC
           ELSE
               MOVE    1               TO      FLG-NYUINACCT
           END-IF
      *
           MOVE     ZERO               TO      FLG-GAIHAKU-SET
           INITIALIZE                          TABLE-GAIHAKU
      *
           PERFORM      GAIHAKU-SET-SEC
               UNTIL   (FLG-NYUINACCT   =       1      )   OR
                       (FLG-GAIHAKU-SET =       1      )
      *
      *
           MOVE     "NYUINACT-KEY9"    TO  WK-PATH
           PERFORM   CSR-CLOSE-SEC
      *
      *入院料関係の取得
           MOVE    ZERO                TO  FLG-NYUINACCT
           INITIALIZE                      NYUINACCT-REC
           MOVE    SYU-HOSPID          TO  NACCT-HOSPID
           MOVE    "1"                 TO  NACCT-NYUGAIKBN
           MOVE    SYU-PTID            TO  NACCT-PTID
           MOVE    SYU-SKYSTYMD (1:6)  TO  NACCT-SRYYM
           MOVE    NYUINACCT-REC       TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "NYUINACCT-KEY9"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "NYUINACCT-KEY9"  TO  ORC-DBPATH
               PERFORM  NYUINACCT-READ-SEC
           ELSE
               MOVE     1               TO  FLG-NYUINACCT
           END-IF
      *
           PERFORM      NYUINACCT-GET-SEC
               UNTIL   (FLG-NYUINACCT   =       1      )
      *
           MOVE     "NYUINACT-KEY9"    TO  WK-PATH
           PERFORM   CSR-CLOSE-SEC
      *
      *医療機関減算の取得（システム管理テーブルより）
           MOVE    ZERO                TO  FLG-SYSKANRI
           INITIALIZE                      SYSKANRI-REC
           MOVE    "5000"              TO  SYS-KANRICD
           MOVE    "*"                 TO  SYS-KBNCD
           MOVE    SYU-SKYSTYMD        TO  ORC-DBYMD
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
               PERFORM  VARYING   GENSAN-IDX  FROM  1  BY  1
                        UNTIL     GENSAN-IDX   >   4
                    IF    SYS-5000-GENKBN(GENSAN-IDX)   =   "2"    
                        EVALUATE  GENSAN-IDX
                            WHEN  2
                                COMPUTE SYU-HKNTEN(11) = SYU-HKNTEN(11)
                                                    - (5 * NYUIN-COUNT)
                            WHEN  3
                                COMPUTE SYU-HKNTEN(11) = SYU-HKNTEN(11)
                                                   - (10 * NYUIN-COUNT)
                            WHEN  4
                                COMPUTE SYU-HKNTEN(11) = SYU-HKNTEN(11)
                                                    - (5 * NYUIN-COUNT)
               END-PERFORM
           END-IF
      *
           PERFORM   VARYING   IDZ   FROM  1   BY   1
                     UNTIL     IDZ   >     11
                     ADD    SYU-HKNTEN (IDZ)  TO  SYU-HKNTEN (12)
           END-PERFORM
           MOVE     "SYSKANRI-KEY"     TO  WK-PATH
           PERFORM   CSR-CLOSE-SEC
      *
           MOVE    SYUNOU-REC          TO  LNK-SYUNOU-REC(IDX)
      *
           .
      *
       NYUIN-KAIKEI-SET-EXT.
           EXIT.
      *
      **************************************************************
      *    外泊情報の取込み
      **************************************************************
       GAIHAKU-SET-SEC           SECTION.
      *
           IF  NACCT-SRYYM      =   SYU-SKYSTYMD(1:6)
      *    外泊情報のテーブルセット
               IF   NACCT-ZAISKBKBN   =   "2"
                   PERFORM   VARYING  SYU-IDX  FROM  1  BY  1
                             UNTIL    SYU-IDX  >   31
                       IF  (SYU-DAY(SYU-IDX)       =   "1")    AND
                           (NACCT-DAY(SYU-IDX) NOT =  ZERO)
                           MOVE   NACCT-DAY(SYU-IDX)
                                      TO  TBL-GAIHAKU (SYU-IDX)
                       END-IF
                   END-PERFORM
                   MOVE     1         TO  FLG-GAIHAKU-SET 
               END-IF
           END-IF
           MOVE    "NYUINACCT-KEY9"   TO  ORC-DBPATH
           PERFORM  NYUINACCT-READ-SEC
           .
      *
       GAIHAKU-SET-EXT.
           EXIT.
      *
      **************************************************************
      *    入院料関係の取得
      **************************************************************
       NYUINACCT-GET-SEC           SECTION.
      *
           IF    (NACCT-ZAITEN            NOT = ZERO  )           AND
                 (NACCT-SRYYM(1:6)    =   SYU-SKYSTYMD(1:6))
      *
      *        入院料の集計
               IF   NACCT-ZAISKBKBN      =   "1"
                   MOVE      ZERO        TO    NYUIN-COUNT
      *            入院基本料と加減算点数の取得
                   PERFORM   NYUINKHN-GET-SEC
      *            入院料と外泊を比較して点数算定
                   PERFORM   VARYING  SYU-IDX  FROM  1  BY  1
                             UNTIL    SYU-IDX  >   31
                       IF  (SYU-DAY(SYU-IDX)       =   "1")    AND
                           (NACCT-DAY(SYU-IDX) NOT =  ZERO)
                           ADD        1      TO    NYUIN-COUNT
                           EVALUATE   TBL-GAIHAKU(SYU-IDX)
                               WHEN   ZERO
                                   ADD    NACCT-ZAITEN
                                                  TO  SYU-HKNTEN(11)
                               WHEN   1
                                   COMPUTE  SYU-HKNTEN(11)  =
                                            SYU-HKNTEN(11)  +
                                           ((WRK-KHNTEN    *  0.85)
                                                           +  0.5)
                                   ADD      WRK-KSNTEN   TO
                                                        SYU-HKNTEN(11)
                               WHEN   2
                                   COMPUTE  SYU-HKNTEN(11)  =
                                            SYU-HKNTEN(11)  +
                                          ((WRK-KHNTEN      *  0.7)
                                                            +  0.5)
                                   ADD      WRK-KSNTEN   TO
                                                        SYU-HKNTEN(11)
                           END-EVALUATE
                       END-IF
                   END-PERFORM
               END-IF
      *
      *
      *        入院料加算の集計
               IF   NACCT-ZAISKBKBN      =   "6"
                   PERFORM   VARYING  SYU-IDX  FROM  1  BY  1
                             UNTIL    SYU-IDX  >   31
                       IF  (SYU-DAY(SYU-IDX)       =   "1")    AND
                           (NACCT-DAY(SYU-IDX) NOT =  ZERO)
                           ADD   NACCT-ZAITEN   TO    SYU-HKNTEN(11)
                       END-IF
                   END-PERFORM
               END-IF
      *
           END-IF
      * 
           IF     NACCT-SRYYM         =   SYU-SKYSTYMD(1:6)
      *        室料差額の集計
               IF   NACCT-ZAISKBKBN       =   "3"
      *            システム管理テーブルから設定室料差額の取り込み
                   INITIALIZE                  SYS-5113-REC
                   MOVE    "5113"              TO   SYS-5113-KANRICD
                   MOVE    SYU-SKYSTYMD        TO   ORC-DBYMD
                   MOVE    SYS-5113-REC        TO   MCPDATA-REC
                   MOVE    "DBSELECT"          TO   MCP-FUNC
                   MOVE    "SYSKANRI-KEY2"     TO   ORC-DBPATH
                   CALL    "ORCMCPSUB"              USING
                                                    MCPAREA
                                                    ORCMCPAREA
                                                    MCPDATA-REC
                   IF      MCP-RC              =    ZERO
                        MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
                        PERFORM  SYSKANRI-READ-SEC
                        PERFORM   VARYING  SYU-IDX   FROM   1   BY   1
                          UNTIL  (SYU-IDX      >     50)    OR
                                 (FLG-SYSKANRI    =  1)
                            MOVE   SYSKANRI-REC   TO  SYS-5113-REC
                            MOVE   SYS-5113-BRM-SAGAKU-NM
                                           TO  TBL-RMSAGAKU(SYU-IDX)
                            MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
                            PERFORM  SYSKANRI-READ-SEC
                        END-PERFORM
                   END-IF
      *             
                   PERFORM   VARYING  SYU-IDX  FROM  1  BY  1
                             UNTIL    SYU-IDX  >   31
                       IF  (SYU-DAY(SYU-IDX)       =   "1")    AND
                           (NACCT-DAY(SYU-IDX) NOT =  ZERO)
                           MOVE   NACCT-DAY(SYU-IDX)  TO  RMSAGAKU-IDX
                           ADD   TBL-RMSAGAKU (RMSAGAKU-IDX)
                                                 TO   SYU-RMSAGAKU
                       END-IF
                   END-PERFORM
               END-IF
           END-IF
      *
           MOVE    "NYUINACCT-KEY9"         TO  ORC-DBPATH
           PERFORM NYUINACCT-READ-SEC
      *
           .
       NYUINACCT-GET-EXT.
           EXIT.
      *
      **************************************************************
      *    入院基本料と加減算点数の取得
      **************************************************************
       NYUINKHN-GET-SEC           SECTION.
      *
           MOVE    ZERO               TO   WRK-KHNTEN
           MOVE    ZERO               TO   WRK-KSNTEN
      *
           MOVE    SYU-HOSPID         TO   NSRY-HOSPID
           MOVE    "1"                TO   NSRY-NYUGAIKBN
           MOVE    SYU-PTID           TO   NSRY-PTID
           MOVE    "00"               TO   NSRY-SRYKA
           MOVE    SYU-SKYSTYMD(1:6)  TO   NSRY-SRYYM
           MOVE    NACCT-ZAINUM       TO   NSRY-ZAINUM
           MOVE    1                  TO   NSRY-RENNUM
           MOVE    NYUINACT-REC       TO   MCPDATA-REC
           MOVE    "DBSELECT"         TO   MCP-FUNC
           MOVE    "NYUINACT-KEY2"    TO   ORC-DBPATH
           CALL    "ORCMCPSUB"             USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
           IF      MCP-RC             =    ZERO
               MOVE    "NYUINACT-KEY2"     TO   ORC-DBPATH
               PERFORM NYUINACT-READ-SEC
           ELSE
               MOVE    1              TO   FLG-NYUINACT
           END-IF
           IF      FLG-NYUINACT        =   ZERO
               MOVE      ZERO          TO  FLG-NYUKHN  
               PERFORM   VARYING  NYUINACT-IDX  FROM 1  BY  1
                 UNTIL  (FLG-NYUKHN         =   1)    OR
                        (NYUINACT-IDX       >   5)    OR
                        (NSRY-SRYCD(NYUINACT-IDX)  =  SPACE)
                     MOVE    SPACE         TO   TNS-TENSU-REC
                     INITIALIZE                 TNS-TENSU-REC
                     MOVE    NSRY-SRYCD(NYUINACT-IDX) TO   TNS-SRYCD
                     MOVE    SYU-SKYSTYMD(1:6)  TO  ORC-DBYMD(1:6)
                     MOVE    "01"               TO  ORC-DBYMD(7:2)
                     PERFORM  TENSU-READ-SEC
                     IF       FLG-TENSU      =    ZERO
                         IF   TNS-DATAKBN    =    1
                              MOVE   TNS-TEN   TO   WRK-KHNTEN
                              MOVE   1         TO   FLG-NYUKHN
                         END-IF
                     END-IF                  
                     MOVE   "TENSU-KEY"      TO  WK-PATH
                     PERFORM   CSR-CLOSE-SEC
               END-PERFORM
           END-IF
      *
      *    初期加算（及び長期減算）の点数取得
           MOVE      ZERO              TO  WRK-KSNTEN
           COMPUTE   WRK-KSNTEN        =   NACCT-ZAITEN   -
                                           WRK-KHNTEN
      *
           MOVE   "NYUINACT-KEY2"      TO  WK-PATH
           PERFORM   CSR-CLOSE-SEC
      *
           .
       NYUINKHN-GET-EXT.
           EXIT.
      *
      ******************************************************************
      *    診療会計セット処理                                *
      ******************************************************************
       SINRYO-KAIKEI-SET-SEC         SECTION.
      *
           MOVE    LNK-SYUNOU-REC(IDX) TO  SYUNOU-REC
      *
           MOVE    SPACE               TO  HKNTEKGAI-TABLE
           INITIALIZE                      HKNTEKGAI-TABLE
           MOVE    SPACE               TO  JIHI-TABLE
           INITIALIZE                      JIHI-TABLE
      *診療会計情報の取得
           MOVE    ZERO                TO  FLG-SRYACCT
           INITIALIZE                      SRYACCT-REC
           MOVE    SYU-HOSPID          TO  ACCT-HOSPID
           MOVE    "1"                 TO  ACCT-NYUGAIKBN
           MOVE    SYU-PTID            TO  ACCT-PTID
           MOVE    SYU-SKYSTYMD(1:6)   TO  ACCT-SRYYM
           MOVE    SRYACCT-REC         TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SRYACCT-KEY9"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SRYACCT-KEY9"  TO  ORC-DBPATH
               PERFORM    SRYACCT-READ-SEC
      *
               PERFORM    SRYACCT-SET-SEC
                      UNTIL   FLG-SRYACCT  =  1
      *
           ELSE
               MOVE    1               TO  FLG-SRYACCT
           END-IF
      *
           MOVE   "SRYACCT-KEY9"       TO  WK-PATH
           PERFORM   CSR-CLOSE-SEC
      *
      *    保険適用外退避テーブルと自費退避用テーブルから
      *    収納テーブルへのセット
           PERFORM   HKNTEKGAI-SET-SEC
      *
           MOVE    SYUNOU-REC          TO  LNK-SYUNOU-REC(IDX)
      *
           .
      *
       SINRYO-KAIKEI-SET-EXT.
           EXIT.
      *
      ******************************************************************
      *    診療会計セット処理                                *
      ******************************************************************
       SRYACCT-SET-SEC         SECTION.
      *
      *    入院日と診療日（診療会計テーブルのカレンダー）を比較して
      *    算定対象日数を求める
           MOVE      ZERO          TO     SINRYO-COUNT
           PERFORM   VARYING   SYU-IDX   FROM   1   BY   1
                     UNTIL      SYU-IDX   >   31
                 IF  (SYU-DAY(SYU-IDX)       =     "1"  OR  "2")   AND
                     (ACCT-DAY(1 SYU-IDX)    NOT =  ZERO)          AND
                     (SYU-HKNCOMBINUM        =    ACCT-HKNCOMBI)
                     ADD   ACCT-DAY(1 SYU-IDX)    TO     SINRYO-COUNT
                 END-IF
           END-PERFORM          
      *
           IF  SINRYO-COUNT     NOT =     ZERO
               EVALUATE    ACCT-SRYKBN
      *            診療
                   WHEN    "11"
                   WHEN    "12"
                    COMPUTE SYU-HKNTEN (01) =  SYU-HKNTEN (01)  +
                           (ACCT-ZAITEN  *   SINRYO-COUNT)
      *            指導
                   WHEN    "13"
                    COMPUTE SYU-HKNTEN (02) =  SYU-HKNTEN (02)  +
                           (ACCT-ZAITEN  *   SINRYO-COUNT)
      *            在宅
                   WHEN    "14"
                    COMPUTE SYU-HKNTEN (03) =  SYU-HKNTEN (03)  +
                           (ACCT-ZAITEN  *   SINRYO-COUNT)
      *            投薬
                   WHEN    "21"   THRU  "27"
                   COMPUTE SYU-HKNTEN (04) =  SYU-HKNTEN (04)  +
                           (ACCT-ZAITEN  *   SINRYO-COUNT)
      *            注射
                   WHEN    "31"
                   WHEN    "32"
                   WHEN    "33"
                    COMPUTE SYU-HKNTEN (05) =  SYU-HKNTEN (05)  +
                           (ACCT-ZAITEN  *   SINRYO-COUNT)
      *            処置
                   WHEN    "40"
                    COMPUTE SYU-HKNTEN (06)   =  SYU-HKNTEN (06)  +
                           (ACCT-ZAITEN  *   SINRYO-COUNT)
      *            手術
                   WHEN    "50"
                   WHEN    "54"
                    COMPUTE SYU-HKNTEN (07)   =  SYU-HKNTEN (07)  +
                           (ACCT-ZAITEN  *   SINRYO-COUNT)
      *            検査
                   WHEN    "60"
                    COMPUTE SYU-HKNTEN (08)   =  SYU-HKNTEN (08)  +
                           (ACCT-ZAITEN  *   SINRYO-COUNT)
      *            Ｘ線
                   WHEN    "70"
                    COMPUTE SYU-HKNTEN (09)   =  SYU-HKNTEN (09)  +
                           (ACCT-ZAITEN  *   SINRYO-COUNT)
      *            その他
                   WHEN    "80"
                    COMPUTE SYU-HKNTEN (10)   =  SYU-HKNTEN (10)  +
                           (ACCT-ZAITEN  *   SINRYO-COUNT)
      *            保険適用外及び自費
                   WHEN    "95"
                   WHEN    "96"
                       MOVE    ACCT-HOSPID        TO   SRY-HOSPID
                       MOVE    ACCT-NYUGAIKBN     TO   SRY-NYUGAIKBN
                       MOVE    ACCT-PTID          TO   SRY-PTID
                       MOVE    ACCT-SRYKA         TO   SRY-SRYKA
                       MOVE    ACCT-SRYYM         TO   SRY-SRYYM
                       MOVE    ACCT-ZAINUM        TO   SRY-ZAINUM
                       MOVE    SRYACT-REC         TO   MCPDATA-REC
                       MOVE    "DBSELECT"         TO   MCP-FUNC
                       MOVE    "SRYACT-KEY2"      TO   ORC-DBPATH
                       CALL    "ORCMCPSUB"             USING
                                                       MCPAREA
                                                       ORCMCPAREA
                                                       MCPDATA-REC
                       IF      MCP-RC             =    ZERO
                         MOVE    "SRYACT-KEY2"    TO   ORC-DBPATH
                         PERFORM  SRYACT-READ-SEC
                       ELSE
                         MOVE    1                TO   FLG-SRYACT
                       END-IF
                       IF      FLG-SRYACT          =   ZERO
                           PERFORM  UNTIL
                               (FLG-SRYACT         =  1)            OR
                               (ACCT-HOSPID  NOT = SRY-HOSPID)      OR
                               (ACCT-NYUGAIKBN  NOT = SRY-NYUGAIKBN) OR
                               (ACCT-PTID     NOT = SRY-PTID)       OR
                               (ACCT-SRYKA    NOT = SRY-SRYKA)      OR
                               (ACCT-SRYKBN   NOT = SRY-SRYKBN)     OR
                               (ACCT-ZAINUM   NOT = SRY-ZAINUM)
      *                        保険適用外金額セット
                               PERFORM    HKNTEKGAI-TBL-SEC
                               MOVE      "SRYACT-KEY2"  TO  MCP-FUNC
                               PERFORM    SRYACT-READ-SEC
                           END-PERFORM
                       END-IF
               END-EVALUATE
           END-IF
      *
           MOVE    "SRYACCT-KEY9"  TO  ORC-DBPATH
           PERFORM SRYACCT-READ-SEC
      *
           .
      *
       SRYACCT-SET-EXT.
           EXIT.
      *
      **************************************************************
      *    保険適用外のテーブル領域セット
      **************************************************************
       HKNTEKGAI-TBL-SEC          SECTION.
      *
           EVALUATE    SRY-SRYKBN
               WHEN    "95"
                   PERFORM     VARYING    IDZ    FROM    1     BY    1
                                 UNTIL   (IDZ         >   5    )   OR
       	                                  (SRY-SRYCD(IDZ)  =   SPACE)
                       IF    SRY-SRYCD (IDZ) (1:3)   =   "095"
                                                     OR  "096"
                           IF    SRY-SRYCD (IDZ) (4:2)    =   "00"
                                                     OR       "91"     
                                                     OR       "92"     
                               MOVE    SPACE         TO   TNS-TENSU-REC
                               INITIALIZE                 TNS-TENSU-REC
                               MOVE    SRY-SRYCD(IDZ) TO   TNS-SRYCD
                               MOVE    SYU-SKYSTYMD(1:6)
                                                     TO  ORC-DBYMD(1:6)
                               MOVE    "01"          TO  ORC-DBYMD(7:2)
                               PERFORM    TENSU-READ-SEC
                               IF      MCP-RC         =    ZERO
                                   EVALUATE    TNS-GAITENTTLKBN
                                       WHEN    1
                                          COMPUTE  TBL-JIHI-TAXNASI(1)
                                               =   TBL-JIHI-TAXNASI(1)
                                               +  (SRY-JIHIMONEY(IDZ)
                                                   *  SINRYO-COUNT) 
                                       WHEN    2
                                          COMPUTE  TBL-JIHI-TAXNASI(2)
                                               =   TBL-JIHI-TAXNASI(2)
                                               +  (SRY-JIHIMONEY(IDZ)
                                                   *  SINRYO-COUNT) 
                                       WHEN    3
                                          COMPUTE  TBL-JIHI-TAXNASI(3)
                                               =   TBL-JIHI-TAXNASI(3)
                                               +  (SRY-JIHIMONEY(IDZ)
                                                   *  SINRYO-COUNT) 
                                       WHEN    4
                                          COMPUTE  TBL-JIHI-TAXNASI(4)
                                               =   TBL-JIHI-TAXNASI(4)
                                               +  (SRY-JIHIMONEY(IDZ)
                                                   *  SINRYO-COUNT) 
                                       WHEN    5
                                          COMPUTE  TBL-JIHI-TAXNASI(5)
                                               =   TBL-JIHI-TAXNASI(5)
                                               +  (SRY-JIHIMONEY(IDZ)
                                                   *  SINRYO-COUNT) 
                                   END-EVALUATE
                               END-IF
                           ELSE
                               EVALUATE   SRY-SRYCD (IDZ) (4:2)
                                   WHEN   "11"
                                   WHEN   "12"
                                       COMPUTE  TBL-TGMONEY(1)  =
                                                TBL-TGMONEY(1)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "13"
                                       COMPUTE  TBL-TGMONEY(2)  =
                                                TBL-TGMONEY(2)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "14"
                                       COMPUTE  TBL-TGMONEY(3)  =
                                                TBL-TGMONEY(3)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "21"   THRU  "27"
                                       COMPUTE  TBL-TGMONEY(4)  =
                                                TBL-TGMONEY(4)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "31"
                                   WHEN   "32"
                                   WHEN   "33"
                                       COMPUTE  TBL-TGMONEY(5)  =
                                                TBL-TGMONEY(5)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "40"
                                       COMPUTE  TBL-TGMONEY(6)  =
                                                TBL-TGMONEY(6)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "50"
                                   WHEN   "54"
                                       COMPUTE  TBL-TGMONEY(7)  =
                                                TBL-TGMONEY(7)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "60"
                                       COMPUTE  TBL-TGMONEY(8)  =
                                                TBL-TGMONEY(8)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "70"
                                       COMPUTE  TBL-TGMONEY(9)  =
                                                TBL-TGMONEY(9)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "80"
                                       COMPUTE  TBL-TGMONEY(10)  =
                                                TBL-TGMONEY(10)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                               END-EVALUATE
                           END-IF
                       ELSE
                           MOVE    SPACE          TO   TNS-TENSU-REC
                           INITIALIZE                  TNS-TENSU-REC
                           MOVE    SRY-SRYCD(IDZ) TO   TNS-SRYCD
                           MOVE    SYU-SKYSTYMD(1:6)
                                                  TO   ORC-DBYMD(1:6)
                           MOVE    "01"           TO   ORC-DBYMD(7:2)
                           PERFORM    TENSU-READ-SEC
                           IF      MCP-RC         =    ZERO
                               EVALUATE   TNS-SRYKBN
                                   WHEN   "11"
                                   WHEN   "12"
                                       COMPUTE  TBL-TGMONEY(1)  =
                                                TBL-TGMONEY(1)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "13"
                                       COMPUTE  TBL-TGMONEY(2)  =
                                                TBL-TGMONEY(2)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "14"
                                       COMPUTE  TBL-TGMONEY(3)  =
                                                TBL-TGMONEY(3)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "21"   THRU  "27"
                                       COMPUTE  TBL-TGMONEY(4)  =
                                                TBL-TGMONEY(4)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "31"
                                   WHEN   "32"
                                   WHEN   "33"
                                       COMPUTE  TBL-TGMONEY(5)  =
                                                TBL-TGMONEY(5)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "40"
                                       COMPUTE  TBL-TGMONEY(6)  =
                                                TBL-TGMONEY(6)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "50"
                                   WHEN   "54"
                                       COMPUTE  TBL-TGMONEY(7)  =
                                                TBL-TGMONEY(7)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "60"
                                       COMPUTE  TBL-TGMONEY(8)  =
                                                TBL-TGMONEY(8)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "70"
                                       COMPUTE  TBL-TGMONEY(9)  =
                                                TBL-TGMONEY(9)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "80"
                                       COMPUTE  TBL-TGMONEY(10)  =
                                                TBL-TGMONEY(10)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   OTHER
                                     IF   TNS-SRYCD(1:1)    =   "6"
                                       COMPUTE  TBL-TGMONEY(4)  =
                                                TBL-TGMONEY(4)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                     END-IF
                                     IF   TNS-SRYCD(1:1)    =   "7"
                                       COMPUTE  TBL-TGMONEY(10)  =
                                                TBL-TGMONEY(10)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                     END-IF
                               END-EVALUATE
                           END-IF
                       END-IF
                   END-PERFORM
               WHEN    "96"
                   PERFORM     VARYING    IDZ    FROM   1    BY   1
                                 UNTIL   (IDZ        >   5    )   OR
                                         (SRY-SRYCD(IDZ)  =   SPACE)
                       IF    SRY-SRYCD (IDZ) (1:3)   =   "095"
                                                     OR  "096"
                           IF    SRY-SRYCD (IDZ) (4:2)    =   "00"
                                                     OR       "91"      
                                                     OR       "92"      
                               MOVE    SPACE         TO   TNS-TENSU-REC
                               INITIALIZE                 TNS-TENSU-REC
                               MOVE    SRY-SRYCD(IDZ) TO   TNS-SRYCD
                               MOVE    SYU-SKYSTYMD(1:6)
                                                     TO  ORC-DBYMD(1:6)
                               MOVE    "01"          TO  ORC-DBYMD(7:2)
                               PERFORM    TENSU-READ-SEC
                               IF      MCP-RC         =    ZERO
                                   EVALUATE    TNS-GAITENTTLKBN
                                       WHEN    1
                                          COMPUTE  TBL-JIHI-TAXARI(1)
                                               =   TBL-JIHI-TAXARI(1)
                                               +  (SRY-JIHIMONEY(IDZ)
                                                   *  SINRYO-COUNT) 
                                       WHEN    2
                                          COMPUTE  TBL-JIHI-TAXARI(2)
                                               =   TBL-JIHI-TAXARI(2)
                                               +  (SRY-JIHIMONEY(IDZ)
                                                   *  SINRYO-COUNT) 
                                       WHEN    3
                                          COMPUTE  TBL-JIHI-TAXARI(3)
                                               =   TBL-JIHI-TAXARI(3)
                                               +  (SRY-JIHIMONEY(IDZ)
                                                   *  SINRYO-COUNT) 
                                       WHEN    4
                                          COMPUTE  TBL-JIHI-TAXARI(4)
                                               =   TBL-JIHI-TAXARI(4)
                                               +  (SRY-JIHIMONEY(IDZ)
                                                   *  SINRYO-COUNT) 
                                       WHEN    5
                                          COMPUTE  TBL-JIHI-TAXARI(5)
                                               =   TBL-JIHI-TAXARI(5)
                                               +  (SRY-JIHIMONEY(IDZ)
                                                   *  SINRYO-COUNT) 
                                   END-EVALUATE
                               END-IF
                           ELSE
                               EVALUATE   SRY-SRYCD (IDZ) (4:2)
                                   WHEN   "11"
                                   WHEN   "12"
                                       COMPUTE  TBL-TGMONEY-TAX(1)  =
                                                TBL-TGMONEY-TAX(1)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "13"
                                       COMPUTE  TBL-TGMONEY-TAX(2)  =
                                                TBL-TGMONEY-TAX(2)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "14"
                                       COMPUTE  TBL-TGMONEY-TAX(3)  =
                                                TBL-TGMONEY-TAX(3)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "21"   THRU  "27"
                                       COMPUTE  TBL-TGMONEY-TAX(4)  =
                                                TBL-TGMONEY-TAX(4)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "31"
                                   WHEN   "32"
                                   WHEN   "33"
                                       COMPUTE  TBL-TGMONEY-TAX(5)  =
                                                TBL-TGMONEY-TAX(5)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "40"
                                       COMPUTE  TBL-TGMONEY-TAX(6)  =
                                                TBL-TGMONEY-TAX(6)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "50"
                                   WHEN   "54"
                                       COMPUTE  TBL-TGMONEY-TAX(7)  =
                                                TBL-TGMONEY-TAX(7)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "60"
                                       COMPUTE  TBL-TGMONEY-TAX(8)  =
                                                TBL-TGMONEY-TAX(8)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "70"
                                       COMPUTE  TBL-TGMONEY-TAX(9)  =
                                                TBL-TGMONEY-TAX(9)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "80"
                                       COMPUTE  TBL-TGMONEY-TAX(10)  =
                                                TBL-TGMONEY-TAX(10)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                               END-EVALUATE
                           END-IF
                       ELSE
                           MOVE    SPACE          TO   TNS-TENSU-REC
                           INITIALIZE                  TNS-TENSU-REC
                           MOVE    SRY-SRYCD(IDZ) TO   TNS-SRYCD
                           MOVE    SYU-SKYSTYMD(1:6)
                                                  TO   ORC-DBYMD(1:6)
                           MOVE    "01"           TO   ORC-DBYMD(7:2)
                           PERFORM    TENSU-READ-SEC
                           IF      MCP-RC         =    ZERO
                               EVALUATE   TNS-SRYKBN
                                   WHEN   "11"
                                   WHEN   "12"
                                       COMPUTE  TBL-TGMONEY-TAX(1)  =
                                                TBL-TGMONEY-TAX(1)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "13"
                                       COMPUTE  TBL-TGMONEY-TAX(2)  =
                                                TBL-TGMONEY-TAX(2)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "14"
                                       COMPUTE  TBL-TGMONEY-TAX(3)  =
                                                TBL-TGMONEY-TAX(3)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "21"   THRU  "27"
                                       COMPUTE  TBL-TGMONEY-TAX(4)  =
                                                TBL-TGMONEY-TAX(4)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "31"
                                   WHEN   "32"
                                   WHEN   "33"
                                       COMPUTE  TBL-TGMONEY-TAX(5)  =
                                                TBL-TGMONEY-TAX(5)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "40"
                                       COMPUTE  TBL-TGMONEY-TAX(6)  =
                                                TBL-TGMONEY-TAX(6)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "50"
                                   WHEN   "54"
                                       COMPUTE  TBL-TGMONEY-TAX(7)  =
                                                TBL-TGMONEY-TAX(7)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "60"
                                       COMPUTE  TBL-TGMONEY-TAX(8)  =
                                                TBL-TGMONEY-TAX(8)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "70"
                                       COMPUTE  TBL-TGMONEY-TAX(9)  =
                                                TBL-TGMONEY-TAX(9)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   "80"
                                       COMPUTE  TBL-TGMONEY-TAX(10)  =
                                                TBL-TGMONEY-TAX(10)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                   WHEN   OTHER
                                     IF   TNS-SRYCD(1:1)    =   "6"
                                       COMPUTE  TBL-TGMONEY-TAX(4)  =
                                                TBL-TGMONEY-TAX(4)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                     END-IF
                                     IF   TNS-SRYCD(1:1)    =   "7"
                                       COMPUTE  TBL-TGMONEY-TAX(10)  =
                                                TBL-TGMONEY-TAX(10)  +
                                               (SRY-JIHIMONEY(IDZ) *
                                                SINRYO-COUNT)
                                     END-IF
                               END-EVALUATE
                           END-IF
                       END-IF
                   END-PERFORM
           END-EVALUATE
           .
       HKNTEKGAI-TBL-EXT.
           EXIT.
      *
      **************************************************************
      *    保険適用外金額の集計テーブルから収納テーブルへのセット
      **************************************************************
       HKNTEKGAI-SET-SEC          SECTION.
      *
      *  保険適用外
           PERFORM     VARYING   IDZ    FROM   1    BY    1
                         UNTIL   IDZ    >      11
                  MOVE   TBL-TGMONEY(IDZ)      TO  SYU-TGMONEY(IDZ)
                  MOVE   TBL-TGMONEY-TAX(IDZ)  TO  SYU-TGMONEY-TAX(IDZ)
                  ADD    TBL-TGMONEY(IDZ)      TO  SYU-TGMONEY(12)
                  ADD    TBL-TGMONEY-TAX(IDZ)  TO  SYU-TGMONEY-TAX(12)
           END-PERFORM
      *
      *  自費１から５
           PERFORM     VARYING   IDZ    FROM    1    BY    1
                         UNTIL   IDZ    >       5
                  MOVE TBL-JIHI-TAXNASI(IDZ) TO SYU-JIHI-TAXNASI(IDZ)
                  MOVE TBL-JIHI-TAXARI(IDZ)  TO SYU-JIHI-TAXARI(IDZ)
                  ADD  TBL-JIHI-TAXNASI(IDZ) TO SYU-JIHI-TOTAL
                  ADD  TBL-JIHI-TAXARI(IDZ)  TO SYU-JIHI-TOTAL-TAX
           END-PERFORM
           .
       HKNTEKGAI-SET-EXT.
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
      *    診療会計マスター読込
      *****************************************************************
       SRYACCT-READ-SEC         SECTION.
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
      *    診療行為マスター読込
      *****************************************************************
       SRYACT-READ-SEC         SECTION.
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
                                           SYS-5000-REC
                                           SYS-5113-REC
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               INITIALIZE                  SYSKANRI-REC
                                           SYS-5000-REC
                                           SYS-5113-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
      *
           .
       SYSKANRI-READ-EXT.
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
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "TENSU-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       TENSU-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター読込
      *****************************************************************
       HKNCOMBI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
               MOVE    ZERO            TO  FLG-HKNCOMBI
           ELSE
               INITIALIZE                  HKNCOMBI-REC
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
      *
           .
       HKNCOMBI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    カーソルクローズ処理
      *****************************************************************
       CSR-CLOSE-SEC            SECTION.
      *
           INITIALIZE                  MCPAREA
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WK-PATH             TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           .
       CSR-CLOSE-EXT.
           EXIT.
