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
000200 IDENTIFICATION          DIVISION.
000300 PROGRAM-ID.             ORCSJOB.
000400*****************************************************************
000500*  システム名        : ＯＲＣＡ
000600*  サブシステム名    : ジョブ管理
000700*  コンポーネント名  : ジョブ管理ＤＢ制御
000800*  管理者            : 
000900*  作成日付    作業者        記述
      *  02/01/20    MCC−藤原　   新規作成
001100*****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     02/05/15  DELALLの追加  
      *****************************************************************
001200*
001300 ENVIRONMENT             DIVISION.
001400 CONFIGURATION           SECTION.
001500 INPUT-OUTPUT            SECTION.
001600 FILE-CONTROL.
007000 DATA                    DIVISION.
010200 WORKING-STORAGE         SECTION.
      *
018000*    フラグ領域
      *
018100 01  FLG-AREA.
           03  FLG-END                                 PIC 9(01).
018900     03  FLG-JOBKANRI                            PIC 9(01).
020800*    カウント領域
020900 01  CNT-AREA.
021000     03  CNT-IN                                  PIC 9(06).
      *
       01  INDEX-AREA.
           03  IDX                                     PIC 9(03). 
      *
      *
024200 01  WRK-AREA.
           03  WRK-SRYYMD.
               05  WRK-SRYYM           PIC 9(06).
               05  WRK-SRYDD           PIC 9(02).  
      *シェルＩＤ
           03  WRK-SHELLID             PIC X(08).
      *
           COPY    "MCPAREA".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
       01  WRK-JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC"    REPLACING   //JOB-//
                                       BY          //WRK-JOB-//.
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
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
           COPY    "ORCA-DBPATH".
           COPY    "CPORCMCP.INC".
      *     
      **************************************************************************
      *
       LINKAGE                 SECTION.
      *   ジョブ管理ＤＢ制御サブ
           COPY    "CPORCSJOBKANRI.INC".
       01  JOBKANRI-REC.
           COPY    "CPJOBKANRI.INC".
      *
      **************************************************************************
       PROCEDURE           DIVISION
               USING
               ORCSJOBKANRIAREA
               JOBKANRI-REC.
      *
      *****************************************************************
      *    主処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
      *???
           DISPLAY "ORCSJOB ST =" SJOBKANRI-MODE "##"
      *???     
           INITIALIZE                  CNT-AREA
                                       WRK-AREA
      *    処理モードのチェック
           EVALUATE    SJOBKANRI-MODE
               WHEN    "JBS"
                       PERFORM 110-JBS-SEC
               WHEN    "JBE"
                       PERFORM 120-JBE-SEC
               WHEN    "STS"
                       PERFORM 130-STS-SEC
                       PERFORM 900-DBCOMMIT-SEC
                       PERFORM 900-DBSTART-SEC
               WHEN    "STE"
                       PERFORM 160-STE-SEC
               WHEN    "DEL"
                       PERFORM 140-DEL-SEC
               WHEN    "ALL"
                       PERFORM 170-DELALL-SEC
               WHEN    "CHK"
                       PERFORM 150-CHK-SEC
               WHEN    OTHER
                       MOVE  10            TO  SJOBKANRI-RETURN  
                       MOVE  1             TO  FLG-END
           END-EVALUATE
      *???
           DISPLAY "ORCSJOB ED =" SJOBKANRI-RETURN "##"
      *???     
      *
           .
       000-PROC-EXT.
           EXIT PROGRAM
           .
      *****************************************************************
      *    ジョブ開始セット　処理
      *****************************************************************
       110-JBS-SEC                 SECTION.
      *
           ACCEPT  JOB-STARTYMD        FROM DATE
           ACCEPT  JOB-STARTTIME       FROM TIME
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    JOBKANRI-REC        TO  MCPDATA-REC
           MOVE    PATH-TBL-JOBKANRI-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC      
      *
           IF      MCP-RC     =   ZERO
               CONTINUE
           ELSE
               DISPLAY "INSERT ERR KEY = [" MCP-RC JOB-KEY "]"   
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           END-IF
      *
           .
       110-JBS-EXT.
           EXIT.
      * 
      *****************************************************************
      *    ジョブ終了セット　処理
      *****************************************************************
       120-JBE-SEC                 SECTION.
      *
      *    レコード存在チェック
           IF      JOB-SHELLID(1:6)    =   "MSTMNT"
               MOVE    JOB-SHELLID         TO  WRK-SHELLID
               MOVE    SPACE               TO  JOB-SHELLID(7:)
           END-IF
           MOVE    JOBKANRI-REC        TO  MCPDATA-REC
           IF      JOB-SHELLID(1:6)    =   "MSTMNT"
               PERFORM 910-JOBKANRI-INV-SEC
           ELSE
               PERFORM 910-JOBKANRI-INV2-SEC
           END-IF        
           IF      FLG-JOBKANRI   NOT  =  ZERO
               MOVE  MCP-RC                TO  SJOBKANRI-RETURN
               GO  TO  120-JBE-EXT
           END-IF
      *    エラーコード
           IF      WRK-SHELLID(7:2)    NOT =   SPACE
               MOVE    WRK-SHELLID(7:2)    TO  JOB-ERRCD(1:2)
           END-IF
      *
      *    レコード更新
           ACCEPT  WRK-JOB-ENDYMD      FROM DATE
           ACCEPT  WRK-JOB-ENDTIME     FROM TIME
           MOVE    JOB-YOBI            TO  WRK-JOB-YOBI
           MOVE    JOB-ERRCD           TO  WRK-JOB-ERRCD
           MOVE    WRK-JOBKANRI-REC    TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    PATH-TBL-JOBKANRI-UPD1
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           IF      MCP-RC     =   ZERO
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           ELSE
               DISPLAY "UPDATE ERR KEY = [" MCP-RC JOB-SHELLID "]"   
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           END-IF
      *
           .
       120-JBE-EXT.
           EXIT.
      * 
      * 
      *****************************************************************
      *    ステップ開始セット　処理
      *****************************************************************
       130-STS-SEC                 SECTION.
      *
      *    レコード存在チェック
           MOVE    JOBKANRI-REC        TO  MCPDATA-REC
           PERFORM 910-JOBKANRI-INV2-SEC
           IF       FLG-JOBKANRI       NOT  =  ZERO
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
               GO    TO                130-STS-EXT
           END-IF
      *
      *    レコード更新
           MOVE    ZERO                TO  WRK-JOB-STEPENDTIME
           ACCEPT  WRK-JOB-STEPSTARTTIME
                                       FROM TIME
           MOVE    JOB-PGID            TO  WRK-JOB-PGID                            
           MOVE    JOB-SHELLMSG        TO  WRK-JOB-SHELLMSG
           MOVE    WRK-JOBKANRI-REC    TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    PATH-TBL-JOBKANRI-UPD1
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC      
      *
           IF      MCP-RC     =   ZERO
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           ELSE
               DISPLAY "UPDATE ERR KEY = [" MCP-RC JOB-SHELLID "]"   
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           END-IF
      *
           .
       130-STS-EXT.
           EXIT.
      * 
      * 
      *****************************************************************
      *    ステップ終了セット　処理
      *****************************************************************
       160-STE-SEC                 SECTION.
      *
      *    レコード存在チェック
           MOVE    JOBKANRI-REC        TO  MCPDATA-REC
           PERFORM 910-JOBKANRI-INV2-SEC
           IF       FLG-JOBKANRI       NOT  =  ZERO
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
               GO    TO                160-STE-EXT
           END-IF
      *
      *    レコード更新
           ACCEPT  WRK-JOB-STEPENDTIME
                                       FROM TIME
           COMPUTE WRK-JOB-UPDCNT      =   WRK-JOB-UPDCNT  +
                                           JOB-UPDCNT                            
           MOVE    WRK-JOBKANRI-REC    TO  MCPDATA-REC
           MOVE    "DBUPDATE"          TO  MCP-FUNC
           MOVE    PATH-TBL-JOBKANRI-UPD1
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC      
      *
           IF      MCP-RC     =   ZERO
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           ELSE
               DISPLAY "UPDATE ERR KEY = [" MCP-RC JOB-SHELLID "]"   
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           END-IF
      *
           .
       160-STE-EXT.
           EXIT.
      * 
      *****************************************************************
      *    削除処理
      *****************************************************************
       140-DEL-SEC                 SECTION.
      *
      *    レコード存在チェック
           MOVE    JOBKANRI-REC        TO  MCPDATA-REC
           PERFORM 910-JOBKANRI-INV2-SEC
           IF       FLG-JOBKANRI       NOT  =  ZERO
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
               GO    TO                140-DEL-EXT
           END-IF
      *
      *    レコード更新
           MOVE    JOBKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    PATH-TBL-JOBKANRI-DEL11
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC      
      *
           IF      MCP-RC     =   ZERO
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           ELSE
               DISPLAY "DELETE ERR KEY = [" MCP-RC JOB-SHELLID "]"   
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           END-IF
      *
           .
       140-DEL-EXT.
           EXIT.
      * 
      *****************************************************************
      *    削除処理（対象のシェルＩＤを全て）
      *****************************************************************
       170-DELALL-SEC                 SECTION.
      *
      *    レコード存在チェック
           MOVE    JOBKANRI-REC        TO  MCPDATA-REC
           PERFORM 910-JOBKANRI-INV-SEC
           IF       FLG-JOBKANRI       NOT  =  ZERO
               MOVE  ZERO              TO  SJOBKANRI-RETURN
               GO    TO                170-DELALL-EXT
           END-IF
      *
      *    レコード更新
           MOVE    JOBKANRI-REC        TO  MCPDATA-REC
           MOVE    "DBDELETE"          TO  MCP-FUNC
           MOVE    PATH-TBL-JOBKANRI-DEL12
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC      
      *
           IF      MCP-RC     =   ZERO
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           ELSE
               DISPLAY "DELETE ERR KEY = [" MCP-RC JOB-SHELLID "]"   
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           END-IF
      *
           .
       170-DELALL-EXT.
           EXIT.
      * 
      *****************************************************************
      *    ジョブ管理チェック処理
      *****************************************************************
       150-CHK-SEC                 SECTION.
      *
      *    レコード存在チェック
           MOVE    JOBKANRI-REC        TO  MCPDATA-REC
           PERFORM 910-JOBKANRI-INV2-SEC
           IF       FLG-JOBKANRI       NOT  =  ZERO
               MOVE  MCP-RC            TO  SJOBKANRI-RETURN
           ELSE
               MOVE    ZERO            TO  SJOBKANRI-RETURN
               MOVE    WRK-JOBKANRI-REC
                                       TO  JOBKANRI-REC
      *???
           DISPLAY "150=" JOBKANRI-REC "##"
      *???     
           END-IF
      *
           .
       150-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理マスタ読込
      *****************************************************************
       910-JOBKANRI-INV-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-JOBKANRI-KEY
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    PATH-TBL-JOBKANRI-KEY
                                       TO  MCP-PATH
               CALL    "MCPSUB"        USING
                                       MCPAREA
                                       MCPDATA-REC
      *????
               DISPLAY "FETCH=" MCP-RC    
      *???? 
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  WRK-JOBKANRI-REC
                   MOVE    ZERO                TO  FLG-JOBKANRI
               ELSE
                   MOVE    1                   TO  FLG-JOBKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-JOBKANRI
           END-IF
      *
           .
       910-JOBKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    ジョブ管理マスタ読込（ＫＥＹ２）
      *****************************************************************
       910-JOBKANRI-INV2-SEC         SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    PATH-TBL-JOBKANRI-KEY2
                                       TO  MCP-PATH
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"       TO  MCP-FUNC
               MOVE    PATH-TBL-JOBKANRI-KEY2
                                       TO  MCP-PATH
               CALL    "MCPSUB"        USING
                                       MCPAREA
                                       MCPDATA-REC
      *????
               DISPLAY "FETCH=" MCP-RC    
      *???? 
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  WRK-JOBKANRI-REC
                   MOVE    ZERO                TO  FLG-JOBKANRI
               ELSE
                   MOVE    1                   TO  FLG-JOBKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-JOBKANRI
           END-IF
      *
           .
       910-JOBKANRI-INV2-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢ　ＣＯＭＭＩＴ処理
      *****************************************************************
       900-DBCOMMIT-SEC            SECTION.
      *
           MOVE    "DBCOMMIT"          TO  MCP-FUNC.
           CALL    "MCPSUB"          USING
                                        MCPAREA
                                        MCPDATA-REC.
      *
           .
       900-DBCOMMIT-EXT.
           EXIT.
      *      
      *****************************************************************
      *    ＤＢ　ＳＴＡＲＴ処理
      *****************************************************************
       900-DBSTART-SEC                SECTION.
      *
           MOVE    "DBSTART"           TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC.
           .
       900-DBSTART-EXT.
           EXIT.
