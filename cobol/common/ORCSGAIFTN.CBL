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
       PROGRAM-ID.         ORCSGAIFTN.
      ****************************************************************
      *    OS           LINUX                                         
      *                                                               
      *    PROGRAM      ORCSGAIFTN  /  負担金額算定サブ               
      *                                （外来用）                     
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/06/30    NACL−門脇    新規作成
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
      *    添え字領域
       01  IDX-AREA.
           03  IDX                         PIC 9(02).
           03  IDY                         PIC 9(02).
           03  IDZ                         PIC 9(02).
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
      *    収納マスター
       01  SYUNOU-REC.
           COPY    "CPSYUNOU.INC".
      *
      *    ワーク収納マスター
       01  WRK-SYUNOU-REC-T.
         02 WRK-SYUNOU-REC     OCCURS 15.
           COPY    "CPSYUNOU.INC" REPLACING  //SYU-// BY //WRK-SYU-//.
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "CPORCS01.INC"   REPLACING  //LNK-// BY //WRK-//.
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      /
      ***
       LINKAGE             SECTION.
           COPY  "MCPAREA". 
           COPY  "CPORCS01.INC".
       01  LNK-SYUNOU-REC-T.
         02 LNK-SYUNOU-REC     OCCURS 15.
           COPY  "CPSYUNOU.INC"    REPLACING  //SYU-// BY //LNK-SYU-//.
      /
       PROCEDURE           DIVISION  USING
                                     MCPAREA
                                     LNK-ORCS01-REC
                                     LNK-SYUNOU-REC-T.
      ******************************************************************
      *        依頼制御処理
      ******************************************************************
       MAIN-RTN            SECTION.
       MAIN-000.
      *
           MOVE    ZERO         TO  LNK-S01-RC.
      *
      *    合計レコードをもつレコードのフラグセット
           PERFORM    VARYING   IDX    FROM   1   BY   1
                              UNTIL  (IDX                 >    15 )
                                OR   (LNK-SYU-SRYYMD(IDX) =  SPACE)
                IF   LNK-SYU-SRYKA(IDX)  =  "00"
                    PERFORM    VARYING   IDY    FROM   1   BY   1
                                UNTIL    IDY    >    IDX
      *
                      IF   LNK-SYU-HKNCOMBINUM(IDY)
                                         =  LNK-SYU-HKNCOMBINUM(IDX)
                          MOVE   "1"   TO   LNK-S01-TTLARIFLG(IDY)
                      END-IF
      *
                    END-PERFORM
                END-IF
      *
           END-PERFORM.
      *
      *
           PERFORM    VARYING   IDX    FROM   1   BY   1
                              UNTIL  (IDX                 >    15 )
                                OR   (LNK-SYU-SRYYMD(IDX) =  SPACE)
                                OR   (LNK-S01-RC      NOT =  ZERO )
      *
                MOVE     LNK-ORCS01-REC       TO  WRK-ORCS01-REC
                MOVE     IDX                  TO  WRK-S01-IDX
                MOVE     LNK-SYUNOU-REC(IDX)  TO  SYUNOU-REC
      *
                MOVE     SPACE                TO  WRK-SYUNOU-REC-T
                INITIALIZE                        WRK-SYUNOU-REC-T
      *
                MOVE     ZERO      TO     IDZ
                IF       IDX   >   1
                   IF   SYU-SRYKA  =  "00"
                     PERFORM    VARYING   IDY    FROM   1   BY   1
                                 UNTIL    IDY    >    IDX - 1
      *
                         IF   WRK-S01-TTLARIFLG(IDY)  =    "1"
                           IF   LNK-SYU-SRYKA(IDY)       =  "00"
                               ADD   1      TO  IDZ
                               MOVE  LNK-SYUNOU-REC(IDY)
                                            TO  WRK-SYUNOU-REC(IDZ)
                           END-IF
                         ELSE
      *                    当該収納が合計レコードで、
      *                    合計レコードをもたないレコードを読む込む場合
                           IF   LNK-SYU-SRYKA(IDY)   NOT =  "00"
                               ADD   1      TO  IDZ
                               MOVE  LNK-SYUNOU-REC(IDY)
                                            TO  WRK-SYUNOU-REC(IDZ)
                           END-IF
                         END-IF
      *
                     END-PERFORM
                   ELSE
                     PERFORM    VARYING   IDY    FROM   1   BY   1
                                 UNTIL    IDY    >    IDX - 1
      *
                       IF  WRK-S01-TTLARIFLG(IDX)  =    "1"
                           IF     LNK-SYU-SRYKA(IDY)   NOT =  "00"
                               ADD   1      TO  IDZ
                               MOVE  LNK-SYUNOU-REC(IDY)
                                            TO  WRK-SYUNOU-REC(IDZ)
                           END-IF
                       ELSE
                         IF   WRK-S01-TTLARIFLG(IDY)  =    "1"
                           IF     WRK-S01-KAGRPFLG       =   "0"
      *                      ＜複数科まとめ集計する場合＞
      *                      当該収納が合計レコードをもたないレコードで、
      *                      合計レコードをもつレコードを読む込む場合
                             IF   LNK-SYU-SRYKA(IDY)       =  "00"
                               ADD   1      TO  IDZ
                               MOVE  LNK-SYUNOU-REC(IDY)
                                            TO  WRK-SYUNOU-REC(IDZ)
                             END-IF
                           ELSE
                             IF   LNK-SYU-SRYKA(IDY)   NOT =  "00"
                               ADD   1      TO  IDZ
                               MOVE  LNK-SYUNOU-REC(IDY)
                                            TO  WRK-SYUNOU-REC(IDZ)
                             END-IF
                           END-IF
                         ELSE
                           IF     LNK-SYU-SRYKA(IDY)   NOT =  "00"
                               ADD   1      TO  IDZ
                               MOVE  LNK-SYUNOU-REC(IDY)
                                            TO  WRK-SYUNOU-REC(IDZ)
                           END-IF
                         END-IF
                       END-IF
      *
                     END-PERFORM
                   END-IF
                END-IF
      *
      *         複数科まとめ集計しない場合、合計レコードは処理しない
                IF     WRK-S01-KAGRPFLG          =   "1"
                AND    SYU-SRYKA                 =  "00"
                    CONTINUE
                ELSE
                    CALL     "ORCS01"     USING    MCPAREA
                                                   WRK-ORCS01-REC
                                                   SYUNOU-REC
                                                   WRK-SYUNOU-REC-T
                END-IF
      *
                MOVE     SYUNOU-REC           TO  LNK-SYUNOU-REC(IDX)
                MOVE     WRK-ORCS01-REC       TO  LNK-ORCS01-REC
      *
           END-PERFORM.
      *
       MAIN-EXT.
           EXIT PROGRAM
           STOP RUN.
      *
