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
       PROGRAM-ID.             ORCHC01.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 患者登録
      *  コンポーネント名  : カルテ（診療録）印刷
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/04/10  保険者番号の編集
      *  01.00.02    MCC-藤原     01/04/11  病名・公費のテーブル化
      *  01.00.03    MCC-藤原     01/04/19  パラメタの変更・公費の編集  
      *  01.00.04    MCC-藤原     01/05/20  住所編集の変更
      *  01.00.05    MCC-森脇     01/09/10  続紙の処理追加
      *  01.00.06    MCC-藤原     01/10/03  出力先プリンタ名編集
      *  01.00.07    MCC-多々納   01/12/11  カルテ病名追加
      *  01.00.08    MCC-藤原     02/03/18  帳票ファイル名の変更
      *  01.00.09    MCC-多々納   02/03/27  保険組合せなし追加
      *  01.00.10    MCC-多々納   02/05/07  全角変換の追加
      *  01.00.11    MCC-多々納   02/05/23  労災の追加
      *  01.00.12    NACL-多々納  02/09/13  自賠責・印刷サプの追加
      *  01.00.13    NACL-多々納  02/11/01  受給者番号の全角８文字以上対応
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    印刷用データ
           SELECT  PRT-FILE       ASSIGN  HC01PARA
                                   FILE    STATUS  IS  STS-PARA.
      *---- (01.00.05) LINE ADD START ----------------------------       
           SELECT  PRTX-FILE      ASSIGN  HC011PARA
                                   FILE    STATUS  IS  STSX-PARA.
      *---- (01.00.05) LINE ADD END   ----------------------------
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    印刷用データ
       FD  PRT-FILE.
           COPY    "HC01.INC".
      *---- (01.00.05) LINE ADD START ----------------------------
      *    印刷用データ続紙
       FD  PRTX-FILE.
           COPY    "HC011.INC".
      *---- (01.00.05) LINE ADD END   ----------------------------
      *
       WORKING-STORAGE             SECTION.
      *     印刷用データ 名称領域 
           COPY    "CPCOMMONPRT.INC".
      *---- (01.00.05) LINE ADD START ----------------------------
      *     印刷用データ 名称領域 
           COPY    "CPCOMMONPRT1.INC".
      *---- (01.00.05) LINE ADD END   ----------------------------
      *    シェル用領域
      *    COPY    "CPCOMMONSHELL.INC".
      *
      *    シェル用領域
      *    COPY    "CPSHELLTBL.INC".
      **** COPY    "ORCA-DBPATH".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-PARA            PIC X(02).
       01  STSX-AREA.
           03  STSX-PARA            PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PARA            PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-PTHKNINF        PIC 9(01).
           03  FLG-PTKOHINF        PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-PTBYOMEI        PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-HKNJAINF        PIC 9(01).
      *---- (01.00.01) LINE ADD START ----------------------------
           03  FLG-OK              PIC 9(01).
           03  FLG-ZOKUSHI         PIC 9(01).
      *---- (01.00.01) LINE ADD END   ----------------------------
           03  FLG-PTRSIINF        PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ERR             PIC 9(06).
      *
      *    システム領域
       01  SYS-AREA.
           03  SYS-YMD.
               05  SYS-YY          PIC 9(02).
               05  SYS-MM          PIC 9(02).
               05  SYS-DD          PIC 9(02).
      *****03  SYS-TIME.
      *        05  SYS-THH         PIC 9(02).
      *        05  SYS-TMM         PIC 9(02).
      *        05  SYS-TSS         PIC 9(02).
      *********05  SYS-TDD         PIC 9(02).
      *    システム領域
       01  SYS-AREA.
           03  SYS-TIME            PIC 9(08).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDX2                PIC 9(02).
           03  IDX3                PIC 9(02).
           03  IDXP                PIC 9(02).
      *---- (01.00.01) LINE ADD START ----------------------------
           03  IDY                 PIC 9(04).
           03  IDK                 PIC 9(04).
      *---- (01.00.01) LINE ADD END   ----------------------------  
           03  IDX2-1              PIC 9(01).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-SYSYMD.
               05  WRK-SYSYY         PIC 9(04).
               05  WRK-SYSMM         PIC 9(02).
               05  WRK-SYSDD         PIC 9(02).
      *
           03  WRK-WSYSYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
      *
           03  WRK-PAGE            PIC 9(03).
      *
           03  WRK-ADRS          PIC X(200).
           03  WRK-NENREI-X.
               05  WRK-NENREI        PIC 9(03).
      *
      *---- (01.00.01) LINE ADD START ----------------------------                          
           03  WRK-HKNJA           PIC X(08).
           03  WRK-HKNJA-G         PIC X(16).
      *
      *    文字変換
           03  WRK-ZENKAKU-G.
               05  WRK-ZENKAKU         PIC X(02)   OCCURS   10.
           03  WRK-MOJI                PIC X(10).
           03  WRK-MOJISU              PIC 9(02).
           03  WRK-MAE-INPUT           PIC X(200).
           03  WRK-OUT-INPUT           PIC X(200).
      *
      *---- (01.00.11) LINE ADD START ----------------------------
           03  WRK-HEN-KIGONUM         PIC X(80).
      *---- (01.00.11) LINE ADD END   ----------------------------
           03  WRK-KIGONUM             PIC X(80).
           03  WRK-NUM                 PIC X(80).
      *
           03  WRK-WARI            PIC 9(02)V9.
           03  WRK-Z6              PIC ZZZZ.
           03  WRK-Z62             PIC Z9.9.
           03  WRK-Z3              PIC ZZ9.
      *
           03  WRK-HKNCOMBI        PIC X(40).
      *---- (01.00.01) LINE ADD END   ----------------------------                          
           03  WRK-HPTNUM          PIC X(08). 
           03  WRK-FTNSNO          PIC X(16).
      *****03  WRK-JKYSNO          PIC X(16).
           03  WRK-JKYSNO          PIC X(20).
           03  WRK-TEKSTYMD        PIC X(22).
           03  WRK-TEKEDYMD        PIC X(22).
      *
           03  WRK-STRYMD.
               05  WRK-STRGO       PIC X(04).
               05  WRK-STRYY       PIC X(04).
               05  WRK-STR1        PIC X(02).
               05  WRK-STRMM       PIC X(04).
               05  WRK-STR2        PIC X(02).
               05  WRK-STRDD       PIC X(04).
               05  WRK-STR3        PIC X(02).
           03  WRK-ENDYMD.
               05  WRK-ENDGO       PIC X(04).
               05  WRK-ENDYY       PIC X(04).
               05  WRK-END1        PIC X(02).
               05  WRK-ENDMM       PIC X(04).
               05  WRK-END2        PIC X(02).
               05  WRK-ENDDD       PIC X(04).
               05  WRK-END3        PIC X(02).
      *
           03  WRK-STRYMDW.
               05  WRK-STRGOW      PIC X(01).
               05  WRK-STRYYW      PIC X(02).
               05  WRK-STR1W       PIC X(01).
               05  WRK-STRMMW      PIC X(02).
               05  WRK-STR2W       PIC X(01).
               05  WRK-STRDDW      PIC X(02).
           03  WRK-ENDYMDW.
               05  WRK-ENDGOW      PIC X(01).
               05  WRK-ENDYYW      PIC X(02).
               05  WRK-END1W       PIC X(01).
               05  WRK-ENDMMW      PIC X(02).
               05  WRK-END2W       PIC X(01).
               05  WRK-ENDDDW      PIC X(02).
      *
           03  WRK-ERRMSG          PIC X(40).
      *
       01  WRK-HENSYU-AREA.
           03  WRK-HENYMDG         PIC X(22).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC X(02).
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HMM         PIC X(02).
               05  FILLER          PIC X(01)   VALUE  ".".
               05  WRK-HDD         PIC X(02).
      *
           03  WRK-HENTIME.
               05  WRK-THH         PIC 99.
               05  FILLER          PIC X(01)   VALUE  ":".
               05  WRK-TMM         PIC 99.
           03  WRK-SPA-SYSYYYY.
               05  WRK-SPA-SYSYY   PIC  9(04).
      *
      *   日本語数字
       01  TBL-SUJI-AREA.
           03  FILLER          PIC X(20)   VALUE
              "１２３４５６７８９０".
       01  TBL-SUJI-R          REDEFINES   TBL-SUJI-AREA.
           03  TBL-SUJI        PIC X(02)   OCCURS   10.
      *
       01  DUMMY PIC X(03).
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険マスタ
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *
      *    公費マスタ
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *
      *    保険組合せ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    保険マスタ
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *    患者病名マスタ−
       01  PTBYOMEI-REC.
           COPY    "CPPTBYOMEI.INC".
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *    出力先プリンタ名割り当て情報
           COPY  "CPSK1031.INC".
      *
      *    印刷パラメタ
           COPY    "CPORCSMKPRT.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    日付サブルーチン領域
      *
           COPY  "CPORCSDAY.INC".
      *
           COPY  "CPORCSLNK.INC".
      *
      *    数字変換領域
           COPY  "CPORCSNUM.INC".
      *   患者番号変換サブ
           COPY  "CPORCSPTID.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *
      *    保険者号マスタ
       01  HKNJAINF-REC.
           COPY    "CPHKNJAINF.INC".
      *
      *    ＤＢ検索
           COPY    "MCPAREA".
      *
      *01  MCPDATA-REC                 PIC X(5000).
           COPY    "MCPDATA.INC".
           COPY    "CPORCMCP.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
           COPY    "COMMON-SPA".
      *
      *---- (01.00.03) LINE DEL START ----------------------------                          
      *01   HC01LNK-PTNUM              PIC X(20).
      *01   HC01LNK-PTID               PIC 9(10).
      *01   HC01LNK-COMBINUM           PIC X(04).
      *01   HC01LNK-SRYKA              PIC X(17).
      *---- (01.00.03) LINE DEL END ------------------------------                          
      *
       PROCEDURE                   DIVISION    USING
           SPA-AREA
      *---- (01.00.03) LINE DEL START ----------------------------                          
      **   HC01LNK-PTNUM
      **   HC01LNK-PTID
      **   HC01LNK-COMBINUM
      **   HC01LNK-SRYKA
      *---- (01.00.03) LINE DEL END ------------------------------
           .                          
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           PERFORM 200-MAIN-SEC    UNTIL   FLG-END  =   1
      *
           PERFORM 300-END-SEC
      *
           .
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
      *    DISPLAY "*** ORCHC01    START  *** = "  SPA-TERMID
           INITIALIZE                  FLG-AREA
           INITIALIZE                  WRK-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  HC01
           MOVE    ZERO                TO  WRK-PAGE
      *
           ACCEPT  SYS-TIME            FROM    TIME
      *
      *    ファイルＯＰＥＮ
           MOVE    "HC01"              TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
      *    変更★★★★★★
      *****MOVE    "001"               TO  HC01PARA-CNT
           ADD     1                   TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  HC01PARA-CNT
           OPEN    OUTPUT               PRT-FILE
      *
      *    パラメタ編集処理
           PERFORM 110-PARA-HENSYU-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    パラメタ編集処理
      *****************************************************************
       110-PARA-HENSYU-SEC                   SECTION.
      *
      *    出力先プリンタ名割り当て情報編集
           MOVE    SPACE               TO  SYS-1031-REC
           INITIALIZE                  SYS-1031-REC
           MOVE    "1031"              TO  SYS-1031-KANRICD
           MOVE    "*"                 TO  SYS-1031-KBNCD
           MOVE    SYS-1031-REC        TO  MCPDATA-REC
           PERFORM 800-SYSKANRI-READ-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    MCPDATA-REC         TO  SYS-1031-REC
           ELSE
      ***      MOVE    "出力先プリンタ名割り当て情報が取得できませんでした。"
      ***                                  TO  WRK-RECEERR
      ***      PERFORM 500-ERR-HENSYU-SEC
               MOVE    1                   TO  FLG-END
           END-IF 
           .
       110-PARA-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
      *　　印刷項目編集
            PERFORM 2001-SYORI-SEC
      *　　印刷用データ出力
            WRITE  HC01
      *
      ***** MOVE   "HC01.sh"           TO  SHELL-ID
      *     MOVE   "HC01.dia"          TO  SHELL-DIA
      *     MOVE   "HC01.def"          TO  SHELL-DEF
      *     MOVE   HC01PARA            TO  SHELL-DAT
      ***** MOVE   SYS-1031-PRTNM(1)    TO  SHELL-PRTNM
            CLOSE                       PRT-FILE
      *
            INITIALIZE                 ORCSMKPRTAREA
            MOVE   "HC01.sh"           TO  MKPRT-ID
            MOVE   "HC01.dia"          TO  MKPRT-DIA
            MOVE   "HC01.def"          TO  MKPRT-DEF
            MOVE   HC01PARA            TO  MKPRT-DAT
            MOVE   SYS-1031-PRTNM(1)   TO  MKPRT-PRTNM
            CALL   "ORCSMKPRT"         USING
                                       ORCSMKPRTAREA
      *
      *   印刷用スクリプト処理
      *★    ETC-EXEC SHELL   SHELL-AREA 10
      *    MOVE    SHELL-NAME          TO  SHELLTBL-NAME
      *    MOVE    SHELL-ARG1          TO  SHELLTBL-ARG1
      *    MOVE    SHELL-ARG2          TO  SHELLTBL-ARG2
      *    MOVE    SHELL-ARG3          TO  SHELLTBL-ARG3
      *    MOVE    SHELL-ARG4          TO  SHELLTBL-ARG4
      *    MOVE    SHELL-ARG5          TO  SHELLTBL-ARG5
      *    MOVE    SHELLTBL            TO  MCPDATA-REC
      *    MOVE    "SHELL"             TO  MCP-FUNC
      *    MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
      *    CALL    "MCPSUB"            USING
      *            MCPAREA
      ******       MCPDATA-REC
      *
      *---- (01.00.05) LINE MOD START ----------------------------
      *    続紙あり
           IF      FLG-ZOKUSHI         =   1  AND
                   FLG-PTBYOMEI        =   ZERO
               PERFORM 2002-ZOKUSHI-SEC
           END-IF
      *---- (01.00.05) LINE MOD END ------------------------------
      *
           MOVE    1                   TO  FLG-END 
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       2001-SYORI-SEC                SECTION.
      *
      *    患者マスター検索
           INITIALIZE                      PTINF-REC
           MOVE    SPA-HOSPID        TO  PTINF-HOSPID
      *---- (01.00.03) LINE MOD START ---------------------------- 
      **   MOVE    HC01LNK-PTID      TO  PTINF-PTID
           MOVE    SPA-PTID          TO  PTINF-PTID
      *---- (01.00.03) LINE MOD END ------------------------------ 
           PERFORM 900-PTINF-READ-SEC
           IF      FLG-PTINF           =   1
               DISPLAY "*** PTINF  INVALIE:"   PTINF-KEY
               GO      TO      2001-SYORI-EXT
           END-IF
      *
      *    保険組合せマスター検索
           INITIALIZE                      HKNCOMBI-REC
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
      *---- (01.00.03) LINE MOD START ----------------------------
      **   MOVE    HC01LNK-PTID        TO  COMB-PTID
      **   MOVE    HC01LNK-COMBINUM    TO  COMB-HKNCOMBINUM
           MOVE    SPA-PTID            TO  COMB-PTID
           MOVE    SPA-HKNCOMBINUM     TO  COMB-HKNCOMBINUM
      *---- (01.00.03) LINE MOD END ------------------------------
           PERFORM 910-HKNCOMBI-READ-SEC
           IF      FLG-HKNCOMBI        =   1
      ********* DISPLAY "*** HKNCOMBI  エラー"
      *********GO      TO      2001-SYORI-EXT
               INITIALIZE                  HKNCOMBI-REC
           END-IF
      *
      *    患者保険情報検索
           INITIALIZE                      PTHKNINF-REC
           MOVE    SPA-HOSPID          TO  PTHKN-HOSPID
      *---- (01.00.03) LINE MOD START ---------------------------- 
      **   MOVE    HC01LNK-PTID        TO  PTHKN-PTID
           MOVE    SPA-PTID            TO  PTHKN-PTID
      *---- (01.00.03) LINE MOD END ------------------------------
      *    主保険−ＩＤ
           MOVE    COMB-HKNID          TO  PTHKN-HKNID
           PERFORM 920-PTHKNINF-READ-SEC
           IF      FLG-PTHKNINF      NOT =   ZERO
               INITIALIZE              PTHKNINF-REC
           END-IF
      *
      *---- (01.00.01) LINE ADD START ---------------------------- 
      *    保険者番号変換処理
           MOVE    SPACE               TO  WRK-HKNJA
           MOVE    9                   TO  IDY
           MOVE    ZERO                TO  FLG-OK
           PERFORM VARYING     IDX     FROM    8   BY  -1
                   UNTIL       IDX     <   1
               IF      PTHKN-HKNJANUM(IDX:1)   NOT =   SPACE
                   MOVE    1               TO  FLG-OK
               END-IF
               IF      FLG-OK              =   1
                   COMPUTE IDY         =   IDY     -   1
                   MOVE    PTHKN-HKNJANUM(IDX:1)   TO  WRK-HKNJA (IDY:1)
               END-IF
           END-PERFORM
      **** MOVE    WRK-HKNJA           TO  WRK-MOJI
      *    MOVE    8                   TO  WRK-MOJISU
      *    PERFORM 2009-HENKAN-SEC
      *****MOVE    WRK-ZENKAKU-G(1:16) TO  WRK-HKNJA-G
           MOVE    16                  TO  WRK-MOJISU
           MOVE    WRK-HKNJA           TO  WRK-MAE-INPUT
           PERFORM 2009-HENKAN-SEC
           MOVE    WRK-OUT-INPUT(1:16) TO  WRK-HKNJA-G
      *---- (01.00.01) LINE ADD END ------------------------------- 
      *
      *    保険番号マスター検索
           INITIALIZE                  HKNNUM-REC
           MOVE    SPA-HOSPID    TO  HKN-HOSPID
           MOVE    COMB-HKNNUM         TO  HKN-HKNNUM
           MOVE    COMB-TEKSTYMD       TO  HKN-TEKSTYMD
           PERFORM 930-HKNNUM-READ-SEC
           IF      FLG-HKNNUM      NOT =   ZERO
               INITIALIZE              HKNNUM-REC
           END-IF
      *
      *    保険者番号　検索チェック
           INITIALIZE                    HKNJAINF-REC
           MOVE    SPA-HOSPID            TO  HKNJA-HOSPID
           MOVE    PTHKN-HKNJA-G         TO  HKNJA-HKNJANUM
           MOVE    HKNJAINF-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"            TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
               PERFORM 900-HKNJAINF-READ-SEC
           ELSE
               INITIALIZE                  HKNJAINF-REC
               MOVE    1               TO  FLG-HKNJAINF
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNJAINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
      *    帳票編集処理
           PERFORM 310-HC01-HEN-SEC
      *
           .
       2001-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    帳票編集処理
      *****************************************************************
       310-HC01-HEN-SEC                SECTION.
      *
           INITIALIZE  HC01
      *
      *    患者マスターより
      *---- (01.00.03) LINE MOD START ----------------------------- 
      *    MOVE    HC01LNK-PTNUM       TO  HC01-PTNUM
           MOVE    SPA-PTNUM           TO  HC01-PTNUM
      *---- (01.00.03) LINE MOD END -------------------------------
           MOVE    PTINF-NAME          TO  HC01-NAME
      *
      *---- (01.00.01) LINE ADD START ----------------------------- 
      *    診療科
      *****MOVE    SPA-SRYKAMEI        TO  HC01-SRYKA
      *---- (01.00.01) LINE ADD END -------------------------------
      *
           EVALUATE    PTINF-SEX
               WHEN    "1"
      ************ MOVE    NC"男"                TO  HC01-SEX
                   MOVE    "○"                  TO  HC01-OTOKO
               WHEN    "2"
      ************ MOVE    NC"女"                TO  HC01-SEX
                   MOVE    "○"                  TO  HC01-ONNA
           END-EVALUATE
      *
           MOVE    PTINF-BIRTHDAY         TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
      *    MOVE    WRK-HENYMDG         TO  SCNV-INCODE
      *    CALL    "ORCSCNV"           USING
      *                                ORCSCNVAREA
      *****MOVE    WRK-HENYMDG         TO  HC01-BIRTH
           MOVE    WRK-HENYMDG(1:4)    TO  HC01-TANJYOG
           MOVE    WRK-HYY             TO  HC01-TANJYOY
           MOVE    WRK-HMM             TO  HC01-TANJYOM
           MOVE    WRK-HDD             TO  HC01-TANJYOD
      *　　年齢
           MOVE    SPA-SYSYMD(1:4)     TO  WRK-SPA-SYSYYYY
           COMPUTE WRK-NENREI        =   WRK-SPA-SYSYY
                                       -   WRK-SYY
           IF      SPA-SYSYMD(5:4)     <   WRK-SYMD(5:4)
               COMPUTE WRK-NENREI   =   WRK-NENREI   -   1
           END-IF
      *---- (01.00.01) LINE MOD START ---------------------------------
      *    MOVE   WRK-NENREI        TO  HC01-NENREI
           MOVE    WRK-NENREI       TO  WRK-Z3
      *****MOVE    WRK-Z3           TO  HC01-NENREI 
      *---- (01.00.01) LINE MOD END -----------------------------------
      *
      *    自宅−住所
           MOVE    SPACE               TO  WRK-ADRS
      *---- (01.00.04) LINE MOD START ---------------------------------
      *    STRING  PTINF-HOME-ADRS     DELIMITED   BY  "　　"
      *            PTINF-HOME-BANTI    DELIMITED   BY  "　　"
      *            INTO                    WRK-ADRS
      *    END-STRING
      *    MOVE    WRK-ADRS(1:36)      TO  HC01-ADRS1
      *    MOVE    WRK-ADRS(37:)       TO  HC01-ADRS2
           STRING  PTINF-HOME-ADRS     DELIMITED   BY  SPACE
                   PTINF-HOME-BANTI    DELIMITED   BY  SPACE
                   INTO                    WRK-ADRS
           END-STRING
           MOVE    WRK-ADRS            TO  HC01-ADRS
      *---- (01.00.04) LINE MOD END -----------------------------------
      *
      *    自宅−昼電話番号
           MOVE    PTINF-HOME-TEL1     TO  HC01-ADRSTEL
      *    続柄
           MOVE    PTINF-ZOKUGARA      TO  HC01-TUZUKI
      *    職業
           MOVE    PTINF-JOB           TO  HC01-WORK
      *
      *事業所
      *    名称
           MOVE    PTINF-OFFICE-NAME   TO  HC01-KINNAME
      *    勤務先−住所,番地方書
           MOVE    SPACE               TO  WRK-ADRS
           STRING  PTINF-OFFICE-ADRS   DELIMITED   BY  SPACE
                   PTINF-OFFICE-BANTI  DELIMITED   BY  SPACE
                   INTO                    WRK-ADRS
           END-STRING
           MOVE    WRK-ADRS            TO  HC01-KINADRS
      *    MOVE    WRK-ADRS(1:36)      TO  HC01-KINADRS1
      *    MOVE    WRK-ADRS(37:)       TO  HC01-KINADRS2
      *    電話番号
           MOVE    PTINF-OFFICE-TEL    TO  HC01-KINADRSTEL
      *
      *    保険者情報
      *    保険者番号
      *---- (01.00.01) LINE MOD START ---------------------------------
      **   MOVE    PTHKN-HKNJANUM      TO  HC01-HPTNUM
           MOVE    WRK-HKNJA-G         TO  HC01-HPTNUM
      *
      *    記号
      **   MOVE    PTHKN-KIGO          TO  HC01-KIGO
      *    番号
      **   MOVE    PTHKN-NUM           TO  HC01-NO
      *    STRING  PTHKN-KIGO          DELIMITED   BY  SPACE
      *            "・"                DELIMITED   BY  SIZE
      *            PTHKN-NUM           DELIMITED   BY  SPACE
      *            INTO                    HC01-KIGONUM
      *****END-STRING
      *    全角変換
           MOVE    PTHKN-KIGO          TO  WRK-MAE-INPUT
           PERFORM 2009-HENKAN-SEC
           MOVE    WRK-OUT-INPUT(1:KANACHK-MAX)
                                       TO  WRK-KIGONUM
           MOVE    PTHKN-NUM           TO  WRK-MAE-INPUT
           PERFORM 2009-HENKAN-SEC
           MOVE    WRK-OUT-INPUT(1:KANACHK-MAX)
                                       TO  WRK-NUM
      *
           IF      (WRK-KIGONUM        =   SPACE )  AND
                   (WRK-NUM            =   SPACE )
               MOVE    SPACE               TO  WRK-HEN-KIGONUM
           ELSE
               STRING  WRK-KIGONUM         DELIMITED   BY  SPACE
                       "・"                DELIMITED   BY  SIZE
                       WRK-NUM             DELIMITED   BY  SPACE
      *---- (01.00.11) LINE UPD START ----------------------------
      ***********  INTO                    HC01-KIGONUM
                   INTO                    WRK-HEN-KIGONUM
               END-STRING
           END-IF
      *
           MOVE    WRK-HEN-KIGONUM     TO  HC01-KIGONUM
      *---- (01.00.11) LINE UPD START ----------------------------
      *
      *---- (01.00.01) LINE MOD END   ---------------------------------
      *    被保険者名
           MOVE    PTHKN-HIHKNJANAME   TO  HC01-HIHKNJNAME
      *    適用開始年月日（資格取得日へ）
      *****MOVE    PTHKN-TEKSTYMD      TO  WRK-SYMD
           IF      PTHKN-SKKGETYMD     =   SPACE
               CONTINUE
           ELSE
               MOVE    PTHKN-SKKGETYMD     TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG(1:4)    TO  HC01-SIKAKUG
               MOVE    WRK-HYY             TO  HC01-SIKAKUY
               MOVE    WRK-HMM             TO  HC01-SIKAKUM
               MOVE    WRK-HDD             TO  HC01-SIKAKUD
           END-IF
      *    適用終了年月日
           IF      PTHKN-TEKEDYMD      =   SPACE  OR  ALL "9"
      *---- (01.00.01) LINE MOD START ---------------------------------
               CONTINUE
      **       MOVE    "平成　　年　　月　　日"
      **                                   TO  HC01-TEKEDYMD
      *---- (01.00.01) LINE MOD END -----------------------------------
           ELSE
               MOVE    PTHKN-TEKEDYMD      TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
      *********MOVE    WRK-HENYMDG         TO  HC01-TEKEDYMD
               MOVE    WRK-HENYMDG(1:4)    TO  HC01-YUKOG
               MOVE    WRK-HYY             TO  HC01-YUKOY
               MOVE    WRK-HMM             TO  HC01-YUKOM
               MOVE    WRK-HDD             TO  HC01-YUKOD
           END-IF
      *
      *    保険者情報
      **** MOVE    HKNJA-HKNJANAME-TAN1    TO  HC01-HKNNAME
           MOVE    HKNJA-HKNJANAME         TO  HC01-HKNNAME
           STRING  HKNJA-ADRS        DELIMITED  BY  SPACE
                   HKNJA-BANTI       DELIMITED  BY  SPACE
                   INTO                    HC01-HKNADRS
           END-STRING
      *    MOVE    HKNJA-ADRS              TO  HC01-HKNADRS
      *    MOVE    HKNJA-BANTI         TO  SPA-GMN2B-HKNJABANTI
           MOVE    HKNJA-TEL           TO  HC01-HKNADRSTEL
      *
      *    負担割合
      *    本人−外来−負担区分 
      *---- (01.00.01) LINE MOD START ------------------------------
      **   IF      PTHKN-HONKZKKBN     =   "1"
      **       MOVE    HKN-HON-GAIKFTNRATE     TO  HC01-FTNWARI
      **   ELSE
      **       MOVE    HKN-KZK-GAIKFTNRATE     TO  HC01-FTNWARI
      **   END-IF
      *****IF      COMB-GAI-KFTNRATE >   ZERO
      *        COMPUTE WRK-WARI        =   COMB-GAI-KFTNRATE   /   10
      *        IF      COMB-GAI-KFTNRATE(3:1)  =   ZERO
      *            MOVE    WRK-WARI            TO  WRK-Z6
      *            MOVE    WRK-Z6              TO  HC01-FTNWARI
      *        ELSE
      *            MOVE    WRK-WARI            TO  WRK-Z62
      *            MOVE    WRK-Z62             TO  HC01-FTNWARI
      *        END-IF
      *****END-IF
      *
      *    保険区分　主保険−短縮制度名
      **   MOVE    COMB-SYU-TANSEIDONAME   TO  HC01-KUMI
           MOVE    SPACE               TO  WRK-HKNCOMBI
      *
           STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                   "　"                    DELIMITED  BY  SIZE
                   COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                         INTO              WRK-HKNCOMBI
           END-STRING
      *****MOVE    WRK-HKNCOMBI            TO  HC01-KUMI
      *---- (01.00.01) LINE MOD END --------------------------------
      *
      *---- (01.00.03) LINE MOD START-------------------------------
      *    公費情報１
      **     INITIALIZE                  PTKOHINF-REC
      **     MOVE    SPA-HOSPID          TO  PTKOH-HOSPID
      **     MOVE    HC01LNK-PTID        TO  PTKOH-PTID
      **     MOVE    SPA-PTID            TO  PTKOH-PTID
      **     MOVE    COMB-KOH1ID         TO  PTKOH-KOHID
      **     PERFORM 940-PTKOHINF-READ-SEC
      **     IF      FLG-PTKOHINF        =   ZERO
      **         PERFORM 3102-PTKOHINF-HEN-SEC
      **         MOVE    WRK-FTNSNO      TO  HC01-FTNSNO1
      **         MOVE    WRK-JKYSNO      TO  HC01-JKYSNO1
      **         MOVE    WRK-TEKSTYMD    TO  HC01-TEKSTYMD1
      **         MOVE    WRK-TEKEDYMD    TO  HC01-TEKEDYMD1
      **     END-IF
      *
      *    公費情報２
      **     INITIALIZE                  PTKOHINF-REC
      **     MOVE    SPA-HOSPID          TO  PTKOH-HOSPID
      **     MOVE    HC01LNK-PTID        TO  PTKOH-PTID
      **     MOVE    COMB-KOH2ID         TO  PTKOH-KOHID
      **     PERFORM 940-PTKOHINF-READ-SEC
      **     IF      FLG-PTKOHINF          =   ZERO
      **         PERFORM 3102-PTKOHINF-HEN-SEC
      **         MOVE    WRK-FTNSNO      TO  HC01-FTNSNO2
      **         MOVE    WRK-JKYSNO      TO  HC01-JKYSNO2
      **         MOVE    WRK-TEKSTYMD    TO  HC01-TEKSTYMD2
      **         MOVE    WRK-TEKEDYMD    TO  HC01-TEKEDYMD2
      **     END-IF
      *
      *    公費情報３
      **     INITIALIZE                  PTKOHINF-REC
      **     MOVE    SPA-HOSPID          TO  PTKOH-HOSPID
      **     MOVE    HC01LNK-PTID        TO  PTKOH-PTID
      **     MOVE    COMB-KOH3ID         TO  PTKOH-KOHID
      **     PERFORM 940-PTKOHINF-READ-SEC
      **     IF      FLG-PTKOHINF          =   ZERO
      **         PERFORM 3102-PTKOHINF-HEN-SEC
      **         MOVE    WRK-FTNSNO      TO  HC01-FTNSNO3
      **         MOVE    WRK-JKYSNO      TO  HC01-JKYSNO3
      **         MOVE    WRK-TEKSTYMD    TO  HC01-TEKSTYMD3
      **         MOVE    WRK-TEKEDYMD    TO  HC01-TEKEDYMD3
      **     END-IF
      *
      *    公費情報
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       3
               INITIALIZE                  PTKOHINF-REC
               MOVE    SPA-HOSPID          TO  PTKOH-HOSPID
               MOVE    SPA-PTID            TO  PTKOH-PTID
               MOVE    COMB-KOHID (IDY)    TO  PTKOH-KOHID
               PERFORM 940-PTKOHINF-READ-SEC
               IF      FLG-PTKOHINF          =   ZERO
                   PERFORM 3102-PTKOHINF-HEN-SEC
                   MOVE    WRK-FTNSNO      TO  HC01-FTNSNO (IDY)
      *************MOVE    WRK-JKYSNO      TO  HC01-JKYSNO (IDY)
                   IF      WRK-JKYSNO(15:)     =   SPACE
                       MOVE    WRK-JKYSNO      TO  HC01-JKYSNO (IDY)
                   ELSE
                       MOVE    WRK-JKYSNO      TO  HC01-JKYSNON(IDY)
                   END-IF
               ELSE
                   MOVE    "平成　　年　　月　　日"
                                           TO  WRK-TEKSTYMD
                                               WRK-TEKEDYMD
               END-IF
      ****     MOVE    WRK-TEKSTYMD    TO  HC01-TTEKSTYMD (IDY)
      ****     MOVE    WRK-TEKEDYMD    TO  HC01-TTEKEDYMD (IDY)
           END-PERFORM
      *---- (01.00.03) LINE MOD END ------------------------------ 
      *---- (01.00.11) LINE ADD START ----------------------------
      *
      *    労災の時、保険者番号・記号の変更
           IF      COMB-HKNNUM         =   "971"  OR  "973"
      *        患者保険情報検索
               INITIALIZE                      PTRSIINF-REC
               MOVE    SPA-HOSPID          TO  PTRSI-HOSPID
               MOVE    SPA-PTID            TO  PTRSI-PTID
               MOVE    COMB-HKNID          TO  PTRSI-HKNID
               MOVE    PTRSIINF-REC        TO  MCPDATA-REC
               MOVE    "DBSELECT"          TO  MCP-FUNC
               MOVE    "PTRSIINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    "PTRSIINF-KEY"     TO  ORC-DBPATH
                   PERFORM 993-PTRSIINF-NEXT-SEC
               ELSE
                   INITIALIZE                      PTRSIINF-REC
                   MOVE    1                   TO  FLG-PTRSIINF
               END-IF
               IF      FLG-PTRSIINF        =   ZERO
      *            保険者番号へ記号（労災区分名）
                   MOVE    WRK-HEN-KIGONUM     TO  HC01-HPTNUM
      *            記号へ患者交付番号
                   MOVE    PTRSI-KOFUNUM       TO  WRK-MAE-INPUT
                   PERFORM 2009-HENKAN-SEC
                   MOVE    WRK-OUT-INPUT(1:KANACHK-MAX)
                                               TO  HC01-KIGONUM
      *
               END-IF
           END-IF
      *---- (01.00.11) LINE ADD END   ----------------------------
      *---(01.00.01) LINE ADD START ------------------------------------
      *
      *    患者病名マスタより編集
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  FLG-ZOKUSHI
           INITIALIZE                      PTBYOMEI-REC
           MOVE    SPA-HOSPID          TO  PTBYO-HOSPID
      *---- (01.00.03) LINE MOD START ---------------------------- 
      **   MOVE    HC01LNK-PTID        TO  PTBYO-PTID
      **   MOVE    HC01LNK-SRYKA       TO  PTBYO-SRYKA
           MOVE    SPA-PTID            TO  PTBYO-PTID
           MOVE    SPA-SRYKA           TO  PTBYO-SRYKA
      *---- LINE MOD END   ----------------------------------------
      *
           MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
               PERFORM 950-PTBYOMEI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-PTBYOMEI
           END-IF
           PERFORM 
                   UNTIL      (FLG-PTBYOMEI    NOT =   ZERO  )
                        OR    (FLG-ZOKUSHI     NOT =   ZERO  )
      *        病名編集処理
               PERFORM 3103-BYOMEI-SET-SEC
      *---- (01.00.05) LINE MOD START ---------------------------------
      *********MOVE    PTBYO-BYOMEI        TO  HC01-BYOMEIG (IDX)  
      *        カルテ病名がある時はカルテ病名
               IF      PTBYO-CHARTBYOMEI   =   SPACE
                   MOVE    PTBYO-BYOMEI        TO  HC01-BYOMEIG (IDX)
               ELSE
                   MOVE    PTBYO-CHARTBYOMEI   TO  HC01-BYOMEIG (IDX)
               END-IF
               MOVE    WRK-STRYYW          TO  HC01-STRYMD  (IDX  1)
               MOVE    WRK-STRMMW          TO  HC01-STRYMD  (IDX  2)
               MOVE    WRK-STRDDW          TO  HC01-STRYMD  (IDX  3)
               MOVE    WRK-ENDYYW          TO  HC01-ENDYMD  (IDX  1)
               MOVE    WRK-ENDMMW          TO  HC01-ENDYMD  (IDX  2)
               MOVE    WRK-ENDDDW          TO  HC01-ENDYMD  (IDX  3)
               IF      IDX2                >   ZERO
                   MOVE    "○"            TO  HC01-TENKI   (IDX IDX2)
               END-IF
      *
               MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
               PERFORM 950-PTBYOMEI-READ-SEC
      *
      *********IF      IDX             >=  6
               IF      IDX             >=  8
                   MOVE    1               TO  FLG-ZOKUSHI
      ******** ELSE
      *            MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
      ***********  PERFORM 950-PTBYOMEI-READ-SEC
               END-IF
           END-PERFORM
      *
      *---- (01.00.05) LINE MOD END -----------------------------------
           .
       310-HC01-HEN-EXT.
           EXIT.
      *****************************************************************
      *    患者公費変換処理
      *****************************************************************
       3102-PTKOHINF-HEN-SEC        SECTION.
      *
           MOVE    SPACE               TO  WRK-TEKSTYMD
           MOVE    SPACE               TO  WRK-TEKEDYMD
           MOVE    SPACE               TO  WRK-FTNSNO
           MOVE    SPACE               TO  WRK-JKYSNO
      *    保険者情報
      *****保険者番号　漢字変換
      *    MOVE    1                   TO  IDX3
      *    MOVE    PTKOH-FTNJANUM      TO  WRK-HPTNUM
      *    PERFORM VARYING     IDX     FROM    1   BY  1
      *            UNTIL       IDX     >   8
      *        IF      WRK-HPTNUM (IDX:1)  NUMERIC
      *            MOVE    ZERO                    TO  IDX2
      *            MOVE    WRK-HPTNUM (IDX:1)      TO  IDX2-1
      *            IF      IDX2-1          =   ZERO
      *                MOVE    10                  TO  IDX2
      *            ELSE
      *                MOVE    IDX2-1              TO  IDX2
      *            END-IF
      *            MOVE    TBL-SUJI (IDX2)     TO  WRK-FTNSNO(IDX3:2)
      *        END-IF
      *        ADD     2                   TO  IDX3
      **** END-PERFORM
      *    全角変換
           MOVE    PTKOH-FTNJANUM      TO  WRK-MAE-INPUT
           MOVE    16                  TO  WRK-MOJISU
           PERFORM 2009-HENKAN-SEC
           MOVE    WRK-OUT-INPUT(1:16) TO  WRK-FTNSNO
      *    受給者番号１　漢字変換
      *****MOVE    1                   TO  IDX3
      *    MOVE    PTKOH-JKYSNUM       TO  WRK-HPTNUM
      *    PERFORM VARYING     IDX     FROM    1   BY  1
      *            UNTIL       IDX     >   8
      *        IF      WRK-HPTNUM (IDX:1)  NUMERIC
      *            MOVE    WRK-HPTNUM (IDX:1)      TO  IDX2-1
      *            IF      IDX2-1          =   ZERO
      *                MOVE    10                  TO  IDX2
      *            ELSE
      *                MOVE    IDX2-1              TO  IDX2
      *            END-IF
      *            MOVE    TBL-SUJI (IDX2)     TO  WRK-JKYSNO(IDX3:2)
      *        END-IF
      *        ADD     2                   TO  IDX3
      *****END-PERFORM
      *    全角変換
           MOVE    PTKOH-JKYSNUM       TO  WRK-MAE-INPUT
           MOVE    14                  TO  WRK-MOJISU
           PERFORM 2009-HENKAN-SEC
      **** IF      KANACHK-MAX         >   14
      *        COMPUTE WRK-MOJISU      =   KANACHK-MAX   -   14
      *                                +   1
      *        MOVE    WRK-OUT-INPUT(WRK-MOJISU:14) TO  WRK-JKYSNO
      *    ELSE
      *        MOVE    WRK-OUT-INPUT(1:14)        TO  WRK-JKYSNO
      *****END-IF
           MOVE    SPACE               TO  WRK-JKYSNO
           MOVE    WRK-OUT-INPUT(1:KANACHK-MAX)
                                       TO  WRK-JKYSNO
      *
      *    適用開始年月日
           MOVE    PTKOH-TEKSTYMD      TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
           MOVE    WRK-HENYMDG         TO  WRK-TEKSTYMD
      *    適用終了年月日
           IF      PTKOH-TEKEDYMD      =   SPACE  OR  ALL "9"
      *---- (01.00.01) LINE MOD START ---------------------------------
      **       MOVE    SPACE               TO  WRK-TEKEDYMD
               MOVE    "平成　　年　　月　　日"
                                           TO  WRK-TEKEDYMD
      *---- (01.00.01) LINE MOD END -----------------------------------
           ELSE
               MOVE    PTKOH-TEKEDYMD      TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
               MOVE    WRK-HENYMDG         TO  WRK-TEKEDYMD
           END-IF
      *
           .
       3102-PTKOHINF-HEN-EXT.
           EXIT.
      *---- (01.00.05) LINE MOD START ----------------------------
      *****************************************************************
      *    続紙印刷処理
      *****************************************************************
       2002-ZOKUSHI-SEC          SECTION.
      *
      *    ファイルＯＰＥＮ
      *    MOVE    "HC011"             TO  HC011PARA-FORM-ID
      *    MOVE    SPA-TERMID          TO  HC011PARA-TERMID
      *    変更★★★★★★
      *    MOVE    "001"               TO  HC011PARA-CNT
      *    OPEN    OUTPUT               PRTX-FILE
      *
           INITIALIZE  HC011
           MOVE    ZERO                TO  IDX
           MOVE    SPA-PTNUM           TO  HC011-PTNUM
           MOVE    PTINF-NAME          TO  HC011-NAME
      *
      * 　 印刷項目編集
           PERFORM  UNTIL      FLG-PTBYOMEI    NOT =   ZERO
      *
               IF      IDX             >=  22
                   PERFORM 20021-HC011-PRINT-SEC
               END-IF
      *
      *        病名編集処理
               PERFORM 3103-BYOMEI-SET-SEC
      *********MOVE    PTBYO-BYOMEI        TO  HC011-BYOMEIG (IDX)
      *        カルテ病名がある時はカルテ病名
               IF      PTBYO-CHARTBYOMEI   =   SPACE
                   MOVE    PTBYO-BYOMEI        TO  HC011-BYOMEIG (IDX)
               ELSE
                   MOVE    PTBYO-CHARTBYOMEI   TO  HC011-BYOMEIG (IDX)
               END-IF
               MOVE    WRK-STRYYW          TO  HC011-STRYMD  (IDX  1)
               MOVE    WRK-STRMMW          TO  HC011-STRYMD  (IDX  2)
               MOVE    WRK-STRDDW          TO  HC011-STRYMD  (IDX  3)
               MOVE    WRK-ENDYYW          TO  HC011-ENDYMD  (IDX  1)
               MOVE    WRK-ENDMMW          TO  HC011-ENDYMD  (IDX  2)
               MOVE    WRK-ENDDDW          TO  HC011-ENDYMD  (IDX  3)
               IF      IDX2                >   ZERO
                   MOVE    "○"            TO  HC011-TENKI   (IDX IDX2)
               END-IF
      *
               MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
               PERFORM 950-PTBYOMEI-READ-SEC
           END-PERFORM
      *
           IF      IDX                 >   ZERO
               PERFORM 20021-HC011-PRINT-SEC
           END-IF
      *
      *    MOVE    "DBCLOSE"           TO  MCP-FUNC
      *    MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
      *    CALL    "ORCMCPSUB"          USING
      *                                 MCPAREA
      *                                 ORCMCPAREA
      ********************************* MCPDATA-REC
           .
       2002-ZOKUSHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    続紙印刷　処理
      *****************************************************************
       20021-HC011-PRINT-SEC                SECTION.
      *
      *    ファイルＯＰＥＮ
      **   MOVE    "HC011"             TO  HC011PARA-FORM-ID
      *    MOVE    SYS-TIME            TO  HC011PARA-SYOHMS
      *    変更★★★★★★
      *    ADD     1                   TO  WRK-PAGE
      *    MOVE    WRK-PAGE            TO  HC011PARA-CNT
      *****OPEN    OUTPUT               PRTX-FILE
      *    ファイルＯＰＥＮ
           MOVE    "HC011"             TO  HC01PARA-FORM-ID
           MOVE    SPA-TERMID          TO  HC01PARA-TERMID
           MOVE    SYS-TIME            TO  HC01PARA-SYOHMS
           ADD     1                   TO  WRK-PAGE
           MOVE    WRK-PAGE            TO  HC01PARA-CNT
           MOVE    HC01PARA            TO  HC011PARA
           OPEN    OUTPUT              PRTX-FILE
      *
      *
      *　　印刷用データ出力
           WRITE   HC011
      *
      **** MOVE    "HC01.sh"           TO  SHELL-ID
      *    MOVE    "HC011.dia"         TO  SHELL-DIA
      *    MOVE    "HC011.def"         TO  SHELL-DEF
      *    MOVE    HC011PARA           TO  SHELL-DAT
      **** MOVE    SYS-1031-PRTNM(1)   TO  SHELL-PRTNM 
           CLOSE                       PRTX-FILE
      *
            INITIALIZE                 ORCSMKPRTAREA
            MOVE   "HC01.sh"           TO  MKPRT-ID
            MOVE   "HC011.dia"         TO  MKPRT-DIA
            MOVE   "HC011.def"         TO  MKPRT-DEF
            MOVE   HC011PARA           TO  MKPRT-DAT
            MOVE   SYS-1031-PRTNM(1)   TO  MKPRT-PRTNM
            CALL   "ORCSMKPRT"         USING
                                       ORCSMKPRTAREA
      *
      *    印刷用スクリプト処理
      *★    ETC-EXEC SHELL   SHELL-AREA 10
      *    MOVE    SHELL-NAME          TO  SHELLTBL-NAME
      *    MOVE    SHELL-ARG1          TO  SHELLTBL-ARG1
      *    MOVE    SHELL-ARG2          TO  SHELLTBL-ARG2
      *    MOVE    SHELL-ARG3          TO  SHELLTBL-ARG3
      *    MOVE    SHELL-ARG4          TO  SHELLTBL-ARG4
      *    MOVE    SHELL-ARG5          TO  SHELLTBL-ARG5
      *    MOVE    SHELLTBL            TO  MCPDATA-REC
      *    MOVE    "SHELL"             TO  MCP-FUNC
      *    MOVE    PATH-SHELL-SHELL    TO  MCP-PATH
      *    CALL    "MCPSUB"            USING
      *            MCPAREA
      ******       MCPDATA-REC
      *
           INITIALIZE  HC011
           MOVE    ZERO                TO  IDX
           MOVE    SPA-PTNUM           TO  HC011-PTNUM
           MOVE    PTINF-NAME          TO  HC011-NAME
      *
           .
       20021-HC011-PRINT-EXT.
           EXIT.
      *
      *---- (01.00.05) LINE MOD END ------------------------------ 
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
           MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMD
      *---- (01.00.01) LINE INS START ---------------------------------
           INSPECT WRK-HENYMDG    REPLACING  ALL "  "  BY  "　"
      *---- (01.00.01) LINE INS END -----------------------------------
           .
       31012-SEIWA-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *        病名編集処理
      *****************************************************************
       3103-BYOMEI-SET-SEC        SECTION.
      *
           ADD     1                   TO  IDX
      *    開始年月日（診療年月日）
           MOVE    PTBYO-SRYYMD        TO  WRK-SYMD
           PERFORM 31012-SEIWA-HEN-SEC
      *****MOVE    WRK-HENYMDG         TO  WRK-STRYMD
           MOVE    WRK-HENYMD          TO  WRK-STRYMDW
      *
      *    終了年月日（転帰年月日）
           MOVE    SPACE               TO  WRK-ENDYMD
           MOVE    SPACE               TO  WRK-ENDYMDW
           IF      PTBYO-TENKIYMD  NOT =   SPACE
               MOVE    PTBYO-TENKIYMD      TO  WRK-SYMD
               PERFORM 31012-SEIWA-HEN-SEC
      *********MOVE    WRK-HENYMDG         TO  WRK-ENDYMD
               MOVE    WRK-HENYMD          TO  WRK-ENDYMDW
           END-IF
      *
           EVALUATE    PTBYO-TENKIKBN
               WHEN    "1"
                   MOVE    1               TO  IDX2
               WHEN    "2"
                   MOVE    2               TO  IDX2
               WHEN    "3"
                   MOVE    3               TO  IDX2
               WHEN    OTHER
                   MOVE    ZERO            TO  IDX2
           END-EVALUATE
      *
      *---- (01.00.02) LINE MOD START ---------------------------------
      **   EVALUATE    IDX
      **     WHEN    1
      **           MOVE    PTBYO-BYOMEI        TO  HC01-BYOMEI1G
      **           MOVE    WRK-STRYY           TO  HC01-STRYMD1 (01)
      **           MOVE    WRK-STRMM           TO  HC01-STRYMD1 (02)
      **           MOVE    WRK-STRDD           TO  HC01-STRYMD1 (03)
      **           MOVE    WRK-ENDYY           TO  HC01-ENDYMD1 (01)
      **           MOVE    WRK-ENDMM           TO  HC01-ENDYMD1 (02)
      **           MOVE    WRK-ENDDD           TO  HC01-ENDYMD1 (03)
      **           IF      IDX2                >   ZERO
      **               MOVE    "○"          TO  HC01-TENKI1 (IDX2)
      **           END-IF
      *
      **       WHEN    2
      **           MOVE    PTBYO-BYOMEI        TO  HC01-BYOMEI2G
      **           MOVE    WRK-STRYY           TO  HC01-STRYMD2 (01)
      **           MOVE    WRK-STRMM           TO  HC01-STRYMD2 (02)
      **           MOVE    WRK-STRDD           TO  HC01-STRYMD2 (03)
      **           MOVE    WRK-ENDYY           TO  HC01-ENDYMD2 (01)
      **           MOVE    WRK-ENDMM           TO  HC01-ENDYMD2 (02)
      **           MOVE    WRK-ENDDD           TO  HC01-ENDYMD2 (03)
      **           IF      IDX2                >   ZERO
      **               MOVE    "○"          TO  HC01-TENKI2 (IDX2)
      **           END-IF
      *
      **       WHEN    3
      **           MOVE    PTBYO-BYOMEI        TO  HC01-BYOMEI3G
      **           MOVE    WRK-STRYY           TO  HC01-STRYMD3 (01)
      **           MOVE    WRK-STRMM           TO  HC01-STRYMD3 (02)
      **           MOVE    WRK-STRDD           TO  HC01-STRYMD3 (03)
      **           MOVE    WRK-ENDYY           TO  HC01-ENDYMD3 (01)
      **           MOVE    WRK-ENDMM           TO  HC01-ENDYMD3 (02)
      **           MOVE    WRK-ENDDD           TO  HC01-ENDYMD3 (03)
      **           IF      IDX2                >   ZERO
      **               MOVE    "○"          TO  HC01-TENKI3 (IDX2)
      **           END-IF
      *
      **       WHEN    4
      **           MOVE    PTBYO-BYOMEI        TO  HC01-BYOMEI4G
      **           MOVE    WRK-STRYY           TO  HC01-STRYMD4 (01)
      **           MOVE    WRK-STRMM           TO  HC01-STRYMD4 (02)
      **           MOVE    WRK-STRDD           TO  HC01-STRYMD4 (03)
      **           MOVE    WRK-ENDYY           TO  HC01-ENDYMD4 (01)
      **           MOVE    WRK-ENDMM           TO  HC01-ENDYMD4 (02)
      **           MOVE    WRK-ENDDD           TO  HC01-ENDYMD4 (03)
      **           IF      IDX2                >   ZERO
      **               MOVE    "○"          TO  HC01-TENKI4 (IDX2)
      **           END-IF
      *
      **       WHEN    5
      **           MOVE    PTBYO-BYOMEI        TO  HC01-BYOMEI5G
      **           MOVE    WRK-STRYY           TO  HC01-STRYMD5 (01)
      **           MOVE    WRK-STRMM           TO  HC01-STRYMD5 (02)
      **           MOVE    WRK-STRDD           TO  HC01-STRYMD5 (03)
      **           MOVE    WRK-ENDYY           TO  HC01-ENDYMD5 (01)
      **           MOVE    WRK-ENDMM           TO  HC01-ENDYMD5 (02)
      **           MOVE    WRK-ENDDD           TO  HC01-ENDYMD5 (03)
      **           IF      IDX2                >   ZERO
      **               MOVE    "○"          TO  HC01-TENKI5 (IDX2)
      **           END-IF
      *
      **       WHEN    6
      **           MOVE    PTBYO-BYOMEI        TO  HC01-BYOMEI6G
      **           MOVE    WRK-STRYY           TO  HC01-STRYMD6 (01)
      **           MOVE    WRK-STRMM           TO  HC01-STRYMD6 (02)
      **           MOVE    WRK-STRDD           TO  HC01-STRYMD6 (03)
      **           MOVE    WRK-ENDYY           TO  HC01-ENDYMD6 (01)
      **           MOVE    WRK-ENDMM           TO  HC01-ENDYMD6 (02)
      **           MOVE    WRK-ENDDD           TO  HC01-ENDYMD6 (03)
      **           IF      IDX2                >   ZERO
      **               MOVE    "○"          TO  HC01-TENKI6 (IDX2)
      **           END-IF
      *
      **   END-EVALUATE
      *---- (01.00.05) LINE ADD START ---------------------------------
      *---- (01.00.05) LINE MOD END ------------------------------------
      *---- (01.00.01) LINE MOD END ------------------------------------
      *
           .
       3103-BYOMEI-SET-EXT.
           EXIT.
      *---- (01.00.01) LINE ADD START ---------------------------------
      *
      *****************************************************************
      *    全角変換処理
      *****************************************************************
       2009-HENKAN-SEC                 SECTION.
     *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"                 TO  KANACHK-SYORI
           MOVE    WRK-MAE-INPUT       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
               MOVE    KANACHK-OUT-INPUT(1:KANACHK-MAX)
                                           TO  WRK-OUT-INPUT
           ELSE
               MOVE    WRK-MAE-INPUT       TO  WRK-OUT-INPUT
           END-IF
      *
      *    MOVE    ALL "　"            TO  WRK-ZENKAKU-G
      *
      *    PERFORM VARYING     IDK     FROM    1   BY  1
      *            UNTIL       IDK     >   WRK-MOJISU
      *        IF      WRK-MOJI (IDK:1)    NUMERIC
      *            MOVE    WRK-MOJI(IDK:1)     TO  IDX2-1
      *            IF      IDX2-1              =   ZERO
      *                MOVE    10                  TO  IDX2
      *            ELSE
      *                MOVE    IDX2-1              TO  IDX2
      *            END-IF
      *            MOVE    TBL-SUJI (IDX2)     TO  WRK-ZENKAKU(IDK)
      *        ELSE
      *            IF      WRK-MOJI (IDK:1)    =   "."
      *                MOVE    "．"            TO  WRK-ZENKAKU(IDK)
      *            END-IF
      *        END-IF
      *****END-PERFORM
           .
       2009-HENKAN-EXT.
           EXIT.
      *---- (01.00.01) LINE ADD END -----------------------------------
      * 
      *****************************************************************
      *    患者マスター読み込み
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
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
                   MOVE    MCPDATA-REC     TO  PTINF-REC
                   MOVE    ZERO            TO  FLG-PTINF
               ELSE
                   MOVE    1               TO  FLG-PTINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTINF
           END-IF
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTINF-KEY"         TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せマスター読み込み
      *****************************************************************
       910-HKNCOMBI-READ-SEC         SECTION.
      *
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
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
                   MOVE    MCPDATA-REC     TO  HKNCOMBI-REC
                   MOVE    ZERO            TO  FLG-HKNCOMBI
               ELSE
                   MOVE    1               TO  FLG-HKNCOMBI
               END-IF
           ELSE
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
     *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       910-HKNCOMBI-READ-EXT.
           EXIT.
      *****************************************************************
      *    保険マスター読み込み
      *****************************************************************
       920-PTHKNINF-READ-SEC         SECTION.
      *
           MOVE    PTHKNINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  PTHKNINF-REC
                   MOVE    ZERO            TO  FLG-PTHKNINF
               ELSE
                   MOVE    1               TO  FLG-PTHKNINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTHKNINF
           END-IF
     *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTHKNINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       920-PTHKNINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号マスター読み込み
      *****************************************************************
       930-HKNNUM-READ-SEC         SECTION.
      *
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  HKNNUM-REC
                   MOVE    ZERO            TO  FLG-HKNNUM
               ELSE
                   MOVE    1               TO  FLG-HKNNUM
               END-IF
           ELSE
               MOVE    1               TO  FLG-HKNNUM
           END-IF
     *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNNUM-KEY"        TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       930-HKNNUM-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    公費マスター読み込み
      *****************************************************************
       940-PTKOHINF-READ-SEC         SECTION.
      *
           MOVE    PTKOHINF-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "PTKOHINF-KEY"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                            MCPAREA
                                            ORCMCPAREA
                                            MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC     TO  PTKOHINF-REC
                   MOVE    ZERO            TO  FLG-PTKOHINF
               ELSE
                   MOVE    1               TO  FLG-PTKOHINF
               END-IF
           ELSE
               MOVE    1               TO  FLG-PTKOHINF
           END-IF
     *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTKOHINF-KEY"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
      *
           .
       940-PTKOHINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者病名マスター読み込み
      *****************************************************************
       950-PTBYOMEI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTBYOMEI-REC
               MOVE    ZERO            TO  FLG-PTBYOMEI
           ELSE
               MOVE    1               TO  FLG-PTBYOMEI
           END-IF
      *
           .
       950-PTBYOMEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスタ読み込み
      *****************************************************************
       800-SYSKANRI-READ-SEC           SECTION.
      *
           MOVE    SPA-SYSYMD     TO  ORC-DBYMD
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
                   MOVE    ZERO            TO  FLG-SYSKANRI
               ELSE
                   MOVE    1               TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
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
       800-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険者番号マスタ次検索処理
      *****************************************************************
       900-HKNJAINF-READ-SEC              SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNJAINF-REC
               MOVE    ZERO            TO  FLG-HKNJAINF
           ELSE
               INITIALIZE              HKNJAINF-REC
               MOVE    1               TO  FLG-HKNJAINF
           END-IF
           .
       900-HKNJAINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者労災保険情報読み込み
      *****************************************************************
       993-PTRSIINF-NEXT-SEC        SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                        MCPAREA
                                        ORCMCPAREA
                                        MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTRSIINF-REC
               MOVE    ZERO            TO  FLG-PTRSIINF
           ELSE
               INITIALIZE                  PTRSIINF-REC
               MOVE    1               TO  FLG-PTRSIINF
           END-IF
      *
           .
       993-PTRSIINF-NEXT-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
      *
           .
       300-END-EXT.
           EXIT.
