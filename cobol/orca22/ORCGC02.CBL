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
      *
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCGC02.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 病名登録
      *  コンポーネント名  : 病名登録（Ｃ０２）
      *  管理者            : 
      *  00/12/01    MCC−藤原　   新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/04/10  保険組合せ削除区分＝１
      *                                     読み飛ばし
      *  01.00.02    MCC-多々納   01/04/18  終了時の更新確認等
      *  01.00.03    MCC-藤原     01/06/06  保険病名フラグの追加
      *  01.00.04    MCC-多々納   01/07/02  日付画面用チェックサブ追加
      *  01.02.01    MCC-藤原     01/08/27  画面修正による項目の追加  
      *  01.02.02    MCC-藤原     01/09/11  転記のチェック修正    
      *  01.02.03    MCC-藤原     01/09/11  選択番号の編集    
      *  01.02.04    MCC-藤原     01/09/12  項目編集時に開始日順に
      *                                     並び替えを行う    
      *  01.02.05    MCC-藤原     01/09/13  基本病名コードの編集追加    
      *  01.03.01    MCC-藤原     01/09/20  JOINの修正      
      *  01.03.02    MCC-藤原     01/10/11  接頭語のみのとき文字数を
      *                                     ゼロにする      
      *  01.03.03    MCC-藤原     01/10/17  疑いフラグ変更のとき
      *                                     病名編集フラグを空白にする
      *                                     転記区分の修正（４→８）       
      *  01.04.01    MCC-藤原     01/11/05  患者番号、診療科を入力項目
      *                                     に変更
      *                                     C01の削除
      *  01.04.02    MCC-藤原     01/11/13  病名コードを７桁に変更     
      *  01.05.01    MCC-藤原     01/11/21  ORCMCPSUBへ変更
      *  01.05.02    MCC-藤原     01/11/27  ボタン・日付の変更     
      *  01.06.01    MCC-藤原     01/12/06  自院病名マスタの追加     
      *  01.06.02    MCC-藤原     01/12/13  疾患区分短縮名の追加     
      *                                     修飾語コードの入力方法の変更    
      *  01.06.03    MCC-藤原     01/12/18  病名のみ入力のとき検索処理を行う     
      *                                     病名コード未入力のとき病名へ移動    
      *  01.06.04    MCC-藤原     02/01/08  病名入力コードの追加     
      *  01.06.05    MCC-藤原     02/01/31  保険組合せの表示の修正     
      *  01.06.06    MCC-藤原     02/02/05  最終受診科の表示を追加     
      *                                     単科のとき初期表示をして入力はしない
      *                                     ようにする     
      *  01.06.07    MCC-藤原     02/02/18  診療開始日と保険組合せの適用日の
      *                                     チェックの追加     
      *  01.06.08    MCC-藤原     02/02/20  慢性疾患の短縮名（０５）の
      *                                     短縮名の修正     
      *  01.06.09    MCC-藤原     02/03/05  転帰日付のチェック追加
      *  01.06.10    MCC-藤原     02/04/04  自院病名の読み込みのＫＥＹ変更
      *  01.06.11    MCC-藤原     02/04/05  自院病名検索画面の追加
      *  01.06.12    MCC-藤原     02/04/11  主病名フラグの重複チェック削除
      *                                     8002"の疑い"の病名コードのとき
      *                                     疑いフラグに１をセット
      *  01.06.13    MCC-藤原     02/05/07  病名コードが削除されるように修正 
      *  01.06.14    MCC-藤原     02/05/08  半角チェック追加
      *                                     転帰日と転帰区分のチェック追加 
      *  01.06.15    MCC-多々納   02/05/08  半角チェック時、半角空白を
      *                                     全角空白へ置換えの追加
      *  01.06.16    MCC-藤原     02/05/09  自院コードのとき病名・カルテ病名に
      *                                     入力できるように修正 
      *                                     同一病名があるときエラーにする
      *  01.06.17    MCC-多々納   02/06/05  患者氏名での検索を追加
      *  01.06.18    MCC-多々納   02/06/21  労災保険追加
      *  01.06.19    MCC-小豆沢   02/06/26  皮膚科特定疾患（３）をコンボから削除
      *  01.06.20    MCC-藤原     02/07/05  病名コード空白の時開始日に移動する
      *  01.06.21    NACL-多々納  02/07/19  患者検索エラーメッセージ修正
      *
      *  01.07.01    NACL-藤原    02/08/20  新傷病名マスタ対応
      *  01.07.02    NACL-藤原    02/08/28  労災のとき保険組合せの名称の修正
      *  01.07.03    NACL-藤原    02/09/17  自賠責とき保険組合せの名称の修正
      *  01.07.04    NACL-藤原    02/10/24  戻り先にｋ０２Ｎを追加
      *  01.07.05    NACL-藤原    02/11/19  編集病名のときの接頭語のチェック
      *                                     の修正
      *                                     病名の長さチェックの修正
      *  01.07.06    NACL-藤原    02/11/25  ＳＰＡパラメタファイルの
      *                                     端末ＩＤ変更
      *  01.07.07    NACL-藤原    02/12/13  病名文字数のチェック修正
      *  01.07.08    NACL-藤原    03/02/14  入力ＣＤ検索から戻ったときの
      *                                     カルテ病名の編集を追加
      *  01.07.09    NACL-藤原    03/02/28  診療科４０に変更
      *  02.07.10    NACL-藤原    03/03/05  排他制御処理追加
      *  02.07.11    NACL-多々納  03/03/14  ファイル削除追加
      *  02.07.12    NACL-藤原    03/03/14  同一開始日の病名の表示順の修正
      *  02.07.13    NACL-藤原    03/03/26  選択番号がエラーのときクリアする
      *  02.07.14    NACL-藤原    03/04/15  診療科から病名を編集しておく
      *  02.07.15    NACL-藤原    03/05/28  変更・削除処理後の選択の解除
      *  02.07.16    NACL-藤原    03/06/03  未コード化傷病名コードのとき
      *                                     病名よりコード検索をする
      *                                     病名からのコード検索方法の修正
      *  02.07.17    NACL-藤原    03/07/03  主病名編集フラグにより主病名
      *                                     のチェックを行う
      *  02.07.18    NACL-藤原    03/07/07  病名コード入力時、病名が変更
      *                                     なければ疑い・慢性区分の変更
      *                                     をしないように修正
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *    ＳＰＡデータ
           SELECT  SPASCR-FILE     ASSIGN  FILE-NAME1
                                   ORGANIZATION    IS  LINE
                                                       SEQUENTIAL 
                                   FILE    STATUS  IS  STS-SPASCR.
      *
       DATA                    DIVISION.
       FILE                        SECTION.
      *
      *    ＳＰＡパラメタデータ
       FD  SPASCR-FILE.
       01  SPA-DATA-REC            PIC X(30000).
      *
      *
       WORKING-STORAGE             SECTION.
      *
      * ＳＰＡパラメタデータ
       01  FILE-NAME1.
           03  FILLE               PIC X(18)   VALUE
                                               "/var/tmp/C02SPASCR".
      *****03  FILE-TERMID         PIC X(16)   VALUE   SPACE.
           03  FILE-TERMID         PIC X(64)   VALUE   SPACE.
           03  FILLER              PIC X(04)   VALUE   ".TXT".
      *
       01  WRK-DATA-REC.
           03  WRK-DATA            PIC X(30000)
                                   OCCURS  10.
      * 
       01  SPA-SCR-REC.
           COPY    "CPC02SPASCR.INC".
      *
      *    スパ領域
           COPY    "COMMON-SPA".
      *
      *    病名登録用共通パラメタ
           COPY    "C01COMMON-SPA".
      *
      *    病名登録用画面ＳＰＡ
           COPY    "C02SCR-SPA".
      *
      *   
           COPY    "ENUM-VALUE".
      *
      *    フラグ領域
       01  STS-AREA.
           03  STS-SPASCR          PIC X(02).
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-END             PIC 9(01).
           03  FLG-PTBYOMEI        PIC 9(01).
           03  FLG-USERBYOMEI      PIC 9(01).
           03  FLG-BYOMEI          PIC 9(01).
           03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-PTINF           PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-SPASCR          PIC 9(01).
           03  FLG-PTRSIINF        PIC 9(01).
      *
           03  FLG-END2            PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDW                 PIC 9(04).
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
      *     
           03  IDZ                 PIC 9(04).
           03  IDX1                PIC 9(04). 
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
      *
           03  IDXX                PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-MOTOPG          PIC X(08).
           03  WRK-SELNO           PIC 9(03). 
           03  WRK-RENNUM          PIC 9(02).
           03  WRK-SRYYMD          PIC 9(08).
           03  WRK-GMN-TBL         PIC X(1000).
           03  WRK-NAI-TBL         PIC X(1000). 
           03  WRK-WIDGET.
               05  WRK-WIDGET1     PIC X(09).
               05  WRK-WIDGET2     PIC 9(01).  
      *****03  WRK-YMD             PIC X(09).
           03  WRK-YMD             PIC X(10).
           03  WRK-YMDMAX          PIC 9(01). 
           03  WRK-SYMD.
               05  WRK-SYY         PIC 9(04).
               05  WRK-SMM         PIC 9(02).
               05  WRK-SDD         PIC 9(02).
           03  WRK-WYMD.
               05  WRK-WGO         PIC X(01).
               05  WRK-WYY         PIC 9(02).
               05  WRK-WMM         PIC 9(02).
               05  WRK-WDD         PIC 9(02).
      *         
           03  WRK-BYOMEI-AREA.
               05  WRK-BYOMEI      PIC X(100).
               05  WRK-CHARTBYOMEI PIC X(100).
               05  WRK-UTAGAIFLG   PIC X(01).
               05  WRK-TENKIKBN    PIC X(01).
               05  WRK-RECECD-TBL.
                   07  WRK-RECECD  OCCURS  3
                                   PIC X(01).
               05  WRK-MOJISU      PIC 9(03).
      *
           03  WRK-HKNCOMBIMEI     PIC X(100).
           03  WRK-HKNKBN-MEI       PIC X(02).
           03  WRK-ZZ              PIC ZZZ.
           03  WRK-MM              PIC 9(02).
           03  WRK-YMD1            PIC 9(08).
           03  WRK-YMD2            PIC 9(08).
           03  WRK-HENFLG          PIC 9(01).
           03  WRK-NUM             PIC ZZ9.
           03  WRK-CHKFLG          PIC X(01).
           03  WRK-HAISIYMDH       PIC X(22).
      *
           03  WRK-KBN-HENSYU-AREA.
               05  WRK-KBN             PIC X(04).
               05  WRK-KBNMEI          PIC X(42).
               05  WRK-KBNMEITAN       PIC X(10).                            
      *     
           03  WRK-TANDOKU-AREA.
               05  WRK-TANDOKUKBN-BYOMEICD
                                   PIC X(07).
               05  WRK-TANDOKUKBN-BYOMEI
                                   PIC X(80).                    
               05  WRK-TANDOKUKBN-G.
                   07  WRK-TANDOKUKBN 
                                   PIC 9(02)    OCCURS  6.
      *     
           03  WRK-BYOMEICD-KENSAKU-AREA.
               05  WRK-KEN-BYOMEI  PIC X(80).
               05  WRK-KEN-LENGTH  PIC 9(04).
               05  WRK-KEN-UTAGAIFLG 
                                   PIC X(01).
               05  WRK-KEN-ADDKBN  PIC X(01).
               05  WRK-BYOMEICD    PIC X(07).
               05  WRK-IKOSAKICD   PIC X(07).
               05  WRK-HAISIYMD    PIC X(08).
               05  WRK-BYO-MAX     PIC 9(01).
               05  WRK-BYO-BYOMEICD-G.
                   07  WRK-BYO-BYOMEICD 
                                   PIC X(07)    OCCURS  6.
                   07  WRK-BYO-IKOSAKICD 
                                   PIC X(07)    OCCURS  6.
                   07  WRK-BYO-HAISIYMD 
                                   PIC X(08)    OCCURS  6.
      *                             
           03  WRK-DBPATH          PIC X(64).
      *
           03  WRK-SORT-TBL.
               05  WRK-SORT-BYOMEICD-G.
                   07  WRK-SORT-BYOMEICD    OCCURS  6
      *************                         PIC X(05).
                                            PIC X(10).
               05  WRK-SORT-BYOMEI-TBL.
                   07  WRK-SORT-BYOMEI-G    OCCURS  6.  
                       09  WRK-SORT-BYOMEI  PIC X(50).
                       09  WRK-SORT-UTAGAIFLG
                                           PIC X(01).
      *****************09  WRK-SORT-RECECD PIC X(07).
                       09  WRK-SORT-TOKSKNCD 
                                           PIC 9(02).
      *
      *    未コード化傷病名コード
       01  WRK-CONS-BYOMEICD       PIC X(07)   VALUE   "0000999".                                     
      *    の疑い
       01  WRK-CONS-UTAGAI         PIC X(07)   VALUE   "ZZZ8002".                                     
      *    自院病名検索画面ＭＡＸ行
       01  WRK-CONS-C04-MAX             PIC 9(03)   VALUE   700.
      *
       01  WRK-HEN-AREA.
           03  WRK-LENGTH          PIC 9(02).
           03  WRK-NENGO           PIC X(04).
           03  WRK-HENYMDG         PIC X(09).
           03  WRK-HENYMD.
               05  WRK-HGO         PIC X(01).
               05  WRK-HYY         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HMM         PIC 9(02).
               05  FILLER          PIC X(01)   VALUE   ".".
               05  WRK-HDD         PIC 9(02).
      *
      *    患者病名マスタ−（ワーク）
       01  WRK-PTBYOMEI-REC.
           COPY    "CPPTBYOMEI.INC"
                                   REPLACING  //PTBYO-//
                                   BY         //WRK-PTBYO-//.
      *
      *    スパ領域（ワーク）
           COPY    "COMMON-SPA"
                                   REPLACING  //SPA-//
                                   BY         //WRK-SPA-//.
      *
      *
      *----(01.00.02) LINE ADD START ----------------------------------
           03  WRK-CIDMSG          PIC X(80).
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1005.INC".
      *
           COPY    "CPSK1010.INC".
      *
           COPY    "CPSK2005.INC".
      *
      *    病名マスタ−
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *
      *    自院病名マスタ−
       01  USERBYOMEI-REC.
           COPY    "CPUSERBYOMEI.INC".
      *
      *    患者病名マスタ−
       01  PTBYOMEI-REC.
           COPY    "CPPTBYOMEI.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    受診履歴マスタ−
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    患者労災保険情報
       01  PTRSIINF-REC.
           COPY    "CPPTRSIINF.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    半角チェックサブ
           COPY    "CPORCSKANACHK.INC".
      *
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *   患者番号変換サブ
           COPY    "CPORCSPTNUM.INC".
      *    数字変換領域
           COPY    "CPORCSNUM.INC".
      *----(01.00.03) LINE ADD START ----------------------------------
      *
      *   画面日付変換サブ
          COPY    "CPORCSGDAY.INC".
      *----(01.00.03) LINE ADD END   ----------------------------------
      *
      *    排他制御サブパラメタ
           COPY    "CPORCSLOCK.INC".
      *
      *    ファイル削除パラメタ
           COPY    "CPORCSFDEL.INC".
      *
      *    ＤＢ検索
           COPY    "MCPDATA.INC".
      *     
           COPY    "CPORCMCP.INC".  
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
        LINKAGE                     SECTION.
      *
      *****COPY    "MCPAREA.INC".
           COPY    MCPAREA.
           COPY    "ORCA-SPA".
      *
           COPY    "LINKAREA".
      *
       01  SCRAREA.
           COPY    "C02.INC".
           COPY    "C03.INC".
           COPY    "C04.INC".
           COPY    "C05.INC".
           COPY    "C06.INC".
           COPY    "C07.INC".
           COPY    "C08.INC".
           COPY    "CERR.INC".
           COPY    "CID1.INC".
           COPY    "CID2.INC".
      *
       PROCEDURE                   DIVISION    USING
           MCPAREA
           SPAAREA
           LINKAREA
           SCRAREA.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-FREE        TO  SPA-C02FREE
           MOVE    SPA-WORK        TO  SPA-C01KYOUTU
      *
      *    画面ＳＰＡ読み込み
           PERFORM 1002-C02SPA-SET-SEC
      *
           MOVE    SPACE           TO  SPA-ERRCD
           MOVE    ZERO            TO  FLG-END
      *
           EVALUATE    MCP-STATUS      ALSO    MCP-EVENT
               WHEN    "LINK"          ALSO    ANY
                   PERFORM 100-INIT-SEC
      *    画面遷移
               WHEN     "PUTG"           ALSO   "CLICKED"
                   PERFORM 200-GMNSENI
      *    入力
               WHEN      OTHER
                   PERFORM 200-ENTRY
           END-EVALUATE.
      *
      *    画面遷移がない時、画面表示へ
           IF      FLG-END             =   ZERO
               PERFORM 500-SET-SCREEN
           END-IF
      *
      *    画面ＳＰＡ書込み
           IF      FLG-END2            =   ZERO
               PERFORM 1003-C02SPA-OUT-SEC
           END-IF
      *
      *
           MOVE    SPA-C01KYOUTU   TO  SPA-WORK
           MOVE    SPA-AREA        TO  SPA-COMMON
           MOVE    SPA-C02FREE     TO  SPA-FREE
      *
           .
           EXIT    PROGRAM
           .
      *
      *****************************************************************
      *    ＳＰＡデータセット処理
      *****************************************************************
      *
       1002-C02SPA-SET-SEC             SECTION.
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID
      *
           OPEN    INPUT               SPASCR-FILE
           IF      STS-SPASCR     NOT =   ZERO
               GO      TO         1002-C02SPA-SET-EXT
           END-IF
      *
           INITIALIZE          SPA-SCR-REC
           INITIALIZE          WRK-DATA-REC
           MOVE    ZERO                TO  FLG-SPASCR
           MOVE    ZERO                TO  IDX
           PERFORM UNTIL       FLG-SPASCR  =   1
               READ    SPASCR-FILE
                   AT  END
                       MOVE   1            TO  FLG-SPASCR
                   NOT AT  END
                       ADD    1            TO  IDX
                       MOVE   SPA-DATA-REC     TO  WRK-DATA (IDX)
               END-READ
           END-PERFORM
      *
           MOVE    WRK-DATA-REC        TO  SPA-SCR-REC 
      *
           CLOSE                       SPASCR-FILE
           .
       1002-C02SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    ＳＰＡデータＷＲＩＴＥ処理
      *****************************************************************
       1003-C02SPA-OUT-SEC             SECTION.
      *
           MOVE    SPA-TERMID          TO  FILE-TERMID
      *
           OPEN    OUTPUT              SPASCR-FILE
           IF      STS-SPASCR     NOT =   ZERO
               DISPLAY "C02SPASCR OUT OPEN ERR:"   STS-SPASCR
      ***      STOP    " "
               GO  TO  1003-C02SPA-SET-EXT
           END-IF
           MOVE    SPACE              TO         WRK-DATA-REC
      *
           MOVE    SPA-SCR-REC        TO  WRK-DATA-REC 
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL      (IDX     >   10  )  OR
                              (WRK-DATA (IDX)     =   SPACE)
      *
               MOVE    WRK-DATA (IDX)      TO  SPA-DATA-REC
               WRITE                       SPA-DATA-REC
               IF      STS-SPASCR     NOT =   ZERO
                   DISPLAY "C02SPASCR OUT WRITE ERR:"   STS-SPASCR
      ***          STOP    " "
                   GO  TO  1003-C02SPA-SET-EXT
                END-IF
           END-PERFORM
      *
           CLOSE                       SPASCR-FILE
           .
       1003-C02SPA-SET-EXT.
           EXIT.
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  STS-AREA
           INITIALIZE                  WRK-AREA
      *
      *    エラー画面より
           IF      SPA-MOTOPG          =   "CERR"
               MOVE    SPACE               TO  SPA-MOTOPG
               PERFORM 5001-MAPCUR-SEC
           ELSE
      *        初期画面セット
               PERFORM 300-SCREEN-SEC
      *----(01.00.02) LINE ADD START ----------------------------------
               IF      FLG-END             =   1
                   GO      TO      100-INIT-EXT
               END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *        画面編集
               PERFORM 500-GMNHEN-SEC
               IF      SPA-ERRCD       NOT =   SPACE
                   PERFORM 510-ERRSET-SEC
                   GO  TO  100-INIT-EXT
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
      ***  MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    SPACE               TO  MCP-PUTTYPE.
           MOVE    "C02    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       100-INIT-EXT.
           EXIT.
      *****************************************************************
      *    初期画面処理
      *****************************************************************
       300-SCREEN-SEC              SECTION.
      *
      **** MOVE    1               TO  SPA-GMN-C02-CUR
      *    他のＬＤより
           IF      LINKAREA        NOT =   SPACE
               MOVE    LNK-KYOUTU          TO  SPA-KYOUTU
               MOVE    SPA-MOTOPG          TO  WRK-MOTOPG
      *
      *        元の画面へ戻す
               IF      WRK-MOTOPG(1:3)     =   "Y01"  OR  "U01"  OR
                                               "P97"  
                   MOVE    LNK-COMMON      TO  SPA-KYOUTU
                   MOVE    LNK-SCRSPA      TO  SPA-C02
                   MOVE    SPA-WORK        TO  SPA-C01KYOUTU
               END-IF
      *        予約とエラー表示の時、そのまま画面表示へ
               IF      WRK-MOTOPG(1:3)     =   "Y01" 
                   GO      TO      300-SCREEN-EXT
               END-IF
      *        外部より選択がある時
               IF      WRK-MOTOPG(1:3)     =   "U01"  OR
                                               "P97"
                   PERFORM 3101-U01SPASET-SEC
                   GO      TO      300-SCREEN-EXT
               END-IF
      *
               IF      WRK-MOTOPG          =   "M01"  OR  "U02"  OR
                                               "K02"  OR  "K02N"
                   MOVE    SPA-MOTOPG          TO  SPA-C02-MOTOPG
               END-IF
      *                      
               MOVE    SPA-MOTOPG          TO  SPA-MOTOPG2
      *
               INITIALIZE              SPA-C01KYOUTU
           END-IF
      *
      *****MOVE    SPA-WORK        TO  SPA-C01KYOUTU
      *
           EVALUATE    SPA-MOTOPG(1:3)
               WHEN    "C03"
               WHEN    "C07"
                   GO      TO      300-SCREEN-EXT
               WHEN    "C04"
      *            自院病名セット処理
                   PERFORM 320-C04SPASET-SEC
                   GO      TO      300-SCREEN-EXT
               WHEN    "C05"
      *            病名セット処理
                   PERFORM 320-C05SPASET-SEC
                   GO      TO      300-SCREEN-EXT
           END-EVALUATE
      *----(01.00.02) LINE ADD START ----------------------------------
      *    確認画面より
           IF      SPA-MOTOPG(1:4)     =   "CID1"
               IF      SPA-CIDCD       =   "0101"
                   MOVE    SPACE           TO  SPA-CIDCD
                   IF      SPA-CID1-FLG        =   "OK"
                       MOVE    SPACE               TO  SPA-C02-UPDFLG
                       MOVE    "JOIN"              TO  MCP-PUTTYPE
                       PERFORM 210-BACK
                   ELSE
                       MOVE    "1"                 TO  SPA-C02-UPDFLG
                       MOVE    1                   TO  SPA-GMN-C02-CUR
                   END-IF
                   GO      TO      300-SCREEN-EXT
               END-IF
      *
               IF      SPA-CIDCD       =   "0102"
      ********     MOVE    SPACE           TO  SPA-CIDCD
                   IF      SPA-CID1-FLG    =   "OK"
                       PERFORM 4501-TOUROKU-SYORI-SEC
                   ELSE
                       MOVE    1               TO  SPA-GMN-C02-CUR
                   END-IF
                   MOVE    SPACE           TO  SPA-CIDCD
                   GO      TO      300-SCREEN-EXT
               END-IF
           END-IF              
      *
      *    病名移行確認画面より
           IF      SPA-MOTOPG(1:4)     =   "CID2"
               IF      SPA-CIDCD2          =   "0101"
                   IF      SPA-CID2-FLG    =   "OK"
                       MOVE    SPA-C02-IKOSAKI-INDEX
                                           TO  IDZ
                       MOVE    SPA-C02-IKOSAKI-BYOMEICD
                                           TO  SPA-GMN-C02-BYOMEICD(IDZ)
                       MOVE    SPA-GMN-C02-BYOMEICD(IDZ)
                                           TO  BYO-BYOMEICD
                       PERFORM 410111-BYOMEI-HENSYU-SEC
                   END-IF
                   PERFORM 4101111-BYOMEI-SELECT-HENSYU-SEC              
                   PERFORM 41021-BYOMEI-HENSYU-SEC
                   MOVE    SPACE           TO  SPA-CIDCD2
                   GO      TO      300-SCREEN-EXT
               END-IF    
               IF      SPA-CIDCD2          =   "0102"
                   IF      SPA-CID2-FLG    =   "OK"
                       PERFORM VARYING IDX2     FROM    1   BY  1
                               UNTIL   IDX2     >       6
                               OR      SPA-NAI-C02-TBYOMEICD  
                                       (SPA-GMN-C02-BANGO IDX2)
                                                =   SPACE 
                           IF      SPA-NAI-C02-TBYOMEICD
                                       (SPA-GMN-C02-BANGO IDX2)    
                                       =   SPA-C02-IKOMOTO-BYOMEICD
                               MOVE    SPA-C02-IKOSAKI-BYOMEICD
                                       TO  SPA-GMN-C02-BYOMEICD (IDX2) 
                           ELSE                
                               MOVE    SPA-NAI-C02-TBYOMEICD
                                       (SPA-GMN-C02-BANGO IDX2)       
                                       TO  SPA-GMN-C02-BYOMEICD (IDX2)
                           END-IF            
                           MOVE    SPA-GMN-C02-BYOMEICD (IDX2)  
                                                   TO  BYO-BYOMEICD
                           MOVE    IDX2            TO  IDZ                        
                           PERFORM 410111-BYOMEI-HENSYU-SEC
                       END-PERFORM
                       COMPUTE SPA-GMN-C02-CUR   =
                                         SPA-GMN-C02-CUR   +
                                         USBYO-BYOMEICDSU  - 
                                         1
                   END-IF
                   MOVE    1             TO  IDZ
                   PERFORM 41021-BYOMEICD-HENSYU-SEC
                   MOVE    SPACE           TO  SPA-CIDCD2
                   GO      TO      300-SCREEN-EXT
               END-IF    
               IF      SPA-CIDCD2          =   "0103"
                   IF      SPA-CID2-FLG    =   "OK"
                       MOVE    SPA-C02-IKOSAKI-INDEX
                                           TO  IDZ
                       MOVE    SPA-C02-IKOSAKI-BYOMEICD
                                           TO  SPA-GMN-C02-BYOMEICD(IDZ)
                       MOVE    SPA-GMN-C02-BYOMEICD(IDZ)
                                           TO  BYO-BYOMEICD
                       PERFORM 410111-BYOMEI-HENSYU-SEC
                   END-IF
                   PERFORM 41021-BYOMEICD-HENSYU-SEC
                   MOVE    SPACE           TO  SPA-CIDCD2
                   GO      TO      300-SCREEN-EXT
               END-IF    
               IF      SPA-CIDCD2          =   "0104"
                   IF      SPA-CID2-FLG    =   "OK"
                       INITIALIZE              USERBYOMEI-REC
                       MOVE    SPA-HOSPID      TO  USBYO-HOSPID
                       MOVE    SPA-C02-IKOSAKI-INDEX
                                               TO  IDZ
                       MOVE    SPA-GMN-C02-BYOMEICD(IDZ)
                                               TO  USBYO-BYOMEIINPUTCD
                       PERFORM 900-USERBYOMEI-INV-SEC
                       IF    ( IDZ     +   USBYO-BYOMEICDSU     -   1 )
                                               >   6
                           MOVE    "0074"              TO  SPA-ERRCD
                       ELSE
                           MOVE    SPA-C02-IKOSAKI-INDEX
                                                   TO  IDZ
                           PERFORM VARYING IDX2     FROM    1   BY  1
                                   UNTIL   IDX2     >       6
                                   OR      USBYO-BYOMEICD (IDX2)
                                                    =   SPACE 
                               IF      USBYO-BYOMEICD (IDX2)    =
                                            SPA-C02-IKOMOTO-BYOMEICD
                                   MOVE    SPA-C02-IKOSAKI-BYOMEICD
                                       TO  SPA-GMN-C02-BYOMEICD(IDZ)
                               ELSE                
                                   MOVE    USBYO-BYOMEICD (IDX2)        
                                       TO  SPA-GMN-C02-BYOMEICD(IDZ)
                               END-IF            
                               MOVE    SPA-GMN-C02-BYOMEICD (IDZ)  
                                                   TO  BYO-BYOMEICD
                               PERFORM 410111-BYOMEI-HENSYU-SEC
                               ADD     1               TO  IDZ
                           END-PERFORM
                           COMPUTE SPA-GMN-C02-CUR   =
                                             SPA-GMN-C02-CUR   +
                                             USBYO-BYOMEICDSU  - 
                                             1 
                       END-IF  
                   END-IF
                   MOVE    SPA-C02-IKOSAKI-INDEX   TO  IDZ
                   PERFORM 41021-BYOMEICD-HENSYU-SEC
                   MOVE    SPACE           TO  SPA-CIDCD2
                   GO      TO      300-SCREEN-EXT
               END-IF    
               IF      SPA-CIDCD2          =   "0105"
                   IF      SPA-CID2-FLG    =   "OK"
                       MOVE    SPA-C02-IKOSAKI-INDEX
                                           TO  IDZ
                       MOVE    SPA-C02-IKOSAKI-BYOMEICD
                                           TO  SPA-GMN-C02-BYOMEICD(IDZ)
                       MOVE    SPA-GMN-C02-BYOMEICD(IDZ)
                                           TO  BYO-BYOMEICD
                       PERFORM 410111-BYOMEI-HENSYU-SEC
                   END-IF
                   PERFORM 41021-BYOMEICD-HENSYU-SEC
                   MOVE    SPACE           TO  SPA-CIDCD2
                   GO      TO      300-SCREEN-EXT
               END-IF
      *            
               IF      SPA-CIDCD2          =   "0106"
                   IF      SPA-CID2-FLG    =   "OK"
                       MOVE    SPA-C02-IKOSAKI-INDEX
                                           TO  IDZ
                       MOVE    SPA-C02-IKOSAKI-BYOMEICD
                                           TO  SPA-GMN-C02-BYOMEICD(IDZ)
                       MOVE    SPA-GMN-C02-BYOMEICD(IDZ)
                                           TO  BYO-BYOMEICD
                       PERFORM 410111-BYOMEI-HENSYU-SEC
                   END-IF
                   MOVE    1               TO  IDZ
                   PERFORM 41021-BYOMEICD-HENSYU-SEC
                   PERFORM 4301-HENKOU-SYORI-SEC
                   MOVE    SPACE           TO  SPA-CIDCD2
                   GO      TO      300-SCREEN-EXT
               END-IF    
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           PERFORM 310-SPASET-SEC
      *
           .
       300-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＬＤ外の項目入力編集処理
      *****************************************************************
       3101-U01SPASET-SEC              SECTION.
      *
           MOVE    LNK-KYOUTU          TO  WRK-SPA-KYOUTU
      *    受付、患者検索より
           IF      WRK-SPA-PTNUM       =   SPA-GMN-C02-PTNUM
               CONTINUE
           ELSE
               IF      WRK-SPA-PTNUM       NOT =   SPACE
                   MOVE    WRK-SPA-PTNUM       TO  C02-PTNUM
                   PERFORM 41015-PTNUM-CHK-SEC
                   MOVE    27              TO  SPA-GMN-C02-CUR
                   IF      WRK-SPA-SRYKA       NOT =   SPACE
                        MOVE    WRK-SPA-SRYKA      TO  C02-SRYKA
                        PERFORM 41016-SRYKA-CHK-SEC
                       MOVE    1                  TO  SPA-GMN-C02-CUR
                   ELSE
                       PERFORM 330-SPASET-JYURRK-HENSYU-SEC
                       IF      SPA-GMN-C02-SRYKA-MAX =   1
                           MOVE    1               TO  SPA-GMN-C02-CUR
                       ELSE      
                           MOVE    27              TO  SPA-GMN-C02-CUR
                       END-IF
                       IF      SPA-GMN-C02-SRYKA NOT =   SPACE 
                           PERFORM 310-SPASET-PTBYO-HENSYU-SEC
                       END-IF
                   END-IF
               END-IF
           END-IF    
           .
       3101-U01SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    スパ初期編集処理
      *****************************************************************
       310-SPASET-SEC              SECTION.
      *
      *
           INITIALIZE              SPA-C02-AREA
                                   SPA-GMN-C02-TBL
                                   SPA-NAI-C02-TBL
                                   SPA-DEL-TBL
      *
      *
           MOVE    "1"             TO  SPA-GMN-C02-TENKIKBNL        (1)
           MOVE    "治ゆ"          TO  SPA-GMN-C02-TENKIKBNMEIL     (1)
           MOVE    "2"             TO  SPA-GMN-C02-TENKIKBNL        (2)
           MOVE    "死亡"          TO  SPA-GMN-C02-TENKIKBNMEIL     (2)
           MOVE    "3"             TO  SPA-GMN-C02-TENKIKBNL        (3)
           MOVE    "中止"          TO  SPA-GMN-C02-TENKIKBNMEIL     (3)
           MOVE    "8"             TO  SPA-GMN-C02-TENKIKBNL        (4)
           MOVE    "移行"          TO  SPA-GMN-C02-TENKIKBNMEIL     (4)
           MOVE    4               TO  SPA-GMN-C02-TENKIKBN-MAX
      *
           MOVE    "1"             TO  SPA-GMN-C02-UTAGAIFLGL       (1)
           MOVE    "疑い"          TO  SPA-GMN-C02-UTAGAIFLGMEIL    (1)
           MOVE    "2"             TO  SPA-GMN-C02-UTAGAIFLGL       (2)
           MOVE    "急性"          TO  SPA-GMN-C02-UTAGAIFLGMEIL    (2)
           MOVE    "3"             TO  SPA-GMN-C02-UTAGAIFLGL       (3)
           MOVE    "急性かつ疑い"  TO  SPA-GMN-C02-UTAGAIFLGMEIL    (3)
           MOVE    3               TO  SPA-GMN-C02-UTAGAIFLG-MAX
      *
           MOVE    "1"             TO  SPA-GMN-C02-SYUBYOFLGL       (1)
           MOVE    "主病名である"  TO  SPA-GMN-C02-SYUBYOFLGMEIL    (1)
           MOVE    1               TO  SPA-GMN-C02-SYUBYOFLG-MAX
      *
           MOVE    "03"            TO  SPA-GMN-C02-MANSEIKBNL       (1)
           MOVE    "皮膚科特定疾患指導管理料(１)"
                                   TO  SPA-GMN-C02-MANSEIKBNMEIL    (1)
           MOVE    "皮膚（１）"    TO  SPA-GMN-C02-MANSEIKBNTANL    (1)
           MOVE    "04"            TO  SPA-GMN-C02-MANSEIKBNL       (2)
           MOVE    "皮膚科特定疾患指導管理料(２)"
                                   TO  SPA-GMN-C02-MANSEIKBNMEIL    (2)
           MOVE    "皮膚（２）"    TO  SPA-GMN-C02-MANSEIKBNTANL    (2)
           MOVE    "05"            TO  SPA-GMN-C02-MANSEIKBNL       (3)
           MOVE    "特定疾患療養指導料／老人慢性疾患生活指導料"
                                   TO  SPA-GMN-C02-MANSEIKBNMEIL    (3)
           MOVE    "特定疾患"      TO  SPA-GMN-C02-MANSEIKBNTANL    (3)
      *     MOVE    "07"            TO  SPA-GMN-C02-MANSEIKBNL       (4)
      *     MOVE    "皮膚科特定疾患指導管理料(３)"
      *                             TO  SPA-GMN-C02-MANSEIKBNMEIL    (4)
      *     MOVE    "皮膚（３）"    TO  SPA-GMN-C02-MANSEIKBNTANL    (4)
           MOVE    3               TO  SPA-GMN-C02-MANSEIKBN-MAX
      *
           MOVE    "1"             TO  SPA-GMN-C02-NYUGAIKBNL       (1)
           MOVE    "入院"          TO  SPA-GMN-C02-NYUGAIKBNMEIL    (1)
           MOVE    "2"             TO  SPA-GMN-C02-NYUGAIKBNL       (2)
           MOVE    "入院外"        TO  SPA-GMN-C02-NYUGAIKBNMEIL    (2)
           MOVE    2               TO  SPA-GMN-C02-NYUGAIKBN-MAX
      *
           MOVE    "1"             TO  SPA-GMN-C02-HKNBYOMEIFLGL    (1)
           MOVE    "保険病名"      TO  SPA-GMN-C02-HKNBYOMEIFLGMEIL (1)
           MOVE    1               TO  SPA-GMN-C02-HKNBYOMEIFLG-MAX
      *
           MOVE    "1"             TO  SPA-GMN-C02-REZEFLGL         (1)
           MOVE    "表示しない"    TO  SPA-GMN-C02-REZEFLGMEIL      (1)
           MOVE    1               TO  SPA-GMN-C02-REZEFLG-MAX
      *      
      *    患者情報（診療行為で患者番号を入力したとき） 
           IF    ( SPA-C02-MOTOPG      =   "K02"   OR  "U02"
                                                   OR  "K02N")
           AND   ( SPA-PTNUM       NOT =   SPACE             )
               MOVE    SPA-PTNUM       TO  C02-PTNUM
               PERFORM 41015-PTNUM-CHK-SEC
               MOVE    SPA-PTID        TO  SPA-NAI-C02-PTID
               MOVE    SPA-HKNCOMBIMEI TO  SPA-GMN-C02-HKNCOMBIMEIH
               MOVE    SPA-FTNRATEMEI  TO  SPA-GMN-C02-FTNRATE
               MOVE    SPA-SRYYMDW     TO  SPA-GMN-C02-SYSYMD
               MOVE    SPA-SRYYMD      TO  SPA-NAI-C02-SYSYMD
               MOVE    SPA-SRYKAMEI    TO  SPA-GMN-C02-SRYKAMEI
               MOVE    SPA-SRYKA       TO  SPA-GMN-C02-SRYKA
               IF      SPA-ERRCD       =   SPACE
                   PERFORM 310-SPASET-PTBYO-HENSYU-SEC
                   PERFORM 310-SPASET-HKNCOMBI-HENSYU-SEC
                   MOVE    1               TO  SPA-GMN-C02-CUR
               ELSE
                   MOVE    27              TO  SPA-GMN-C02-CUR
                   MOVE    SPACE           TO  SPA-ERRCD
               END-IF
           ELSE    
               MOVE    SPA-SYSYMDWH    TO  SPA-GMN-C02-SYSYMD
               MOVE    SPA-SYSYMD      TO  SPA-NAI-C02-SYSYMD
               MOVE    26              TO  SPA-GMN-C02-CUR
           END-IF   
      *
           PERFORM 3104-SRYKA-SPA-SEC
      *         
      *    主病名編集フラグ情報
           MOVE    SPACE            TO  SYSKANRI-REC
           INITIALIZE                   SYSKANRI-REC
           MOVE    "2005"           TO  SYS-KANRICD
           MOVE    "*"              TO  SYS-KBNCD
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI     =   ZERO
               MOVE    MCPDATA-REC      TO  SYS-2005-REC
           ELSE    
               MOVE    SPACE            TO  SYS-2005-REC
           END-IF
           IF      SYS-2005-SYUBYOHENFLG    =   SPACE
               MOVE    ZERO             TO  SYS-2005-SYUBYOHENFLG
           END-IF
           MOVE    SYS-2005-SYUBYOHENFLG
                                       TO  SPA-C02-2005-SYUBYOHENFLG
      *
           MOVE    1               TO  SPA-GMN-C02-PAGE
           .
       310-SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険組合せ情報 編集処理
      *****************************************************************
       310-SPASET-HKNCOMBI-HENSYU-SEC  SECTION.
      * 
           MOVE    ZERO                TO  IDY
                                           IDX
      *     
           MOVE    SPA-HOSPID          TO  COMB-HOSPID
           MOVE    SPA-NAI-C02-PTID    TO  COMB-PTID
           MOVE    HKNCOMBI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-COMB-READ-SEC
           ELSE
               INITIALIZE                  HKNCOMBI-REC
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
      *     
           PERFORM UNTIL       (IDX            =   10   )  OR
                               (FLG-HKNCOMBI   =   1    )
      *---- (01.00.01) LINE MOD START ---------------------------------
      **       PERFORM 3102-HKNCOMBI-SPA-SEC
               IF      COMB-DELKBN           =   SPACE
                   PERFORM 3102-HKNCOMBI-SPA-SEC
               END-IF
      *---- (01.00.01) LINE MOD END   ---------------------------------
      *
               MOVE    "HKNCOMBI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-COMB-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "HKNCOMBI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *                                 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-NAI-C02-HKN-MAX
                   OR      IDY =       20
               PERFORM 3103-HKNCOMBI-GMN-SEC
           END-PERFORM                                
           .
       310-SPASET-HKNCOMBI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者病名マスター情報 編集処理
      *****************************************************************
       310-SPASET-PTBYO-HENSYU-SEC     SECTION.
      *
           INITIALIZE                  PTBYOMEI-REC
           MOVE    SPA-HOSPID          TO  PTBYO-HOSPID
           MOVE    SPA-NAI-C02-PTID    TO  PTBYO-PTID
           MOVE    SPA-GMN-C02-SRYKA   TO  PTBYO-SRYKA
           MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-PTBYO-READ-SEC
           ELSE
               INITIALIZE                  PTBYOMEI-REC
               MOVE    1                   TO  FLG-PTBYOMEI
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       (IDX            >   200  )  OR
                               (FLG-PTBYOMEI   =   1    )
               PERFORM 3101-PTBYO-SPA-SEC
      *
               MOVE    "PTBYOMEI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-PTBYO-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "PTBYOMEI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       310-SPASET-PTBYO-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者病名画面編集処理
      *****************************************************************
       3101-PTBYO-SPA-SEC         SECTION.
      *
           MOVE    IDX             TO  SPA-GMN-C02-MAX
      *
           MOVE    IDX             TO  SPA-GMN-C02-TBANGO  (IDX)
           MOVE    PTBYO-RENNUM    TO  SPA-NAI-C02-TRENNUM (IDX) 
           MOVE    PTBYO-BYOMEI    TO  SPA-GMN-C02-TBYOMEI (IDX)
           MOVE    PTBYO-SRYYMD    TO  SPA-NAI-C02-TSRYYMD (IDX)
           MOVE    PTBYO-SRYYMD    TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-C02-TSRYYMD (IDX)
           MOVE    WRK-NENGO       TO  SPA-GMN-C02-TSRYNENGOH(IDX)
      *
           PERFORM VARYING IDY FROM    1   BY  1
                   UNTIL   IDY >       6 
               MOVE    PTBYO-BYOMEICD(IDY)
                                   TO  SPA-NAI-C02-TBYOMEICD(IDX IDY)
           END-PERFORM
           MOVE    PTBYO-BYOMEIMOJI
                                   TO  SPA-NAI-C02-TBYOMEIMOJI  (IDX)
           MOVE    PTBYO-CHARTBYOMEI
                                   TO  SPA-NAI-C02-TCHARTBYOMEI (IDX)
           MOVE    PTBYO-CHARTBYOMEIMOJI
                               TO  SPA-NAI-C02-TCHARTBYOMEIMOJI(IDX)
           MOVE    PTBYO-BYOMEIINPUTCD 
                                   TO  SPA-NAI-C02-TBYOMEIINPUTCD(IDX)
           MOVE    PTBYO-BYOMEICDSU
                                   TO  SPA-NAI-C02-TBYOMEICDSU   (IDX)
      *
           MOVE    PTBYO-BYOMEIHENFLG
                                   TO  SPA-NAI-C02-TBYOMEIHENFLG(IDX)
           MOVE    PTBYO-UTAGAIFLG TO  SPA-NAI-C02-TUTAGAIFLG   (IDX)
           MOVE    PTBYO-SYUBYOFLG TO  SPA-NAI-C02-TSYUBYOFLG   (IDX)
           MOVE    PTBYO-MANSEIKBN TO  SPA-NAI-C02-TMANSEIKBN   (IDX)
           MOVE    PTBYO-NYUGAIKBN TO  SPA-NAI-C02-TNYUGAIKBN   (IDX)
           MOVE    PTBYO-HKNCOMBI  TO  SPA-NAI-C02-THKNCOMBI    (IDX)
           MOVE    PTBYO-REZEFLG   TO  SPA-NAI-C02-TREZEFLG     (IDX)
           MOVE    PTBYO-REZEMM    TO  SPA-GMN-C02-TREZEMM      (IDX)
           MOVE    PTBYO-TENKIKBN  TO  SPA-NAI-C02-TTENKIKBN    (IDX)
           MOVE    PTBYO-HKNBYOMEIFLG
                                   TO  SPA-NAI-C02-THKNBYOMEIFLG(IDX)
      *
           MOVE    PTBYO-TENKIYMD  TO  SPA-NAI-C02-TTENKIYMD    (IDX)
           IF      PTBYO-TENKIYMD  NOT =   SPACE
               MOVE    PTBYO-TENKIYMD      TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG TO  SPA-GMN-C02-TTENKIYMD(IDX)
               MOVE    WRK-NENGO   TO  SPA-GMN-C02-TTENKINENGOH (IDX)
           END-IF
      * 
           MOVE    SPA-NAI-C02-TTENKIKBN (IDX)
                                       TO  WRK-KBN
           PERFORM 5001-TENKIKBN-HENSYU-SEC
           MOVE    WRK-KBNMEI          TO  SPA-GMN-C02-TTENKIKBN (IDX)
      * 
           MOVE    SPA-NAI-C02-TUTAGAIFLG (IDX)
                                       TO  WRK-KBN
           PERFORM 5001-UTAGAIFLG-HENSYU-SEC
           MOVE    WRK-KBNMEI          TO  SPA-GMN-C02-TUTAGAIFLG(IDX)
      * 
           MOVE    SPA-NAI-C02-TSYUBYOFLG (IDX)
                                       TO  WRK-KBN
           PERFORM 5001-SYUBYOFLG-HENSYU-SEC
           MOVE    WRK-KBNMEI          TO  SPA-GMN-C02-TSYUBYOFLG(IDX)
      *
           MOVE    SPA-NAI-C02-TMANSEIKBN (IDX) (1:2)
                                       TO  WRK-KBN 
           PERFORM 5001-MANSEIKBN-HENSYU-SEC
           MOVE    WRK-KBNMEITAN       TO  SPA-GMN-C02-TMANSEIKBN (IDX)
      * 
           PERFORM VARYING IDY FROM   1   BY  1
                   UNTIL   IDY >      5
                   OR      SPA-GMN-C02-NYUGAIKBNL (IDY) =   SPACE
               IF      SPA-NAI-C02-TNYUGAIKBN (IDX)
                                      =   SPA-GMN-C02-NYUGAIKBNL (IDY)
                   MOVE    SPA-GMN-C02-NYUGAIKBNMEIL (IDY)
                                      TO  SPA-GMN-C02-TNYUGAIKBN(IDX)
                   MOVE    5          TO  IDY
               END-IF
           END-PERFORM
      * 
           PERFORM VARYING IDY FROM   1   BY  1
                   UNTIL   IDY >      10
                   OR      SPA-GMN-C02-HKNCOMBIL (IDY) =   SPACE
               IF      SPA-NAI-C02-THKNCOMBI (IDX)
                                      =   SPA-GMN-C02-HKNCOMBIL (IDY)
                   MOVE    SPA-GMN-C02-HKNCOMBIMEIL (IDY)
                                      TO  SPA-GMN-C02-THKNCOMBI(IDX)
                   MOVE    10         TO  IDY
               END-IF
           END-PERFORM
      * 
           PERFORM VARYING IDY FROM   1   BY  1
                   UNTIL   IDY >      5
                   OR      SPA-GMN-C02-HKNBYOMEIFLGL (IDY) =   SPACE
               IF      SPA-NAI-C02-THKNBYOMEIFLG (IDX)
                                  =   SPA-GMN-C02-HKNBYOMEIFLGL (IDY)
                   MOVE    SPA-GMN-C02-HKNBYOMEIFLGMEIL (IDY)
                                  TO  SPA-GMN-C02-THKNBYOMEIFLG(IDX)
                   MOVE    5      TO  IDY
               END-IF
           END-PERFORM
      * 
           PERFORM VARYING IDY FROM   1   BY  1
                   UNTIL   IDY >      5
                   OR      SPA-GMN-C02-REZEFLGL (IDY) =   SPACE
               IF      SPA-NAI-C02-TREZEFLG (IDX)
                                      =   SPA-GMN-C02-REZEFLGL (IDY)
                   MOVE    SPA-GMN-C02-REZEFLGMEIL (IDY)
                                      TO  SPA-GMN-C02-TREZEFLG (IDX)
                   MOVE    5          TO  IDY
               END-IF
           END-PERFORM
      *
           MOVE    ZERO               TO  SPA-NAI-C02-TUPDFLG  (IDX) 
      *
           GO  TO  3101-PTBYO-SPA-EXT
      *
      *    初期表示のとき警告エラー表示できないのでスキップ
      * 
           IF    ( PTBYO-TENKIKBN      =   SPACE   OR  "8" )
           AND   ( PTBYO-UTAGAIFLG     =   "1"     OR  "2" )
           AND   ( PTBYO-REZEFLG       =   SPACE           )
               MOVE    "61"            TO  LNK-DAY6-IRAI
               MOVE    PTBYO-SRYYMD    TO  LNK-DAY6-KIJUN 
               MOVE    "2"             TO  LNK-DAY6-ZOGENPTN
               EVALUATE    PTBYO-UTAGAIFLG
                   WHEN    "1"
                       MOVE    2               TO  LNK-DAY6-ZOGEN 
                   WHEN    "2"
                       MOVE    1               TO  LNK-DAY6-ZOGEN 
               END-EVALUATE         
               CALL    "ORCSDAY"       USING    STS-AREA-DAY
                                                LNK-DAY6-AREA
               IF      STS-DAY-RC1         NOT =   ZERO
                   MOVE    ZERO            TO  LNK-DAY6-KEISAN
               END-IF
               IF      LNK-DAY6-KEISAN     <=  SPA-NAI-C02-SYSYMD
                   MOVE    "0003"              TO  SPA-ERRCD
               END-IF
           END-IF           
           .
       3101-PTBYO-SPA-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せＳＰＡ画面編集処理
      *****************************************************************
       3102-HKNCOMBI-SPA-SEC          SECTION.
      *
           ADD     1                   TO  IDX
      *
           MOVE    SPACE               TO  WRK-HKNCOMBIMEI
      *
           IF       COMB-SYU-TANSEIDONAME  NOT =   SPACE                    
               STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                             INTO              WRK-HKNCOMBIMEI
               END-STRING
           ELSE
               STRING  COMB-KOH1-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH2-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH3-TANSEIDONAME  DELIMITED  BY  SPACE
                       " "                 DELIMITED  BY  SIZE
                       COMB-KOH4-TANSEIDONAME  DELIMITED  BY  SPACE
                             INTO              WRK-HKNCOMBIMEI
               END-STRING
           END-IF                      
      *
      *    労災の時、コメントの追加
           IF      COMB-HKNNUM         =   "971"  OR  "973"
      *        患者保険情報検索
               INITIALIZE                      PTRSIINF-REC
               MOVE    SPA-HOSPID          TO  PTRSI-HOSPID
               MOVE    SPA-NAI-C02-PTID    TO  PTRSI-PTID
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
               MOVE    SPACE               TO  WRK-HKNKBN-MEI
               EVALUATE    PTRSI-HKNKBN
                   WHEN    "1"
                       MOVE    "短"        TO  WRK-HKNKBN-MEI
                   WHEN    "2"
                       MOVE    "傷"        TO  WRK-HKNKBN-MEI
                   WHEN    "3"
                       MOVE    "ア"        TO  WRK-HKNKBN-MEI
               END-EVALUATE
               IF      PTRSI-COMMENT       =   SPACE
                   MOVE    SPACE               TO  WRK-HKNCOMBIMEI
                   STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                           " "                     DELIMITED  BY  SIZE
                           WRK-HKNKBN-MEI          DELIMITED  BY  SPACE
                           INTO              WRK-HKNCOMBIMEI
               ELSE
                   MOVE    SPACE               TO  WRK-HKNCOMBIMEI
                   STRING  COMB-SYU-TANSEIDONAME   DELIMITED  BY  SPACE
                           " "                     DELIMITED  BY  SIZE
                           WRK-HKNKBN-MEI          DELIMITED  BY  SPACE
                           "（"                    DELIMITED  BY  SIZE
                           PTRSI-COMMENT           DELIMITED  BY  SPACE
                           "）"                    DELIMITED  BY  SIZE
                           INTO              WRK-HKNCOMBIMEI
               END-IF
           END-IF    
      *     
           MOVE    COMB-HKNCOMBINUM    TO  SPA-GMN-C02-HKNCOMBIL(IDX)
           MOVE    WRK-HKNCOMBIMEI     TO
                                       SPA-GMN-C02-HKNCOMBIMEIL (IDX)
      *                                 
           MOVE    COMB-HKNCOMBINUM    TO
                                       SPA-NAI-C02-THKNCOMBINUM (IDX)
           MOVE    WRK-HKNCOMBIMEI     TO
                                       SPA-NAI-C02-THKNCOMBIMEI (IDX)
           MOVE    COMB-TEKSTYMD       TO  SPA-NAI-C02-TEKSTYMD(IDX)
           MOVE    COMB-TEKEDYMD       TO  SPA-NAI-C02-TEKEDYMD(IDX)
      *
           MOVE    IDX                 TO  SPA-NAI-C02-HKN-MAX
                                           SPA-GMN-C02-HKNCOMBI-MAX
           .
       3102-HKNCOMBI-SPA-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せ画面編集処理
      *****************************************************************
       3103-HKNCOMBI-GMN-SEC          SECTION.
      *
           ADD     1                   TO  IDY
      *      
           MOVE    SPA-NAI-C02-THKNCOMBINUM (IDX)
                                   TO  SPA-GMN-C02-THKNCOMBINUM (IDY)
           MOVE    SPA-NAI-C02-THKNCOMBIMEI (IDX)
                                   TO  SPA-GMN-C02-THKNCOMBIMEI (IDY)
           MOVE    SPA-NAI-C02-THKNCOMBINUM (IDX)
                                   TO  SPA-GMN-C02-TNUM (IDY)
      *
           ADD     1               TO  IDY 
           MOVE    SPA-NAI-C02-TEKSTYMD     (IDX)
                                   TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG     TO  SPA-GMN-C02-THKNCOMBIMEI (IDY)
      *
           MOVE    SPA-NAI-C02-TEKEDYMD     (IDX)
                                   TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG     TO
                                   SPA-GMN-C02-THKNCOMBIMEI (IDY)(15:)
           MOVE    SPA-NAI-C02-THKNCOMBINUM (IDX)
                                   TO  SPA-GMN-C02-TNUM (IDY)
      *
           MOVE    IDY             TO  SPA-GMN-C02-HKN-MAX
      *
           .
       3103-HKNCOMBI-GMN-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科ＳＰＡ画面編集処理
      *****************************************************************
       3104-SRYKA-SPA-SEC              SECTION.
      *
           MOVE    ZERO                TO  SPA-GMN-C02-SRYKA-MAX  
      *    
           MOVE    SPACE               TO  SYS-KEY
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SPA-NAI-C02-SYSYMD  TO  ORC-DBYMD
      *    システム管理検索
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           ELSE
               INITIALIZE                  SYS-1005-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       (IDX            >   40   )  OR
                               (FLG-SYSKANRI   =   1    )
               MOVE    MCPDATA-REC           TO  SYS-1005-REC
               MOVE    SYS-1005-KBNCD (1:2)  TO
                                             SPA-GMN-C02-SRYKAL   (IDX)
               MOVE    SYS-1005-SRYKANAME1   TO
                                             SPA-GMN-C02-SRYKAMEIL(IDX)
      *
               MOVE    IDX                   TO  SPA-GMN-C02-SRYKA-MAX  
      *
               MOVE    "SYSKANRI-KEY2"       TO  ORC-DBPATH
               PERFORM 900-SYSKANRI-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY2"     TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           IF      SPA-GMN-C02-SRYKA-MAX    =   1
               MOVE    SPA-GMN-C02-SRYKALST (1)
                                       TO  SPA-GMN-C02-SRYKA-G
           END-IF                                                             
      *
           .
       3104-SRYKA-SPA-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名セット処理（病名検索画面より戻り）
      *****************************************************************
       320-C05SPASET-SEC          SECTION.
      *
           IF      SPA-C01KYOUTU       =   SPACE
               GO  TO  320-C05SPASET-EXT
           END-IF
      *   
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       6      
               MOVE    SPA-C01-TBYOMEICD (IDZ)
                                       TO  SPA-GMN-C02-BYOMEICD(IDZ)
               MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                           TO  BYO-BYOMEICD
               PERFORM 410111-BYOMEI-HENSYU-SEC
           END-PERFORM
      *
           PERFORM 41021-BYOMEI-HENSYU-SEC
      *
      *   入力病名コード数カウント
           PERFORM 410111-BYOMEICDSU-HENSYU-SEC
      *
           MOVE    28                  TO  SPA-GMN-C02-CUR
           .
       320-C05SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名セット処理（自院病名検索画面より戻り）
      *****************************************************************
       320-C04SPASET-SEC          SECTION.
      *
           IF      SPA-C01KYOUTU       =   SPACE
               GO  TO  320-C04SPASET-EXT
           END-IF
      *   
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       6      
               MOVE    SPA-C01-TBYOMEICD (IDZ)
                                       TO  SPA-GMN-C02-BYOMEICD(IDZ)
               MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                           TO  USBYO-BYOMEIINPUTCD
               PERFORM 410112-USERBYOMEI-HENSYU-SEC
           END-PERFORM
      *
           PERFORM 41021-BYOMEI-HENSYU-SEC
           PERFORM 41022-CHARTBYOMEI-HENSYU-SEC
      *
      *   入力病名コード数カウント
           PERFORM 410111-BYOMEICDSU-HENSYU-SEC
      *
           MOVE    9                   TO  SPA-GMN-C02-CUR     
           .
       320-C04SPASET-EXT.
           EXIT.
      *
      *****************************************************************
      *    最終受診診療科情報 編集処理
      *****************************************************************
       330-SPASET-JYURRK-HENSYU-SEC    SECTION.
      *     
           MOVE    SPA-HOSPID          TO  JYURRK-HOSPID
           MOVE    SPA-NAI-C02-PTID    TO  JYURRK-PTID
           MOVE    SPA-NAI-C02-SYSYMD  TO  JYURRK-SRYYMD
           PERFORM 900-JYURRK-INV-SEC
           IF      FLG-JYURRK          =   ZERO
               MOVE    JYURRK-SRYKA        TO  SPA-GMN-C02-SRYKA
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-C02-SRYKA-MAX
                   IF      SPA-GMN-C02-SRYKA 
                                  =   SPA-GMN-C02-SRYKAL (IDY)
                       MOVE    SPA-GMN-C02-SRYKALST (IDY)
                                      TO  SPA-GMN-C02-SRYKA-G
                       MOVE    SPA-GMN-C02-SRYKA-MAX     TO  IDY
                   END-IF
               END-PERFORM
           END-IF
           .
       330-SPASET-JYURRK-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面遷移処理
      *****************************************************************
       200-GMNSENI                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *    戻る
               WHEN    "CLICKED"       ALSO    "B01"
                   MOVE    "CHANGE"    TO  MCP-PUTTYPE
                   PERFORM 210-BACK
      *    クリア
               WHEN    "CLICKED"       ALSO    "B02"
                   PERFORM 220-CLEAR-SEC
      *    前回の患者番号
               WHEN    "CLICKED"       ALSO    "B03"
                   PERFORM 230-MAEKPTNUM-SEC
      *    入力ＣＤへ
               WHEN    "CLICKED"       ALSO    "B16"
                   PERFORM 600-C03-SYORI-SEC
      *    病名検索へ
               WHEN    "CLICKED"       ALSO    "B05"
                   PERFORM 600-C05-SYORI-SEC
      *    追加
               WHEN    "CLICKED"       ALSO    "B06"
                   PERFORM 420-TUIKA-SEC
      *    変更
               WHEN    "CLICKED"       ALSO    "B07"
                   PERFORM 430-HENKOU-SEC
      *    削除
               WHEN    "CLICKED"       ALSO    "B08"
                   PERFORM 440-SAKUJYO-SEC
      *    氏名検索
               WHEN    "CLICKED"       ALSO    "B09"
                   PERFORM 480-KENSAKU-SEC
      *    予約登録へ
               WHEN    "CLICKED"       ALSO    "B10"
                   PERFORM 480-YOYAKU-SEC
      *    受付一覧へ
               WHEN    "CLICKED"       ALSO    "B11"
                   PERFORM 490-UKEICHI-SEC
      *    登録
               WHEN    "CLICKED"       ALSO    "B12"
                   PERFORM 450-TOUROKU-SEC
      *    自院病名検索
               WHEN    "CLICKED"       ALSO    "B04"
               PERFORM 490-USERBYOMEI-KENSAKU-SEC
      *    コメント処理
               WHEN    "CLICKED"       ALSO    "B17"
                   PERFORM 430-FREEMSG-SEC
           END-EVALUATE
      *
           .
       200-GMNSENI-EXT.
           EXIT.
      *****************************************************************
      *    会話　処理
      *****************************************************************
       200-ENTRY                   SECTION.
      *
           EVALUATE    MCP-EVENT       ALSO    MCP-WIDGET
      *     
               WHEN    "ACTIVATE"      ALSO    "PTNUM"
                   PERFORM 41015-PTNUM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SRYKA"
                   PERFORM 41016-SRYKA-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "BANGO"
                   PERFORM 41011-BANGO-HEN-SEC
               WHEN    "ACTIVATE"      ALSO    "SRYYMD"
                   PERFORM 41012-SRYYMD-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_1"
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_2"
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_3"
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_4"
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_5"
               WHEN    "ACTIVATE"      ALSO    "BYOMEICD_6"
                   PERFORM 4102-BYOMEICD-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "UTAGAIFLG"
                   PERFORM 4104-UTAGAI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "SYUBYOFLG"
                   PERFORM 4105-SYUBYOFLG-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "MANSEIFLG"
                   PERFORM 4106-MANSEI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "NYUGAIKBN"
                   PERFORM 4107-NYUGAIKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "HKNCOMBI"
                   PERFORM 4108-COMB-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "REZEFLG"
                   PERFORM 4109-REZEFLG-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "REZEMM"
                   PERFORM 41010-REZEMM-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "TENKIKBN"
                   PERFORM 41011-TENKIKBN-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "TENKIYMD"
                   PERFORM 41012-TENKIYMD-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "BYOMEI"
                   PERFORM 41013-BYOMEI-CHK-SEC
               WHEN    "ACTIVATE"      ALSO    "CHARTBYOMEI"
                   PERFORM 41018-CHARTBYOMEI-CHK-SEC
      *----(01.00.03) LINE ADD START ----------------------------------
               WHEN    "ACTIVATE"      ALSO    "HKNBYOMEIFLG"
                   PERFORM 41014-HKNBYOMEIFLG-CHK-SEC
      *----(01.00.03) LINE ADD END   ----------------------------------
               WHEN    "ACTIVATE"      ALSO    "BYOMEIINPUTCD"
                   PERFORM 41017-BYOMEIINPUTCD-CHK-SEC
      *        病名行選択
               WHEN    ANY             ALSO    "BYOMEILST"
                   PERFORM 41020-BYOMEISEL-SEC
      *        保険組合せ行選択
               WHEN    ANY             ALSO    "HKNCOMBILST"
                   PERFORM 41021-HKNCOMBISEL-SEC
           END-EVALUATE
      *
           .
       200-ENTRY-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者番号チェック処理
      *****************************************************************
       41015-PTNUM-CHK-SEC            SECTION.
      *
           MOVE    26                  TO  SPA-GMN-C02-CUR
      *
           INITIALIZE                  SPA-DEL-TBL
                                       SPA-DEL-C02-MAX
      *                              
                                       SPA-GMN-C02-KOUMOKU
                                       SPA-NAI-C02-KOUMOKU
                                       SPA-GMN-C02-HEAD
                                       SPA-NAI-C02-HEAD
                                       SPA-NAI-C02-SELNO
                                       SPA-C02-UPDFLG
                                       SPA-C02-IKOFLG
      *                              
                                       SPA-GMN-C02-TBL
                                       SPA-NAI-C02-TBL
                                       SPA-GMN-C02-MAX
      *                                 
                                       SPA-GMN-C02-HKN-TBL
                                       SPA-NAI-C02-HKN-TBL
                                       SPA-GMN-C02-HKNCOMBILST-G
                                       SPA-GMN-C02-HKN-MAX
                                       SPA-GMN-C02-HKNCOMBI-MAX
      *
           IF      SPA-GMN-C02-SRYKA-MAX   >   1
               INITIALIZE              SPA-GMN-C02-SRYKA-G
           END-IF                                      
      *
           MOVE    C02-PTNUM           TO  SPA-GMN-C02-PTNUM
      *
      **** INITIALIZE                  ORCSPTIDAREA
      *    MOVE    SPA-HOSPID          TO  SPTID-HOSPID
      *    MOVE    SPA-GMN-C02-PTNUM   TO  SPTID-PTNUM
      *    CALL    "ORCSPTID"          USING   ORCSPTIDAREA
      *                                        SPA-1009-TBL
      *    IF      SPTID-RC        NOT =   ZERO
      *        MOVE    "0032"          TO  SPA-ERRCD
      *****ELSE
      *
           INITIALIZE                  ORCSPTNUMAREA
           MOVE    SPA-GMN-C02-PTNUM   TO  SPTNUM-PTNUM
           CALL    "ORCSPTNUM"         USING   ORCSPTNUMAREA
                                               SPA-AREA
           EVALUATE    SPTNUM-RC
               WHEN    00
                   MOVE    SPTNUM-PTNUM        TO  SPTID-PTNUM
                   MOVE    SPTNUM-PTID         TO  SPTID-PTID
               WHEN   10
                   MOVE    "0031"              TO  SPA-ERRCD
               WHEN    20
      *            氏名検索へ
                   MOVE    SPACE               TO  LINKAREA
                   MOVE    SPA-KYOUTU          TO  LNK-COMMON
                   MOVE    SPA-C02             TO  LNK-SCRSPA
      *
                   MOVE    "C02"               TO  SPA-MOTOPG
                   MOVE    "P97"               TO  SPA-SAKIPG
      *            氏名セット
                   MOVE    SPA-GMN-C02-PTNUM   TO  SPA-NAME
                   MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
                   MOVE    "CHANGE"            TO  MCP-PUTTYPE
                   MOVE    "P97"               TO  MCP-WINDOW
                   PERFORM 900-PUT-WINDOW
                   MOVE    1                   TO  FLG-END
                   GO      TO     41015-PTNUM-CHK-EXT
               WHEN    OTHER
                   MOVE    "0031"          TO  SPA-ERRCD
           END-EVALUATE
      *
           IF      SPA-ERRCD           =   SPACE
               MOVE    SPTID-PTNUM         TO  SPA-GMN-C02-PTNUM
               MOVE    SPTID-PTID          TO  SPA-NAI-C02-PTID
      *
      *        患者マスター存在チェック
               MOVE    SPA-HOSPID          TO  PTINF-HOSPID
               MOVE    SPA-NAI-C02-PTID    TO  PTINF-PTID
               PERFORM 900-PTINF-READ-SEC
               IF      FLG-PTINF           NOT =   ZERO
                   MOVE    "0031"              TO  SPA-ERRCD
               ELSE
      *
      *            排他制御処理
                   PERFORM 990-LOCK-IN-SEC
                   IF      SPA-ERRCD       NOT =   SPACE
                           GO      TO      41015-PTNUM-CHK-EXT
                   END-IF
      *
                   MOVE    PTINF-NAME        TO  SPA-GMN-C02-NAME
                   MOVE    PTINF-KANANAME    TO  SPA-GMN-C02-KANANAME
                   EVALUATE    PTINF-SEX
                       WHEN    "1" 
                           MOVE    "男"          TO  SPA-GMN-C02-SEX
                       WHEN    "2"
                           MOVE    "女"          TO  SPA-GMN-C02-SEX
                   END-EVALUATE
                   MOVE    PTINF-BIRTHDAY    TO  WRK-SYMD
                   PERFORM 5002-HIZUKE-HEN-SEC
                   MOVE    WRK-HENYMDG       TO  SPA-GMN-C02-BIRTHDAY
                   MOVE    SPA-NAI-C02-PTID  TO  SPA-LAST-PTID
                   MOVE    SPA-GMN-C02-PTNUM TO  SPA-LAST-PTNUM 
               END-IF
           END-IF    
      *
           IF      SPA-ERRCD         =   SPACE
               PERFORM 310-SPASET-HKNCOMBI-HENSYU-SEC
               PERFORM 330-SPASET-JYURRK-HENSYU-SEC     
               MOVE    27                TO  SPA-GMN-C02-CUR
               IF      SPA-GMN-C02-SRYKA NOT =   SPACE 
                   PERFORM 310-SPASET-PTBYO-HENSYU-SEC
               END-IF
               IF      SPA-GMN-C02-SRYKA-MAX =   1
      *************PERFORM 310-SPASET-PTBYO-HENSYU-SEC 
                   MOVE    1                   TO  SPA-GMN-C02-CUR
               END-IF                                      
           END-IF    
           . 
       41015-PTNUM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科入力処理
      *****************************************************************
       41016-SRYKA-CHK-SEC             SECTION.
      *
           MOVE    27                  TO  SPA-GMN-C02-CUR
      *
      *    排他制御処理（診療行為で患者番号を入力したとき）
           IF    ( SPA-C02-MOTOPG      =   "K02"   OR  "U02"
                                                   OR  "K02N")
           AND   ( SPA-PTNUM       NOT =   SPACE             )
               MOVE    SPA-PTNUM       TO  C02-PTNUM
               PERFORM 41015-PTNUM-CHK-SEC
               MOVE    SPA-PTID        TO  SPA-NAI-C02-PTID
               MOVE    SPA-HKNCOMBIMEI TO  SPA-GMN-C02-HKNCOMBIMEIH
               MOVE    SPA-FTNRATEMEI  TO  SPA-GMN-C02-FTNRATE
               MOVE    SPA-SRYYMDW     TO  SPA-GMN-C02-SYSYMD
               MOVE    SPA-SRYYMD      TO  SPA-NAI-C02-SYSYMD
               MOVE    SPA-SRYKAMEI    TO  SPA-GMN-C02-SRYKAMEI
               MOVE    SPA-SRYKA       TO  SPA-GMN-C02-SRYKA
               IF      SPA-ERRCD       NOT =   SPACE
                   MOVE    27              TO  SPA-GMN-C02-CUR
                   GO      TO      41016-SRYKA-CHK-EXT
               END-IF
           END-IF
      *
           INITIALIZE                  SPA-DEL-TBL
                                       SPA-DEL-C02-MAX
      *                              
                                       SPA-GMN-C02-KOUMOKU
                                       SPA-NAI-C02-KOUMOKU
                                       SPA-NAI-C02-SELNO
                                       SPA-C02-UPDFLG
                                       SPA-C02-IKOFLG
      *                              
                                       SPA-GMN-C02-TBL
                                       SPA-NAI-C02-TBL
                                       SPA-GMN-C02-MAX
      *
           MOVE    C02-SRYKA           TO  SPA-GMN-C02-SRYKA-G
      *
           MOVE    ZERO               TO  WRK-HENFLG
           PERFORM VARYING IDY FROM   1   BY  1
                   UNTIL   IDY >      SPA-GMN-C02-SRYKA-MAX
                   OR      WRK-HENFLG =   1
               IF      SPA-GMN-C02-SRYKA 
                                  =   SPA-GMN-C02-SRYKAL (IDY)
                   MOVE    SPA-GMN-C02-SRYKALST (IDY)
                                      TO  SPA-GMN-C02-SRYKA-G
                   MOVE    1          TO  WRK-HENFLG
               END-IF
           END-PERFORM
           IF      WRK-HENFLG         =   ZERO
               MOVE    "0030"               TO  SPA-ERRCD
           END-IF        
      *
           IF      SPA-ERRCD           =   SPACE
               PERFORM 310-SPASET-PTBYO-HENSYU-SEC 
               MOVE    1                   TO  SPA-GMN-C02-CUR
           END-IF    
           .
       41016-SRYKA-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    番号選択　入力処理
      *****************************************************************
       41011-BANGO-HEN-SEC         SECTION.
      *
           MOVE    1                  TO  SPA-GMN-C02-CUR
      *
           INITIALIZE                 SPA-GMN-C02-KOUMOKU
                                      SPA-NAI-C02-KOUMOKU
                                      SPA-NAI-C02-SELNO
                                      SPA-C02-IKOFLG
      *                                
           MOVE    SPA-NAI-C02-SYSYMD TO  SPA-NAI-C02-SRYYMD
      *
           MOVE    C02-BANGO         TO  SPA-GMN-C02-BANGO
      *
           IF      SPA-GMN-C02-BANGO      =   ZERO
               IF      SPA-GMN-C02-MAX         =   200
                   MOVE    "0034"              TO  SPA-ERRCD
               ELSE
                   MOVE    2                   TO  SPA-GMN-C02-CUR 
               END-IF
               GO  TO  41011-BANGO-HEN-EXT
           END-IF
      *
           IF      SPA-GMN-C02-BANGO      >   SPA-GMN-C02-MAX
               MOVE    ZERO            TO  SPA-GMN-C02-BANGO
               MOVE    "0012"          TO  SPA-ERRCD
               GO      TO      41011-BANGO-HEN-EXT
           END-IF
      *
           MOVE    SPA-GMN-C02-BANGO   TO  SPA-NAI-C02-SELNO     
      *
           PERFORM 410111-BYOMEI-SELECT-SEC     
           .
       41011-BANGO-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    選択病名編集処理
      *****************************************************************
       410111-BYOMEI-SELECT-SEC         SECTION.
      *
           MOVE    ZERO                TO  SPA-C02-IKOFLG
           MOVE    SPACE               TO  WRK-HAISIYMDH
      *      
           MOVE    SPA-GMN-C02-TSRYYMD (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-SRYYMD
           MOVE    SPA-NAI-C02-TSRYYMD (SPA-GMN-C02-BANGO)
                                       TO  SPA-NAI-C02-SRYYMD
      *
           IF      SPA-NAI-C02-TBYOMEIINPUTCD (SPA-GMN-C02-BANGO)
                                           =   SPACE
      *        病名コードのとき
               PERFORM VARYING IDZ     FROM    1   BY  1
                       UNTIL   IDZ     >       6
                   MOVE    SPA-NAI-C02-TBYOMEICD(SPA-GMN-C02-BANGO IDZ)
                                       TO  SPA-GMN-C02-BYOMEICD(IDZ)
                   MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                       TO  BYO-BYOMEICD
                   PERFORM 410111-BYOMEI-HENSYU-SEC
                   IF      FLG-BYOMEI          =   ZERO
                     IF      BYO-BYOMEICD (1:1)  NOT =   "Z"
                     AND     SPA-NAI-C02-TBYOMEIHENFLG
                                  (SPA-GMN-C02-BANGO)
                                                   =   SPACE
                       IF      BYO-IKOSAKICD       =   SPACE
                         IF      BYO-HAISIYMD      =   ALL "9" OR  SPACE
                           CONTINUE
                         ELSE
                           MOVE    BYO-HAISIYMD    TO  WRK-SYMD
                           PERFORM 5002-HIZUKE-HEN-SEC
                           MOVE    LNK-DAY2-EDTYMD3
                                                   TO  WRK-HAISIYMDH
                         END-IF        
                       ELSE
                         MOVE    BYO-IKOSAKICD   TO  BYO-BYOMEICD
                         MOVE    ZERO                  TO  FLG-BYOMEI
                         PERFORM 900-BYOMEI-READ-SEC
                         IF      FLG-BYOMEI          =   ZERO
                           MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                                   TO
                                               SPA-C02-IKOMOTO-BYOMEICD
                           MOVE    SPA-NAI-C02-BYOMEI   (IDZ)
                                                   TO
                                               SPA-C02-IKOMOTO-BYOMEI
                           MOVE    BYO-BYOMEICD    TO
                                               SPA-C02-IKOSAKI-BYOMEICD
                           MOVE    BYO-BYOMEI      TO
                                               SPA-C02-IKOSAKI-BYOMEI
                           MOVE    IDZ       TO  SPA-C02-IKOSAKI-INDEX                  
                           MOVE    "0101"    TO  SPA-CIDCD2
                         END-IF    
                       END-IF
                     END-IF
                   END-IF                
               END-PERFORM
           ELSE
      *
      *        自院病名コードのとき
      *           （マスタと内容が違っていればメッセージを出して
      *             病名コードを表示する）
               INITIALIZE                  USERBYOMEI-REC
               MOVE    SPA-HOSPID          TO  USBYO-HOSPID
               MOVE    SPA-NAI-C02-TBYOMEIINPUTCD(SPA-GMN-C02-BANGO)
                                           TO  USBYO-BYOMEIINPUTCD
               PERFORM 900-USERBYOMEI-INV-SEC                            
               IF      FLG-USERBYOMEI      =   ZERO
                   IF      SPA-NAI-C02-TBYOMEICD (SPA-GMN-C02-BANGO 1)
                                           NOT =   USBYO-BYOMEICD  (1)
                   OR      SPA-NAI-C02-TBYOMEICD (SPA-GMN-C02-BANGO 2)
                                           NOT =   USBYO-BYOMEICD  (2)
                   OR      SPA-NAI-C02-TBYOMEICD (SPA-GMN-C02-BANGO 3)
                                           NOT =   USBYO-BYOMEICD  (3)
                   OR      SPA-NAI-C02-TBYOMEICD (SPA-GMN-C02-BANGO 4)
                                           NOT =   USBYO-BYOMEICD  (4)
                   OR      SPA-NAI-C02-TBYOMEICD (SPA-GMN-C02-BANGO 5)
                                           NOT =   USBYO-BYOMEICD  (5)
                   OR      SPA-NAI-C02-TBYOMEICD (SPA-GMN-C02-BANGO 6)
                                           NOT =   USBYO-BYOMEICD  (6)
                       MOVE    "0052"              TO  SPA-ERRCD
                       MOVE    1                   TO  SPA-C02-IKOFLG
                       MOVE    1                   TO  FLG-USERBYOMEI
                   END-IF
               ELSE    
                   MOVE    "0053"              TO  SPA-ERRCD
               END-IF
               IF      FLG-USERBYOMEI          =   ZERO
                   MOVE    SPA-NAI-C02-TBYOMEIINPUTCD(SPA-GMN-C02-BANGO)
                                           TO  SPA-GMN-C02-BYOMEICD (1)
                   MOVE    SPA-GMN-C02-TBYOMEI (SPA-GMN-C02-BANGO)
                                           TO  SPA-NAI-C02-BYOMEI   (1)
                   MOVE    SPA-NAI-C02-TCHARTBYOMEI (SPA-GMN-C02-BANGO)
                                           TO
                                           SPA-NAI-C02-CHARTBYOMEI  (1)
                   MOVE    SPA-NAI-C02-TUTAGAIFLG (SPA-GMN-C02-BANGO)
                                           TO  SPA-NAI-C02-UTAGAIFLG(1)
                   MOVE    SPA-NAI-C02-TMANSEIKBN (SPA-GMN-C02-BANGO)
                                           TO  SPA-NAI-C02-TOKSKNCD (1)
                   MOVE    "1"             TO
                                           SPA-NAI-C02-USERBYOMEIFLG(1)
                   IF      SPA-NAI-C02-TBYOMEIHENFLG (SPA-GMN-C02-BANGO)
                                           =   SPACE
                     PERFORM VARYING IDX3    FROM    1   BY  1
                             UNTIL   IDX3    >   6
                             OR      SPA-NAI-C02-TBYOMEICD
                                    (SPA-GMN-C02-BANGO IDX3)   =   SPACE
                       IF      SPA-NAI-C02-TBYOMEICD 
                                  (SPA-GMN-C02-BANGO IDX3)(1:1) =   "Z"
                           CONTINUE
                       ELSE        
                           MOVE    SPA-NAI-C02-TBYOMEICD
                                       (SPA-GMN-C02-BANGO IDX3)
                                                       TO  BYO-BYOMEICD
                           MOVE    ZERO                TO  FLG-BYOMEI
                           PERFORM 900-BYOMEI-READ-SEC
                           IF      FLG-BYOMEI          =   ZERO
                             IF      BYO-IKOSAKICD       =   SPACE
                                 IF      BYO-HAISIYMD        =   ALL "9"
                                                             OR  SPACE
                                     CONTINUE
                                 ELSE
                                     MOVE    BYO-HAISIYMD  TO  WRK-SYMD
                                     PERFORM 5002-HIZUKE-HEN-SEC
                                     MOVE    LNK-DAY2-EDTYMD3
                                                   TO  WRK-HAISIYMDH
                                 END-IF
                             ELSE
                                 MOVE    SPA-NAI-C02-TBYOMEICD
                                           (SPA-GMN-C02-BANGO IDX3) 
                                           TO  SPA-C02-IKOMOTO-BYOMEICD
                                 MOVE    BYO-BYOMEI 
                                           TO  SPA-C02-IKOMOTO-BYOMEI
                                 MOVE    BYO-IKOSAKICD
                                           TO  BYO-BYOMEICD
                                 PERFORM 900-BYOMEI-READ-SEC
                                 IF      FLG-BYOMEI          =   ZERO
                                     MOVE    BYO-BYOMEICD    TO
                                               SPA-C02-IKOSAKI-BYOMEICD
                                     MOVE    BYO-BYOMEI      TO
                                               SPA-C02-IKOSAKI-BYOMEI
                                     MOVE    IDX3            TO
                                               SPA-C02-IKOSAKI-INDEX                    
                                     MOVE    "0102"      TO  SPA-CIDCD2
                                 END-IF
                             END-IF
                             MOVE    6                   TO  IDX3  
                           END-IF                            
                       END-IF    
                     END-PERFORM        
                   END-IF                                                
               ELSE                                 
                   PERFORM VARYING IDZ     FROM    1   BY  1
                           UNTIL   IDZ     >       6 
                       MOVE
                           SPA-NAI-C02-TBYOMEICD(SPA-GMN-C02-BANGO IDZ)
                                           TO  SPA-GMN-C02-BYOMEICD(IDZ)
                       MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                           TO  BYO-BYOMEICD
                       PERFORM 410111-BYOMEI-HENSYU-SEC
                   END-PERFORM
               END-IF
           END-IF
      *
           IF      SPA-CIDCD2      NOT   =   SPACE
               GO  TO  410111-BYOMEI-SELECT-EXT
           END-IF
      *
           PERFORM 4101111-BYOMEI-SELECT-HENSYU-SEC              
      *
           IF      WRK-HAISIYMDH       =   SPACE
               CONTINUE
           ELSE
               MOVE    "0075"              TO  SPA-ERRCD
           END-IF                     
           .
       410111-BYOMEI-SELECT-EXT.
           EXIT.
      *
      *****************************************************************
      *   入力病名コード数カウント処理
      *****************************************************************
       4101111-BYOMEI-SELECT-HENSYU-SEC      SECTION.
      *      
           MOVE    SPA-GMN-C02-TBYOMEI       (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-BYOMEI
      *                                 
           MOVE    SPA-NAI-C02-TBYOMEIMOJI   (SPA-GMN-C02-BANGO)
                                       TO  SPA-NAI-C02-BYOMEIMOJI
      *                                 
           MOVE    SPA-NAI-C02-TBYOMEIHENFLG (SPA-GMN-C02-BANGO)
                                       TO  SPA-NAI-C02-BYOMEIHENFLG
           IF      SPA-NAI-C02-BYOMEIHENFLG  =   "1" 
               MOVE    "病名編集"      TO  SPA-GMN-C02-BYOMEIHENFLG
           END-IF    
      *      
           MOVE    SPA-NAI-C02-TCHARTBYOMEI  (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-CHARTBYOMEI
      *                                 
           MOVE    SPA-NAI-C02-TCHARTBYOMEIMOJI (SPA-GMN-C02-BANGO)
                                       TO  SPA-NAI-C02-CHARTBYOMEIMOJI
      *
           MOVE    SPA-NAI-C02-TUTAGAIFLG (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-UTAGAIFLG
           MOVE    SPA-GMN-C02-TUTAGAIFLG (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-UTAGAIFLGMEI
      *                                                              
           MOVE    SPA-NAI-C02-TSYUBYOFLG (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-SYUBYOFLG
           MOVE    SPA-GMN-C02-TSYUBYOFLG (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-SYUBYOFLGMEI
      *                                 
           IF      SPA-NAI-C02-TMANSEIKBN (SPA-GMN-C02-BANGO)
                                       NOT =   ZERO
               MOVE    SPA-NAI-C02-TMANSEIKBN (SPA-GMN-C02-BANGO)
                                           TO  SPA-GMN-C02-MANSEIKBN
                                               WRK-KBN
               PERFORM 5001-MANSEIKBN-HENSYU-SEC                                
               MOVE    WRK-KBNMEI         TO  SPA-GMN-C02-MANSEIKBNMEI
           END-IF
      *                                     
           MOVE    SPA-NAI-C02-TNYUGAIKBN (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-NYUGAIKBN
           MOVE    SPA-GMN-C02-TNYUGAIKBN (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-NYUGAIKBNMEI
      *                                 
           IF      SPA-NAI-C02-THKNCOMBI  (SPA-GMN-C02-BANGO)
                                       NOT =   ZERO
               MOVE    SPA-NAI-C02-THKNCOMBI  (SPA-GMN-C02-BANGO)
                                           TO  SPA-GMN-C02-HKNCOMBI
               MOVE    SPA-GMN-C02-THKNCOMBI  (SPA-GMN-C02-BANGO)
                                           TO  SPA-GMN-C02-HKNCOMBIMEI
           END-IF
      *                                     
           MOVE    SPA-NAI-C02-TREZEFLG (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-REZEFLG
           MOVE    SPA-GMN-C02-TREZEFLG (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-REZEFLGMEI
      *                                 
           MOVE    SPA-GMN-C02-TREZEMM (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-REZEMM
      *                                 
           MOVE    SPA-NAI-C02-TTENKIKBN (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-TENKIKBN
           MOVE    SPA-GMN-C02-TTENKIKBN (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-TENKIKBNMEI
      *
           MOVE    SPA-GMN-C02-TTENKIYMD (SPA-GMN-C02-BANGO)
                                       TO  SPA-GMN-C02-TENKIYMD
           MOVE    SPA-NAI-C02-TTENKIYMD (SPA-GMN-C02-BANGO)
                                       TO  SPA-NAI-C02-TENKIYMD
      *                                 
           MOVE    SPA-NAI-C02-THKNBYOMEIFLG (SPA-GMN-C02-BANGO)
                                        TO  SPA-GMN-C02-HKNBYOMEIFLG 
           MOVE    SPA-GMN-C02-THKNBYOMEIFLG (SPA-GMN-C02-BANGO)
                                        TO  SPA-GMN-C02-HKNBYOMEIFLGMEI
      *
      *   入力病名コード数カウント
           PERFORM 410111-BYOMEICDSU-HENSYU-SEC
      *
      *    編集病名のときは病名へ遷移以外は病名コードへ
           IF      SPA-NAI-C02-BYOMEIHENFLG  =   "1" 
               MOVE    8                   TO  SPA-GMN-C02-CUR
           ELSE    
               MOVE    2                   TO  SPA-GMN-C02-CUR 
           END-IF    
      *
           .
       4101111-BYOMEI-SELECT-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *   入力病名コード数カウント処理
      *****************************************************************
       410111-BYOMEICDSU-HENSYU-SEC      SECTION.
      *
      *   入力病名コード数カウント
           MOVE    ZERO                TO  SPA-NAI-C02-BYOMEICD-MAX
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-NAI-C02-BYOMEITOP (IDX)  =   "1"                   
                   ADD     1               TO  SPA-NAI-C02-BYOMEICD-MAX
               END-IF
           END-PERFORM  
      *
      ***      IF      SPA-GMN-C02-BYOMEICD(IDX)
      ***                              NOT =   SPACE
      ***      AND     SPA-GMN-C02-BYOMEICD(IDX)(1:1)
      ***                              NOT =   "Z"                        
      ***          ADD     1               TO  SPA-NAI-C02-BYOMEICD-MAX
      ***      END-IF
      ***  END-PERFORM                                    
           .
       410111-BYOMEICDSU-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名マスタ編集処理
      *****************************************************************
       410111-BYOMEI-HENSYU-SEC          SECTION.
      *
           INITIALIZE                    SPA-NAI-C02-BYOMEI-G(IDZ)
      *
           MOVE    ZERO                  TO  FLG-BYOMEI
      *  
           IF      BYO-BYOMEICD      NOT =   SPACE             
               PERFORM 900-BYOMEI-READ-SEC
      *
               IF      FLG-BYOMEI        =   ZERO
                   MOVE    IDZ               TO  IDX3
                   PERFORM 4101111-BYOMEITOP-HENSYU-SEC
                   MOVE    SPACE         TO
                                         SPA-NAI-C02-USERBYOMEIFLG(IDZ)
                   IF      BYO-BYOMEICD  =   WRK-CONS-BYOMEICD
                       MOVE    SPACE     TO  SPA-NAI-C02-BYOMEI (IDZ)
                   ELSE                           
                       MOVE    BYO-BYOMEI
                                         TO  SPA-NAI-C02-BYOMEI (IDZ)
                   END-IF    
                   MOVE    BYO-UTAGAIFLG TO  SPA-NAI-C02-UTAGAIFLG(IDZ)
                   IF      BYO-BYOMEICD  =   WRK-CONS-UTAGAI
                       MOVE    "1"       TO  SPA-NAI-C02-UTAGAIFLG(IDZ)
                   END-IF    
      *************MOVE    BYO-RECECD(1) TO  SPA-NAI-C02-RECECD   (IDZ)
                   MOVE    BYO-TOKSKNCD  TO  SPA-NAI-C02-TOKSKNCD (IDZ)
               ELSE
                   MOVE    "■■■"      TO  SPA-NAI-C02-BYOMEI   (IDZ)
               END-IF
           END-IF 
           .
       410111-BYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    複数病名の先頭フラグ編集処理
      *****************************************************************
       4101111-BYOMEITOP-HENSYU-SEC      SECTION.
      *
           IF      SPA-GMN-C02-BYOMEICD (IDX3) 
                                     =   SPACE
               MOVE    SPACE       TO  SPA-NAI-C02-BYOMEITOP(IDX3)
               GO  TO  4101111-BYOMEITOP-HENSYU-EXT
           END-IF
      *     
           IF      SPA-GMN-C02-BYOMEICD (IDX3) (1:1)
                                     =   "Z"
      *        修飾語コードのとき
               IF      SPA-GMN-C02-BYOMEICD (IDX3) (4:1)
                                         =   "8"
                   IF      IDX3            >   1
                       COMPUTE IDW     =   IDX3    -   1
                       IF      SPA-NAI-C02-USERBYOMEIFLG (IDW)
                                           =   "1"
                           MOVE    "1"
                                       TO  SPA-NAI-C02-BYOMEITOP(IDX3)
                       ELSE            
                           MOVE    SPACE
                                       TO  SPA-NAI-C02-BYOMEITOP(IDX3)
                       END-IF
                   ELSE
                       MOVE    "1"     TO  SPA-NAI-C02-BYOMEITOP(IDX3)
                   END-IF                
               ELSE
                   IF      IDX3            >   1
                       COMPUTE IDW     =   IDX3    -   1
                       IF      SPA-GMN-C02-BYOMEICD (IDW)(1:1)
                                                   = "Z"
                       AND     SPA-GMN-C02-BYOMEICD (IDW)(4:1) 
                                               NOT =   "8"
                           MOVE    SPACE
                                       TO  SPA-NAI-C02-BYOMEITOP(IDX3)
                       ELSE
                           MOVE    "1"
                                       TO  SPA-NAI-C02-BYOMEITOP(IDX3)
                       END-IF
                   ELSE
                       MOVE    "1"     TO  SPA-NAI-C02-BYOMEITOP(IDX3)
                   END-IF            
               END-IF    
           ELSE
      *        病名コードのとき
               IF      IDX3            >   1
                   COMPUTE IDW     =   IDX3        -   1
                   IF      SPA-GMN-C02-BYOMEICD (IDW)(1:1) = "Z"
                   AND     SPA-GMN-C02-BYOMEICD (IDW)(4:1) 
                                                       NOT =   "8"
                       MOVE    SPACE   TO  SPA-NAI-C02-BYOMEITOP(IDX3)
                   ELSE
                       MOVE    "1"     TO  SPA-NAI-C02-BYOMEITOP(IDX3)
                   END-IF    
               ELSE
                   MOVE    "1"   TO  SPA-NAI-C02-BYOMEITOP(IDX3)
               END-IF    
           END-IF        
           .
       4101111-BYOMEITOP-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名マスタ編集処理
      *****************************************************************
       410112-USERBYOMEI-HENSYU-SEC      SECTION.
      *
           INITIALIZE                    SPA-NAI-C02-BYOMEI-G(IDZ)
      *
           MOVE    ZERO                  TO  FLG-USERBYOMEI
           IF      USBYO-BYOMEIINPUTCD   =   SPACE
               CONTINUE
           ELSE
               MOVE    SPA-HOSPID        TO  USBYO-HOSPID    
               PERFORM 900-USERBYOMEI-INV-SEC
               IF      FLG-USERBYOMEI    =   ZERO
                   MOVE    "1"           TO  SPA-NAI-C02-BYOMEITOP(IDZ)
                   MOVE    "1"           TO
                                         SPA-NAI-C02-USERBYOMEIFLG(IDZ)
                   MOVE    USBYO-BYOMEI  TO  SPA-NAI-C02-BYOMEI   (IDZ)
      *****             MOVE    USBYO-BYOMEIMOJI
      *****                                   TO
      *****                                   SPA-NAI-C02-TBYOMEIMOJI(IDZ)
                   MOVE    USBYO-CHARTBYOMEI
                                         TO
                                         SPA-NAI-C02-CHARTBYOMEI  (IDZ)
      *****             MOVE    USBYO-CHARTBYOMEIMOJI
      *****                                   TO
      *****                           SPA-NAI-C02-TCHARTBYOMEIMOJI (IDZ)
                   MOVE    USBYO-UTAGAIFLG
                                         TO  SPA-NAI-C02-UTAGAIFLG(IDZ)
                   MOVE    USBYO-MANSEIKBN
                                         TO  SPA-NAI-C02-TOKSKNCD (IDZ)
                   MOVE    USBYO-BYOMEIHENFLG
                                         TO
                                       SPA-NAI-C02-US-BYOMEIHENFLG(IDZ)
               ELSE
                   MOVE    "■■■"      TO  SPA-NAI-C02-BYOMEI   (IDZ)
               END-IF
           END-IF
           .
       410112-USERBYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    開始日チェック処理
      *****************************************************************
       41012-SRYYMD-CHK-SEC           SECTION.
      *
           MOVE    9                    TO  SPA-GMN-C02-CUR
      * 
           MOVE   C02-SRYYMD            TO  SPA-GMN-C02-SRYYMD
      *
           IF     SPA-GMN-C02-SRYYMD    =   SPACE
      *********MOVE    SPA-SYSYMD          TO  SPA-NAI-C02-SRYYMD
               MOVE    SPA-NAI-C02-SYSYMD  TO  SPA-NAI-C02-SRYYMD
               MOVE    SPACE               TO  SPA-GMN-C02-SRYYMD
           ELSE    
      *        日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-C02-SRYYMD  TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN-C02-SRYYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI-C02-SRYYMD
               ELSE
                   MOVE    "0015"          TO  SPA-ERRCD
               END-IF
           END-IF    
      *         
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-GMN-C02-HKNCOMBI    =   SPACE
                   CONTINUE
               ELSE
                   PERFORM VARYING IDY FROM   1   BY  1
                           UNTIL   IDY >      10
                       IF      SPA-GMN-C02-HKNCOMBI 
                                  =   SPA-GMN-C02-HKNCOMBIL (IDY)
                           IF      SPA-NAI-C02-SRYYMD
                                      <= SPA-NAI-C02-TEKEDYMD (IDY)
                               CONTINUE
                           ELSE
                               MOVE    "0011"     TO  SPA-ERRCD
                           END-IF        
                           MOVE    10         TO  IDY
                       END-IF
                   END-PERFORM
               END-IF
           END-IF
      *         
           IF      SPA-ERRCD           =   SPACE
               IF      SPA-NAI-C02-TENKIYMD    =   SPACE
                   CONTINUE
               ELSE    
                   IF      SPA-NAI-C02-SRYYMD  >   SPA-NAI-C02-TENKIYMD
                       MOVE    "0027"              TO  SPA-ERRCD
                   END-IF
               END-IF
           END-IF        
      *     
           IF      SPA-ERRCD           =   SPACE
               MOVE    17                  TO  SPA-GMN-C02-CUR 
           END-IF     
           .
       41012-SRYYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名コードチェック処理
      *****************************************************************
       4102-BYOMEICD-CHK-SEC          SECTION.
      *
           MOVE    1               TO  SPA-GMN-C02-CUR
      *
           MOVE    SPACE           TO  WRK-HAISIYMDH      
      *
           MOVE    MCP-WIDGET      TO  WRK-WIDGET
           MOVE    WRK-WIDGET2     TO  IDZ
      *
           COMPUTE SPA-GMN-C02-CUR     =   SPA-GMN-C02-CUR    +   IDZ
      *
      *    半角チェック
           IF      C02-BYOMEICD (IDZ)  =   SPACE
               CONTINUE
           ELSE    
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    C02-BYOMEICD (IDZ)  TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-RC2         =   ZERO
                   MOVE    KANACHK-OUT-INPUT   TO  C02-BYOMEICD (IDZ)
      *************CONTINUE
               ELSE
                   MOVE    "0072"              TO  SPA-ERRCD
                   GO  TO  4102-BYOMEICD-CHK-EXT
               END-IF
           END-IF    
      *
      *    自院病名検索へ（自院病名のみ入力のとき）
           IF      C02-BYOMEICD (IDZ)(1:2) =   "//"
               PERFORM 490-USERBYOMEI-KENSAKU-SEC
               GO  TO  4102-BYOMEICD-CHK-EXT
           END-IF     
                                   
      *    病名コードチェック                                                      
           IF      C02-BYOMEICD(IDZ)  NOT =   SPACE
      *        新規以外のときは自院病名には病名の入力不可
               IF      SPA-GMN-C02-BANGO           >   ZERO
                   IF      IDZ                         >   1
                   AND     SPA-NAI-C02-USERBYOMEIFLG (1)
                                                       =   "1"
                       MOVE    "0064"             TO  SPA-ERRCD
                   END-IF    
               END-IF    
      *
      *        未コード化傷病名入力のとき
               IF      SPA-ERRCD       =   SPACE
                   IF      C02-BYOMEICD (IDZ)
                                           =   WRK-CONS-BYOMEICD
                       PERFORM VARYING IDX FROM    1   BY  1
                               UNTIL   IDX >       6
                           IF      SPA-GMN-C02-BYOMEICD (IDX)
                                                  NOT =  SPACE
                           AND     IDX            NOT =   IDZ                       
                               MOVE    "0062"      TO  SPA-ERRCD
                               MOVE    6           TO  IDX
                           END-IF
                       END-PERFORM                                    
                   ELSE
                       PERFORM VARYING IDX FROM    1   BY  1
                               UNTIL   IDX >       6
                           IF      SPA-GMN-C02-BYOMEICD(IDX)
                                               =   WRK-CONS-BYOMEICD
                               MOVE    "0063"      TO  SPA-ERRCD
                           END-IF
                       END-PERFORM                                    
                   END-IF
               END-IF    
           END-IF                            
           IF      SPA-ERRCD       NOT =   SPACE
               MOVE    SPA-GMN-C02-BYOMEICD(IDZ)
                                       TO  C02-BYOMEICD (IDZ)
               GO  TO  4102-BYOMEICD-CHK-EXT
           END-IF
      *
           MOVE    C02-BYOMEICD (IDZ)  TO  SPA-GMN-C02-BYOMEICD(IDZ)
      *
           INITIALIZE                    SPA-NAI-C02-BYOMEI-G(IDZ)
                                         WRK-HAISIYMDH
      *         
           IF      SPA-GMN-C02-BYOMEICD(IDZ)(1:1)
                                       =   "."
               MOVE    "ZZZ"       TO  SPA-GMN-C02-BYOMEICD(IDZ)(1:3)
               MOVE    C02-BYOMEICD(IDZ)(2:)
                                   TO  SPA-GMN-C02-BYOMEICD(IDZ)(4:) 
           END-IF                                                       
      *
           MOVE    ZERO                TO  WRK-LENGTH                    
           PERFORM VARYING IDX FROM    10  BY  -1
                   UNTIL   IDX <       1
               IF      SPA-GMN-C02-BYOMEICD(IDZ)(IDX:1)
                                   NOT =   SPACE
                   MOVE    IDX             TO  WRK-LENGTH
                   MOVE    1               TO  IDX
               END-IF
           END-PERFORM
      *                                         
      *    ７桁入力のときは病名マスタ、以外は自院病名マスタを読み込む
      *    空白のときずらす
           EVALUATE    WRK-LENGTH
             WHEN    ZERO
      *         
               PERFORM VARYING IDX FROM    IDZ BY  1
                       UNTIL   IDX >       6
                   IF      IDX             =   6
                       INITIALIZE          SPA-NAI-C02-BYOMEI-G (IDX)
                                           SPA-GMN-C02-BYOMEICD (IDX)
                   ELSE
                       COMPUTE IDW     =   IDX     +   1
                       MOVE    SPA-NAI-C02-BYOMEI-G (IDW)
                                       TO  SPA-NAI-C02-BYOMEI-G (IDX)
                       MOVE    SPA-GMN-C02-BYOMEICD (IDW)
                                       TO  SPA-GMN-C02-BYOMEICD(IDX)
                   END-IF                     
               END-PERFORM                           
             WHEN    7   
      *        病名マスタ読み込み
               MOVE    SPA-GMN-C02-BYOMEICD (IDZ) TO  BYO-BYOMEICD
               PERFORM 410111-BYOMEI-HENSYU-SEC
               IF      FLG-BYOMEI      NOT =   ZERO
                   MOVE    "0054"              TO  SPA-ERRCD
               ELSE
                   IF      BYO-IKOSAKICD       =   SPACE
                       IF      BYO-HAISIYMD        =   ALL "9" OR  SPACE
                           CONTINUE
                       ELSE
                           MOVE    BYO-HAISIYMD    TO  WRK-SYMD
                           PERFORM 5002-HIZUKE-HEN-SEC
                           MOVE    LNK-DAY2-EDTYMD3
                                                   TO  WRK-HAISIYMDH
                       END-IF        
                   ELSE
                       MOVE    BYO-IKOSAKICD   TO  BYO-BYOMEICD
                       MOVE    ZERO                  TO  FLG-BYOMEI
                       PERFORM 900-BYOMEI-READ-SEC
                       IF      FLG-BYOMEI          =   ZERO
                           MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                                   TO
                                               SPA-C02-IKOMOTO-BYOMEICD
                           MOVE    SPA-NAI-C02-BYOMEI   (IDZ)
                                                   TO
                                               SPA-C02-IKOMOTO-BYOMEI
                           MOVE    BYO-BYOMEICD    TO
                                               SPA-C02-IKOSAKI-BYOMEICD
                           MOVE    BYO-BYOMEI      TO
                                               SPA-C02-IKOSAKI-BYOMEI
                           MOVE    IDZ         TO  SPA-C02-IKOSAKI-INDEX                    
                           MOVE    "0103"      TO  SPA-CIDCD2
                           GO  TO  4102-BYOMEICD-CHK-EXT
                       END-IF    
                   END-IF        
               END-IF
             WHEN    OTHER       
      *        自院病名マスタ読み込み
               INITIALIZE                  USERBYOMEI-REC
               MOVE    SPA-HOSPID          TO  USBYO-HOSPID
               MOVE    SPA-GMN-C02-BYOMEICD(IDZ)
                                           TO  USBYO-BYOMEIINPUTCD
               PERFORM 410112-USERBYOMEI-HENSYU-SEC
               IF      FLG-USERBYOMEI   NOT =   ZERO
                   MOVE    "0053"          TO  SPA-ERRCD
               ELSE
                 IF      USBYO-BYOMEIHENFLG    =   SPACE        
                   PERFORM VARYING IDX3    FROM    1   BY  1
                           UNTIL   IDX3    >   6
                           OR      USBYO-BYOMEICD (IDX3)   =   SPACE
                       IF      USBYO-BYOMEICD (IDX3) (1:1) =   "Z"
                           CONTINUE
                       ELSE
                           MOVE    USBYO-BYOMEICD (IDX3)
                                                       TO  BYO-BYOMEICD
                           MOVE    ZERO                TO  FLG-BYOMEI
                           PERFORM 900-BYOMEI-READ-SEC
                           IF      FLG-BYOMEI          =   ZERO
                           AND     BYO-IKOSAKICD   NOT =   SPACE
                               MOVE    USBYO-BYOMEICD (IDX3) 
                                           TO  SPA-C02-IKOMOTO-BYOMEICD
                               MOVE    BYO-BYOMEI 
                                           TO  SPA-C02-IKOMOTO-BYOMEI
                               MOVE    BYO-IKOSAKICD   TO  BYO-BYOMEICD
                               PERFORM 900-BYOMEI-READ-SEC
                               IF      FLG-BYOMEI          =   ZERO
                                   MOVE    BYO-BYOMEICD    TO
                                               SPA-C02-IKOSAKI-BYOMEICD
                                   MOVE    BYO-BYOMEI      TO
                                               SPA-C02-IKOSAKI-BYOMEI
                                   MOVE    IDZ             TO
                                               SPA-C02-IKOSAKI-INDEX                    
                                   MOVE    "0104"      TO  SPA-CIDCD2
                                   GO  TO  4102-BYOMEICD-CHK-EXT
                               END-IF
                           END-IF
                           MOVE    6                   TO  IDX3
                       END-IF    
                   END-PERFORM        
                 END-IF                      
               END-IF
           END-EVALUATE    
      *
           PERFORM 41021-BYOMEICD-HENSYU-SEC
           .
       4102-BYOMEICD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名コード編集処理
      *****************************************************************
       41021-BYOMEICD-HENSYU-SEC      SECTION.
      *
      *    病名編集処理
           PERFORM VARYING IDX3    FROM    1   BY  1
                   UNTIL   IDX3    >   6
               PERFORM 4101111-BYOMEITOP-HENSYU-SEC
           END-PERFORM
           PERFORM 41021-BYOMEI-HENSYU-SEC
           PERFORM 41022-CHARTBYOMEI-HENSYU-SEC
      *
      *    六番目に接頭語が入力されたとき
           IF      SPA-ERRCD               =   SPACE  
               IF      IDZ                 =   6
                   IF      SPA-GMN-C02-BYOMEICD (IDZ)(1:1) =   "Z"
                   AND     SPA-GMN-C02-BYOMEICD (IDZ)(4:1)
                                                       NOT =   "8"
                       MOVE    "0059"          TO  SPA-ERRCD
                   END-IF
               END-IF    
           END-IF
      *                                                   
      *    複数病名入力時、同一病名入力不可
           IF      SPA-ERRCD               =   SPACE  
               IF      SPA-GMN-C02-BYOMEICD (IDZ)  NOT =   SPACE
               AND     SPA-GMN-C02-BYOMEICD (IDZ)(1:1)
                                                   NOT =   "Z" 
                   PERFORM VARYING IDX FROM    1   BY  1
                           UNTIL   IDX >       6
                       IF      IDX             NOT =   IDZ
                       AND     SPA-GMN-C02-BYOMEICD (IDZ)  =   
                                       SPA-GMN-C02-BYOMEICD (IDX)
                           MOVE    "0055"          TO  SPA-ERRCD
                       END-IF
                   END-PERFORM
               END-IF    
           END-IF
      *
      *   入力病名コード数カウント
           PERFORM 410111-BYOMEICDSU-HENSYU-SEC
      *                                       
      *    新規以外のときは複数病名の入力不可
           IF      SPA-ERRCD               =   SPACE  
               IF      SPA-GMN-C02-BANGO           >   ZERO
               AND     SPA-NAI-C02-BYOMEICD-MAX    >   1
                   MOVE    "0056"             TO  SPA-ERRCD
               END-IF
           END-IF        
      *
           IF      SPA-ERRCD            NOT =   SPACE     
               GO  TO  41021-BYOMEICD-HENSYU-EXT
           END-IF
      *
      *    全ての病名コード未入力または
      *            未コード化傷病名コードのとき病名へ遷移
           IF      IDZ                 =   1
               IF    ( SPA-GMN-C02-BYOMEICD-G  
                                       =   SPACE                 )
               OR    ( SPA-GMN-C02-BYOMEICD(1)
                                           =   WRK-CONS-BYOMEICD )
                   MOVE    8                   TO  SPA-GMN-C02-CUR
                   GO  TO  41021-BYOMEICD-HENSYU-EXT
               END-IF    
           END-IF
      *    病名コード未入力のとき開始日へ遷移     
           IF      SPA-GMN-C02-BYOMEICD (IDZ)  =   SPACE
               MOVE    9                   TO  SPA-GMN-C02-CUR
               GO  TO  41021-BYOMEICD-HENSYU-EXT
           END-IF    
      *    変更処理で自院病名コードのとき開始日へ遷移
           IF      SPA-GMN-C02-BANGO      >   ZERO
           AND     SPA-NAI-C02-USERBYOMEIFLG  (1) =   "1"
               MOVE    9                          TO  SPA-GMN-C02-CUR
               GO  TO  41021-BYOMEICD-HENSYU-EXT
           END-IF
      *    複数病名コード入力のとき開始日へ遷移
           IF      WRK-LENGTH          =   ZERO
               CONTINUE
           ELSE    
               ADD     1               TO  SPA-GMN-C02-CUR
           END-IF    
           IF      SPA-NAI-C02-BYOMEICD-MAX
                                           >   1
           AND     SPA-GMN-C02-CUR         =   8
                   MOVE    9           TO  SPA-GMN-C02-CUR
           END-IF
      *
      *    廃止病名のとき
           IF      WRK-HAISIYMDH       =   SPACE
               CONTINUE
           ELSE
               MOVE    "0075"              TO  SPA-ERRCD
           END-IF                     
           .
       41021-BYOMEICD-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名コード編集チェック処理
      *****************************************************************
       41021-BYOMEI-HENSYU-SEC        SECTION.
      *
      *    未コード化傷病名のとき
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6 
               IF      SPA-GMN-C02-BYOMEICD (IDX)
                                       =   WRK-CONS-BYOMEICD
                   GO  TO  41021-BYOMEI-HENSYU-EXT
               END-IF
           END-PERFORM                                
      *         
           MOVE    ZERO                TO  SPA-NAI-C02-BYOMEIMOJI
      *　　病名編集
           MOVE    SPA-NAI-C02-BYOMEI(1)
                                       TO  WRK-BYOMEI
           PERFORM VARYING IDX FROM    2   BY  1
                   UNTIL   IDX >       6
               IF      SPA-NAI-C02-BYOMEITOP   (IDX)   =   "1"
               AND     WRK-BYOMEI                  NOT =   SPACE    
                   STRING  WRK-BYOMEI              DELIMITED  BY  SPACE
                           "／"                    DELIMITED  BY  SIZE
                           SPA-NAI-C02-BYOMEI(IDX) DELIMITED  BY  SPACE
                                  INTO             WRK-BYOMEI
                   END-STRING
               ELSE    
                   STRING  WRK-BYOMEI              DELIMITED  BY  SPACE
                           SPA-NAI-C02-BYOMEI(IDX) DELIMITED  BY  SPACE
                                  INTO          WRK-BYOMEI
                   END-STRING
               END-IF    
           END-PERFORM
      **** MOVE    WRK-BYOMEI          TO  SPA-GMN-C02-BYOMEI
      *
      *    疑いフラグ編集
           IF      WRK-BYOMEI      NOT =   SPA-GMN-C02-BYOMEI
             MOVE    SPACE               TO  SPA-GMN-C02-UTAGAIFLG-G 
             PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
                   OR      SPA-GMN-C02-UTAGAIFLG   =   "3"
               EVALUATE    SPA-NAI-C02-UTAGAIFLG   (IDX)
                   WHEN    "1"
                       IF      SPA-GMN-C02-UTAGAIFLG   =   "2"
                           MOVE    "3"     TO  SPA-GMN-C02-UTAGAIFLG
                        ELSE
                           MOVE    SPA-NAI-C02-UTAGAIFLG(IDX)
                                           TO  SPA-GMN-C02-UTAGAIFLG
                        END-IF    
                   WHEN    "2"
                       IF      SPA-GMN-C02-UTAGAIFLG   =   "1"
                           MOVE    "3"     TO  SPA-GMN-C02-UTAGAIFLG
                        ELSE
                           MOVE    SPA-NAI-C02-UTAGAIFLG(IDX)
                                           TO  SPA-GMN-C02-UTAGAIFLG
                       END-IF
                   WHEN    "3"
                       MOVE    "3"     TO  SPA-GMN-C02-UTAGAIFLG
                END-EVALUATE
             END-PERFORM
             MOVE    SPA-GMN-C02-UTAGAIFLG
                                           TO  WRK-KBN
             PERFORM 5001-UTAGAIFLG-HENSYU-SEC
             MOVE    WRK-KBNMEI            TO  SPA-GMN-C02-UTAGAIFLGMEI
      *            
      *    慢性区分編集
             MOVE    SPACE               TO  SPA-GMN-C02-MANSEIKBN-G  
             PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-NAI-C02-TOKSKNCD (IDX)   NOT =   ZERO
                   MOVE    SPA-NAI-C02-TOKSKNCD (IDX)
                                           TO  SPA-GMN-C02-MANSEIKBN
                   MOVE    6               TO  IDX
               END-IF   
             END-PERFORM
      *     
             MOVE    SPA-GMN-C02-MANSEIKBN
                                       TO  WRK-KBN
             PERFORM 5001-MANSEIKBN-HENSYU-SEC
             MOVE    WRK-KBNMEI          TO  SPA-GMN-C02-MANSEIKBNMEI
           END-IF
      *
           MOVE    WRK-BYOMEI          TO  SPA-GMN-C02-BYOMEI
      *
      *    病名コードエラーの時以下の処理はしない
           IF      SPA-ERRCD            NOT =   SPACE     
               GO  TO  41021-BYOMEI-HENSYU-EXT
           END-IF
      * 
      *　　接尾語・接頭語チェック
           MOVE    SPACE                   TO  WRK-RECECD-TBL
      * 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
      *
               IF      SPA-NAI-C02-BYOMEITOP(IDX)    =   "1"
                   MOVE    SPACE               TO  WRK-RECECD-TBL
               END-IF
      *                      
               IF      SPA-GMN-C02-BYOMEICD(IDX)     NOT =   SPACE                
                   EVALUATE    SPA-GMN-C02-BYOMEICD(IDX)(1:3)
                               ALSO    SPA-GMN-C02-BYOMEICD(IDX)(4:1)
                       WHEN    "ZZZ"         ALSO    "1"  THRU    "7"
                           IF      WRK-RECECD (2)    NOT =   SPACE   OR
                                   WRK-RECECD (3)    NOT =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (1)
                           END-IF            
                       WHEN    "ZZZ"       ALSO    "8"  
                           IF      WRK-RECECD (2)    =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (3)
                           END-IF
                       WHEN    OTHER                 
                           IF      WRK-RECECD (3)    NOT =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (2)
                           END-IF    
                   END-EVALUATE
               END-IF
           END-PERFORM
           IF      SPA-ERRCD             NOT =   SPACE
               GO  TO  41021-BYOMEI-HENSYU-EXT
           END-IF
      *
      *    文字チェック     
           MOVE    ZERO                TO  WRK-MOJISU
           PERFORM VARYING     IDX     FROM    1   BY  2
                   UNTIL       IDX     >       100
                   OR  WRK-BYOMEI(IDX:2)       =   SPACE
               IF      WRK-BYOMEI(IDX:2)   =   "■"
                   MOVE    "0035"          TO  SPA-ERRCD
                   GO  TO  41021-BYOMEI-HENSYU-EXT
              END-IF
           END-PERFORM
      *     
      *    文字数チェック
           MOVE    SPA-NAI-C02-BYOMEI(1)
                                       TO  WRK-BYOMEI
           PERFORM VARYING IDX FROM    2   BY  1
                   UNTIL   IDX  >      6  
               IF      SPA-NAI-C02-BYOMEITOP   (IDX)   =   "1"   
               AND     WRK-BYOMEI                  NOT =   SPACE
                   MOVE    99                  TO  IDY     
                   PERFORM UNTIL       IDY     =       ZERO 
                       IF      WRK-BYOMEI(IDY:2)   NOT =   SPACE
                           COMPUTE WRK-MOJISU  =   IDY     +   1 
                           MOVE    ZERO                    TO  IDY
                       ELSE
                           IF      IDY         =   1
                               MOVE    ZERO        TO  IDY
                           ELSE
                               COMPUTE IDY =   IDY     -   2
                           END-IF            
                       END-IF  
                   END-PERFORM
                   IF      WRK-MOJISU              >   80
                       MOVE    "0007"          TO  SPA-ERRCD
                       GO  TO  41021-BYOMEI-HENSYU-EXT
                   END-IF
                   MOVE    SPACE                   TO  WRK-BYOMEI
               END-IF    
               STRING  WRK-BYOMEI              DELIMITED  BY  SPACE
                       SPA-NAI-C02-BYOMEI(IDX) DELIMITED  BY  SPACE
                              INTO          WRK-BYOMEI
               END-STRING
           END-PERFORM    
           IF     WRK-BYOMEI                  NOT =   SPACE     
               MOVE    99                  TO  IDY     
               PERFORM UNTIL       IDY     =       ZERO 
                   IF      WRK-BYOMEI(IDY:2)   NOT =   SPACE
                       COMPUTE WRK-MOJISU  =   IDY     +   1 
                       MOVE    ZERO                    TO  IDY
                   ELSE
                       IF      IDY         =   1
                           MOVE    ZERO        TO  IDY
                       ELSE
                           COMPUTE IDY =   IDY     -   2
                       END-IF            
                   END-IF  
               END-PERFORM
               IF      WRK-MOJISU              >   80
                   MOVE    "0007"          TO  SPA-ERRCD
                   GO  TO  41021-BYOMEI-HENSYU-EXT
               END-IF
           END-IF    
      *
      *    病名文字数編集
           COMPUTE WRK-MOJISU   =   WRK-MOJISU  /   2        
           MOVE    WRK-MOJISU          TO  SPA-NAI-C02-BYOMEIMOJI
      *
      *    病名編集フラグセット
           MOVE    SPACE                   TO  SPA-GMN-C02-BYOMEIHENFLG
                                               SPA-NAI-C02-BYOMEIHENFLG
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6 
               IF      SPA-NAI-C02-US-BYOMEIHENFLG (IDX)
                                       =   "1"
                   MOVE    "1"             TO  SPA-NAI-C02-BYOMEIHENFLG
                   MOVE    "病名編集"      TO  SPA-GMN-C02-BYOMEIHENFLG
                   MOVE    6               TO  IDX
               END-IF
           END-PERFORM                                
           .
       41021-BYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    カルテ病名編集チェック処理
      *****************************************************************
       41022-CHARTBYOMEI-HENSYU-SEC        SECTION.
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6 
               IF      SPA-GMN-C02-BYOMEICD (IDX)
                                       =   WRK-CONS-BYOMEICD
                   GO  TO  41022-CHARTBYOMEI-HENSYU-EXT
               END-IF
           END-PERFORM                                
      *
           MOVE    ZERO                TO  SPA-NAI-C02-CHARTBYOMEIMOJI
      *　　病名編集
           MOVE    SPA-NAI-C02-CHARTBYOMEI (1)
                                       TO  WRK-BYOMEI
           PERFORM VARYING IDX FROM    2   BY  1
                   UNTIL   IDX >       6
               IF      SPA-NAI-C02-BYOMEITOP   (IDX)   =   "1"
               AND     WRK-BYOMEI                  NOT =   SPACE 
                   STRING  WRK-BYOMEI              DELIMITED  BY  SPACE
                           "／"                    DELIMITED  BY  SIZE
                           SPA-NAI-C02-CHARTBYOMEI (IDX)
                                                   DELIMITED  BY  SPACE
                                  INTO             WRK-BYOMEI
                   END-STRING
               ELSE    
                   STRING  WRK-BYOMEI              DELIMITED  BY  SPACE
                           SPA-NAI-C02-CHARTBYOMEI (IDX)
                                                   DELIMITED  BY  SPACE
                                  INTO          WRK-BYOMEI
                   END-STRING
               END-IF    
           END-PERFORM    
           MOVE    WRK-BYOMEI          TO  SPA-GMN-C02-CHARTBYOMEI
      *
      *    病名文字数編集
           COMPUTE WRK-MOJISU   =   WRK-MOJISU  /   2        
           MOVE    WRK-MOJISU          TO  SPA-NAI-C02-CHARTBYOMEIMOJI
           .
       41022-CHARTBYOMEI-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    疑い　入力処理
      *****************************************************************
       4104-UTAGAI-CHK-SEC                SECTION.
      *        
           MOVE    18                     TO  SPA-GMN-C02-CUR
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR
               GO  TO  4104-UTAGAI-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-C02-UTAGAIFLG  TO  WRK-UTAGAIFLG 
           MOVE    C02-UTAGAIFLG          TO  SPA-GMN-C02-UTAGAIFLG-G
      *
           IF      SPA-GMN-C02-UTAGAIFLG  =   WRK-UTAGAIFLG
               MOVE    19                 TO  SPA-GMN-C02-CUR
               GO  TO  4104-UTAGAI-CHK-EXT
           END-IF
      *
           MOVE    SPA-GMN-C02-UTAGAIFLG   TO  WRK-KBN
           PERFORM 5001-UTAGAIFLG-HENSYU-SEC
           MOVE    WRK-KBNMEI              TO  SPA-GMN-C02-UTAGAIFLGMEI
           IF      SPA-GMN-C02-UTAGAIFLG =   SPACE
               CONTINUE
           ELSE
               IF      SPA-GMN-C02-UTAGAIFLGMEI   =   SPACE    
                  MOVE    "0018"               TO  SPA-ERRCD
                  GO  TO  4104-UTAGAI-CHK-EXT
               END-IF
           END-IF    
      *        
           MOVE    19                   TO  SPA-GMN-C02-CUR
           GO  TO  4104-UTAGAI-CHK-EXT
      *     
      *    以下の処理は中止         
      *    疑い・急性の病名コードの削除
           IF      SPA-GMN-C02-UTAGAIFLG   =   "3"
               CONTINUE
           ELSE 
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       6
                   IF      SPA-NAI-C02-UTAGAIFLG   (IDX)   =   SPACE
                       CONTINUE
                   ELSE
                       EVALUATE    SPA-GMN-C02-UTAGAIFLG
                           WHEN    "1"
                           WHEN    "2"
                               IF      SPA-NAI-C02-UTAGAIFLG(IDX)
                                       NOT =   SPA-GMN-C02-UTAGAIFLG
                                 INITIALIZE  SPA-NAI-C02-BYOMEI-G(IDX)
                                 MOVE    SPACE       
                                         TO  SPA-GMN-C02-BYOMEICD(IDX)
                               END-IF
                           WHEN    SPACE
                               INITIALIZE SPA-NAI-C02-BYOMEI-G(IDX)
                               MOVE    SPACE
                                       TO  SPA-GMN-C02-BYOMEICD(IDX) 
                       END-EVALUATE
                   END-IF 
               END-PERFORM
           END-IF 
      *
           INITIALIZE                   WRK-SORT-TBL
           MOVE    SPA-GMN-C02-BYOMEICD-G  TO  WRK-SORT-BYOMEICD-G
           MOVE    SPA-NAI-C02-BYOMEI-TBL  TO  WRK-SORT-BYOMEI-TBL
           INITIALIZE                          SPA-GMN-C02-BYOMEICD-G
           INITIALIZE                          SPA-NAI-C02-BYOMEI-TBL
           MOVE    ZERO                    TO  IDY     
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      WRK-SORT-BYOMEICD (IDX) =   SPACE
                   CONTINUE
               ELSE
                   ADD     1           TO  IDY
                   MOVE    WRK-SORT-BYOMEICD (IDX)
                                       TO  SPA-GMN-C02-BYOMEICD (IDY)
                   MOVE    WRK-SORT-BYOMEI-G (IDX)
                                       TO  SPA-NAI-C02-BYOMEI-G (IDY)
               END-IF
           END-PERFORM
      *
      *    病名編集
           MOVE    SPACE                    TO  WRK-BYOMEI
           STRING  SPA-NAI-C02-BYOMEI (1) DELIMITED  BY  SPACE
                   SPA-NAI-C02-BYOMEI (2) DELIMITED  BY  SPACE
                   SPA-NAI-C02-BYOMEI (3) DELIMITED  BY  SPACE
                   SPA-NAI-C02-BYOMEI (4) DELIMITED  BY  SPACE
                   SPA-NAI-C02-BYOMEI (5) DELIMITED  BY  SPACE
                   SPA-NAI-C02-BYOMEI (6) DELIMITED  BY  SPACE
                              INTO          WRK-BYOMEI
           END-STRING
           MOVE    WRK-BYOMEI               TO  SPA-GMN-C02-BYOMEI
      *
      * 
      *　　接尾語・接頭語チェック
           MOVE    SPACE                   TO  WRK-RECECD-TBL
      * 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-GMN-C02-BYOMEICD(IDX)     NOT =   SPACE 
                   EVALUATE    SPA-GMN-C02-BYOMEICD(IDX)(1:1)
                               ALSO    SPA-GMN-C02-BYOMEICD(IDX)(4:1)
                       WHEN    "Z"         ALSO    "1"  THRU    "7"
                           IF      WRK-RECECD (2)    NOT =   SPACE   OR
                                   WRK-RECECD (3)    NOT =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (1)
                           END-IF            
                       WHEN    "Z"         ALSO    "8"  THRU    "8"
                           IF      WRK-RECECD (2)        =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (3)
                           END-IF
                       WHEN    OTHER                 
                           IF      WRK-RECECD (3)    NOT =   SPACE 
                               MOVE    "0006"        TO  SPA-ERRCD
                               MOVE    6             TO  IDX
                           ELSE
                               MOVE    "1"           TO  WRK-RECECD (2)
                           END-IF
                   END-EVALUATE
               END-IF
           END-PERFORM
           IF      SPA-ERRCD             NOT =   SPACE
               GO  TO  4104-UTAGAI-CHK-EXT
           END-IF
      *
      *    文字数チェック     
           MOVE    ZERO                TO  WRK-MOJISU
           IF      WRK-RECECD (1)    NOT =   SPACE   AND
                   WRK-RECECD (2)        =   SPACE   AND
                   WRK-RECECD (3)        =   SPACE
               CONTINUE                
           ELSE
               PERFORM VARYING     IDX     FROM    100 BY  -1
                       UNTIL       IDX     <       1
                   IF      WRK-BYOMEI(IDX:1)   NOT =   SPACE
                       MOVE    IDX                 TO  WRK-MOJISU 
                       MOVE    1                   TO  IDX
                   END-IF  
               END-PERFORM
           END-IF
      *         
           COMPUTE WRK-MOJISU   =   WRK-MOJISU  /   2        
           MOVE    WRK-MOJISU          TO  SPA-NAI-C02-BYOMEIMOJI
      *
      *    病名編集フラグセット
           MOVE    SPACE                   TO  SPA-GMN-C02-BYOMEIHENFLG
                                               SPA-NAI-C02-BYOMEIHENFLG
      *        
           MOVE    19                   TO  SPA-GMN-C02-CUR
           .
       4104-UTAGAI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    主病　入力処理
      *****************************************************************
       4105-SYUBYOFLG-CHK-SEC                SECTION.
      *   
           MOVE    19                   TO  SPA-GMN-C02-CUR
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR
               GO  TO  4105-SYUBYOFLG-CHK-EXT
           END-IF
      *
           MOVE    C02-SYUBYOFLG        TO  SPA-GMN-C02-SYUBYOFLG-G
      *
      *
           MOVE    SPA-GMN-C02-SYUBYOFLG
                                        TO  WRK-KBN
           PERFORM 5001-SYUBYOFLG-HENSYU-SEC
           MOVE    WRK-KBNMEI              TO  SPA-GMN-C02-SYUBYOFLGMEI
           IF      SPA-GMN-C02-SYUBYOFLG  =   SPACE
               CONTINUE
           ELSE
               IF      SPA-GMN-C02-SYUBYOFLGMEI     =   SPACE
                   MOVE    "0019"               TO  SPA-ERRCD
                   GO  TO  4105-SYUBYOFLG-CHK-EXT
               END-IF
           END-IF        
      *     
      *****IF      SPA-GMN-C02-SYUBYOFLG   =   "1"
      *        PERFORM VARYING IDX FROM    1   BY  1
      *                UNTIL   IDX >       SPA-GMN-C02-MAX
      *            IF      SPA-GMN-C02-BANGO  =   IDX
      *                CONTINUE
      *            ELSE
      *                IF      SPA-NAI-C02-TSYUBYOFLG (IDX)
      *                                               =   "1"   AND
      *                        SPA-NAI-C02-TTENKIKBN  (IDX)
      *                                               =   SPACE
      *                    MOVE    "0020"               TO  SPA-ERRCD
      *                    GO  TO  4105-SYUBYOFLG-CHK-EXT
      *                END-IF
      *            END-IF     
      *        END-PERFORM
      *****END-IF
      *       
           MOVE    20                   TO  SPA-GMN-C02-CUR
           .
       4105-SYUBYOFLG-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    慢性　入力処理
      *****************************************************************
       4106-MANSEI-CHK-SEC                SECTION.
      *   
           MOVE    20                   TO  SPA-GMN-C02-CUR
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR
               GO  TO  4106-MANSEI-CHK-EXT
           END-IF
      *
           MOVE    C02-MANSEIFLG        TO  SPA-GMN-C02-MANSEIKBN-G
      *
           MOVE    SPA-GMN-C02-MANSEIKBN
                                       TO  WRK-KBN
           PERFORM 5001-MANSEIKBN-HENSYU-SEC
           MOVE    WRK-KBNMEI          TO  SPA-GMN-C02-MANSEIKBNMEI
      *                                 
           IF      SPA-GMN-C02-MANSEIKBN =   SPACE
               CONTINUE
           ELSE
               IF      SPA-GMN-C02-MANSEIKBNMEI   =   SPACE    
                  MOVE    "0021"               TO  SPA-ERRCD
                  GO  TO  4106-MANSEI-CHK-EXT
               END-IF
           END-IF    
      *
      *
           IF      SPA-ERRCD              =   SPACE
               MOVE    21                   TO  SPA-GMN-C02-CUR
           END-IF
           .
       4106-MANSEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入外区分  入力処理
      *****************************************************************
       4107-NYUGAIKBN-CHK-SEC                SECTION.
      *   
           MOVE    21                   TO  SPA-GMN-C02-CUR
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR
               GO  TO  4107-NYUGAIKBN-CHK-EXT
           END-IF
      *
           MOVE    C02-NYUGAIKBN        TO  SPA-GMN-C02-NYUGAIKBN-G
      *
           IF      SPA-GMN-C02-NYUGAIKBN   =   SPACE
               CONTINUE
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      5
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-C02-NYUGAIKBN 
                               =   SPA-GMN-C02-NYUGAIKBNL (IDY)
                       MOVE    SPA-GMN-C02-NYUGAIKBNLST (IDY)
                                          TO  SPA-GMN-C02-NYUGAIKBN-G
                       MOVE    1          TO  WRK-HENFLG
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0022"               TO  SPA-ERRCD
                   GO  TO  4107-NYUGAIKBN-CHK-EXT
               END-IF
           END-IF
      *             
           MOVE    22                   TO  SPA-GMN-C02-CUR
           .
       4107-NYUGAIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号区分  入力処理
      *****************************************************************
       4108-COMB-CHK-SEC                SECTION.
      *
           MOVE    22                  TO  SPA-GMN-C02-CUR
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR
               GO  TO  4108-COMB-CHK-EXT
           END-IF
      *
           MOVE    C02-HKNCOMBI        TO  SPA-GMN-C02-HKNCOMBI-G
      *
           IF      SPA-GMN-C02-HKNCOMBI    =   SPACE
               CONTINUE
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      10
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-C02-HKNCOMBI 
                                  =   SPA-GMN-C02-HKNCOMBIL (IDY)
                       IF      SPA-NAI-C02-SRYYMD
                                      <= SPA-NAI-C02-TEKEDYMD (IDY)
                           MOVE    SPA-GMN-C02-HKNCOMBILST (IDY)
                                              TO
                                              SPA-GMN-C02-HKNCOMBI-G
                       ELSE    
                           MOVE    "0011"     TO  SPA-ERRCD
                       END-IF        
                       MOVE    1              TO  WRK-HENFLG
                       MOVE    10             TO  IDY
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
               AND     SPA-ERRCD          =   SPACE
                   MOVE    "0009"               TO  SPA-ERRCD
               END-IF
           END-IF
      *
           IF      SPA-ERRCD              =   SPACE
               MOVE    23                  TO  SPA-GMN-C02-CUR
           END-IF
      *
           .
       4108-COMB-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト表  入力処理
      *****************************************************************
       4109-REZEFLG-CHK-SEC             SECTION.
      *
           MOVE    23                 TO  SPA-GMN-C02-CUR
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR
               GO  TO  4109-REZEFLG-CHK-EXT
           END-IF
      *
           MOVE    C02-REZEFLG        TO  SPA-GMN-C02-REZEFLG-G
      *
           IF      SPA-GMN-C02-REZEFLG   =   SPACE
               CONTINUE
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      5
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-C02-REZEFLG 
                                      =   SPA-GMN-C02-REZEFLGL (IDY)
                       MOVE    SPA-GMN-C02-REZEFLGLST (IDY)
                                          TO  SPA-GMN-C02-REZEFLG-G
                       MOVE    1          TO  WRK-HENFLG
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0023"               TO  SPA-ERRCD
                   GO  TO  4109-REZEFLG-CHK-EXT
               END-IF
           END-IF
      *
           MOVE    24                 TO  SPA-GMN-C02-CUR
           .
       4109-REZEFLG-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセプト月  入力処理
      *****************************************************************
       41010-REZEMM-CHK-SEC            SECTION.
      *
           MOVE    24                  TO  SPA-GMN-C02-CUR
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR
               GO  TO  41010-REZEMM-CHK-EXT
           END-IF
      *
           MOVE    C02-REZEMM          TO  SPA-GMN-C02-REZEMM
      *
           MOVE    25                  TO  SPA-GMN-C02-CUR
           .
       41010-REZEMM-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    転帰区分  入力処理
      *****************************************************************
       41011-TENKIKBN-CHK-SEC            SECTION.
      *
           MOVE    17                  TO  SPA-GMN-C02-CUR
      *
           MOVE    C02-TENKIKBN         TO  SPA-GMN-C02-TENKIKBN-G
      *
           IF      SPA-GMN-C02-TENKIKBN   =   SPACE
               MOVE    SPACE              TO  SPA-NAI-C02-TENKIYMD
               MOVE    SPACE              TO  SPA-GMN-C02-TENKIYMD
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      5
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-C02-TENKIKBN 
                                  =   SPA-GMN-C02-TENKIKBNL (IDY)
                       MOVE    SPA-GMN-C02-TENKIKBNLST (IDY)
                                          TO  SPA-GMN-C02-TENKIKBN-G
                       MOVE    1          TO  WRK-HENFLG
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0024"               TO  SPA-ERRCD
                   GO  TO  41011-TENKIKBN-CHK-EXT
               END-IF
           END-IF
      *     
      *----(01.02.02) LINE INS START ----------------------------------
           IF      SPA-GMN-C02-TENKIKBN     =   SPACE
               IF      SPA-GMN-C02-TENKIYMD NOT =   SPACE
                   MOVE    "0025"          TO  SPA-ERRCD
                   GO      TO      41011-TENKIKBN-CHK-EXT
               END-IF
           ELSE
               IF      SPA-GMN-C02-TENKIYMD =   SPACE
                   MOVE    SPA-NAI-C02-SYSYMD   TO  SPA-NAI-C02-TENKIYMD
                   MOVE    SPA-GMN-C02-SYSYMD   TO  SPA-GMN-C02-TENKIYMD
      *************MOVE    "0026"          TO  SPA-ERRCD
      *************GO      TO      41011-TENKIKBN-CHK-EXT
               END-IF
           END-IF    
      *----(01.02.02) LINE INS END   ----------------------------------
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX >   1
               MOVE    2                    TO  SPA-GMN-C02-CUR
           ELSE
               IF      SPA-GMN-C02-TENKIKBN =   SPACE
                   MOVE    29                   TO  SPA-GMN-C02-CUR
               ELSE                 
                   MOVE    13                   TO  SPA-GMN-C02-CUR
               END-IF    
           END-IF    
           .
       41011-TENKIKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    転帰年月日  入力処理
      *****************************************************************
       41012-TENKIYMD-CHK-SEC            SECTION.
      *
           MOVE    13                 TO  SPA-GMN-C02-CUR
      *
           MOVE    C02-TENKIYMD       TO  SPA-GMN-C02-TENKIYMD
      *     
           MOVE    SPACE              TO  SPA-NAI-C02-TENKIYMD
           IF      SPA-GMN-C02-TENKIYMD
                                      =   SPACE
               IF      SPA-GMN-C02-TENKIKBN   NOT =   SPACE
                   MOVE    "0036"          TO  SPA-ERRCD
               END-IF    
           ELSE    
      *        日付画面チェックサブ
               INITIALIZE                      ORCSGDAYAREA
               MOVE    SPA-GMN-C02-TENKIYMD    TO  SGDAY-INDAY
               CALL    "ORCSGDAY"          USING
                                           ORCSGDAYAREA
               IF      SGDAY-RC            =   ZERO
                   MOVE    SGDAY-OTDAY         TO  SPA-GMN-C02-TENKIYMD
                   MOVE    SGDAY-SDAY          TO  SPA-NAI-C02-TENKIYMD
      *             
                   IF      SPA-NAI-C02-SRYYMD  >   SPA-NAI-C02-TENKIYMD
                       MOVE    "0027"              TO  SPA-ERRCD
                   END-IF    
                   IF      SPA-GMN-C02-TENKIKBN    =   SPACE
                       MOVE    "0037"          TO  SPA-ERRCD
                   END-IF    
               ELSE
                   MOVE    "0016"          TO  SPA-ERRCD
               END-IF
           END-IF    
      *         
           IF      SPA-ERRCD           =   SPACE
               MOVE    29                  TO  SPA-GMN-C02-CUR 
           END-IF     
           .
       41012-TENKIYMD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名  入力処理
      *****************************************************************
       41013-BYOMEI-CHK-SEC             SECTION.
      *
           MOVE    8                    TO  SPA-GMN-C02-CUR
      * 
      *    複数病名入力のとき
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR 
               GO  TO  41013-BYOMEI-CHK-EXT
      *****ELSE
      *        自院病名入力のとき
      *        IF      SPA-NAI-C02-USERBYOMEIFLG (1)
      *                                    =   "1"
      *            IF      C02-BYOMEI  NOT =   SPA-GMN-C02-BYOMEI
      *                MOVE    "0061"              TO  SPA-ERRCD
      *                MOVE    9                   TO  SPA-GMN-C02-CUR 
      *                GO  TO  41013-BYOMEI-CHK-EXT
      *            END-IF
      *********END-IF        
           END-IF    
      *
           MOVE    C02-BYOMEI           TO  SPA-GMN-C02-BYOMEI
      *     
           MOVE    ZERO                 TO  SPA-NAI-C02-BYOMEIMOJI
      *
           IF      SPA-GMN-C02-BYOMEI   =   SPACE
                INITIALIZE                   SPA-GMN-C02-BYOMEICD-G
                                             SPA-NAI-C02-BYOMEI-TBL
                MOVE    SPACE            TO  SPA-NAI-C02-BYOMEIHENFLG
                                             SPA-GMN-C02-BYOMEIHENFLG
                MOVE    ZERO             TO  SPA-NAI-C02-BYOMEIMOJI
                MOVE    ZERO             TO  SPA-NAI-C02-BYOMEICD-MAX
                INITIALIZE                   SPA-GMN-C02-UTAGAIFLG-G
                                             SPA-GMN-C02-MANSEIKBN-G
                MOVE    28               TO  SPA-GMN-C02-CUR
                GO  TO  41013-BYOMEI-CHK-EXT
           END-IF
      *          
           IF      SPA-GMN-C02-BYOMEI (81:) NOT =   SPACE
               MOVE    "0007"              TO  SPA-ERRCD
               GO  TO  41013-BYOMEI-CHK-EXT
           END-IF
      *
      *    半角チェック
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI 
           MOVE    SPA-GMN-C02-BYOMEI  TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
           AND     KANACHK-SYUBETU     =   "2"
               MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-C02-BYOMEI
           ELSE
               MOVE    "0071"              TO  SPA-ERRCD
               GO  TO  41013-BYOMEI-CHK-EXT
           END-IF
      *
      *    病名のみ入力のとき検索処理をする
      *    （病名コード未入力、または未コード化傷病名コードのとき
      *                                     、または編集病名以外のとき）
           IF      SPA-GMN-C02-BYOMEI   NOT =   SPACE
               IF      SPA-NAI-C02-USERBYOMEIFLG (1)
                                                =   "1"
                   CONTINUE
               ELSE 
      *********IF      SPA-GMN-C02-BYOMEICD-G   =   SPACE
      *********OR      SPA-GMN-C02-BYOMEICD (1) =   WRK-CONS-BYOMEICD
      *********OR (      ( SPA-NAI-C02-BYOMEIHENFLG =   SPACE )
      *********    AND   ( SPA-NAI-C02-USERBYOMEIFLG (1)
      *********                                 =   SPACE     ) )
      ************ MOVE    SPACE        TO  SPA-GMN-C02-BYOMEICD-G
      ************ MOVE    ZERO         TO  SPA-NAI-C02-BYOMEICD-MAX
                   PERFORM 410131-BYOMEI-KENSAKU-SEC
                   IF      WRK-BYO-MAX      >   ZERO
                       INITIALIZE               SPA-GMN-C02-BYOMEICD-G
                                                SPA-NAI-C02-BYOMEI-TBL
                     IF      WRK-BYO-MAX      >   6
                         MOVE    "0077"           TO  SPA-ERRCD
                     ELSE
                       MOVE    ZERO         TO  IDZ
                       PERFORM VARYING IDX FROM    1   BY  1
                               UNTIL   IDX >       6
                           IF      WRK-BYO-BYOMEICD (IDX)
                                                   NOT =   SPACE
                               ADD     1           TO  IDZ
                               MOVE    WRK-BYO-BYOMEICD (IDX)
                                       TO  SPA-GMN-C02-BYOMEICD (IDZ)
                               MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                       TO  BYO-BYOMEICD
                               PERFORM 410111-BYOMEI-HENSYU-SEC
      *                         
                               IF      SPA-GMN-C02-BYOMEICD (IDZ)(1:1)
                                                       NOT =   "Z"     
                                 IF      WRK-BYO-IKOSAKICD (IDX)
                                                           =   SPACE
                                   IF      WRK-BYO-HAISIYMD (IDX)
                                                           =   ALL "9"
                                                           OR  SPACE  
                                       CONTINUE
                                   ELSE
                                       MOVE    WRK-BYO-HAISIYMD (IDX)
                                                   TO  WRK-SYMD
                                       PERFORM 5002-HIZUKE-HEN-SEC
                                       MOVE    LNK-DAY2-EDTYMD3
                                                   TO  WRK-HAISIYMDH
                                   END-IF        
                                 ELSE                            
                                   MOVE    SPA-GMN-C02-BYOMEICD (IDZ) 
                                           TO  SPA-C02-IKOMOTO-BYOMEICD
                                   MOVE    SPA-NAI-C02-BYOMEI   (IDZ) 
                                           TO  SPA-C02-IKOMOTO-BYOMEI
                                   MOVE    WRK-BYO-IKOSAKICD (IDX)
                                           TO  BYO-BYOMEICD
                                   PERFORM 900-BYOMEI-READ-SEC
                                   IF      FLG-BYOMEI          =   ZERO
                                       MOVE    BYO-BYOMEICD    TO
                                               SPA-C02-IKOSAKI-BYOMEICD
                                       MOVE    BYO-BYOMEI      TO
                                               SPA-C02-IKOSAKI-BYOMEI
                                       MOVE    IDX             TO
                                               SPA-C02-IKOSAKI-INDEX                    
                                       MOVE    "0105"          TO
                                               SPA-CIDCD2
                                   END-IF
                                 END-IF
                               END-IF  
                           END-IF    
                       END-PERFORM
                       PERFORM 41021-BYOMEI-HENSYU-SEC
      *                入力病名コード数カウント
                       PERFORM 410111-BYOMEICDSU-HENSYU-SEC
                       IF      SPA-ERRCD       =   SPACE
                           MOVE    28          TO  SPA-GMN-C02-CUR
                       END-IF
                       IF      SPA-CIDCD2          =   SPACE
                       AND     WRK-HAISIYMDH   NOT =   SPACE
                           MOVE    "0075"          TO  SPA-ERRCD
                       END-IF    
                       GO  TO  41013-BYOMEI-CHK-EXT
                     END-IF
                   END-IF    
               END-IF        
           END-IF    
      *
      *    文字チェック     
           PERFORM VARYING     IDX     FROM    1   BY  2
                   UNTIL       IDX     >       80
                   OR  SPA-GMN-C02-BYOMEI(IDX:2)   =   SPACE
               IF      SPA-GMN-C02-BYOMEI(IDX:2)   =   "■"
                   MOVE    "0035"          TO  SPA-ERRCD
                   GO  TO  41013-BYOMEI-CHK-EXT
              END-IF
           END-PERFORM
      *         
      *    病名文字数編集
           MOVE    ZERO                TO  WRK-MOJISU
           PERFORM VARYING     IDX     FROM    80  BY  -1
                   UNTIL       IDX     <       1
               IF      SPA-GMN-C02-BYOMEI(IDX:1)   NOT =   SPACE
                   MOVE    IDX                 TO  WRK-MOJISU 
                   MOVE    1                   TO  IDX
               END-IF  
           END-PERFORM
      *
           COMPUTE WRK-MOJISU   =   WRK-MOJISU  /   2        
           MOVE    WRK-MOJISU           TO  SPA-NAI-C02-BYOMEIMOJI
      *
      *    病名編集フラグ編集
           MOVE    SPACE               TO  WRK-BYOMEI
           STRING  SPA-NAI-C02-BYOMEI (1) DELIMITED  BY  SPACE
                   SPA-NAI-C02-BYOMEI (2) DELIMITED  BY  SPACE
                   SPA-NAI-C02-BYOMEI (3) DELIMITED  BY  SPACE
                   SPA-NAI-C02-BYOMEI (4) DELIMITED  BY  SPACE
                   SPA-NAI-C02-BYOMEI (5) DELIMITED  BY  SPACE
                   SPA-NAI-C02-BYOMEI (6) DELIMITED  BY  SPACE
                              INTO          WRK-BYOMEI
           END-STRING
      * 
      *    自院コードで編集病名のときは編集しない
           IF      SPA-NAI-C02-USERBYOMEIFLG (1)    =   "1"
           AND     SPA-NAI-C02-BYOMEIHENFLG         =   "1"
               CONTINUE
           ELSE
               IF      WRK-BYOMEI           NOT =   SPA-GMN-C02-BYOMEI 
                   MOVE    "1"              TO  SPA-NAI-C02-BYOMEIHENFLG
                   MOVE    " 病名編集"      TO  SPA-GMN-C02-BYOMEIHENFLG
               ELSE
                   MOVE    SPACE            TO  SPA-GMN-C02-BYOMEIHENFLG
                                                SPA-NAI-C02-BYOMEIHENFLG
               END-IF
           END-IF
      *
      *    病名が未入力のとき未コード化傷病名コードをクリア
           IF      SPA-GMN-C02-BYOMEICD (1) =   WRK-CONS-BYOMEICD
           AND     SPA-GMN-C02-BYOMEI       =   SPACE
               MOVE    SPACE                TO  SPA-GMN-C02-BYOMEICD (1)
               MOVE    SPA-GMN-C02-BYOMEICD (1)
                                            TO  BYO-BYOMEICD
               MOVE    1                    TO  IDZ
               PERFORM 410111-BYOMEI-HENSYU-SEC
               MOVE    ZERO                 TO  SPA-NAI-C02-BYOMEICD-MAX
           END-IF
      *
      *    病名のみ入力のときは未コード化傷病名コードをセット
           IF      SPA-GMN-C02-BYOMEICD-G   =   SPACE
           AND     SPA-GMN-C02-BYOMEI   NOT =   SPACE    
               MOVE    WRK-CONS-BYOMEICD    TO  SPA-GMN-C02-BYOMEICD(1)
               MOVE    SPA-GMN-C02-BYOMEICD (1)
                                            TO  BYO-BYOMEICD
               MOVE    1                    TO  IDZ
               PERFORM 410111-BYOMEI-HENSYU-SEC
               MOVE    1                    TO
                                            SPA-NAI-C02-BYOMEICD-MAX
           END-IF          
      *
           MOVE    28                   TO  SPA-GMN-C02-CUR
           .
       41013-BYOMEI-CHK-EXT.
           EXIT.
      *----(01.00.03) LINE ADD START ----------------------------------
      *****************************************************************
      *    病名検索処理
      *****************************************************************
       410131-BYOMEI-KENSAKU-SEC       SECTION.
      *         
      *    病名文字数編集
           MOVE    ZERO                TO  WRK-MOJISU
           PERFORM VARYING     IDX     FROM    80  BY  -1
                   UNTIL       IDX     <       1
               IF      SPA-GMN-C02-BYOMEI(IDX:1)   NOT =   SPACE
                   MOVE    IDX                 TO  WRK-MOJISU 
                   MOVE    1                   TO  IDX
               END-IF  
           END-PERFORM
      *
           INITIALIZE                  WRK-BYOMEICD-KENSAKU-AREA
                                       WRK-KEN-UTAGAIFLG
      *
      *    入力された病名で検索
           MOVE    "BYOMEI-KEY4"       TO  WRK-DBPATH
           INITIALIZE                  BYOMEI-REC
           MOVE    SPA-GMN-C02-BYOMEI  TO  BYO-BYOMEI
           PERFORM 410131-BYOKEN-HEN-SEC
           IF      IDX                 =   1
               MOVE    WRK-BYOMEICD        TO  WRK-BYO-BYOMEICD (1)
               MOVE    WRK-IKOSAKICD       TO  WRK-BYO-IKOSAKICD(1)
               MOVE    WRK-HAISIYMD        TO  WRK-BYO-HAISIYMD (1) 
               MOVE    1                   TO  WRK-BYO-MAX
               GO  TO  410131-BYOMEI-KENSAKU-EXT
           END-IF
      *
      *    接尾語（の疑い）以外の病名で検索
           IF      WRK-MOJISU          >   6
               COMPUTE IDW     =   WRK-MOJISU   -   5
               IF      SPA-GMN-C02-BYOMEI (IDW:6)   =   "の疑い"
                   MOVE    1                   TO  WRK-KEN-UTAGAIFLG
                   MOVE    "BYOMEI-KEY4"       TO  WRK-DBPATH
                   INITIALIZE                  BYOMEI-REC
                   COMPUTE IDX     =   IDW     -   1
                   MOVE    SPA-GMN-C02-BYOMEI  (1:IDX)
                                               TO  BYO-BYOMEI
                   PERFORM 410131-BYOKEN-HEN-SEC
                   IF      IDX                 =   1
                       MOVE    WRK-BYOMEICD    TO  WRK-BYO-BYOMEICD (1)
                       MOVE    WRK-IKOSAKICD   TO  WRK-BYO-IKOSAKICD(1)
                       MOVE    WRK-HAISIYMD    TO  WRK-BYO-HAISIYMD (1) 
                       MOVE    "ZZZ8002"       TO  WRK-BYO-BYOMEICD (2)
                       MOVE    2               TO  WRK-BYO-MAX
                       GO  TO  410131-BYOMEI-KENSAKU-EXT
                   END-IF
               END-IF
           END-IF
      *
      *    接尾語（急性増悪）以外の病名で検索
           IF      WRK-MOJISU          >   8
               COMPUTE IDW     =   WRK-MOJISU   -   7
               IF      SPA-GMN-C02-BYOMEI (IDW:8)   =   "急性増悪"
                   MOVE    2                   TO  WRK-KEN-UTAGAIFLG
                   MOVE    "BYOMEI-KEY4"       TO  WRK-DBPATH
                   INITIALIZE                  BYOMEI-REC
                   COMPUTE IDX     =   IDW     -   1
                   MOVE    SPA-GMN-C02-BYOMEI  (1:IDX)
                                               TO  BYO-BYOMEI
                   PERFORM 410131-BYOKEN-HEN-SEC
                   IF      IDX                 =   1
                       MOVE    WRK-BYOMEICD    TO  WRK-BYO-BYOMEICD (1)
                       MOVE    WRK-IKOSAKICD   TO  WRK-BYO-IKOSAKICD(1)
                       MOVE    WRK-HAISIYMD    TO  WRK-BYO-HAISIYMD (1) 
                       MOVE    "ZZZ8007"       TO  WRK-BYO-BYOMEICD (2)
                       MOVE    2               TO  WRK-BYO-MAX
                       GO  TO  410131-BYOMEI-KENSAKU-EXT
                   END-IF
               END-IF
           END-IF
      *
      *    接頭語の検索
           MOVE    ZERO                TO  IDXX
           EVALUATE    WRK-KEN-UTAGAIFLG
               WHEN    "1"
                   COMPUTE IDW     =   WRK-MOJISU  -   6
                   MOVE    SPA-GMN-C02-BYOMEI (1:IDW) 
                                                   TO  WRK-KEN-BYOMEI
               WHEN    "2"
                   COMPUTE IDW     =   WRK-MOJISU  -   8
                   MOVE    SPA-GMN-C02-BYOMEI (1:IDW)
                                                   TO  WRK-KEN-BYOMEI
               WHEN    OTHER
                   MOVE    WRK-MOJISU              TO  IDW
                   MOVE    SPA-GMN-C02-BYOMEI      TO  WRK-KEN-BYOMEI
           END-EVALUATE
           MOVE    IDW                 TO  WRK-MOJISU
                                           WRK-KEN-LENGTH
           MOVE    1                   TO  IDZ
      *
           PERFORM                     UNTIL   IDZ     >=  WRK-MOJISU
      *
      *        病名の検索
               MOVE    ZERO                TO  WRK-KEN-ADDKBN
               PERFORM VARYING IDW FROM    WRK-KEN-LENGTH  BY  -2 
                       UNTIL   IDW <       2
                   MOVE    "BYOMEI-KEY6"       TO  WRK-DBPATH
                   INITIALIZE                  BYOMEI-REC
                   MOVE    WRK-KEN-BYOMEI(IDZ:IDW)  
                                               TO  BYO-BYOMEI
                   PERFORM 410131-BYOKEN-HEN-SEC
                   IF      IDX                 =   1
                       ADD     1       TO  WRK-BYO-MAX
                       IF      WRK-BYO-MAX     <   7
                           ADD     1       TO  IDXX
                           MOVE    WRK-BYOMEICD
                                       TO  WRK-BYO-BYOMEICD (IDXX)
                           MOVE    WRK-IKOSAKICD
                                       TO  WRK-BYO-IKOSAKICD(IDXX)
                           MOVE    WRK-HAISIYMD
                                       TO  WRK-BYO-HAISIYMD (IDXX) 
                       ELSE
                           GO  TO  410131-BYOMEI-KENSAKU-EXT
                       END-IF
                       COMPUTE IDZ     =   IDZ   +   IDW
                       COMPUTE WRK-KEN-LENGTH  =   WRK-KEN-LENGTH  -
                                                   IDW
                       MOVE    2                   TO  IDW
                       MOVE    1                   TO  WRK-KEN-ADDKBN   
                   END-IF      
               END-PERFORM
      *
      *        検索できなかったときは終了
               IF      WRK-KEN-ADDKBN          =   ZERO
                   INITIALIZE                  WRK-BYOMEICD-KENSAKU-AREA
                   GO  TO  410131-BYOMEI-KENSAKU-EXT
               END-IF
           END-PERFORM     
      *
           IF      WRK-KEN-UTAGAIFLG   =   "1"
               ADD     1       TO  WRK-BYO-MAX
               IF      WRK-BYO-MAX     <   7
                   ADD     1           TO  IDXX
                   MOVE    "ZZZ8002"   TO  WRK-BYO-BYOMEICD (IDXX)
               ELSE
                   GO  TO  410131-BYOMEI-KENSAKU-EXT
               END-IF
           END-IF
           IF      WRK-KEN-UTAGAIFLG   =   "2"
               ADD     1       TO  WRK-BYO-MAX
               IF      WRK-BYO-MAX     <   7
                   ADD     1           TO  IDXX
                   MOVE    "ZZZ8007"   TO  WRK-BYO-BYOMEICD (IDXX)
               ELSE
                   GO  TO  410131-BYOMEI-KENSAKU-EXT
               END-IF
           END-IF
           .
       410131-BYOMEI-KENSAKU-EXT.
           EXIT.
      *     
      *****************************************************************
      *    病名検索処理
      *****************************************************************
       410131-BYOKEN-HEN-SEC        SECTION.
      * 
           MOVE    SPACE               TO  WRK-BYOMEICD
      *
           MOVE    ZERO                TO  IDX
      * 
           MOVE    BYOMEI-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-DBPATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-DBPATH            TO  ORC-DBPATH
               PERFORM 900-BYOMEI-READ-N-SEC
           ELSE
               INITIALIZE                  BYOMEI-REC
               MOVE    1               TO  FLG-BYOMEI
           END-IF
      *
           PERFORM  UNTIL     (IDX             >   1   )   OR
                              (FLG-BYOMEI      =   1   )
               ADD     1                   TO  IDX                
               IF      IDX                 =   1               
                   MOVE    BYO-BYOMEICD        TO  WRK-BYOMEICD
                   MOVE    BYO-IKOSAKICD       TO  WRK-IKOSAKICD
                   MOVE    BYO-HAISIYMD        TO  WRK-HAISIYMD
               ELSE
                   MOVE    SPACE               TO  WRK-BYOMEICD
                                                   WRK-IKOSAKICD 
                                                   WRK-HAISIYMD
               END-IF
      *
               MOVE    WRK-DBPATH                TO  ORC-DBPATH
               PERFORM 900-BYOMEI-READ-N-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-DBPATH            TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       410131-BYOKEN-HEN-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    保険病名フラグ　入力処理
      *****************************************************************
       41014-HKNBYOMEIFLG-CHK-SEC                SECTION.
      *   
           MOVE    25                   TO  SPA-GMN-C02-CUR
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR 
               GO  TO  41014-HKNBYOMEIFLG-CHK-EXT
           END-IF    
      *
           MOVE    C02-HKNBYOMEIFLG     TO  SPA-GMN-C02-HKNBYOMEIFLG-G
      *
           IF      SPA-GMN-C02-HKNBYOMEIFLG   =   SPACE
               CONTINUE
           ELSE
               MOVE    ZERO               TO  WRK-HENFLG
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      5
                       OR      WRK-HENFLG =   1
                   IF      SPA-GMN-C02-HKNBYOMEIFLG 
                               =   SPA-GMN-C02-HKNBYOMEIFLGL (IDY)
                       MOVE    SPA-GMN-C02-HKNBYOMEIFLGLST (IDY)
                                      TO  SPA-GMN-C02-HKNBYOMEIFLG-G
                       MOVE    1      TO  WRK-HENFLG
                   END-IF
               END-PERFORM
               IF      WRK-HENFLG         =   ZERO
                   MOVE    "0028"               TO  SPA-ERRCD
                   GO  TO  41014-HKNBYOMEIFLG-CHK-EXT
                   
               END-IF
           END-IF
      *     
           MOVE    2                   TO  SPA-GMN-C02-CUR
           .
       41014-HKNBYOMEIFLG-CHK-EXT.
           EXIT.
      *----(01.00.03) LINE ADD END   ----------------------------------
      *
      *****************************************************************
      *    病名入力コード  入力処理
      *****************************************************************
       41017-BYOMEIINPUTCD-CHK-SEC             SECTION.
      *
           MOVE    29                  TO  SPA-GMN-C02-CUR
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR 
               GO  TO  41017-BYOMEIINPUTCD-CHK-EXT
           END-IF
      *
      *    半角チェック
           IF      C02-BYOMEIINPUTCD   =   SPACE
               CONTINUE
           ELSE    
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    C02-BYOMEIINPUTCD   TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-RC2         =   ZERO
                   MOVE    KANACHK-OUT-INPUT   TO  C02-BYOMEIINPUTCD
      *************CONTINUE
               ELSE
                   MOVE    "0072"              TO  SPA-ERRCD
                   GO  TO  41017-BYOMEIINPUTCD-CHK-EXT
               END-IF
           END-IF    
      *
           MOVE    C02-BYOMEIINPUTCD   TO  SPA-GMN-C02-BYOMEIINPUTCD
      *
           IF      SPA-GMN-C02-BYOMEIINPUTCD
                                       =   SPACE
               CONTINUE
           ELSE
      *         
               PERFORM VARYING IDZ FROM    1   BY  1
                       UNTIL   IDZ >       6
                   IF      SPA-NAI-C02-USERBYOMEIFLG (IDZ)
                                               =   "1"
                       MOVE    "0064"              TO  SPA-ERRCD
                        GO  TO  41017-BYOMEIINPUTCD-CHK-EXT
                   END-IF
               END-PERFORM
      *
               IF      SPA-ERRCD           =   SPACE
                   MOVE    ZERO                TO  WRK-LENGTH                    
                   PERFORM VARYING IDX FROM    10  BY  -1
                           UNTIL   IDX <       1
                       IF      SPA-GMN-C02-BYOMEIINPUTCD(IDX:1)
                                           NOT =   SPACE
                           MOVE    IDX             TO  WRK-LENGTH
                           MOVE    1               TO  IDX
                       END-IF
                   END-PERFORM
                   IF      WRK-LENGTH          =   7   OR  ZERO
                       MOVE    "0070"              TO  SPA-ERRCD
                   END-IF    
               END-IF                                  
      *                 
      *        自院病名マスタ読み込み
               IF      SPA-ERRCD           =   SPACE
                   INITIALIZE                  USERBYOMEI-REC
                   MOVE    SPA-HOSPID          TO  USBYO-HOSPID
                   MOVE    SPA-GMN-C02-BYOMEIINPUTCD
                                           TO  USBYO-BYOMEIINPUTCD
                   PERFORM 900-USERBYOMEI-INV-SEC
                   IF      FLG-USERBYOMEI      =   ZERO
                       MOVE    "0068"              TO  SPA-ERRCD
                   ELSE
                       IF      SPA-GMN-C02-BYOMEI  =   SPACE
                       AND     SPA-GMN-C02-BYOMEICD-G   =   SPACE
                           MOVE    "0010"              TO  SPA-ERRCD
                       END-IF
                   END-IF
               END-IF    
           END-IF                            
      *
           IF      SPA-ERRCD            =   SPACE
               MOVE    18                   TO  SPA-GMN-C02-CUR
           END-IF    
           .
       41017-BYOMEIINPUTCD-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    カルテ病名  入力処理
      *****************************************************************
       41018-CHARTBYOMEI-CHK-SEC        SECTION.
      *
           MOVE    28                   TO  SPA-GMN-C02-CUR
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR 
               GO  TO  41018-CHARTBYOMEI-CHK-EXT
      *****ELSE
      *        IF      SPA-NAI-C02-USERBYOMEIFLG (1)
      *                                    =   "1"
      *            IF      C02-CHARTBYOMEI
      *                                NOT =   SPA-GMN-C02-CHARTBYOMEI
      *                MOVE    "0061"              TO  SPA-ERRCD
      *                MOVE    9                   TO  SPA-GMN-C02-CUR 
      *                GO  TO  41018-CHARTBYOMEI-CHK-EXT
      *            END-IF
      *********END-IF      
           END-IF    
      *
           MOVE    C02-CHARTBYOMEI      TO  SPA-GMN-C02-CHARTBYOMEI
      *
           MOVE    ZERO                 TO  SPA-NAI-C02-CHARTBYOMEIMOJI
      *
           IF      SPA-GMN-C02-CHARTBYOMEI  =   SPACE
               MOVE    9                    TO  SPA-GMN-C02-CUR
               GO  TO  41018-CHARTBYOMEI-CHK-EXT
           END-IF                                       
      *               
           IF      SPA-GMN-C02-CHARTBYOMEI (81:)
                                    NOT =   SPACE
               MOVE    "0033"               TO  SPA-ERRCD
               GO  TO  41018-CHARTBYOMEI-CHK-EXT
           END-IF                                       
      *
      *    半角チェック
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI 
           MOVE    SPA-GMN-C02-CHARTBYOMEI
                                       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
           AND     KANACHK-SYUBETU     =   "2"
      *********CONTINUE
               MOVE    KANACHK-OUT-INPUT   TO  SPA-GMN-C02-CHARTBYOMEI
           ELSE
               MOVE    "0071"              TO  SPA-ERRCD
               GO  TO  41018-CHARTBYOMEI-CHK-EXT
           END-IF                                       
      *
      *    病名文字数編集
           MOVE    ZERO                TO  WRK-MOJISU
           PERFORM VARYING     IDX     FROM    80  BY  -1
                   UNTIL       IDX     <       1
               IF      SPA-GMN-C02-CHARTBYOMEI(IDX:1)   NOT =   SPACE
                   MOVE    IDX                 TO  WRK-MOJISU 
                   MOVE    1                   TO  IDX
               END-IF  
           END-PERFORM
      *
           COMPUTE WRK-MOJISU   =   WRK-MOJISU  /   2        
           MOVE    WRK-MOJISU           TO  SPA-NAI-C02-CHARTBYOMEIMOJI
      *
      *
           MOVE    9                    TO  SPA-GMN-C02-CUR
           .
       41018-CHARTBYOMEI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41020-BYOMEISEL-SEC       SECTION.
      *
           MOVE    ZERO                TO  SPA-C02-IKOFLG           
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
      *     
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-C02-MAX
               IF      C02-BYO-SELECT (IDX)    =   "T"
                   IF      IDX             =   SPA-NAI-C02-SELNO
                       CONTINUE
                   ELSE        
                       MOVE    IDX             TO  WRK-SELNO
                       MOVE    200             TO  IDX
                   END-IF
               END-IF    
           END-PERFORM
      *
           IF      WRK-SELNO           >   ZERO
               MOVE    WRK-SELNO           TO  SPA-NAI-C02-SELNO
      *****     ELSE
      *****         GO  TO  41020-BYOMEISEL-EXT    
           END-IF
      *
           INITIALIZE                 SPA-GMN-C02-KOUMOKU
                                      SPA-NAI-C02-KOUMOKU
      *
           MOVE    SPA-GMN-C02-TBANGO (SPA-NAI-C02-SELNO)
                                       TO  SPA-GMN-C02-BANGO
      *                                 
           PERFORM 410111-BYOMEI-SELECT-SEC     
           .
       41020-BYOMEISEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    行選択処理
      *****************************************************************
       41021-HKNCOMBISEL-SEC       SECTION.
      *          
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0060"              TO  SPA-ERRCD
               MOVE    2                   TO  SPA-GMN-C02-CUR 
               GO  TO  41021-HKNCOMBISEL-EXT
           END-IF
      *     
      *        行選択
           MOVE    ZERO                TO  WRK-SELNO
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-C02-HKN-MAX
               IF      C02-HKN-SELECT (IDX)    =   "T"
                   MOVE    IDX                  TO  WRK-SELNO
                   MOVE    20                   TO  IDX
               END-IF
           END-PERFORM
      *
      ***  MOVE    SPA-GMN-C02-TNUM (WRK-SELNO)
      ***                              TO  SPA-GMN-C02-HKNCOMBI
      *
           MOVE    ZERO               TO  WRK-HENFLG
           PERFORM VARYING IDY FROM   1   BY  1
                   UNTIL   IDY >      10
               IF      SPA-GMN-C02-TNUM (WRK-SELNO) 
                                      =   SPA-GMN-C02-HKNCOMBIL (IDY)
                   IF      SPA-NAI-C02-SRYYMD
                                  <= SPA-NAI-C02-TEKEDYMD (IDY)
                       MOVE    SPA-GMN-C02-HKNCOMBILST (IDY)
                                          TO  SPA-GMN-C02-HKNCOMBI-G
                   ELSE    
                       MOVE    "0011"     TO  SPA-ERRCD
                   END-IF        
                   MOVE    1              TO  WRK-HENFLG
                   MOVE    20             TO  IDY
               END-IF
           END-PERFORM
           IF      WRK-HENFLG         =   ZERO
           AND     SPA-ERRCD          =   SPACE
               MOVE    "0009"               TO  SPA-ERRCD
           END-IF
           .
       41021-HKNCOMBISEL-EXT.
           EXIT.
      *
      *****************************************************************
      *    戻る　処理
      *****************************************************************
       210-BACK                    SECTION.
      *----(01.00.02) LINE ADD START ----------------------------------
           IF      SPA-C02-UPDFLG          =   "1"
               MOVE    "0101"          TO  SPA-CIDCD
               GO      TO      210-BACK-EXT
           END-IF
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *    排他制御解除処理
           PERFORM 990-LOCK-OUT-SEC
      *
      *    ファイルクリア
           MOVE    SPA-TERMID          TO  FILE-TERMID
           MOVE    ZERO                TO  IF-RESULT
           MOVE    FILE-NAME1          TO  IF-FILENAME
           CALL    "orcfiledel"        USING
                                       ORCSFDELAREA
           MOVE    1                   TO  FLG-END2
      *
           MOVE    SPA-C02-MOTOPG     TO  SPA-SAKIPG
           IF      SPA-C02-MOTOPG NOT =   "K02"  AND  "U02"   AND
                                          "K02N"
      ********* 患者番号入力へ
      *********MOVE   "C01"            TO  SPA-SAKIPG
               MOVE   "M01"            TO  SPA-SAKIPG
           END-IF
           MOVE    "C02"               TO  SPA-MOTOPG
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    SPACE               TO  SPA-WORK 
           IF      SPA-C02-MOTOPG  NOT =   "K02"  AND  "U02"  AND 
                                           "K02N"
               INITIALIZE                  SPA-KYOTUKEY
                                           SPA-KYOTU-SET
           END-IF 
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
      ***  MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    SPA-SAKIPG          TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       210-BACK-EXT.
           EXIT.
      *    
      *****************************************************************
      *    クリア処理
      *****************************************************************
       220-CLEAR-SEC                   SECTION.
      *
           MOVE    SPACE               TO  WRK-HAISIYMDH
           MOVE    ZERO                TO  SPA-C02-IKOFLG
      *      
           IF      SPA-GMN-C02-BYOMEI  NOT =   SPACE      
               INITIALIZE               SPA-GMN-C02-KOUMOKU
                                        SPA-NAI-C02-KOUMOKU
                                        SPA-NAI-C02-SELNO
               MOVE    1                TO  SPA-GMN-C02-CUR
           ELSE                             
      *
      *        排他制御解除処理
               PERFORM 990-LOCK-OUT-SEC
      *
               INITIALIZE                  SPA-DEL-TBL
                                           SPA-DEL-C02-MAX
      *                              
                                           SPA-GMN-C02-KOUMOKU
                                           SPA-NAI-C02-KOUMOKU
                                           SPA-NAI-C02-SELNO
                                           SPA-C02-UPDFLG
                                           SPA-C02-IKOFLG
      *                              
                                           SPA-GMN-C02-TBL
                                           SPA-NAI-C02-TBL
                                           SPA-GMN-C02-MAX
                                           SPA-GMN-C02-SRYKA-G
      *
               IF      SPA-C02-MOTOPG      =   "K02"   OR  "U02"   OR
                                               "K02N"
                   MOVE    27              TO  SPA-GMN-C02-CUR
               ELSE                                     
                   INITIALIZE              SPA-GMN-C02-HEAD
                                           SPA-NAI-C02-HEAD
                                           SPA-GMN-C02-HKN-TBL
                                           SPA-NAI-C02-HKN-TBL
                                           SPA-GMN-C02-HKNCOMBILST-G
                                           SPA-GMN-C02-HKN-MAX
                                           SPA-GMN-C02-HKNCOMBI-MAX
                   MOVE    26              TO  SPA-GMN-C02-CUR
               END-IF
      *
               IF      SPA-GMN-C02-SRYKA-MAX   =   1 
                   MOVE    SPA-GMN-C02-SRYKALST (1)
                                           TO  SPA-GMN-C02-SRYKA-G
               END-IF                            
           END-IF                                    
      *
           .
       220-CLEAR-EXT.
           EXIT.
      *    
      *****************************************************************
      *    前回患者番号編集処理
      *****************************************************************
       230-MAEKPTNUM-SEC             SECTION.
      *
           IF      SPA-LAST-PTNUM      =   SPACE
               GO      TO      230-MAEKPTNUM-EXT
           END-IF
      *
           MOVE    SPA-LAST-PTNUM      TO  C02-PTNUM
           PERFORM 41015-PTNUM-CHK-SEC
      *
           .
       230-MAEKPTNUM-EXT.
           EXIT.
      *
      *****************************************************************
      *    追加　処理
      *****************************************************************
       420-TUIKA-SEC                SECTION.
      *
      *    患者番号・診療科が未入力のとき
           IF      SPA-NAI-C02-PTID    =   ZERO
           OR      SPA-GMN-C02-SRYKA   =   SPACE
               MOVE    "0050"              TO  SPA-ERRCD
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    変更処理のとき
           IF      SPA-GMN-C02-BANGO  >   ZERO
               MOVE    "0005"              TO  SPA-ERRCD
               GO  TO  420-TUIKA-EXT
           END-IF
      *
      *    病名コード再編集
      *
           INITIALIZE                  WRK-TANDOKU-AREA
      *            
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       6    
               INITIALIZE                    SPA-NAI-C02-BYOMEI-G(IDZ)
      *
               IF      SPA-GMN-C02-BYOMEICD(IDZ)
                                           NOT =   SPACE
                   MOVE    ZERO                TO  WRK-LENGTH                    
                   PERFORM VARYING IDX FROM    10  BY  -1
                           UNTIL   IDX <       1
                       IF      SPA-GMN-C02-BYOMEICD(IDZ)(IDX:1)
                                           NOT =   SPACE
                           MOVE    IDX             TO  WRK-LENGTH
                           MOVE    1               TO  IDX
                       END-IF
                   END-PERFORM    
      *                                         
      *            ７桁入力のときは病名マスタ、以外は自院病名マスタを読み込む
                   IF      WRK-LENGTH          =   7   
      *                病名マスタ読み込み
                       MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                               TO  BYO-BYOMEICD
                       PERFORM 410111-BYOMEI-HENSYU-SEC
                       MOVE    BYO-TANDOKUKBN  TO  WRK-TANDOKUKBN (IDZ)
                   ELSE       
      *                自院病名マスタ読み込み
                       INITIALIZE              USERBYOMEI-REC
                       MOVE    SPA-HOSPID      TO  USBYO-HOSPID
                       MOVE    SPA-GMN-C02-BYOMEICD(IDZ)
                                               TO  USBYO-BYOMEIINPUTCD
                       PERFORM 410112-USERBYOMEI-HENSYU-SEC
                   END-IF 
               END-IF       
           END-PERFORM
      *
      *    病名編集処理
      *****PERFORM 41021-BYOMEI-HENSYU-SEC
      *****PERFORM 41022-CHARTBYOMEI-HENSYU-SEC
      *
      *   入力病名コード数カウント
           PERFORM 410111-BYOMEICDSU-HENSYU-SEC
      *
      *    病名が未入力のとき
           IF      SPA-NAI-C02-BYOMEIMOJI   =   ZERO
               MOVE    "0010"               TO  SPA-ERRCD
               GO      TO      420-TUIKA-EXT
           END-IF
      *
      *    カルテ病名の半角チェック
           IF      SPA-GMN-C02-CHARTBYOMEI =   SPACE
               CONTINUE
           ELSE    
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    SPA-GMN-C02-CHARTBYOMEI
                                           TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "2"
                   CONTINUE
               ELSE
                   MOVE    "0071"              TO  SPA-ERRCD
                   MOVE    28                  TO  SPA-GMN-C02-CUR 
                   GO      TO      420-TUIKA-EXT
               END-IF
           END-IF    
      *
      *    最後の病名コードが接頭語のとき
           IF      SPA-NAI-C02-BYOMEIHENFLG    =   SPACE
               PERFORM VARYING IDZ FROM    6   BY  -1
                       UNTIL   IDZ <       1
                   IF      SPA-GMN-C02-BYOMEICD(IDZ)   NOT =   SPACE    
                       IF      SPA-GMN-C02-BYOMEICD (IDZ)(1:1) =   "Z"
                       AND     SPA-GMN-C02-BYOMEICD (IDZ)(4:1) 
                                                           NOT =   "8" 
                           MOVE    "0067"              TO  SPA-ERRCD
                           GO      TO      420-TUIKA-EXT
                       END-IF
                       MOVE    1               TO  IDZ     
                   END-IF
               END-PERFORM
           END-IF           
      *
      *    単独使用禁止の病名があるとき
           IF      SPA-NAI-C02-BYOMEIHENFLG    =   SPACE
               MOVE    ZERO                TO  IDX
               INITIALIZE                  WRK-TANDOKUKBN-BYOMEICD
                                           WRK-TANDOKUKBN-BYOMEI
               PERFORM VARYING IDZ FROM    1   BY  1
                       UNTIL   IDZ >       6
                 IF      SPA-GMN-C02-BYOMEICD (IDZ)  
                                   NOT =   SPACE
                   IF      SPA-NAI-C02-BYOMEITOP (IDZ) =   "1"
                   AND     IDZ                         >   1
                       IF      IDX                 =   ZERO
                       AND     WRK-TANDOKUKBN-BYOMEICD
                                               NOT =   SPACE
                           MOVE    "0076"              TO  SPA-ERRCD  
                           GO  TO  420-TUIKA-EXT
                       END-IF
                       MOVE    ZERO            TO  IDX
                       INITIALIZE              WRK-TANDOKUKBN-BYOMEICD
                                               WRK-TANDOKUKBN-BYOMEI
                   END-IF
                   IF      WRK-TANDOKUKBN (IDZ)    =   ZERO   
                       MOVE    1                   TO  IDX
                   ELSE
                       MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                           TO  WRK-TANDOKUKBN-BYOMEICD  
                       MOVE    SPA-NAI-C02-BYOMEI   (IDZ)
                                           TO  WRK-TANDOKUKBN-BYOMEI  
                   END-IF
                 END-IF     
               END-PERFORM
               IF      IDX                 =   ZERO
                   MOVE    "0076"              TO  SPA-ERRCD  
                   GO  TO  420-TUIKA-EXT
               END-IF
           END-IF    
      *     
      *    これ以上追加できないとき
           IF      SPA-GMN-C02-MAX      =   200
               MOVE    "0057"               TO  SPA-ERRCD
               GO      TO      420-TUIKA-EXT
           END-IF
      *
      *    複数病名がすべて追加できないとき
           COMPUTE IDX =   SPA-GMN-C02-MAX  +
                           SPA-NAI-C02-BYOMEICD-MAX
           IF      IDX                  >   200
               MOVE    "0057"               TO  SPA-ERRCD
               GO      TO      420-TUIKA-EXT
           END-IF
      *
           IF      SPA-GMN-C02-KOUMOKU(3:)  =   SPACE
               MOVE    "0008"               TO  SPA-ERRCD
               GO      TO      420-TUIKA-EXT
           END-IF
      *  
           IF      SPA-GMN-C02-SRYYMD   =   SPACE
      *********MOVE    SPA-SYSYMD       TO  SPA-NAI-C02-SRYYMD
               MOVE    SPA-NAI-C02-SYSYMD
                                        TO  SPA-NAI-C02-SRYYMD
           END-IF
      *
           COMPUTE IDY     =   SPA-GMN-C02-MAX  +   1
           PERFORM 4202-INTBL-CHK-SEC
           IF      SPA-ERRCD        NOT =   SPACE
              GO  TO  420-TUIKA-EXT
           END-IF
      *
           PERFORM 4204-USERBYOMEI-KOUSIN-SEC
           IF      SPA-ERRCD        NOT =   SPACE
              GO  TO  420-TUIKA-EXT
           END-IF
      *    
      ***     ADD     1                TO  SPA-GMN-C02-MAX
      ***     MOVE    SPA-GMN-C02-MAX      TO
      ***                          SPA-GMN-C02-TBANGO   (SPA-GMN-C02-MAX)
      *
           IF      SPA-GMN-C02-SRYYMD   =   SPACE
      *********MOVE    SPA-SYSYMDWH         TO  SPA-GMN-C02-SRYYMD
               MOVE    SPA-GMN-C02-SYSYMD   TO  SPA-GMN-C02-SRYYMD
           END-IF
      *     
           MOVE    SPA-GMN-C02-MAX          TO  IDX
           PERFORM 4201-INTBL-SET-SEC
      *
      *----(01.02.04) LINE ADD START ----------------------------------
      *        診療開始日別に並び替え
           PERFORM 4203-INTBL-SORT-SEC
      *----(01.02.04) LINE ADD END   ----------------------------------
      *
           MOVE    1                TO  SPA-GMN-C02-CUR  
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-C02-UPDFLG
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
           .
       420-TUIKA-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目重複チェック処理
      *****************************************************************
       4202-INTBL-CHK-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-ERRCD
      *　　病名編集
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    SPA-NAI-C02-BYOMEI(1)
                                           TO  WRK-BYOMEI
               PERFORM VARYING IDZ FROM    2   BY  1
                       UNTIL   IDZ >       6
                       OR      SPA-ERRCD   NOT =   SPACE
                   IF      SPA-NAI-C02-BYOMEITOP   (IDZ)   =   "1"
                       PERFORM 42021-DABURI-CHK-SEC
                       IF      SPA-ERRCD           =   SPACE
                           MOVE    SPACE               TO  WRK-BYOMEI
                       END-IF
                   END-IF    
                   STRING  WRK-BYOMEI              DELIMITED  BY  SPACE
                           SPA-NAI-C02-BYOMEI(IDZ) DELIMITED  BY  SPACE
                                  INTO          WRK-BYOMEI
                   END-STRING
               END-PERFORM
           ELSE
               MOVE    SPA-GMN-C02-BYOMEI       TO  WRK-BYOMEI
           END-IF        
      *         
           PERFORM 42021-DABURI-CHK-SEC
      *
           .
       4202-INTBL-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目重複チェック処理
      *****************************************************************
       42021-DABURI-CHK-SEC        SECTION.
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       200
                   OR      SPA-ERRCD       NOT =   SPACE
               IF      IDX         =   IDY 
                   CONTINUE
               ELSE
                   IF      SPA-NAI-C02-TSRYYMD (IDX)
                                           =   SPA-NAI-C02-SRYYMD
                   AND     SPA-GMN-C02-TBYOMEI (IDX)
                                           =   WRK-BYOMEI
                       MOVE    "0002"              TO  SPA-ERRCD
                       MOVE    200                  TO  IDX
                   ELSE
                       IF      SPA-GMN-C02-TBYOMEI (IDX)
                                               =   WRK-BYOMEI
                       AND     SPA-NAI-C02-TTENKIYMD(IDX)
                                               =   SPACE                             
                           MOVE    "0038"              TO  SPA-ERRCD
                           MOVE    200                 TO  IDX
                       END-IF    
                   END-IF
               END-IF
           END-PERFORM
           .                   
       42021-DABURI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    入力項目編集処理
      *****************************************************************
       4201-INTBL-SET-SEC                SECTION.
      *
           EVALUATE    SPA-NAI-C02-BYOMEICD-MAX
      *        病名だけのとき
               WHEN    ZERO
                   PERFORM 42011-TBLSET-SEC
      *        単独病名コードのとき
               WHEN    1
                   PERFORM VARYING IDZ FROM    1   BY  1
                           UNTIL   IDZ >       6
                       IF      SPA-GMN-C02-BYOMEICD (IDZ)  NOT =   SPACE        
                           IF      SPA-NAI-C02-USERBYOMEIFLG (IDZ)
                                                   =   "1"
                               PERFORM 42011-USERBYOMEI-TBLSET-SEC
                           ELSE
                               PERFORM 42011-TBLSET-SEC
                           END-IF    
                           MOVE    6               TO  IDZ
                      END-IF
                   END-PERFORM        
      *        複数病名コードのとき
               WHEN    OTHER
                   MOVE    1                   TO  IDZ
                   PERFORM UNTIL   IDZ >       6
                           OR      SPA-ERRCD   NOT =   SPACE
                       IF      SPA-GMN-C02-BYOMEICD (IDZ)  NOT =   SPACE
                           IF      SPA-NAI-C02-USERBYOMEIFLG (IDZ)
                                                   =   "1"
                               PERFORM 42011-USERBYOMEI-TBLSET-SEC
                           ELSE
                               MOVE    SPACE       TO  WRK-PTBYOMEI-REC
                               INITIALIZE              WRK-PTBYOMEI-REC
                               PERFORM 42012-BYOMEI-TBLSET-SEC
                               PERFORM UNTIL   IDZ >       6
                                       OR  SPA-NAI-C02-BYOMEITOP (IDZ)
                                                   =   "1"
                                       OR  SPA-ERRCD   NOT =   SPACE
                                   IF      SPA-GMN-C02-BYOMEICD (IDZ)
                                                          NOT =   SPACE
                                       PERFORM 42012-BYOMEI-TBLSET-SEC
                                   ELSE
                                       ADD     1       TO  IDZ    
                                   END-IF    
                               END-PERFORM    
                               PERFORM 42011-TBLSET-SEC
                           END-IF    
                       ELSE
                           ADD     1           TO  IDZ    
                       END-IF
                   END-PERFORM            
           END-EVALUATE
      *
           INITIALIZE               SPA-GMN-C02-KOUMOKU
                                    SPA-NAI-C02-KOUMOKU
                                    SPA-NAI-C02-SELNO
      *                              
           MOVE    SPACE            TO  WRK-HAISIYMDH                          
           .                   
       4201-INTBL-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名より編集処理
      *****************************************************************
       42011-USERBYOMEI-TBLSET-SEC      SECTION.
      *
           MOVE    SPACE           TO  WRK-PTBYOMEI-REC
           INITIALIZE                  WRK-PTBYOMEI-REC
      *     
           INITIALIZE              USERBYOMEI-REC
           MOVE    SPA-HOSPID  TO  USBYO-HOSPID
           MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                   TO  USBYO-BYOMEIINPUTCD
           PERFORM 900-USERBYOMEI-INV-SEC                            
           IF      FLG-USERBYOMEI      =   ZERO
               MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                           TO  WRK-PTBYO-BYOMEIINPUTCD
               MOVE    USBYO-BYOMEICDSU    TO  WRK-PTBYO-BYOMEICDSU
               MOVE    USBYO-BYOMEICD-G    TO  WRK-PTBYO-BYOMEICD-G
               MOVE    USBYO-UTAGAIFLG     TO  WRK-PTBYO-UTAGAIFLG
               MOVE    USBYO-MANSEIKBN     TO  WRK-PTBYO-MANSEIKBN
               MOVE    USBYO-BYOMEI        TO  WRK-PTBYO-BYOMEI
               MOVE    USBYO-BYOMEIMOJI    TO  WRK-PTBYO-BYOMEIMOJI
               MOVE    USBYO-CHARTBYOMEI   TO  WRK-PTBYO-CHARTBYOMEI
               MOVE    USBYO-CHARTBYOMEIMOJI
                                       TO  WRK-PTBYO-CHARTBYOMEIMOJI
               MOVE    USBYO-BYOMEIHENFLG  TO  WRK-PTBYO-BYOMEIHENFLG
               MOVE    USBYO-HKNBYOMEIFLG  TO  WRK-PTBYO-HKNBYOMEIFLG
           END-IF
      *     
           PERFORM 42011-TBLSET-SEC
      *
           ADD     1                       TO  IDZ     
           .
       42011-USERBYOMEI-TBLSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名より編集処理
      *****************************************************************
       42012-BYOMEI-TBLSET-SEC      SECTION.
      *
      *
           ADD     1                   TO  WRK-PTBYO-BYOMEICDSU
           MOVE    SPA-GMN-C02-BYOMEICD (IDZ)  TO
                            WRK-PTBYO-BYOMEICD (WRK-PTBYO-BYOMEICDSU)
      *                      
           STRING  WRK-PTBYO-BYOMEI        DELIMITED  BY  SPACE
                   SPA-NAI-C02-BYOMEI(IDZ) DELIMITED  BY  SPACE
                              INTO          WRK-PTBYO-BYOMEI
           END-STRING
           PERFORM VARYING IDY FROM    100 BY  -1
                   UNTIL   IDY <       1
               IF      WRK-PTBYO-BYOMEI (IDY:1)    NOT =   SPACE
                   COMPUTE WRK-PTBYO-BYOMEIMOJI
                                       =   IDY     /   2
                   MOVE    1               TO  IDY
               END-IF
           END-PERFORM                                
      *
           EVALUATE    SPA-NAI-C02-UTAGAIFLG   (IDZ)
               WHEN    "1"
                   IF      WRK-PTBYO-UTAGAIFLG   =   "2"
                       MOVE    "3"     TO  WRK-PTBYO-UTAGAIFLG
                   ELSE
                       MOVE    SPA-NAI-C02-UTAGAIFLG(IDZ)
                                       TO  WRK-PTBYO-UTAGAIFLG
                   END-IF    
               WHEN    "2"
                   IF      WRK-PTBYO-UTAGAIFLG   =   "1"
                       MOVE    "3"     TO  WRK-PTBYO-UTAGAIFLG
                    ELSE
                       MOVE    SPA-NAI-C02-UTAGAIFLG(IDZ)
                                       TO  WRK-PTBYO-UTAGAIFLG
                   END-IF
           END-EVALUATE
      *
           IF      SPA-NAI-C02-TOKSKNCD(IDZ)   NOT =   ZERO
           AND     WRK-PTBYO-MANSEIKBN             =   ZERO  
               MOVE    SPA-NAI-C02-TOKSKNCD (IDZ)
                                       TO  WRK-PTBYO-MANSEIKBN
           END-IF
      *
           ADD     1                   TO  IDZ         
           .                   
       42012-BYOMEI-TBLSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    病名別入力項目編集処理
      *****************************************************************
       42011-TBLSET-SEC                SECTION.
      *                
           EVALUATE   MCP-WIDGET
               WHEN    "B06"
                   ADD     1               TO  SPA-GMN-C02-MAX
                   MOVE    SPA-GMN-C02-MAX TO  IDX
           END-EVALUATE
      *                
           EVALUATE   MCP-WIDGET
               WHEN    "B06"
                   MOVE    1           TO  SPA-NAI-C02-TUPDFLG (IDX)
               WHEN    "B07"
                   IF      SPA-NAI-C02-TRENNUM (IDX)   =   ZERO
                       MOVE    1       TO  SPA-NAI-C02-TUPDFLG (IDX)
                   ELSE
                       MOVE    2       TO  SPA-NAI-C02-TUPDFLG (IDX)
                   END-IF
           END-EVALUATE
      *    
           MOVE    SPA-NAI-C02-SRYYMD   TO  WRK-SYMD
           PERFORM 5002-HIZUKE-HEN-SEC
           MOVE    WRK-HENYMDG          TO  SPA-GMN-C02-TSRYYMD (IDX)
           MOVE    SPA-NAI-C02-SRYYMD   TO  SPA-NAI-C02-TSRYYMD (IDX)
      *     
      *                              
           MOVE    SPA-GMN-C02-TENKIKBN
                                    TO  SPA-NAI-C02-TTENKIKBN  (IDX)
           MOVE    SPA-GMN-C02-TENKIKBNMEI
                                    TO  SPA-GMN-C02-TTENKIKBN  (IDX)
           MOVE    SPA-NAI-C02-TENKIYMD
                                    TO  SPA-NAI-C02-TTENKIYMD  (IDX)
           IF      SPA-NAI-C02-TENKIYMD NOT =   SPACE
               MOVE    SPA-NAI-C02-TENKIYMD TO  WRK-SYMD
               PERFORM 5002-HIZUKE-HEN-SEC
               MOVE    WRK-HENYMDG  TO  SPA-GMN-C02-TTENKIYMD  (IDX)
           ELSE
               MOVE    SPACE        TO  SPA-GMN-C02-TTENKIYMD  (IDX)
           END-IF
           MOVE    SPACE            TO  SPA-NAI-C02-TBYOMEICD-G(IDX)         
      *
      *    単独病名のみ画面より編集
      *
           IF      SPA-NAI-C02-BYOMEICD-MAX    =   1   OR  ZERO
               IF      SPA-NAI-C02-BYOMEICD-MAX    =   ZERO
                   MOVE    SPA-GMN-C02-BYOMEIINPUTCD
                                    TO  SPA-NAI-C02-TBYOMEIINPUTCD(IDX)
               ELSE
                   IF      SPA-NAI-C02-USERBYOMEIFLG (IDZ)   =   "1"
                       MOVE    WRK-PTBYO-BYOMEIINPUTCD
                                    TO  SPA-NAI-C02-TBYOMEIINPUTCD(IDX)
                       MOVE    WRK-PTBYO-BYOMEICDSU
                                    TO  SPA-NAI-C02-TBYOMEICDSU (IDX)
                       PERFORM VARYING IDY FROM    1   BY  1
                               UNTIL   IDY >       6
                           MOVE    WRK-PTBYO-BYOMEICD(IDY)
                                TO  SPA-NAI-C02-TBYOMEICD(IDX IDY)
                       END-PERFORM
      *****************MOVE    WRK-PTBYO-BYOMEIMOJI
      *                              TO  SPA-NAI-C02-TBYOMEIMOJI(IDX)
      *                 MOVE    WRK-PTBYO-BYOMEI
      *                              TO  SPA-GMN-C02-TBYOMEI    (IDX)
      *                 MOVE    WRK-PTBYO-CHARTBYOMEI
      *                              TO  SPA-NAI-C02-TCHARTBYOMEI(IDX)
      *                 MOVE    WRK-PTBYO-CHARTBYOMEIMOJI
      *                              TO
      ******************             SPA-NAI-C02-TCHARTBYOMEIMOJI(IDX)
                   ELSE
                       MOVE    ZERO                TO  IDW
                       PERFORM VARYING IDY FROM    1   BY  1
                               UNTIL   IDY >       6
                           IF      SPA-GMN-C02-BYOMEICD(IDY)
                                                   NOT =   SPACE
                               ADD     1               TO  IDW 
                               MOVE    SPA-GMN-C02-BYOMEICD(IDY)
                                    TO  SPA-NAI-C02-TBYOMEICD(IDX IDW)
                           END-IF             
                       END-PERFORM
                       MOVE    SPA-GMN-C02-BYOMEIINPUTCD
                                    TO  SPA-NAI-C02-TBYOMEIINPUTCD(IDX)
                   END-IF
               END-IF    
               MOVE    SPA-NAI-C02-BYOMEIMOJI
                                    TO  SPA-NAI-C02-TBYOMEIMOJI(IDX)
               MOVE    SPA-GMN-C02-BYOMEI
                                    TO  SPA-GMN-C02-TBYOMEI    (IDX)
               MOVE    SPA-GMN-C02-CHARTBYOMEI
                                    TO  SPA-NAI-C02-TCHARTBYOMEI(IDX)
               MOVE    SPA-NAI-C02-CHARTBYOMEIMOJI
                                    TO
                                    SPA-NAI-C02-TCHARTBYOMEIMOJI(IDX)
               MOVE    SPA-GMN-C02-UTAGAIFLG
                                    TO  SPA-NAI-C02-TUTAGAIFLG (IDX)
               MOVE    SPA-GMN-C02-UTAGAIFLGMEI
                                    TO  SPA-GMN-C02-TUTAGAIFLG (IDX)
               MOVE    SPA-GMN-C02-SYUBYOFLG
                                    TO  SPA-NAI-C02-TSYUBYOFLG (IDX)
               MOVE    SPA-GMN-C02-SYUBYOFLGMEI
                                    TO  SPA-GMN-C02-TSYUBYOFLG (IDX)
               IF      SPA-GMN-C02-MANSEIKBN  =   SPACE
                   MOVE    ZERO     TO  SPA-NAI-C02-TMANSEIKBN (IDX)
               ELSE                            
                   MOVE    SPA-GMN-C02-MANSEIKBN
                                    TO  SPA-NAI-C02-TMANSEIKBN (IDX)
               END-IF                     
               MOVE    SPA-GMN-C02-MANSEIKBN  TO  WRK-KBN
               PERFORM 5001-MANSEIKBN-HENSYU-SEC
               MOVE    WRK-KBNMEITAN
                                    TO  SPA-GMN-C02-TMANSEIKBN (IDX)
               MOVE    SPA-GMN-C02-NYUGAIKBN
                                    TO  SPA-NAI-C02-TNYUGAIKBN (IDX)
               MOVE    SPA-GMN-C02-NYUGAIKBNMEI
                                    TO  SPA-GMN-C02-TNYUGAIKBN (IDX)
               IF      SPA-GMN-C02-HKNCOMBI =   ZERO
                   MOVE    ZERO     TO  SPA-NAI-C02-THKNCOMBI  (IDX)
               ELSE                          
                   MOVE    SPA-GMN-C02-HKNCOMBI
                                    TO  SPA-NAI-C02-THKNCOMBI  (IDX)
               END-IF                     
               MOVE    SPA-GMN-C02-HKNCOMBIMEI
                                    TO  SPA-GMN-C02-THKNCOMBI  (IDX)
               MOVE    SPA-GMN-C02-REZEFLG
                                    TO  SPA-NAI-C02-TREZEFLG   (IDX)
               MOVE    SPA-GMN-C02-REZEFLGMEI
                                    TO  SPA-GMN-C02-TREZEFLG   (IDX)
               MOVE    SPA-GMN-C02-REZEMM
                                    TO  SPA-GMN-C02-TREZEMM    (IDX)
               MOVE    SPA-NAI-C02-BYOMEIHENFLG
                                    TO  SPA-NAI-C02-TBYOMEIHENFLG(IDX)
      *----(01.00.03) LINE ADD START ----------------------------------
               MOVE    SPA-GMN-C02-HKNBYOMEIFLG
                                    TO  SPA-NAI-C02-THKNBYOMEIFLG (IDX)
      *----(01.00.03) LINE ADD END   ----------------------------------
               MOVE    SPA-GMN-C02-HKNBYOMEIFLGMEI
                                    TO  SPA-GMN-C02-THKNBYOMEIFLG (IDX)
                                    
           ELSE
               MOVE    WRK-PTBYO-BYOMEIINPUTCD
                                    TO  SPA-NAI-C02-TBYOMEIINPUTCD(IDX)
               MOVE    WRK-PTBYO-BYOMEICDSU
                                    TO  SPA-NAI-C02-TBYOMEICDSU (IDX)
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       6
                   MOVE    WRK-PTBYO-BYOMEICD(IDY)
                                TO  SPA-NAI-C02-TBYOMEICD(IDX IDY)
               END-PERFORM
               MOVE    WRK-PTBYO-BYOMEIMOJI
                                    TO  SPA-NAI-C02-TBYOMEIMOJI(IDX)
               MOVE    WRK-PTBYO-BYOMEI
                                    TO  SPA-GMN-C02-TBYOMEI    (IDX)
               MOVE    WRK-PTBYO-CHARTBYOMEI
                                    TO  SPA-NAI-C02-TCHARTBYOMEI(IDX)
               MOVE    WRK-PTBYO-CHARTBYOMEIMOJI
                                    TO
                                    SPA-NAI-C02-TCHARTBYOMEIMOJI(IDX)
               MOVE    WRK-PTBYO-UTAGAIFLG
                                    TO  SPA-NAI-C02-TUTAGAIFLG (IDX)
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      5
                   IF      WRK-PTBYO-UTAGAIFLG
                                  =   SPA-GMN-C02-UTAGAIFLGL (IDY)
                       MOVE    SPA-GMN-C02-UTAGAIFLGMEIL (IDY)
                                      TO  SPA-GMN-C02-TUTAGAIFLG (IDX)
                       MOVE    5      TO  IDY
                   END-IF
               END-PERFORM
               MOVE    WRK-PTBYO-MANSEIKBN
                                    TO  SPA-NAI-C02-TMANSEIKBN (IDX)
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      5
                   IF      WRK-PTBYO-MANSEIKBN 
                                  =   SPA-GMN-C02-MANSEIKBNL (IDY)
                       MOVE    SPA-GMN-C02-MANSEIKBNTANL (IDY)
                                      TO  SPA-GMN-C02-TMANSEIKBN (IDX)
                       MOVE    5      TO  IDY
                   END-IF
               END-PERFORM
               MOVE    WRK-PTBYO-BYOMEIHENFLG
                                    TO  SPA-NAI-C02-TBYOMEIHENFLG(IDX)
               MOVE    WRK-PTBYO-HKNBYOMEIFLG
                                    TO  SPA-NAI-C02-THKNBYOMEIFLG (IDX)
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      5
                   IF      WRK-PTBYO-HKNBYOMEIFLG 
                                  =   SPA-GMN-C02-HKNBYOMEIFLGL (IDY)
                       MOVE    SPA-GMN-C02-HKNBYOMEIFLGMEIL (IDY)
                                      TO
                                      SPA-GMN-C02-THKNBYOMEIFLG (IDX)
                       MOVE    5      TO  IDY
                   END-IF
               END-PERFORM     
           END-IF
      *
          .
       42011-TBLSET-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療開始日別に並び替え処理
      *****************************************************************
       4203-INTBL-SORT-SEC         SECTION.
      *
           IF      SPA-GMN-C02-MAX             >   ZERO 
      *
               COMPUTE IDX1    =   SPA-GMN-C02-MAX -   1
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       IDX1
                   COMPUTE IDX2    =   IDX     +   1
                   PERFORM VARYING IDY FROM    IDX2    BY  1
                           UNTIL   IDY >       SPA-GMN-C02-MAX 
                       IF      SPA-NAI-C02-TKEY (IDX)   >
                                           SPA-NAI-C02-TKEY (IDY)
                           MOVE    SPA-GMN-C02-TBLO (IDX)
                                           TO  WRK-GMN-TBL
                           MOVE    SPA-GMN-C02-TBLO (IDY)
                                           TO  SPA-GMN-C02-TBLO (IDX)
                           MOVE    WRK-GMN-TBL
                                           TO  SPA-GMN-C02-TBLO (IDY)
                           MOVE    SPA-NAI-C02-TBLO (IDX)
                                           TO  WRK-NAI-TBL
                           MOVE    SPA-NAI-C02-TBLO (IDY)
                                           TO  SPA-NAI-C02-TBLO (IDX)
                           MOVE    WRK-NAI-TBL
                                           TO  SPA-NAI-C02-TBLO (IDY)
                       END-IF
                   END-PERFORM    
               END-PERFORM
      *
               PERFORM VARYING IDX FROM    1   BY  1
                       UNTIL   IDX >       SPA-GMN-C02-MAX
                   MOVE    IDX             TO  SPA-GMN-C02-TBANGO (IDX)
               END-PERFORM                 
           END-IF    
      *
          .
       4203-INTBL-SORT-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名マスタ更新処理
      *****************************************************************
       4204-USERBYOMEI-KOUSIN-SEC          SECTION.
      *
           IF      SPA-GMN-C02-BYOMEIINPUTCD
                                       =   SPACE
               GO  TO  4204-USERBYOMEI-KOUSIN-EXT
           END-IF
      *                                    
           INITIALIZE                  USERBYOMEI-REC
           MOVE    SPA-HOSPID          TO  USBYO-HOSPID
      *   
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI 
           MOVE    SPA-GMN-C02-BYOMEIINPUTCD
                                       TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
           IF      KANACHK-RC          =   ZERO
           AND     KANACHK-RC2         =   ZERO
      *****    IF      SPA-GMN-C02-BYOMEIINPUTCD(1:1)
      *****                                >=  X"A1"
               IF      KANACHK-SYUBETU     =   "2"    
                  MOVE    "J"               TO  USBYO-CDSYU
               ELSE
                  MOVE    "A"               TO  USBYO-CDSYU
               END-IF
           ELSE               
               MOVE    "1005"              TO  SPA-ERRCD
               DISPLAY "INS USERBYOMEI-KEY =>" USBYO-KEY 
               GO  TO  4204-USERBYOMEI-KOUSIN-EXT
           END-IF
      *     
           MOVE    SPA-GMN-C02-BYOMEIINPUTCD
                                       TO  USBYO-BYOMEIINPUTCD
      *
           MOVE    SPACE               TO  USBYO-BUNRUICD
           MOVE    50                  TO  USBYO-DSPSEQ
      *                                 
           MOVE    ZERO                TO  IDZ 
           MOVE    ZERO                TO  USBYO-BYOMEICDSU
           MOVE    SPACE               TO  USBYO-BYOMEICD-G
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL       IDY     >       6
               IF      SPA-GMN-C02-BYOMEICD (IDY) 
                                           NOT =   SPACE
                   ADD     1               TO  USBYO-BYOMEICDSU
                   ADD     1               TO  IDZ 
                   MOVE    SPA-GMN-C02-BYOMEICD (IDY)
                                           TO  USBYO-BYOMEICD (IDZ)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-C02-UTAGAIFLG   TO  USBYO-UTAGAIFLG
           MOVE    SPA-GMN-C02-MANSEIKBN   TO  USBYO-MANSEIKBN
           MOVE    SPA-GMN-C02-BYOMEI      TO  USBYO-BYOMEI
           MOVE    SPA-NAI-C02-BYOMEIMOJI  TO  USBYO-BYOMEIMOJI
           MOVE    SPA-GMN-C02-CHARTBYOMEI TO  USBYO-CHARTBYOMEI
           MOVE    SPA-NAI-C02-CHARTBYOMEIMOJI
                                           TO  USBYO-CHARTBYOMEIMOJI
           MOVE    SPA-NAI-C02-BYOMEIHENFLG 
                                           TO  USBYO-BYOMEIHENFLG
           MOVE    SPA-GMN-C02-HKNBYOMEIFLG
                                           TO  USBYO-HKNBYOMEIFLG
      *
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "DBINSERT"          TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY"    TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC          NOT =   ZERO 
               MOVE    "1005"              TO  SPA-ERRCD
               DISPLAY "INS USERBYOMEI-KEY =>" USBYO-KEY 
           END-IF
          .
       4204-USERBYOMEI-KOUSIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    変更前チェック処理
      *****************************************************************
       430-HENKOU-SEC              SECTION.
      *
      *    患者番号・診療科が未入力のとき      
           IF      SPA-NAI-C02-PTID    =   ZERO
           OR      SPA-GMN-C02-SRYKA   =   SPACE
               MOVE    "0050"              TO  SPA-ERRCD
               GO  TO  430-HENKOU-EXT
           END-IF
      *
      *    新規入力のとき
           IF      SPA-GMN-C02-BANGO  =   ZERO
               MOVE    "0004"              TO  SPA-ERRCD
               GO  TO  430-HENKOU-EXT
           END-IF
      *
      *    病名コード再編集
           INITIALIZE                  WRK-TANDOKU-AREA
      *            
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       6      
      *
               INITIALIZE                    SPA-NAI-C02-BYOMEI-G(IDZ)
      *
               IF      SPA-GMN-C02-BYOMEICD(IDZ)
                                           NOT =   SPACE
                   MOVE    ZERO                TO  WRK-LENGTH                    
                   PERFORM VARYING IDX FROM    10  BY  -1
                           UNTIL   IDX <       1
                       IF      SPA-GMN-C02-BYOMEICD(IDZ)(IDX:1)
                                           NOT =   SPACE
                           MOVE    IDX             TO  WRK-LENGTH
                           MOVE    1               TO  IDX
                       END-IF
                   END-PERFORM    
      *                                         
      *            ７桁入力のときは病名マスタ、以外は自院病名マスタを読み込む
                   IF      WRK-LENGTH          =   7   
      *                病名マスタ読み込み
                       MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                               TO  BYO-BYOMEICD
                       PERFORM 410111-BYOMEI-HENSYU-SEC
                       MOVE    BYO-TANDOKUKBN  TO  WRK-TANDOKUKBN (IDZ)
                       IF      SPA-C02-IKOFLG      =   1
                       AND     SPA-NAI-C02-BYOMEIHENFLG
                                                   =   SPACE
                           IF      SPA-GMN-C02-BYOMEICD (IDZ)(1:1)
                                                       =   "Z"
                               CONTINUE
                           ELSE        
                             IF      BYO-IKOSAKICD       =   SPACE
                                 IF      BYO-HAISIYMD        =   ALL "9"
                                                             OR  SPACE
                                     CONTINUE
                                 ELSE
                                     MOVE    BYO-HAISIYMD  TO  WRK-SYMD
                                     PERFORM 5002-HIZUKE-HEN-SEC
                                     MOVE    LNK-DAY2-EDTYMD3
                                                   TO  WRK-HAISIYMDH
                                 END-IF
                                 MOVE    SPACE     TO  WRK-HAISIYMDH
                             ELSE
                                 MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                           TO  SPA-C02-IKOMOTO-BYOMEICD
                                 MOVE    BYO-BYOMEI 
                                           TO  SPA-C02-IKOMOTO-BYOMEI
                                 MOVE    BYO-IKOSAKICD
                                           TO  BYO-BYOMEICD
                                 PERFORM 900-BYOMEI-READ-SEC
                                 IF      FLG-BYOMEI          =   ZERO
                                     MOVE    BYO-BYOMEICD    TO
                                               SPA-C02-IKOSAKI-BYOMEICD
                                     MOVE    BYO-BYOMEI      TO
                                               SPA-C02-IKOSAKI-BYOMEI
                                     MOVE    IDZ             TO
                                               SPA-C02-IKOSAKI-INDEX                    
                                     MOVE    "0106"      TO  SPA-CIDCD2
                                 END-IF
                             END-IF
                           END-IF  
                       END-IF   
                   ELSE       
      *                自院病名マスタ読み込み
                       INITIALIZE              USERBYOMEI-REC
                       MOVE    SPA-HOSPID      TO  USBYO-HOSPID
                       MOVE    SPA-GMN-C02-BYOMEICD(IDZ)
                                               TO  USBYO-BYOMEIINPUTCD
                       PERFORM 410112-USERBYOMEI-HENSYU-SEC
                   END-IF 
               END-IF       
           END-PERFORM
      *
      *    病名編集処理
      *****PERFORM 41021-BYOMEI-HENSYU-SEC
      *****PERFORM 41022-CHARTBYOMEI-HENSYU-SEC
      *
      *   入力病名コード数カウント
           PERFORM 410111-BYOMEICDSU-HENSYU-SEC
      *
      *    複数病名が入力されているとき
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0066"              TO  SPA-ERRCD
               GO  TO  430-HENKOU-EXT
           END-IF
      *
      *    病名が未入力のとき
           IF      SPA-NAI-C02-BYOMEIMOJI   =   ZERO
      ****?AND     SPA-GMN-C02-BYOMEICD-G   =   SPACE
               MOVE    "0010"               TO  SPA-ERRCD
               GO      TO      430-HENKOU-EXT
           END-IF
      *
      *    カルテ病名の半角チェック
           IF      SPA-GMN-C02-CHARTBYOMEI =   SPACE
               CONTINUE
           ELSE    
               INITIALIZE                  ORCSKANACHKAREA
               MOVE    "1"                 TO  KANACHK-SYORI 
               MOVE    SPA-GMN-C02-CHARTBYOMEI
                                           TO  KANACHK-MAE-INPUT
               CALL    "ORCSKANACHK"       USING   ORCSKANACHKAREA
               IF      KANACHK-RC          =   ZERO
               AND     KANACHK-SYUBETU     =   "2"
                   MOVE    KANACHK-OUT-INPUT   TO
                                           SPA-GMN-C02-CHARTBYOMEI
      ***********  CONTINUE
               ELSE
                   MOVE    "0071"              TO  SPA-ERRCD
                   MOVE    28                  TO  SPA-GMN-C02-CUR 
                   GO      TO      430-HENKOU-EXT
               END-IF
           END-IF    
      *
      *    単独使用禁止の病名があるとき
           IF      SPA-NAI-C02-BYOMEIHENFLG    =   SPACE
               MOVE    ZERO                TO  IDX
               PERFORM VARYING IDZ FROM    1   BY  1
                       UNTIL   IDZ >       6
                       OR      SPA-GMN-C02-BYOMEICD (IDZ)  
                                       =   SPACE
                   IF      WRK-TANDOKUKBN (IDZ)    =   ZERO   
                       MOVE    1                   TO  IDX
                   ELSE
                       MOVE    SPA-GMN-C02-BYOMEICD (IDZ)
                                           TO  WRK-TANDOKUKBN-BYOMEICD  
                       MOVE    SPA-NAI-C02-BYOMEI   (IDZ)
                                           TO  WRK-TANDOKUKBN-BYOMEI  
                   END-IF   
               END-PERFORM
               IF      IDX                 =   ZERO
                   MOVE    "0076"              TO  SPA-ERRCD  
                   GO  TO  430-HENKOU-EXT
               END-IF
           END-IF    
      *
      *    自院病名が変更されていたとき病名に移行があるとき
           IF      SPA-CIDCD2         NOT =   SPACE
              GO  TO  430-HENKOU-EXT
           END-IF
      *
           PERFORM 4301-HENKOU-SYORI-SEC     
      *
          .
       430-HENKOU-EXT.
           EXIT.
      *
      *****************************************************************
      *    変更処理
      *****************************************************************
       4301-HENKOU-SYORI-SEC             SECTION.
      *
      *    同一病名のチェック 
           MOVE    SPA-GMN-C02-BANGO  TO  IDY
      *
           PERFORM 4202-INTBL-CHK-SEC
           IF      SPA-ERRCD        NOT =   SPACE
              GO  TO  4301-HENKOU-SYORI-EXT
           END-IF
      *
           PERFORM 4204-USERBYOMEI-KOUSIN-SEC
           IF      SPA-ERRCD        NOT =   SPACE
              GO  TO  4301-HENKOU-SYORI-EXT
           END-IF
      *
           MOVE    SPA-GMN-C02-BANGO  TO  IDX
      *
      *    診療開始日が変更の時
           IF      SPA-NAI-C02-SRYYMD
                                   NOT =   SPA-NAI-C02-TSRYYMD (IDX)
               IF      SPA-NAI-C02-TRENNUM (IDX)  =   ZERO
                   CONTINUE
               ELSE
                   ADD     1           TO  SPA-DEL-C02-MAX
                   MOVE    SPA-DEL-C02-MAX
                                       TO  IDZ  
                   MOVE    SPA-NAI-C02-TSRYYMD (IDX)
                                       TO  SPA-DEL-TSRYYMD (IDZ)
                   MOVE    SPA-NAI-C02-TRENNUM (IDX)
                                       TO  SPA-DEL-TRENNUM (IDZ)
                   MOVE    ZERO        TO  SPA-NAI-C02-TRENNUM (IDX)
               END-IF 
           END-IF
      *
           PERFORM 4201-INTBL-SET-SEC
      *
      *----(01.02.04) LINE ADD START ----------------------------------
      *        診療開始日別に並び替え
           PERFORM 4203-INTBL-SORT-SEC
      *----(01.02.04) LINE ADD END   ----------------------------------
      *
           MOVE    ZERO                TO   SPA-NAI-C02-SELNO
      *
           MOVE    1                   TO  SPA-GMN-C02-CUR 
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-C02-UPDFLG
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
          .
       4301-HENKOU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    削除　処理
      *****************************************************************
       440-SAKUJYO-SEC             SECTION.
      *
           IF      SPA-NAI-C02-PTID    =   ZERO
           OR      SPA-GMN-C02-SRYKA   =   SPACE
               MOVE    "0050"              TO  SPA-ERRCD
               GO  TO  440-SAKUJYO-EXT
           END-IF
      *
           IF      SPA-GMN-C02-BANGO  =   ZERO
               MOVE    "0004"              TO  SPA-ERRCD
               GO  TO  440-SAKUJYO-EXT
           END-IF
      *
           MOVE    SPA-GMN-C02-BANGO  TO  IDX
      *
           IF      SPA-NAI-C02-TRENNUM (IDX)  =   ZERO
               CONTINUE
           ELSE
               ADD     1                   TO  SPA-DEL-C02-MAX
               MOVE    SPA-DEL-C02-MAX     TO  IDZ  
               MOVE    SPA-NAI-C02-TSRYYMD (IDX)
                                           TO  SPA-DEL-TSRYYMD (IDZ)
               MOVE    SPA-NAI-C02-TRENNUM (IDX)
                                           TO  SPA-DEL-TRENNUM (IDZ)
           END-IF 
      *
           INITIALIZE              SPA-GMN-C02-TBLO (IDX)
           INITIALIZE              SPA-NAI-C02-TBLO (IDX)
      *
           PERFORM VARYING     IDX1    FROM    IDX     BY  1
                   UNTIL       IDX1    =   SPA-GMN-C02-MAX
               COMPUTE IDX2    =   IDX1    +   1
               MOVE    SPA-GMN-C02-TBLO (IDX2) TO
                                               SPA-GMN-C02-TBLO  (IDX1)
               MOVE    SPA-NAI-C02-TBLO (IDX2) TO
                                               SPA-NAI-C02-TBLO  (IDX1)
               MOVE    IDX1                    TO
                                               SPA-GMN-C02-TBANGO(IDX1)
               INITIALIZE          SPA-GMN-C02-TBLO (IDX2)
               INITIALIZE          SPA-NAI-C02-TBLO (IDX2)
           END-PERFORM
      *
           COMPUTE SPA-GMN-C02-MAX     =   SPA-GMN-C02-MAX     -   1
      *
           INITIALIZE                  SPA-GMN-C02-KOUMOKU
                                       SPA-NAI-C02-KOUMOKU
                                        SPA-NAI-C02-SELNO 
      *
      *----(01.02.04) LINE ADD START ----------------------------------
      *        診療開始日別に並び替え
           PERFORM 4203-INTBL-SORT-SEC
      *----(01.02.04) LINE ADD END   ----------------------------------
      *
      *
           MOVE    1                   TO  SPA-GMN-C02-CUR  
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *    更新フラグセット
           MOVE    "1"                 TO  SPA-C02-UPDFLG
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
          .
       440-SAKUJYO-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録前処理
      *****************************************************************
       450-TOUROKU-SEC                SECTION.
      *----(01.00.01) LINE ADD START ----------------------------------
      *
           IF     (SPA-NAI-C02-PTID         =   ZERO  )
             OR   (SPA-GMN-C02-SRYKA        =   SPACE )
               MOVE    "0050"             TO  SPA-ERRCD
               GO  TO  450-TOUROKU-EXT
           END-IF
      *
           IF     (SPA-GMN-C02-BANGO       NOT =   ZERO  )
             OR   (SPA-GMN-C02-BYOMEICD-G  NOT =   SPACE )
               MOVE    "0051"             TO  SPA-ERRCD
               GO  TO  450-TOUROKU-EXT
           END-IF
      *
      *    主病名の存在チェック
           IF      SPA-C02-2005-SYUBYOHENFLG   =   ZERO
               CONTINUE
           ELSE
               IF      SPA-GMN-C02-MAX         >   1
                   MOVE    SPACE                   TO  WRK-CHKFLG    
                   PERFORM VARYING IDX FROM    1   BY  1
                          UNTIL   IDX >       SPA-GMN-C02-MAX
                          OR      WRK-CHKFLG   =   "1" 
                      IF      SPA-NAI-C02-TSYUBYOFLG (IDX)
                                                     =   "1"
                          MOVE    "1"                TO  WRK-CHKFLG
                      END-IF
                   END-PERFORM
                   IF      WRK-CHKFLG        =   SPACE
                       MOVE    "0102"            TO  SPA-CIDCD
                       GO  TO  450-TOUROKU-EXT
                   END-IF
               END-IF
           END-IF
      *
           PERFORM 4501-TOUROKU-SYORI-SEC         
           .
       450-TOUROKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録　処理
      *****************************************************************
       4501-TOUROKU-SYORI-SEC             SECTION.
      *
      *    更新済
           MOVE    SPACE            TO  SPA-C02-UPDFLG
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *    患者病名マスター削除
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-DEL-C02-MAX
               INITIALIZE                      PTBYO-KEY
               MOVE    SPA-HOSPID              TO  PTBYO-HOSPID
               MOVE    SPA-NAI-C02-PTID        TO  PTBYO-PTID
               MOVE    SPA-GMN-C02-SRYKA       TO  PTBYO-SRYKA
               MOVE    SPA-DEL-TSRYYMD (IDX)   TO  PTBYO-SRYYMD
               MOVE    SPA-DEL-TRENNUM (IDX)   TO  PTBYO-RENNUM 
               MOVE    PTBYOMEI-REC            TO  MCPDATA-REC
               MOVE    "DBDELETE"              TO  MCP-FUNC
               MOVE    "PTBYOMEI-KEY"          TO  ORC-DBPATH
               CALL    "ORCMCPSUB"          USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
      *
               IF      MCP-RC              NOT =   ZERO 
                   MOVE    "1002"                  TO  SPA-ERRCD
                   DISPLAY "PTBYOMEI-KEY =>" PTBYO-KEY 
                   GO  TO  4501-TOUROKU-SYORI-EXT
               END-IF
           END-PERFORM
      *
      *    患者病名マスター追加
      *
           IF      SPA-GMN-C02-MAX             >   ZERO 
      *
      *        診療開始日別に連番セット
               MOVE    1                       TO  IDX
               MOVE    ZERO                    TO  WRK-SRYYMD
                                                   WRK-RENNUM
               PERFORM     UNTIL       IDX     >   SPA-GMN-C02-MAX
                   IF      SPA-NAI-C02-TSRYYMD (IDX)
                                           NOT =   WRK-SRYYMD
                       MOVE    SPA-NAI-C02-TSRYYMD (IDX)
                                               TO  WRK-SRYYMD   
                       MOVE    ZERO            TO  WRK-RENNUM
                       IF      SPA-NAI-C02-TRENNUM (IDX)
                                                       =   ZERO 
                           INITIALIZE                  PTBYO-KEY
                           MOVE    SPA-HOSPID          TO  PTBYO-HOSPID
                           MOVE    SPA-NAI-C02-PTID    TO  PTBYO-PTID
                           MOVE    SPA-GMN-C02-SRYKA   TO  PTBYO-SRYKA
                           MOVE    SPA-NAI-C02-TSRYYMD (IDX)
                                                       TO  PTBYO-SRYYMD
                           MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
                           MOVE    "PTBYOMEI-KEY7"     TO  WRK-DBPATH
                           PERFORM 900-PTBYO-INV-SEC
                           IF      FLG-PTBYOMEI        =   ZERO
                               MOVE    PTBYO-RENNUM    TO  WRK-RENNUM
                           END-IF
                       END-IF
                   END-IF
                   IF      SPA-NAI-C02-TRENNUM (IDX)
                                                   =   ZERO 
                       ADD     1               TO  WRK-RENNUM
                       MOVE    WRK-RENNUM      TO
                                           SPA-NAI-C02-TRENNUM (IDX)
                   END-IF
                   ADD     1                   TO  IDX
               END-PERFORM               
                          
               MOVE    SPACE               TO  WRK-TENKIKBN
      *
               PERFORM VARYING     IDX     FROM    1   BY  1
                       UNTIL       IDX     >       SPA-GMN-C02-MAX
      *
                   IF      SPA-NAI-C02-TTENKIKBN (IDX) =   "2"
                       MOVE    "2"                 TO  WRK-TENKIKBN
                   END-IF
      * 
                   EVALUATE    SPA-NAI-C02-TUPDFLG (IDX)
                     WHEN    ZERO
                       CONTINUE
                     WHEN    1     
                       INITIALIZE              PTBYOMEI-REC
                       MOVE    SPA-HOSPID          TO  PTBYO-HOSPID
                       MOVE    SPA-NAI-C02-PTID    TO  PTBYO-PTID
                       MOVE    SPA-GMN-C02-SRYKA   TO  PTBYO-SRYKA
                       MOVE    SPA-NAI-C02-TRENNUM(IDX)
                                                   TO  PTBYO-RENNUM
                       MOVE    SPA-NAI-C02-TSRYYMD(IDX)
                                                   TO  PTBYO-SRYYMD
                       PERFORM 4501-PTBYOMEI-HENSYU-SEC
      *
                       MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
                       MOVE    "DBINSERT"          TO  MCP-FUNC
                       MOVE    "PTBYOMEI-KEY"      TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"         USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
                       IF      MCP-RC          NOT =   ZERO 
                           MOVE    "1001"              TO  SPA-ERRCD
                           DISPLAY "INS PTBYOMEI-KEY =>" PTBYO-KEY 
                           GO  TO  4501-TOUROKU-SYORI-EXT
                       END-IF
                     WHEN    2
                       INITIALIZE                  PTBYO-KEY
                       MOVE    SPA-HOSPID          TO  PTBYO-HOSPID
                       MOVE    SPA-NAI-C02-PTID    TO  PTBYO-PTID
                       MOVE    SPA-GMN-C02-SRYKA   TO  PTBYO-SRYKA
                       MOVE    SPA-NAI-C02-TSRYYMD (IDX)
                                                   TO  PTBYO-SRYYMD
                       MOVE    SPA-NAI-C02-TRENNUM (IDX)
                                                   TO  PTBYO-RENNUM 
                       MOVE    "PTBYOMEI-KEY"      TO  WRK-DBPATH
                       PERFORM 900-PTBYO-INV-SEC
                       IF      FLG-PTBYOMEI        =   1
                           MOVE    "1003"          TO  SPA-ERRCD
                           DISPLAY "INV PTBYOMEI-KEY =>" PTBYO-KEY 
                           GO  TO  4501-TOUROKU-SYORI-EXT
                       END-IF
                       PERFORM 4501-PTBYOMEI-HENSYU-SEC
                       MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
                       MOVE    "DBUPDATE"          TO  MCP-FUNC
                       MOVE    "PTBYOMEI-KEY"      TO  ORC-DBPATH
                       CALL    "ORCMCPSUB"         USING
                                                   MCPAREA
                                                   ORCMCPAREA
                                                   MCPDATA-REC
                       IF      MCP-RC          NOT =   ZERO 
                           MOVE    "1001"              TO  SPA-ERRCD
                           DISPLAY "UPD PTBYOMEI-KEY =>" PTBYO-KEY 
                           GO  TO  4501-TOUROKU-SYORI-EXT
                       END-IF
                   END-EVALUATE
               END-PERFORM
      *
      *    患者マスタ更新・転帰区分２のとき
               IF      WRK-TENKIKBN        =   "2"
                 MOVE    SPA-HOSPID          TO  PTINF-HOSPID
                 MOVE    SPA-NAI-C02-PTID    TO  PTINF-PTID
                 PERFORM 900-PTINF-READ-SEC
                 IF      FLG-PTINF               =   ZERO
                   MOVE    MCPDATA-REC         TO  PTINF-REC
                   MOVE    "1"                 TO  PTINF-DEATHKBN 
                   MOVE    PTINF-REC           TO  MCPDATA-REC
                   MOVE    "DBUPDATE"          TO  MCP-FUNC
                   MOVE    "PTINF-KEY"         TO  ORC-DBPATH
                   CALL    "ORCMCPSUB"         USING
                                               MCPAREA
                                               ORCMCPAREA
                                               MCPDATA-REC
                   IF      MCP-RC          NOT =   ZERO 
                       MOVE    "1004"              TO  SPA-ERRCD
                       DISPLAY "UPD PTINF-KEY =>" PTINF-KEY 
                       GO  TO  4501-TOUROKU-SYORI-EXT
                   END-IF
                 END-IF
               END-IF
           END-IF     
      *
      *    排他制御解除処理
           PERFORM 990-LOCK-OUT-SEC
      *
           INITIALIZE                  SPA-DEL-TBL
                                       SPA-DEL-C02-MAX
      *                              
                                       SPA-GMN-C02-KOUMOKU
                                       SPA-NAI-C02-KOUMOKU
                                       SPA-NAI-C02-SELNO
                                       SPA-C02-UPDFLG
                                       SPA-C02-IKOFLG
      *                              
                                       SPA-GMN-C02-TBL
                                       SPA-NAI-C02-TBL
                                       SPA-GMN-C02-MAX
      *
           IF    ( SPA-C02-MOTOPG      =   "K02"   OR  "U02" 
                                                   OR  "K02N")
           AND   ( SPA-PTNUM       NOT =   SPACE             )
      *****     INITIALIZE                  SPA-GMN-C02-SRYKA-G
      *****     MOVE    27                  TO  SPA-GMN-C02-CUR
                IF      SPA-CIDCD           =   "0102"
                    MOVE    SPACE               TO  SPA-CIDCD
                    MOVE    "JOIN"              TO  MCP-PUTTYPE
                ELSE 
                    MOVE    "CHANGE"            TO  MCP-PUTTYPE
                END-IF    
                PERFORM 210-BACK
           ELSE                                     
               INITIALIZE                  SPA-GMN-C02-HEAD
                                           SPA-NAI-C02-HEAD
                                           SPA-GMN-C02-HKN-TBL
                                           SPA-NAI-C02-HKN-TBL
                                           SPA-GMN-C02-HKNCOMBILST-G
                                           SPA-GMN-C02-HKN-MAX
                                           SPA-GMN-C02-HKNCOMBI-MAX
               IF      SPA-GMN-C02-SRYKA-MAX   >   1
                   MOVE    SPACE           TO  SPA-GMN-C02-SRYKA-G
               END-IF                                
               MOVE    26                  TO  SPA-GMN-C02-CUR
           END-IF                                
           .
       4501-TOUROKU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    登録　処理
      *****************************************************************
       4501-PTBYOMEI-HENSYU-SEC                SECTION.
      *
           MOVE    SPA-GMN-C02-TBYOMEI(IDX)
                                       TO  PTBYO-BYOMEI
      *----(01.02.06) LINE ADD START ----------------------------------
           MOVE    SPACE               TO  PTBYO-KHNBYOMEICD
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL       IDY     >       6
                   OR      PTBYO-KHNBYOMEICD   NOT =   SPACE
               IF      SPA-NAI-C02-TBYOMEICD (IDX IDY) 
                                               NOT =   SPACE
               AND     SPA-NAI-C02-TBYOMEICD (IDX IDY)(1:1)
                                               NOT =   "Z"     
                   MOVE    SPA-NAI-C02-TBYOMEICD (IDX IDY)
                                                  TO  PTBYO-KHNBYOMEICD
               END-IF
           END-PERFORM                                       
      *----(01.02.06) LINE ADD end   ----------------------------------
           MOVE    SPACE               TO  PTBYO-BYOMEICD-G
           MOVE    ZERO                TO  IDZ 
           PERFORM VARYING     IDY    FROM    1   BY  1
                   UNTIL       IDY    >       6
               IF      SPA-NAI-C02-TBYOMEICD (IDX IDY) 
                                              NOT =   SPACE
                   ADD     1                  TO  IDZ 
                   MOVE    SPA-NAI-C02-TBYOMEICD (IDX IDY)
                                              TO  PTBYO-BYOMEICD (IDZ)
               END-IF
           END-PERFORM
           MOVE    SPA-NAI-C02-TBYOMEIHENFLG  (IDX)
                                       TO  PTBYO-BYOMEIHENFLG
           MOVE    SPA-NAI-C02-TBYOMEIMOJI    (IDX)
                                       TO  PTBYO-BYOMEIMOJI
      *
           MOVE    SPA-NAI-C02-TUTAGAIFLG (IDX)
                                           TO  PTBYO-UTAGAIFLG
           MOVE    SPA-NAI-C02-TSYUBYOFLG (IDX)
                                           TO  PTBYO-SYUBYOFLG
           MOVE    SPA-NAI-C02-TMANSEIKBN (IDX)
                                           TO  PTBYO-MANSEIKBN
           MOVE    SPA-NAI-C02-TNYUGAIKBN (IDX)
                                           TO  PTBYO-NYUGAIKBN
           MOVE    SPA-NAI-C02-THKNCOMBI  (IDX)
                                           TO  PTBYO-HKNCOMBI
           MOVE    SPA-NAI-C02-TREZEFLG   (IDX)
                                           TO  PTBYO-REZEFLG
           MOVE    SPA-GMN-C02-TREZEMM    (IDX)
                                           TO  PTBYO-REZEMM
           MOVE    SPA-NAI-C02-TTENKIKBN  (IDX)
                                           TO  PTBYO-TENKIKBN
           MOVE    SPA-NAI-C02-TTENKIYMD  (IDX)
                                           TO  PTBYO-TENKIYMD
           MOVE    SPA-NAI-C02-TBYOMEIINPUTCD  (IDX)
                                           TO  PTBYO-BYOMEIINPUTCD
           MOVE    SPA-NAI-C02-TBYOMEICDSU (IDX)
                                           TO  PTBYO-BYOMEICDSU
           MOVE    SPA-NAI-C02-TCHARTBYOMEI(IDX)
                                           TO  PTBYO-CHARTBYOMEI
           MOVE    SPA-NAI-C02-TCHARTBYOMEIMOJI(IDX)
                                           TO  PTBYO-CHARTBYOMEIMOJI
      *----(01.00.03) LINE ADD START ----------------------------------
           MOVE    SPA-NAI-C02-THKNBYOMEIFLG  (IDX)
                                           TO  PTBYO-HKNBYOMEIFLG
      *----(01.00.03) LINE ADD END   ----------------------------------
           .
       4501-PTBYOMEI-HENSYU-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    病名検索へ
      *****************************************************************
       600-C05-SYORI-SEC           SECTION.
      *
           IF      SPA-NAI-C02-PTID    =   ZERO
           OR      SPA-GMN-C02-SRYKA   =   SPACE
           OR      SPA-GMN-C02-CUR     =   27  OR  26
               MOVE    "0050"              TO  SPA-ERRCD
               GO  TO  600-C05-SYORI-EXT
           END-IF
      *     
           IF      SPA-NAI-C02-BYOMEICD-MAX    >   1
               MOVE    "0058"              TO  SPA-ERRCD
               GO  TO  600-C05-SYORI-EXT
           END-IF
      *     
           IF      SPA-NAI-C02-USERBYOMEIFLG (1)   =  "1"
               MOVE    "0065"              TO  SPA-ERRCD
               GO  TO  600-C05-SYORI-EXT
           END-IF
      *
      *    画面移行用のパラメタ変更
      *    受付と患者検索以外の元をセット
           MOVE    "C05"               TO  SPA-SAKIPG
      *
           INITIALIZE                  SPA-C01KYOUTU
           MOVE    "C02"               TO  SPA-C01-MOTOPG
           MOVE    ZERO                TO  IDY
      * 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-GMN-C02-BYOMEICD (IDX)  NOT =   SPACE
                   ADD     1               TO  IDY              
                   MOVE    SPA-GMN-C02-BYOMEICD (IDX)
                                           TO  SPA-C01-TBYOMEICD (IDY)
                   MOVE    SPA-NAI-C02-BYOMEI   (IDX)
                                           TO  SPA-C01-TBYOMEI   (IDY)
               END-IF                              
           END-PERFORM 
      *
           MOVE    SPA-C01KYOUTU       TO  SPA-WORK
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "C05    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
      *
           .
       600-C05-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名登録へ
      *****************************************************************
       600-C03-SYORI-SEC           SECTION.
      *
      *    画面移行用のパラメタ変更
      *    受付と患者検索以外の元をセット
           MOVE    "C02"               TO  SPA-MOTOPG
           MOVE    "C03"               TO  SPA-SAKIPG
           INITIALIZE                  SPA-C01KYOUTU
           MOVE    SPA-C01KYOUTU       TO  SPA-WORK
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "C03    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
      *
           .
       600-C03-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    コメント画面へ
      *****************************************************************
       430-FREEMSG-SEC              SECTION.
      *
      *    剤修正のチェック
           IF      SPA-GMN-C02-BANGO   NOT =   ZERO
               MOVE    "0073"          TO  SPA-ERRCD
               GO      TO      430-FREEMSG-EXT
           END-IF
      *
           MOVE    SPACE               TO  SPA-MOTOPG
           INITIALIZE                  SPA-C01KYOUTU
           MOVE    SPA-C01KYOUTU       TO  SPA-WORK
           MOVE    SPA-AREA            TO  SPA-COMMON
           MOVE    SPA-C02FREE         TO  SPA-FREE
      *
           MOVE    "LINK"              TO  MCP-STATUS
           MOVE    SPACE               TO  MCP-EVENT
      *
           CALL    "ORCGC07"           USING
                                       MCPAREA
                                       SPAAREA
                                       LINKAREA
                                       SCRAREA.
      *
           MOVE    SPA-COMMON      TO  SPA-AREA
           MOVE    SPA-WORK        TO  SPA-C01KYOUTU
           MOVE    SPA-FREE        TO  SPA-C02FREE
      *
      *    カーソル移動
           MOVE    "COMMENT"           TO  MCP-WIDGET
      *
           MOVE    "C02"               TO  SPA-MOTOPG
           MOVE    "C07"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "C07"               TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       430-FREEMSG-EXT.
           EXIT.
      *
      *****************************************************************
      *    氏名検索へ
      *****************************************************************
       480-KENSAKU-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-C02             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "C02"               TO  SPA-MOTOPG
           MOVE    "P97"               TO  SPA-SAKIPG
      *
      *    氏名をクリアする
           MOVE    SPACE               TO  SPA-NAME
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE    "CHANGE"            TO  MCP-PUTTYPE
           MOVE    "P97"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                   TO  FLG-END
      *
           .
       480-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    予約登録へ
      *****************************************************************
       480-YOYAKU-SEC             SECTION.
      *
      *    戻り時、画面を元へ戻す
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-C02             TO  LNK-SCRSPA
      *    画面移行用のパラメタ変更
           MOVE    "C02"               TO  SPA-MOTOPG
           MOVE    "Y01"               TO  SPA-SAKIPG
           MOVE    "C02"               TO  SPA-MOTOPG3
      *     
           INITIALIZE                  SPA-KYOTUKEY
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE.
           MOVE   "Y01    "            TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
           .
       480-YOYAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    受付一覧へ
      *****************************************************************
       490-UKEICHI-SEC             SECTION.
      *
           MOVE    SPACE               TO  LINKAREA
           MOVE    SPA-KYOUTU          TO  LNK-COMMON
           MOVE    SPA-C02             TO  LNK-SCRSPA
      *
      *    画面移行用のパラメタ変更
           MOVE    "C02"               TO  SPA-MOTOPG
           MOVE    "U01"               TO  SPA-SAKIPG
           MOVE    SPA-KYOUTU          TO  LNK-KYOUTU
      *
           MOVE   "CHANGE"             TO  MCP-PUTTYPE
           MOVE   "U01    "            TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       490-UKEICHI-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名検索画面編集処理
      *****************************************************************
       490-USERBYOMEI-KENSAKU-SEC      SECTION.
      *
           IF      SPA-NAI-C02-PTID    =   ZERO
           OR      SPA-GMN-C02-SRYKA   =   SPACE
           OR      SPA-GMN-C02-CUR     =   27  OR  26
               MOVE    "0050"              TO  SPA-ERRCD
               GO  TO  490-USERBYOMEI-KENSAKU-EXT
           END-IF
      *     
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-NAI-C02-BYOMEITOP (IDX)      =   "1"
               AND     SPA-NAI-C02-USERBYOMEIFLG (IDX)  =   SPACE            
                   MOVE    "0069"              TO  SPA-ERRCD
                   GO  TO  490-USERBYOMEI-KENSAKU-EXT 
               END-IF
           END-PERFORM
      *
           INITIALIZE                  SPA-C01KYOUTU
           MOVE    "C02"               TO  SPA-C01-MOTOPG
           MOVE    ZERO                TO  IDY
      * 
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       6
               IF      SPA-GMN-C02-BYOMEICD (IDX)  NOT =   SPACE
                   ADD     1               TO  IDY              
                   MOVE    SPA-GMN-C02-BYOMEICD (IDX)
                                           TO  SPA-C01-TBYOMEICD (IDY)
                   MOVE    SPA-NAI-C02-BYOMEI   (IDX)
                                           TO  SPA-C01-TBYOMEI   (IDY)
               END-IF                              
           END-PERFORM 
      *
           MOVE    SPA-C01KYOUTU       TO  SPA-WORK
      *
      *    検索画面スパ編集処理     
           INITIALIZE              SPA-C04
      *
           PERFORM VARYING IDX     FROM    1   BY  1
                   UNTIL   IDX     >       6
                   OR      SPA-C01-TBYOMEICD(IDX)  =   SPACE
               MOVE    SPA-C01-TBYOMEICD(IDX)
                                       TO  SPA-GMN-C04-INPUTCD(IDX)
               MOVE    SPA-C01-TBYOMEI  (IDX)
                                       TO  SPA-NAI-C04-BYOMEI (IDX)  
               ADD     1               TO  SPA-NAI-C04-BYOMEICD-MAX                            
           END-PERFORM
      *
      *    病名編集 
           MOVE    SPA-NAI-C04-BYOMEI (1)  TO  WRK-BYOMEI
      *     
           PERFORM VARYING IDX FROM    2   BY  1
                   UNTIL   IDX >       6
               IF      SPA-GMN-C04-INPUTCD (IDX)   NOT =   SPACE
                   STRING  WRK-BYOMEI              DELIMITED  BY  SPACE
                           "／"                    DELIMITED  BY  SIZE
                           SPA-NAI-C04-BYOMEI(IDX) DELIMITED  BY  SPACE
                                  INTO             WRK-BYOMEI
               END-IF    
           END-PERFORM    
           MOVE    WRK-BYOMEI          TO  SPA-GMN-C04-BYOMEI
      *
      *    分類一覧編集
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDY
      *
           INITIALIZE                  USERBYOMEI-REC
           MOVE    SPA-HOSPID          TO  USBYO-HOSPID
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY4"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "USERBYOMEI-KEY4"   TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           ELSE
               INITIALIZE                  USERBYOMEI-REC
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
      *
           PERFORM UNTIL       (FLG-USERBYOMEI   =   1    )  OR
                               (IDX              >=  100  )
      *
               ADD     1               TO  IDX
               IF      USBYO-BYOMEIINPUTCD NOT =   SPACE
                   MOVE    USBYO-BYOMEIINPUTCD(1:3)
                                       TO  SPA-GMN-C04-BBUNRUICD (IDX)
               END-IF                            
               MOVE    USBYO-BYOMEI    TO  SPA-GMN-C04-BBUNRUIMEI(IDX)
      *
               MOVE    "USERBYOMEI-KEY4"
                                       TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           END-PERFORM
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY4"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    IDX                 TO  SPA-GMN-C04-BUNRUI-MAX
      *
      *    自院病名一覧編集
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDY
      *
           INITIALIZE                  USERBYOMEI-REC
           MOVE    SPA-HOSPID          TO  USBYO-HOSPID
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY3"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "USERBYOMEI-KEY3"   TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           ELSE
               INITIALIZE                  USERBYOMEI-REC
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
      *
           PERFORM UNTIL   (FLG-USERBYOMEI   =   1               )  OR
                           (IDX              >=  WRK-CONS-C04-MAX)
      *
               ADD     1               TO  IDX
              MOVE    IDX              TO  SPA-GMN-C04-TBANGO  (IDX)
               MOVE    USBYO-BYOMEIINPUTCD
                                       TO  SPA-GMN-C04-TINPUTCD(IDX)
               MOVE    USBYO-BYOMEI    TO  SPA-GMN-C04-TBYOMEI (IDX)
      *
               MOVE    "USERBYOMEI-KEY3"
                                       TO  ORC-DBPATH
               PERFORM 900-USBYO-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY3"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           MOVE    IDX                 TO  SPA-GMN-C04-MAX
      *
      *    画面表示
           MOVE    SPACE               TO  C04
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-C04-MAX
               MOVE    SPA-GMN-C04-TBANGO    (IDX)
                                           TO  WRK-NUM
               MOVE    WRK-NUM             TO  C04-TBANGO    (IDX)
               MOVE    SPA-GMN-C04-TINPUTCD(IDX)
                                           TO  C04-TBYOMEIINPUTCD(IDX)
               MOVE    SPA-GMN-C04-TBYOMEI    (IDX)
                                           TO  C04-TBYOMEI   (IDX)
           END-PERFORM
           MOVE    SPA-GMN-C04-MAX     TO  C04-BYOMEILST-COUNT
      *
           MOVE    SPA-GMN-C04-KENBYOMEI   TO  C04-KENBYOMEI
           MOVE    SPA-GMN-C04-SELNUM1     TO  C04-SELNUM1
           MOVE    SPA-GMN-C04-SELNUM2     TO  C04-SELNUM2
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL       IDX     >      6
               MOVE    SPA-GMN-C04-INPUTCD(IDX)   TO  C04-INPUTCD (IDX)
           END-PERFORM
           MOVE    SPA-GMN-C04-BYOMEI      TO  C04-BYOMEI
      *
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL   IDX >       SPA-GMN-C04-BUNRUI-MAX
               MOVE    SPA-GMN-C04-BBUNRUICD (IDX)
                                           TO  C04-BBUNRUICD (IDX)
               MOVE    SPA-GMN-C04-BBUNRUIMEI(IDX)
                                           TO  C04-BBUNRUIMEI(IDX)
      *        
               IF      IDX             =   SPA-NAI-C04-SELNUM1
                   MOVE    "T"         TO  C04-BUNRUI-SELECT (IDX)
               ELSE
                   MOVE    "F"         TO  C04-BUNRUI-SELECT (IDX)
               END-IF
           END-PERFORM    
           MOVE    SPA-GMN-C04-BUNRUI-MAX  TO  C04-BUNRUI-COUNT
      *
           MOVE    "SELNUM2"            TO  MCP-WIDGET
      *
           MOVE    "C02"                TO  SPA-MOTOPG
           MOVE    "C04"                TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "C04"                TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
           .
       490-USERBYOMEI-KENSAKU-EXT.
           EXIT.
      *
      *****************************************************************
      *    疑いフラグ編集処理
      *****************************************************************
       5001-UTAGAIFLG-HENSYU-SEC       SECTION.
      * 
           MOVE    SPACE              TO  WRK-KBNMEI
      *     
           IF      WRK-KBN             =   SPACE
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-C02-UTAGAIFLG-MAX
                   IF      WRK-KBN (1:1) 
                                  =   SPA-GMN-C02-UTAGAIFLGL (IDY)
                       MOVE    SPA-GMN-C02-UTAGAIFLGMEIL (IDY)
                                          TO  WRK-KBNMEI
                       MOVE    SPA-GMN-C02-UTAGAIFLG-MAX
                                          TO  IDY
                   END-IF
               END-PERFORM
           END-IF
      *
           .
       5001-UTAGAIFLG-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    慢性フラグ編集処理
      *****************************************************************
       5001-MANSEIKBN-HENSYU-SEC       SECTION.
      * 
           MOVE    SPACE              TO  WRK-KBNMEI
                                          WRK-KBNMEITAN
      *     
           IF      WRK-KBN (1:2)      =   SPACE   OR  ZERO
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-C02-MANSEIKBN-MAX
                   IF      WRK-KBN (1:2)
                                  =   SPA-GMN-C02-MANSEIKBNL (IDY)
                       MOVE    SPA-GMN-C02-MANSEIKBNMEIL (IDY)
                                          TO  WRK-KBNMEI
                       MOVE    SPA-GMN-C02-MANSEIKBNTANL(IDY)
                                          TO  WRK-KBNMEITAN                   
                       MOVE    SPA-GMN-C02-MANSEIKBN-MAX
                                          TO  IDY
                   END-IF
               END-PERFORM
           END-IF
      *
           .
       5001-MANSEIKBN-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    転帰区分編集処理
      *****************************************************************
       5001-TENKIKBN-HENSYU-SEC       SECTION.
      * 
           MOVE    SPACE              TO  WRK-KBNMEI
      *     
           IF      WRK-KBN  =   SPACE   
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-C02-TENKIKBN-MAX
                   IF      WRK-KBN (1:1)
                                      =   SPA-GMN-C02-TENKIKBNL (IDY)
                       MOVE    SPA-GMN-C02-TENKIKBNMEIL (IDY)
                                          TO  WRK-KBNMEI
                       MOVE    SPA-GMN-C02-TENKIKBN-MAX
                                          TO  IDY
                   END-IF
               END-PERFORM
           END-IF    
      *
           .
       5001-TENKIKBN-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    主病フラグ編集処理
      *****************************************************************
       5001-SYUBYOFLG-HENSYU-SEC       SECTION.
      * 
           MOVE    SPACE              TO  WRK-KBNMEI
      *     
           IF      WRK-KBN            =   SPACE   
               CONTINUE
           ELSE
               PERFORM VARYING IDY FROM   1   BY  1
                       UNTIL   IDY >      SPA-GMN-C02-SYUBYOFLG-MAX
                   IF      WRK-KBN (1:1)
                                      =   SPA-GMN-C02-SYUBYOFLGL (IDY)
                       MOVE    SPA-GMN-C02-SYUBYOFLGMEIL (IDY) (1:6)
                                          TO  WRK-KBNMEI
                       MOVE    SPA-GMN-C02-SYUBYOFLG-MAX
                                          TO  IDY
                   END-IF
               END-PERFORM
           END-IF    
      *
           .
       5001-TENKIKBN-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    日付チェック・編集処理
      *****************************************************************
       5002-HIZUKE-CHK-SEC         SECTION.
      *----(01.00.03) LINE ADD START ----------------------------------
      *
      *    日付画面チェックサブ
           INITIALIZE                      ORCSGDAYAREA
           MOVE    WRK-YMD             TO  SGDAY-INDAY
           CALL    "ORCSGDAY"          USING
                                       ORCSGDAYAREA
           IF      SGDAY-RC            =   ZERO
               MOVE    SGDAY-OTDAY         TO  WRK-HENYMDG
               MOVE    SGDAY-SDAY          TO  WRK-SYMD
           ELSE
               MOVE    "0017"          TO  SPA-ERRCD
           END-IF
      *----(01.00.03) LINE ADD END   ----------------------------------
           .
       5002-HIZUKE-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    和暦西暦変換編集処理
      *****************************************************************
       5002-HIZUKE-HEN-SEC          SECTION.
      *
           IF      WRK-SYMD            =   ALL "9"  OR   SPACE
               MOVE    SPACE               TO  WRK-HGO
               MOVE    WRK-SYMD(3:2)       TO  WRK-HYY
               MOVE    WRK-SYMD(5:2)       TO  WRK-HMM
               MOVE    WRK-SYMD(7:2)       TO  WRK-HDD
               MOVE    WRK-HENYMD          TO  WRK-HENYMDG
               MOVE    SPACE               TO  WRK-NENGO
           ELSE
               INITIALIZE                      STS-AREA-DAY
               INITIALIZE                      LNK-DAY2-AREA
               MOVE    "21"                TO  LNK-DAY2-IRAI
               MOVE    WRK-SYMD            TO  LNK-DAY2-YMD
               CALL    "ORCSDAY"            USING   STS-AREA-DAY
                                                   LNK-DAY2-AREA
               MOVE    LNK-DAY2-EDTYMD1    TO  WRK-HENYMDG
               MOVE    LNK-DAY2-EDTYMD2-G  TO  WRK-NENGO
           END-IF
      *
           .
       5002-HIZUKE-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    自画面編集処理
      *****************************************************************
       500-SET-SCREEN              SECTION.
      *
           PERFORM 500-GMNHEN-SEC
      *
           IF      SPA-ERRCD       NOT =   SPACE
               PERFORM 510-ERRSET-SEC
               GO  TO  500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-CIDCD       NOT =   SPACE
               PERFORM 520-CIDSET-SEC
               GO      TO      500-SET-SCREEN-EXT
           END-IF
      *
           IF      SPA-CIDCD2      NOT =   SPACE
               PERFORM 530-CIDSET2-SEC
               GO      TO      500-SET-SCREEN-EXT
           END-IF
      *
           MOVE    SPACE               TO  LINKAREA
      *
           MOVE    "CURRENT"           TO  MCP-PUTTYPE.
           MOVE    "C02    "           TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
           .
       500-SET-SCREEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面編集処理
      *****************************************************************
       500-GMNHEN-SEC              SECTION.
      * 
           MOVE    SPACE               TO  C02
      *
           MOVE    SPA-GMN-C02-PTNUM       TO  C02-PTNUM
           MOVE    SPA-GMN-C02-SYSYMD      TO  C02-SYSYMD
           MOVE    SPA-GMN-C02-KANANAME    TO  C02-KANANAME
           MOVE    SPA-GMN-C02-NAME        TO  C02-NAME
           MOVE    SPA-GMN-C02-SEX         TO  C02-SEX
           MOVE    SPA-GMN-C02-BIRTHDAY    TO  C02-BIRTHDAY
           MOVE    SPA-GMN-C02-HKNCOMBIMEIH
                                           TO  C02-HKNNAME
           MOVE    SPA-GMN-C02-FTNRATE     TO  C02-PTFTNRATE
      **** MOVE    SPA-GMN-C02-SRYKAMEI    TO  C02-SRYKA
           MOVE    SPA-GMN-C02-SRYKA-G     TO  C02-SRYKA
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL       IDX         >   SPA-GMN-C02-SRYKA-MAX
               MOVE    SPA-GMN-C02-SRYKALST (IDX)
                                               TO  C02-SRYKALST (IDX)
           END-PERFORM
           MOVE    SPA-GMN-C02-SRYKA-MAX   TO  C02-SRYKA-COUNT
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-C02-MAX
               MOVE    SPA-GMN-C02-TBANGO    (IDX)
                                           TO  WRK-NUM
               MOVE    WRK-NUM             TO  C02-TBANGO    (IDX)
               MOVE    SPA-GMN-C02-TSRYYMD    (IDX)
                                           TO  C02-TSRYYMD   (IDX)
               MOVE    SPA-GMN-C02-TBYOMEI    (IDX)
                                           TO  C02-TBYOMEI   (IDX)
               MOVE    SPA-GMN-C02-TSYUBYOFLG (IDX)
                                           TO  C02-TSYUBYOFLG(IDX)
               MOVE    SPA-GMN-C02-TMANSEIKBN (IDX)
                                           TO  C02-TMANSEIFLG(IDX)
               MOVE    SPA-GMN-C02-TNYUGAIKBN (IDX)
                                           TO  C02-TNYUGAIKBN(IDX)
               MOVE    SPA-GMN-C02-TUTAGAIFLG (IDX)
                                           TO  C02-TUTAGAIFLG(IDX)
               MOVE    SPA-GMN-C02-THKNCOMBI  (IDX)
                                           TO  C02-THKNCOMBI (IDX)
               MOVE    SPA-GMN-C02-TREZEFLG (IDX)
                                           TO  C02-TREZEFLG (IDX)
               IF      SPA-GMN-C02-TREZEMM  (IDX)    NOT =   ZERO
                   MOVE    SPA-GMN-C02-TREZEMM (IDX)
                                           TO  C02-TREZEMM (IDX)(2:)
               END-IF
               MOVE    SPA-GMN-C02-TTENKIKBN  (IDX)
                                           TO  C02-TTENKIKBN  (IDX)
               MOVE    SPA-GMN-C02-TTENKIYMD (IDX)
                                           TO  C02-TTENKIYMD (IDX)
      *----(01.00.03) LINE ADD START ----------------------------------
               MOVE    SPA-GMN-C02-THKNBYOMEIFLG (IDX)
                                           TO  C02-THKNBYOMEIFLG (IDX)
      *----(01.00.03) LINE ADD END   ----------------------------------
      *
      ***      MOVE    IDX                 TO  C02-BYO-COUNT
      *         
               IF      IDX             =   SPA-NAI-C02-SELNO
                   MOVE    "T"             TO  C02-BYO-SELECT (IDX)
               ELSE
                   MOVE    "F"             TO  C02-BYO-SELECT (IDX)
               END-IF
           END-PERFORM
           MOVE    SPA-GMN-C02-MAX         TO  C02-BYO-COUNT
      *
           MOVE    SPA-GMN-C02-BANGO          TO  C02-BANGO
           MOVE    SPA-GMN-C02-SRYYMD         TO  C02-SRYYMD
           PERFORM VARYING     IDX     FROM   1   BY  1
                   UNTIL       IDX     >      6
               MOVE    SPA-GMN-C02-BYOMEICD(IDX)
                                              TO  C02-BYOMEICD (IDX)
           END-PERFORM
           MOVE    SPA-GMN-C02-BYOMEI         TO  C02-BYOMEI
           MOVE    SPA-GMN-C02-BYOMEIHENFLG   TO  C02-BYOMEIHENFLG
           MOVE    SPA-GMN-C02-CHARTBYOMEI    TO  C02-CHARTBYOMEI
           MOVE    SPA-GMN-C02-BYOMEIINPUTCD  TO  C02-BYOMEIINPUTCD
      *
           MOVE    SPA-GMN-C02-REZEMM         TO  C02-REZEMM
           MOVE    SPA-GMN-C02-TENKIYMD       TO  C02-TENKIYMD
      *
      *
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   SPA-GMN-C02-HKN-MAX
               IF      SPA-GMN-C02-THKNCOMBINUM(IDX)    NOT =   ZERO
                   MOVE    SPA-GMN-C02-THKNCOMBINUM(IDX)
                                               TO  C02-HKNCOMBINUM(IDX)
               END-IF
               MOVE    SPA-GMN-C02-THKNCOMBIMEI(IDX)
                                               TO  C02-HKNCOMBIMEI(IDX)
      *
      ****     MOVE    IDX                     TO  C02-HKN-COUNT
           END-PERFORM
           MOVE    SPA-GMN-C02-HKN-MAX    TO  C02-HKN-COUNT
      *
           MOVE    SPA-GMN-C02-TENKIKBN-G TO  C02-TENKIKBN
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   5
                   OR          SPA-GMN-C02-TENKIKBNL  (IDX)   =   SPACE
               MOVE    SPA-GMN-C02-TENKIKBNLST (IDX)
                                           TO  C02-TENKIKBN-ITEM (IDX)
               MOVE    IDX                 TO  C02-TENKIKBN-COUNT
           END-PERFORM
      *
           MOVE    SPA-GMN-C02-UTAGAIFLG-G TO  C02-UTAGAIFLG
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   5
                   OR          SPA-GMN-C02-UTAGAIFLGL  (IDX)  =   SPACE
               MOVE    SPA-GMN-C02-UTAGAIFLGLST (IDX)
                                           TO  C02-UTAGAIFLG-ITEM (IDX)
               MOVE    IDX                 TO  C02-UTAGAIFLG-COUNT    
           END-PERFORM
      *
           MOVE    SPA-GMN-C02-SYUBYOFLG-G TO  C02-SYUBYOFLG
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   5
                   OR          SPA-GMN-C02-SYUBYOFLGL  (IDX)  =   SPACE
               MOVE    SPA-GMN-C02-SYUBYOFLGLST (IDX)
                                           TO  C02-SYUBYOFLG-ITEM (IDX)
               MOVE    IDX                 TO  C02-SYUBYOFLG-COUNT  
           END-PERFORM
      *
           MOVE    SPA-GMN-C02-MANSEIKBN-G TO  C02-MANSEIFLG
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   5
                   OR          SPA-GMN-C02-MANSEIKBNL  (IDX)  =   SPACE
               MOVE    SPA-GMN-C02-MANSEIKBNLST (IDX)
                                           TO  C02-MANSEIFLG-ITEM (IDX)
               MOVE    IDX                 TO  C02-MANSEIFLG-COUNT
           END-PERFORM
      *
           MOVE    SPA-GMN-C02-NYUGAIKBN-G TO  C02-NYUGAIKBN
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   5
                   OR          SPA-GMN-C02-NYUGAIKBNL  (IDX)  =   SPACE
               MOVE    SPA-GMN-C02-NYUGAIKBNLST (IDX)
                                           TO  C02-NYUGAIKBN-ITEM (IDX)
               MOVE    IDX                 TO  C02-NYUGAIKBN-COUNT
           END-PERFORM
      *
           MOVE    SPA-GMN-C02-HKNCOMBI-G TO  C02-HKNCOMBI
           PERFORM VARYING IDX FROM    1   BY  1
                   UNTIL       IDX         >   10
                   OR          IDX         >   SPA-GMN-C02-HKNCOMBI-MAX
               MOVE    SPA-GMN-C02-HKNCOMBILST (IDX)
                                           TO  C02-HKNCOMBI-ITEM (IDX)
      *****    MOVE    IDX                 TO  C02-HKNCOMBI-COUNT
           END-PERFORM
           MOVE    SPA-GMN-C02-HKNCOMBI-MAX    TO  C02-HKNCOMBI-COUNT
      *
           MOVE    SPA-GMN-C02-HKNBYOMEIFLG-G TO  C02-HKNBYOMEIFLG
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   5
                   OR          SPA-GMN-C02-HKNBYOMEIFLGL(IDX) =   SPACE
               MOVE    SPA-GMN-C02-HKNBYOMEIFLGLST (IDX)
                                       TO  C02-HKNBYOMEIFLG-ITEM (IDX)
               MOVE    IDX             TO  C02-HKNBYOMEIFLG-COUNT
           END-PERFORM
      *
           MOVE    SPA-GMN-C02-REZEFLG-G TO  C02-REZEFLG
           PERFORM VARYING IDX FROM    1       BY  1
                   UNTIL       IDX             >   5
                   OR          SPA-GMN-C02-REZEFLGL  (IDX)   =   SPACE
               MOVE    SPA-GMN-C02-REZEFLGLST (IDX)
                                           TO  C02-REZEFLG-ITEM (IDX)
               MOVE    IDX                 TO  C02-REZEFLG-COUNT
           END-PERFORM
      *
      *    
           IF    ( SPA-C02-MOTOPG      =   "K02"   OR  "U02" 
                                                   OR  "K02N")
           AND   ( SPA-PTNUM       NOT =   SPACE             )
               MOVE    WIDGET-INSENSITIVE  TO  C02-PTNUM-STATE
               MOVE    WIDGET-INSENSITIVE  TO  C02-B03-STATE
                                               C02-B09-STATE
           ELSE
              MOVE    WIDGET-NORMAL        TO  C02-PTNUM-STATE
                                               C02-B03-STATE
                                               C02-B09-STATE
           END-IF
               
           PERFORM 5001-MAPCUR-SEC
      *
           .
       500-GMNHEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    画面カーソルセット処理
      *****************************************************************
       5001-MAPCUR-SEC             SECTION.
      *
         EVALUATE    SPA-GMN-C02-CUR
              WHEN    01
                     MOVE  "BANGO"      TO  MCP-WIDGET
             WHEN    9
                     MOVE  "SRYYMD"     TO  MCP-WIDGET
      *******        MOVE  "SRYNENGO"   TO  MCP-WIDGET
      **     WHEN    10
      **             MOVE  "SRYYY"      TO  MCP-WIDGET
      **     WHEN    11
      **             MOVE  "SRYMM"      TO  MCP-WIDGET
      **     WHEN    12
      *******        MOVE  "SRYDD"      TO  MCP-WIDGET
             WHEN    2
                     MOVE  "BYOMEICD_1" TO  MCP-WIDGET
             WHEN    3
                     MOVE  "BYOMEICD_2" TO  MCP-WIDGET
             WHEN    4
                     MOVE  "BYOMEICD_3" TO  MCP-WIDGET
             WHEN    5
                     MOVE  "BYOMEICD_4" TO  MCP-WIDGET
             WHEN    6
                     MOVE  "BYOMEICD_5" TO  MCP-WIDGET
             WHEN    7
                     MOVE  "BYOMEICD_6" TO  MCP-WIDGET
             WHEN    18
                     MOVE  "UTAGAIFLG"  TO  MCP-WIDGET
             WHEN    19
                     MOVE  "SYUBYOFLG"  TO  MCP-WIDGET
             WHEN    20
                     MOVE  "MANSEIFLG"  TO  MCP-WIDGET
             WHEN    21
                     MOVE  "NYUGAIKBN"  TO  MCP-WIDGET
             WHEN    22
                     MOVE  "HKNCOMBI"   TO  MCP-WIDGET
             WHEN    23
                     MOVE  "REZEFLG"    TO  MCP-WIDGET
             WHEN    24
                     MOVE  "REZEMM"     TO  MCP-WIDGET
             WHEN    17
                     MOVE  "TENKIKBN"   TO  MCP-WIDGET
             WHEN    13
                     MOVE  "TENKIYMD"   TO  MCP-WIDGET
      *******        MOVE  "TENKINENGO" TO  MCP-WIDGET
      ***    WHEN    14
      ***            MOVE  "TENKIYY"    TO  MCP-WIDGET
      ***    WHEN    15
      ***            MOVE  "TENKIMM"    TO  MCP-WIDGET
      ***    WHEN    16
      *******          MOVE  "TENKIDD"  TO  MCP-WIDGET
             WHEN    8
                     MOVE  "BYOMEI"   TO  MCP-WIDGET
             WHEN    28
                     MOVE  "CHARTBYOMEI"
                                      TO  MCP-WIDGET
      *----(01.00.03) LINE MOD START ----------------------------------
             WHEN    25
                     MOVE  "HKNBYOMEIFLG"
                                      TO  MCP-WIDGET
      *----(01.00.03) LINE MOD END   ----------------------------------
             WHEN   26
                    MOVE  "PTNUM"    TO  MCP-WIDGET
             WHEN   27
                    MOVE  "SRYKA"    TO  MCP-WIDGET
             WHEN   29
                    MOVE  "BYOMEIINPUTCD"    TO  MCP-WIDGET
             WHEN   30
                    MOVE  "PTNUM"    TO  MCP-WIDGET
           END-EVALUATE
      *
           .
       5001-MAPCUR-EXT.
           EXIT.
      *
      *****************************************************************
      *    エラーメッセージ表示理
      *****************************************************************
       510-ERRSET-SEC              SECTION.
           MOVE    SPACE               TO  SPA-ERRMSG
      *
           EVALUATE    SPA-ERRCD
               WHEN    "0001"
                   MOVE    "入力エラーです"            TO  SPA-ERRMSG
               WHEN    "0002"
                   MOVE    "既に同一開始日、病名が存在します" 
                                                       TO  SPA-ERRMSG
               WHEN    "0003"
                   MOVE    "警告メッセージ"            TO  SPA-ERRMSG
               WHEN    "0004"
                   MOVE    "対象のデータを選択してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0005"
                   MOVE    "対象のデータが選択してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0006"
                   MOVE    "病名コード順がエラーです"  TO  SPA-ERRMSG
               WHEN    "0007"
                   MOVE    "病名が長すぎます"          TO  SPA-ERRMSG
               WHEN    "0008"
                   MOVE    "項目に入力がありません"    TO  SPA-ERRMSG
               WHEN    "0009"
                   MOVE    "該当の保険組合せがありません" 
                                                       TO  SPA-ERRMSG
               WHEN    "0010"
                   MOVE    "病名が未入力か入力の途中です"
                                                       TO  SPA-ERRMSG
               WHEN    "0011"
               MOVE "開始日が該当の保険組合せの適用日の範囲外です"
                                                       TO  SPA-ERRMSG
               WHEN    "0012"
                   MOVE    "病名番号入力エラー"        TO  SPA-ERRMSG
               WHEN    "0013"
                   MOVE    "年号入力エラー"            TO  SPA-ERRMSG
               WHEN    "0014"
                   MOVE    "数字で入力してください"    TO  SPA-ERRMSG
               WHEN    "0015"
                   MOVE    "開始日付入力エラー"        TO  SPA-ERRMSG
               WHEN    "0016"
                   MOVE    "転帰日付入力エラー"        TO  SPA-ERRMSG
               WHEN    "0017"
                   MOVE    "日付入力エラー"            TO  SPA-ERRMSG
               WHEN    "0018"
                   MOVE    "疑い入力エラー"            TO  SPA-ERRMSG
               WHEN    "0019"
                   MOVE    "主病名入力エラー"          TO  SPA-ERRMSG
               WHEN    "0020"
                   MOVE    "既に主病名が入力されています"
                                                       TO  SPA-ERRMSG
               WHEN    "0021"
                   MOVE    "慢性区分入力エラー"        TO  SPA-ERRMSG
               WHEN    "0022"
                   MOVE    "入外区分入力エラー"        TO  SPA-ERRMSG
               WHEN    "0023"
                   MOVE    "レセプト表示入力エラー"    TO  SPA-ERRMSG
               WHEN    "0024"
                   MOVE    "転帰区分入力エラー"        TO  SPA-ERRMSG
               WHEN    "0025"
                   MOVE    "転帰年月日が入力してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0026"
                   MOVE    "転帰年月日が入力してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0027"
                   MOVE    "開始日付以前の転帰日付が入力してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0028"
                   MOVE    "保険病名入力エラー"        TO  SPA-ERRMSG
               WHEN    "0029"
                   MOVE    "基本病名が入力してありません"
                                                       TO  SPA-ERRMSG
               WHEN    "0030"
                   MOVE    "診療科目入力エラー"
                                               TO  SPA-ERRMSG
               WHEN    "0031"
                   MOVE    "該当の患者が存在しません"
                                               TO  SPA-ERRMSG
      *********WHEN    "0032"
      *************MOVE    "ＩＤ取得サブでエラー" 
      *********                                TO  SPA-ERRMSG
               WHEN    "0033"
                   MOVE    "カルテ病名が長すぎます"    TO  SPA-ERRMSG
               WHEN    "0034"
                   MOVE    "これ以上追加できません"    TO  SPA-ERRMSG
               WHEN    "0035"
                   MOVE    "不明の病名コードが入力されています"
                                               TO  SPA-ERRMSG
               WHEN    "0036"
                   MOVE    "転帰区分が入力してあります"
                                               TO  SPA-ERRMSG
               WHEN    "0037"
                   MOVE    "転帰区分が入力してありません"
                                               TO  SPA-ERRMSG
               WHEN    "0038"
                   MOVE    "既に同一病名が存在します" 
                                               TO  SPA-ERRMSG
               WHEN    "0039"
                   MOVE    "患者番号が存在しません"
                                               TO  SPA-ERRMSG
               WHEN    "0050"
                   MOVE    "患者ＩＤ・診療科の入力がありません" 
                                               TO  SPA-ERRMSG
               WHEN    "0051"
                   MOVE    "入力の途中です"            TO  SPA-ERRMSG
               WHEN    "0052"
                   MOVE    "自院病名マスタが変更されています"
                                                       TO  SPA-ERRMSG
               WHEN    "0053"
                   MOVE    "自院病名コードがありません" TO  SPA-ERRMSG
               WHEN    "0054"
                   MOVE    "病名コードがありません"    TO  SPA-ERRMSG
               WHEN    "0055"
                   MOVE    "同一病名コードが入力されています"
                                                       TO  SPA-ERRMSG
               WHEN    "0056"
                   MOVE    "変更処理のときは複数病名の入力はできません"
                                                       TO  SPA-ERRMSG
               WHEN    "0057"
                   MOVE    "すべて病名が登録できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0058"
                   MOVE    "複数病名の入力中なので病名検索はできません"
                                                       TO  SPA-ERRMSG
               WHEN    "0059"
                   MOVE    "接頭語しか入力できません"  TO  SPA-ERRMSG
               WHEN    "0060"
                   MOVE
                 "複数の病名を入力中ですので、この項目の編集は無効です"
                                                       TO  SPA-ERRMSG
               WHEN    "0061"
                   MOVE    "自院病名の病名・カルテ病名は変更できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0062"
                   MOVE
               "未コード化傷病名は他のコードといっしょに入力できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0063"
                   MOVE
                 "未コード化傷病名が入力されているので入力できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0064"
                   MOVE    "自院病名が入力されているので入力できません"
                                                       TO  SPA-ERRMSG
               WHEN    "0065"
                 MOVE    "自院病名の入力があるので病名検索はできません"
                                                       TO  SPA-ERRMSG
               WHEN    "0066"
                   MOVE    "複数の病名が入力してあります"
                                                       TO  SPA-ERRMSG
               WHEN    "0067"
                   MOVE    "接頭語で病名が終わっています"
                                                       TO  SPA-ERRMSG
               WHEN    "0068"
                   MOVE    "既にこのコードは登録されています"
                                                       TO  SPA-ERRMSG
               WHEN    "0069"
                 MOVE
                 "自院病名以外の入力があるので自院病名検索はできません"
                                                       TO  SPA-ERRMSG
               WHEN    "0070"
                   MOVE    "病名入力コードの長さが違います"
                                                       TO  SPA-ERRMSG
               WHEN    "0071"
                   MOVE    "全角入力して下さい"        TO  SPA-ERRMSG
               WHEN    "0072"
                   MOVE    "全角または半角のみで入力して下さい" 
                                                       TO  SPA-ERRMSG
               WHEN    "0073"
                   MOVE
                   "病名の入力中です。クリアして下さい。"
                                       TO  SPA-ERRMSG
               WHEN    "0074"
                   MOVE
                   "病名を移行すると全ての病名コードを表示できません。"
                                       TO  SPA-ERRMSG
               WHEN    "0075"
                   MOVE    "入力された病名はマスター上で"
                                       TO  SPA-ERRMSG
                   MOVE    WRK-HAISIYMDH
                                       TO  SPA-ERRMSG (29:22)
                   MOVE    "で廃止の扱いとなっています。"
                                       TO  SPA-ERRMSG (51:)
               WHEN    "0076"
                   STRING   WRK-TANDOKUKBN-BYOMEI  DELIMITED  BY  SPACE
                           "は単独使用禁止の病名です"
                                                   DELIMITED  BY  SIZE
                                                   INTO    SPA-ERRMSG 
               WHEN    "0077"
                   MOVE
                   "病名コードが６個以上になります。"
                                       TO  SPA-ERRMSG
               WHEN    "1001"
                   MOVE    "更新処理でエラーになりました"
                                                       TO  SPA-ERRMSG
               WHEN    "1002"
                   MOVE    "削除処理でエラーになりました"
                                                       TO  SPA-ERRMSG
               WHEN    "1003"
                   MOVE    "患者病名マスタが存在しません"
                                                       TO  SPA-ERRMSG
               WHEN    "1004"
                   MOVE    "患者マスタの更新処理でエラーになりました"
                                                       TO  SPA-ERRMSG
               WHEN    "1005"
                   MOVE    "自院病名の更新処理でエラーになりました"
                                                       TO  SPA-ERRMSG
      *
               WHEN    "9999"
                   MOVE    "他端末で使用中です。"
                                               TO  SPA-ERRMSG
                   MOVE    SLOCK-MSG           TO  SPA-ERRMSG(21:)
           END-EVALUATE
      *
           MOVE    SPACE                TO  WRK-HAISIYMDH
      *
           MOVE    SPACE                TO  CERR
           MOVE    SPA-ERRCD            TO  CERR-ERRCODE
           MOVE    SPA-ERRMSG           TO  CERR-ERRMSG
           MOVE    "B01"                TO  MCP-WIDGET
      *
           MOVE    "C02"                TO  SPA-MOTOPG
           MOVE    "CERR"               TO  SPA-SAKIPG
      *
           MOVE    "NEW"                TO  MCP-PUTTYPE
           MOVE    "CERR"               TO  MCP-WINDOW
      *
           PERFORM 900-PUT-WINDOW
      *
           MOVE    1                    TO  FLG-END              
      *
           .
       510-ERRMSG-EXT.
           EXIT.
      *
      *----(01.00.02) LINE ADD START ----------------------------------
      *****************************************************************
      *    確認画面表示処理
      *****************************************************************
       520-CIDSET-SEC              SECTION.
      *
           EVALUATE    SPA-CIDCD
               WHEN    "0101"
                   MOVE    "内容が修正されています。"
                                       TO  WRK-CIDMSG
                   MOVE    "ＯＫで修正分は反映されずに終了します"
                                       TO  WRK-CIDMSG (25:)
               WHEN    "0102"
                   MOVE    "主病名がありません。更新しますか？"
                                       TO  WRK-CIDMSG
               WHEN    OTHER
                   MOVE    SPA-ERRCD
                                       TO  WRK-CIDMSG
           END-EVALUATE
      *
           MOVE    SPACE               TO  SPA-CID1-FLG
      *
           MOVE    SPACE               TO  CID1
           MOVE    SPA-CIDCD           TO  CID1-ID1CODE
           MOVE    WRK-CIDMSG          TO  CID1-ID1MSG
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "C02"               TO  SPA-MOTOPG
           MOVE    "CID1"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "CID1"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       520-CIDSET-EXT.
           EXIT.
      *----(01.00.02) LINE ADD END   ----------------------------------
      *
      *****************************************************************
      *    病名移行確認画面表示処理
      *****************************************************************
       530-CIDSET2-SEC              SECTION.
      *
           MOVE    SPACE               TO  SPA-CID2-FLG
      *
           EVALUATE    SPA-CIDCD2
               WHEN    "0101"
                   MOVE    "選択された病名はマスター上で移行"
                                       TO  WRK-CIDMSG
                   MOVE    "病名の扱いとなっています。"
                                       TO  WRK-CIDMSG (33:)
               WHEN    "0102"
                   MOVE    "選択された自院病名の病名はマスタ"
                                       TO  WRK-CIDMSG
                   MOVE    "ー上で移行病名の扱いとなっています。"
                                       TO  WRK-CIDMSG (33:)
               WHEN    "0103"
                   MOVE    "あなたの入力された病名はマスター上で移行"
                                       TO  WRK-CIDMSG
                   MOVE    "病名の扱いとなっています。"
                                       TO  WRK-CIDMSG (41:)
               WHEN    "0104"
                   MOVE    "あなたの入力された自院病名の病名はマスタ"
                                       TO  WRK-CIDMSG
                   MOVE    "ー上で移行病名の扱いとなっています。"
                                       TO  WRK-CIDMSG (41:)
               WHEN    "0105"
                   MOVE    "あなたの入力された病名はマスター上で移行"
                                       TO  WRK-CIDMSG
                   MOVE    "病名の扱いとなっています。"
                                       TO  WRK-CIDMSG (41:)
               WHEN    "0106"
                   MOVE    "あなたの入力された病名はマスター上で移行"
                                       TO  WRK-CIDMSG
                   MOVE    "病名の扱いとなっています。"
                                       TO  WRK-CIDMSG (41:)
           END-EVALUATE
      *
           MOVE    SPACE               TO  CID2
           MOVE    WRK-CIDMSG          TO  CID2-MSG
           MOVE    SPA-C02-IKOMOTO-BYOMEICD
                                       TO  CID2-BYOMEICD1
           MOVE    SPA-C02-IKOMOTO-BYOMEI  
                                       TO  CID2-BYOMEI1
           MOVE    SPA-C02-IKOSAKI-BYOMEICD
                                       TO  CID2-BYOMEICD2
           MOVE    SPA-C02-IKOSAKI-BYOMEI
                                       TO  CID2-BYOMEI2
           MOVE    "B12"               TO  MCP-WIDGET
      *
           MOVE    "C02"               TO  SPA-MOTOPG
           MOVE    "CID2"              TO  SPA-SAKIPG
      *
           MOVE    "NEW"               TO  MCP-PUTTYPE.
           MOVE    "CID2"              TO  MCP-WINDOW.
      *
           PERFORM 900-PUT-WINDOW.
      *
           MOVE    1                   TO  FLG-END
      *
           .
       530-CIDSET2-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者病名マスター読込（主キー）
      *****************************************************************
       900-PTBYO-INV-SEC         SECTION.
      *
           MOVE    PTBYOMEI-REC        TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    WRK-DBPATH          TO  ORC-DBPATH
               PERFORM 900-PTBYO-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-PTBYOMEI
               INITIALIZE                  PTBYOMEI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    WRK-DBPATH          TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PTBYO-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者病名マスター読込
      *****************************************************************
       900-PTBYO-READ-SEC           SECTION.
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
               INITIALIZE                  PTBYOMEI-REC
               MOVE    1               TO  FLG-PTBYOMEI
           END-IF
      *
           .
       900-PTBYO-READ-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せマスター読込
      *****************************************************************
       900-COMB-READ-SEC         SECTION.
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
       900-COMB-READ-EXT.
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
               MOVE    "BYOMEI-KEY"        TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
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
      *
      *****************************************************************
      *    病名マスター読込
      *****************************************************************
       900-BYOMEI-READ-N-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-BYOMEI
               MOVE    MCPDATA-REC     TO  BYOMEI-REC
           ELSE
              MOVE    1               TO  FLG-BYOMEI
              INITIALIZE                  BYOMEI-REC
           END-IF
           .
       900-BYOMEI-READ-N-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名マスター読込
      *****************************************************************
       900-USERBYOMEI-INV-SEC         SECTION.
      *
      *
           MOVE    USERBYOMEI-REC      TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY6"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "USERBYOMEI-KEY6"   TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  USERBYOMEI-REC
                   MOVE    ZERO                TO  FLG-USERBYOMEI
               ELSE
                   MOVE    1                   TO  FLG-USERBYOMEI
                   INITIALIZE                  USERBYOMEI-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-USERBYOMEI
               INITIALIZE                  USERBYOMEI-REC
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "USERBYOMEI-KEY6"   TO  ORC-DBPATH
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-USERBYOMEI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    自院病名マスター読込
      *****************************************************************
       900-USBYO-READ-SEC           SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  USERBYOMEI-REC
               MOVE    ZERO            TO  FLG-USERBYOMEI
           ELSE
               INITIALIZE                  USERBYOMEI-REC
               MOVE    1               TO  FLG-USERBYOMEI
           END-IF
      *
           .
       900-USBYO-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴マスター読込
      *****************************************************************
       900-JYURRK-INV-SEC         SECTION.
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "DBSELECT"          TO  MCP-FUNC
           MOVE    "JYURRK-KEY10"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    "DBFETCH"           TO  MCP-FUNC
               MOVE    "JYURRK-KEY10"      TO  ORC-DBPATH
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  JYURRK-REC
                   MOVE    ZERO                TO  FLG-JYURRK
               ELSE
                   MOVE    1                   TO  FLG-JYURRK
               END-IF
           ELSE
               MOVE    1                   TO  FLG-JYURRK
           END-IF
      *
           MOVE    "DBCLOSE"           TO  MCP-FUNC
           MOVE    "JYURRK-KEY10"      TO  ORC-DBPATH
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-JYURRK-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込（主キー）
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
               CALL    "ORCMCPSUB"         USING
                                           MCPAREA
                                           ORCMCPAREA
                                           MCPDATA-REC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  PTINF-REC
                   MOVE    ZERO                TO  FLG-PTINF
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
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    システム管理マスタ読込
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    SYSKANRI-REC    TO  MCPDATA-REC
           MOVE    "DBSELECT"      TO  MCP-FUNC
           MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
           MOVE    SPA-NAI-C02-SYSYMD
                                   TO  ORC-DBYMD
           CALL    "ORCMCPSUB"     USING
                                   MCPAREA
                                   ORCMCPAREA
                                   MCPDATA-REC
           IF      MCP-RC          =   ZERO
               MOVE    "SYSKANRI-KEY"  TO  ORC-DBPATH
               MOVE    "DBFETCH"       TO  MCP-FUNC
               CALL    "ORCMCPSUB"     USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
               IF      MCP-RC          =   ZERO
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
           CALL    "ORCMCPSUB"         USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           .
       900-SYSKANRI-INV-EXT.
           EXIT.
      *     
      *****************************************************************
      *    システム管理マスタ　ＲＥＡＤ
      *****************************************************************
       900-SYSKANRI-READ-SEC         SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO            TO  FLG-SYSKANRI
           ELSE
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           .
       900-SYSKANRI-READ-EXT.
           EXIT.
      *
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
      *    排他制御処理
      *****************************************************************
       990-LOCK-IN-SEC         SECTION.
      *
      *    排他制御処理
           MOVE    1                   TO  SLOCK-MODE
           MOVE    SPA-NAI-C02-PTID    TO  SLOCK-PTID
           CALL    "ORCSLOCK"          USING
                                       MCPAREA
                                       SPA-AREA
                                       ORCSLOCKAREA
           IF      SLOCK-RETURN    NOT =   ZERO
               MOVE    "9999"              TO  SPA-ERRCD
           END-IF
           .
       990-LOCK-IN-EXT.
           EXIT.
      *
      *****************************************************************
      *    排他制御解除処理
      *****************************************************************
       990-LOCK-OUT-SEC         SECTION.
      *
      *    排他制御解除処理
           MOVE    2                   TO  SLOCK-MODE
           CALL    "ORCSLOCK"          USING
                                       MCPAREA
                                       SPA-AREA
                                       ORCSLOCKAREA
           .
       990-LOCK-OUT-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＰＵＴ　処理
      *****************************************************************
       900-PUT-WINDOW              SECTION.
      *
           MOVE   "PUTWINDOW"       TO  MCP-FUNC.
           CALL    "ORCMCPSUB"          USING
                                       MCPAREA
                                       ORCMCPAREA
                                       MCPDATA-REC
      *
           .
       900-PUT-WINDOW-EXT.
           EXIT.
      *
      *
