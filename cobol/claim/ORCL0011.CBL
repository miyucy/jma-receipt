      ******************************************************************
      * ORCA -- Online Receipt Computer Advantage
      *
      * Copyright (C)  2000-2001 JMA.         
      *
      * This module is part of ORCA.
      *
      *     ORCA is distributed in the hope that it will be useful, but
      * WITHOUT ANY WARRANTY.  No author or distributor accepts 
      * responsibility to anyone for the consequences of using it or for
      * whether it serves any particular purpose or works at all, unless
      * he says so in writing.
      * Refer to the GNU General Public License for full details. 
      *
      *     Everyone is granted permission to copy, modify and
      * redistribute ORCA, but only under the conditions described in
      * the GNU General Public License.  A copy of this license is
      * supposed to have been given to you along with ORCA so you can
      * know your rights and responsibilities.  It should be in a file
      * named COPYING.  Among other things, the copyright notice and 
      * this notice must be preserved on all copies. 
      ******************************************************************      *
      *
       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ORCL0011.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC-藤原      新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      * 01.00.01     NACL-多々納  03/05/23  Ｈ１５年６月改正対応
      * 01.00.02     NACL-多々納  03/07/01  外来診療料追加
      * 01.00.03     NACL-多々納  04/02/17  診療科’ＸＸ’追加
      * 01.00.04     NACL-多々納  04/10/29  保険組合せの選択分を最初へ
      * 01.00.05     NACL-竹田    05/03/02  公費出力順変更
      * 01.00.06     NACL-多々納  06/03/20  Ｈ１８年４月改正対応
      * 01.00.07     NACL-多々納  06/05/25  MONFUNC対応
      *
      * 03.03.01     NACL-藤原    06/10/15  ２００６年１０月改正対応
      *                                     公費の追加
      * 03.03.02     NACL-藤原    06/10/31  療養介護医療２４の追加
      * 03.05.00     NACL-多々納  07/05/09  グループ診療対応
      * 03.05.00     NACL-多々納  07/05/25  UIDテーブル対応
      * 03.05.01     NACL-多々納  07/08/10  受付メモ追加対応
      * 04.03.00     NACL-多々納  08/06/11  メモ登録の送信対応
      * 04.04.00     NACL-竹田　  09/02/25  公害対応
      * 04.05.00     NACL-多々納  10/01/15  治験・拡張漢字対応
      * 04.05.00     NACL-多々納  10/03/XX  平成２２年４月改正対応
      * 04.07.00     NACL-多々納  14/11/XX  公費SORT廃止対応
      * 04.08.00     NACL-多々納  14/12/XX  Ｈ２７年１月改正対応
      * 04.08.00     NACL-多々納  16/03/XX  Ｈ２８年４月改正対応
      *****************************************************************
      *
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      **** SELECT  LF03-FILE       ASSIGN  "/var/tmp/LF03V01"
      *                            ORGANIZATION    IS  INDEXED
      *                            ACCESS  MODE    IS  DYNAMIC
      *                            RECORD  KEY     IS  LF03-KEY
      ***                          FILE    STATUS  IS  STS-LF03.
      *
       DATA                        DIVISION.
       FILE                        SECTION.
      *
      *FD  LF03-FILE.
      *01  LF03-REC. 
      *    COPY    "CPRLF003.INC".
      *
       WORKING-STORAGE             SECTION.
      *        
018000*    フラグ領域
      *01  STS-AREA.
      *    03  STS-LF03            PIC X(02).
      *
018000*    フラグ領域
018100 01  FLG-AREA.
           03  FLG-END             PIC 9(01).
018900     03  FLG-PTINF           PIC 9(01).
018900     03  FLG-PTKOHINF        PIC 9(01).
018900     03  FLG-PTHKNINF        PIC 9(01).
018900     03  FLG-HKNCOMBI        PIC 9(01).
           03  FLG-SRYKARRK        PIC 9(01).
           03  FLG-SYSKANRI        PIC 9(01).
           03  FLG-TENSU           PIC 9(01).
      ***  03  FLG-LF03            PIC 9(01).
           03  FLG-CLMUID          PIC 9(01).
           03  FLG-JYURRK          PIC 9(01).
           03  FLG-SRYACT          PIC 9(01).
           03  FLG-HKNNUM          PIC 9(01).
           03  FLG-PTMEMOINF       PIC 9(01).
           03  FLG-UID             PIC 9(01).
      *H28.4
      *    小児かかりつけ診療料　施設規準あり
           03  FLG-SYONIKKR-ARI        PIC 9(01).
           03  FLG-SYOUNI-ARI          PIC 9(01).
           03  FLG-SYOUNIKA-CHK        PIC 9(01).
           03  FLG-SYONIKKR-OK         PIC 9(01).
      *
           03  FLG-PTCONF              PIC 9(01).
           03  FLG-SANTEI              PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDW                 PIC 9(04).
           03  IDX                 PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDY1                PIC 9(01).
           03  IDZ                 PIC 9(04).
      *
           03  IDX-U               PIC 9(04).
      *
           03  IDX-HZN             PIC 9(04).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-WYMD.
               05  WRK-WYY         PIC X(04).
               05  WRK-WMM         PIC X(02).
               05  WRK-WDD         PIC X(02).
      *
           03  WRK-POST            PIC X(07).
           03  WRK-HENPOST         PIC X(08).
      *
           03  WRK-ZZZ             PIC Z99.
           03  WRK-999             PIC 9(03).
           03  WRK-SYOYMD          PIC X(08).
           03  WRK-SYOSIN          PIC 9(01).
           03  WRK-SYOSINKBN       PIC X(08).
      *
           03  WRK-SRYKA           PIC X(02).
      *
           03 TBL-MAX              PIC 9(01).
      *
      *    公費並替え用ワーク
           03  WRK-KOHI-AREA.
      *    並び替え前
               05  WRK-KOHI-TBL        OCCURS  4.
                   07  WRK-KOHID-O     PIC  9(10).
                   07  WRK-KOHHKNNUM-O PIC  X(03).
                   07  WRK-KOHMEI-O    PIC  X(50).
                   07  WRK-GAIJGNKBN-O PIC  X(01).
      *    並び替え後
           03  WRK-KOHI-AREA-X.
               05  WRK-KOHI-TBL-X      OCCURS  4.
                   07  WRK-KOHID       PIC  9(10).
                   07  WRK-KOHHKNNUM   PIC  X(03).
                   07  WRK-KOHMEI      PIC  X(50).
                   07  WRK-GAIJGNKBN   PIC  X(01).
      *    ＳＯＲＴ用ワーク
           03  WRK-KOHI.
               05  WRK-KOHID-W         PIC  9(10).
               05  WRK-KOHHKNNUM-W     PIC  X(03).
               05  WRK-KOHMEI-W        PIC  X(50).
               05  WRK-GAIJGNKBN-W     PIC  X(01).
      *
      *    診察料用
       01  WRK-SINSATU-AREA.
      *    受診回数
           03  WRK-SINSATU-CNT         PIC 9(04).
      *    １５歳未満再診料あり
           03  WRK-15MIMAN-ARI         PIC 9(01).
           03  FLG-15MIMAN             PIC 9(01).
           03  FLG-CHK                 PIC 9(01).
      *    小児科外来診療科施設規準あり
           03  FLG-SYONIKA-ARI         PIC 9(01).
      *    小児科外来診療科算定
           03  FLG-SYONIKA             PIC 9(01).
           03  FLG-SYOSIN              PIC 9(01).
      *    診察料
           03  FLG-SINSATU             PIC 9(01).
      *    老人
           03  FLG-ROUJIN              PIC 9(01).
      *H27.1
      *    妥結率区分
           03  WRK-DAKT50-KBN          PIC 9(01).
      *
      *    年齢判定用
           03  WRK-BIRTHDAY.
               05  WRK-BIRTH-YY    PIC 9(04).
               05  WRK-BIRTH-MM    PIC 9(02).
               05  WRK-BIRTH-DD    PIC 9(02).
      *    齢計算領域
           03  WRK-NENREI.
               05  WRK-NENREI-YY         PIC 9(03).
               05  WRK-NENREI-MM         PIC 9(02).
               05  WRK-NENREI-DD         PIC 9(02).
      *
           03  WRK-YMDS1.
               05  WRK-YYS1        PIC 9(04).
               05  WRK-MMS1        PIC 9(02).
               05  WRK-DDS1        PIC 9(02).
           03  WRK-YMDS2.
               05  WRK-YYS2        PIC 9(04).
               05  WRK-MMS2        PIC 9(02).
               05  WRK-DDS2        PIC 9(02).
      *
           03  WRK-KAISU               PIC 9(04).
           03  WRK-HOSPSBT             PIC 9(01).
           03  WRK-SRYKBN              PIC X(02).
           03  WRK-KBN                 PIC X(01).
           03  WRK-KBN2                PIC X(01).
           03  WRK-ETCKBN              PIC X(01).
           03  FLG-ARI                 PIC 9(01).
      *
           03  FLG-ARIS                PIC 9(01).
      *
           03  WRK-LSTYMD              PIC X(08).
           03  WRK-LSTSRYKA            PIC X(02).
      * 
      *    負担率
           03  WRK-FTNRATE             PIC 9(02)V99.
           03  WRK-Z9                  PIC 9.ZZ.
           03  WRK-FTNRATEMEI          PIC X(05).
           03  WRK-ZZ9                 PIC ZZZZ9.
      *
           03  WRK-C-UID               PIC X(36).
      *
      *    患者メモ分解
           03  WRK-MEMO                PIC X(1000).
           03  WRK-MEMO-G.
               05  WRK-MEMO-01         PIC X(1000).
               05  WRK-MEMO-02         PIC X(1000).
               05  WRK-MEMO-03         PIC X(1000).
               05  WRK-MEMO-04         PIC X(1000).
               05  WRK-MEMO-05         PIC X(1000).
               05  WRK-MEMO-OK         PIC X(1000).
      *
           03  WRK-KOUMOKU             PIC X(200).
      *
       01  WRK-SRT-AREA.
           03  WRK-SRT-TABLE.
               05  FILLER              PIC X(03)   VALUE   "027".  
               05  FILLER              PIC X(03)   VALUE   "013".  
               05  FILLER              PIC X(03)   VALUE   "014".  
               05  FILLER              PIC X(03)   VALUE   "018".  
               05  FILLER              PIC X(03)   VALUE   "029".  
               05  FILLER              PIC X(03)   VALUE   "010".  
               05  FILLER              PIC X(03)   VALUE   "011".  
               05  FILLER              PIC X(03)   VALUE   "020".  
               05  FILLER              PIC X(03)   VALUE   "021".  
               05  FILLER              PIC X(03)   VALUE   "015".  
               05  FILLER              PIC X(03)   VALUE   "016".  
               05  FILLER              PIC X(03)   VALUE   "024".  
               05  FILLER              PIC X(03)   VALUE   "022".  
               05  FILLER              PIC X(03)   VALUE   "028".  
               05  FILLER              PIC X(03)   VALUE   "017".  
               05  FILLER              PIC X(03)   VALUE   "079".  
               05  FILLER              PIC X(03)   VALUE   "019".  
               05  FILLER              PIC X(03)   VALUE   "023".  
               05  FILLER              PIC X(03)   VALUE   "051".  
               05  FILLER              PIC X(03)   VALUE   "091".  
               05  FILLER              PIC X(03)   VALUE   "052".  
               05  FILLER              PIC X(03)   VALUE   "053".  
               05  FILLER              PIC X(03)   VALUE   "066".  
               05  FILLER              PIC X(03)   VALUE   "012".
      *********05  FILLER              PIC X(03)   VALUE   "972".
      *********05  FILLER              PIC X(03)   VALUE   "974".
           03  WRK-SRT-TABLE-R         REDEFINES   WRK-SRT-TABLE.      
               05  WRK-SRT-KOHHKNNUM   PIC X(03)   OCCURS  24.
      *
           03  WRK-SRT-KOHHKNNUM-MAX   PIC 9(02)   VALUE   24.
      *  
       01  WRK-HENYMD.
           03  WRK-HENYY           PIC X(04).
           03  FILLER              PIC X(01)   VALUE   "-".  
           03  WRK-HENMM           PIC X(02).
           03  FILLER              PIC X(01)   VALUE   "-".
           03  WRK-HENDD           PIC X(02).
      *
      *    診察料テーブル
       01  TBL-SINSATU-AREA.
      *    初診料（一般 病院）
           03  FILLER              PIC X(14)   VALUE   "101F 111000110".
      *    初診料（老人 病院）
           03  FILLER              PIC X(14)   VALUE   "111F 111700110".
      *    初診料（一般 診療所）
           03  FILLER              PIC X(14)   VALUE   "102F 111003610".
      *    初診料（老人 診療所）
           03  FILLER              PIC X(14)   VALUE   "112F 111700210".
      *
      *    再診料（一般 病院）１回目
           03  FILLER              PIC X(14)   VALUE   "101  112007410".
      *    再診料（一般 病院）２，３回目
           03  FILLER              PIC X(14)   VALUE   "201  112007510".
      *    再診料（一般 病院）４回目以降
           03  FILLER              PIC X(14)   VALUE   "401  112007610".
      *    再診料（一般 病院）１５才未満
           03  FILLER              PIC X(14)   VALUE   "401 M112007710".
      *    再診料（一般 病院）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "401 E112012310".
      *    再診料（一般 病院）人工腎臓
           03  FILLER              PIC X(14)   VALUE   "401 J112007810".
      *
      *    電話再診料（一般 病院）１回目
           03  FILLER              PIC X(14)   VALUE   "101T 112007950".
      *    電話再診料（一般 病院）２，３回目
           03  FILLER              PIC X(14)   VALUE   "201T 112008050".
      *    電話再診料（一般 病院）４回目以降
           03  FILLER              PIC X(14)   VALUE   "401T 112008150".
      *    電話再診料（一般 病院）１５才未満
           03  FILLER              PIC X(14)   VALUE   "401TM112008250".
      *    電話再診料（一般 病院）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "401TE112012450".
      *
      *    同日再診（一般 病院）１回目
           03  FILLER              PIC X(14)   VALUE   "101D 112008350".
      *    同日再診（一般 病院）２，３回目
           03  FILLER              PIC X(14)   VALUE   "201D 112008450".
      *    同日再診（一般 病院）４回目以降
           03  FILLER              PIC X(14)   VALUE   "401D 112008550".
      *    同日再診（一般 病院）１５才未満
           03  FILLER              PIC X(14)   VALUE   "401DM112008650".
      *    同日再診（一般 病院）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "401DE112008750".
      *
      *    電話同日再診（一般 病院）１回目
           03  FILLER              PIC X(14)   VALUE   "101S 112008850".
      *    電話同日再診（一般 病院）２，３回目
           03  FILLER              PIC X(14)   VALUE   "201S 112008950".
      *    電話同日再診（一般 病院）４回目以降
           03  FILLER              PIC X(14)   VALUE   "401S 112009050".
      *    電話同日再診（一般 病院）１５才未満
           03  FILLER              PIC X(14)   VALUE   "401SM112009150".
      *    電話同日再診（一般 病院））厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "401SE112012550".
      *
      *    再診料（一般 診療所）１回目
           03  FILLER              PIC X(14)   VALUE   "102  112009210".
      *    再診料（一般 診療所）２，３回目
           03  FILLER              PIC X(14)   VALUE   "202  112009310".
      *    再診料（一般 診療所）４回目以降
           03  FILLER              PIC X(14)   VALUE   "402  112009410".
      *    再診料（一般 診療所）１５才未満
           03  FILLER              PIC X(14)   VALUE   "402 M112009510".
      *    再診料（一般 診療所）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "402 E112012610".
      *    再診料（一般 診療所）人工腎臓
           03  FILLER              PIC X(14)   VALUE   "402 J112009610".
      *
      *    電話再診（一般 診療所）１回目
           03  FILLER              PIC X(14)   VALUE   "102T 112009750".
      *    電話再診（一般 診療所）２，３回目
           03  FILLER              PIC X(14)   VALUE   "202T 112009850".
      *    電話再診（一般 診療所）４回目以降
           03  FILLER              PIC X(14)   VALUE   "402T 112009950".
      *    電話再診（一般 診療所）１５才未満
           03  FILLER              PIC X(14)   VALUE   "402TM112010050".
      *    電話再診（一般 診療所）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "402TE112012750".
      *
      *    同日再診（一般 診療所）１回目
           03  FILLER              PIC X(14)   VALUE   "102D 112010150".
      *    同日再診（一般 診療所）２，３回目
           03  FILLER              PIC X(14)   VALUE   "202D 112010250".
      *    同日再診（一般 診療所）４回目以降
           03  FILLER              PIC X(14)   VALUE   "402D 112010350".
      *    同日再診（一般 診療所）１５才未満
           03  FILLER              PIC X(14)   VALUE   "402DM112010450".
      *    同日再診（一般 診療所）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "402DE112010550".
      *
      *    電話同日再診（一般 診療所）１回目
           03  FILLER              PIC X(14)   VALUE   "102S 112010650".
      *    電話同日再診（一般 診療所）２，３回目
           03  FILLER              PIC X(14)   VALUE   "202S 112010750".
      *    電話同日再診（一般 診療所）４回目以降
           03  FILLER              PIC X(14)   VALUE   "402S 112010850".
      *    電話同日再診（一般 診療所）１５才未満
           03  FILLER              PIC X(14)   VALUE   "402SM112010950".
      *    電話同日再診（一般 診療所）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "402SE112012850".
      *
      *    再診料（老人 病院）１回目
           03  FILLER              PIC X(14)   VALUE   "111  112702310".
      *    再診料（老人 病院）２，３回目
           03  FILLER              PIC X(14)   VALUE   "211  112702410".
      *    再診料（老人 病院）４回目以降
           03  FILLER              PIC X(14)   VALUE   "411  112702510".
      *    再診料（老人 病院）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "411 E112706310".
      *    再診料（老人 病院）人工腎臓
           03  FILLER              PIC X(14)   VALUE   "411 J112702610".
      *
      *    電話再診（老人 病院）１回目
           03  FILLER              PIC X(14)   VALUE   "111T 112702750".
      *    電話再診（老人 病院）２，３回目
           03  FILLER              PIC X(14)   VALUE   "211T 112702850".
      *    電話再診（老人 病院）４回目以降
           03  FILLER              PIC X(14)   VALUE   "411T 112702950".
      *    電話再診（老人 病院）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "411TE112706450".
      *
      *    同日再診（老人 病院）１回目
           03  FILLER              PIC X(14)   VALUE   "111D 112703050".
      *    同日再診（老人 病院）２，３回目
           03  FILLER              PIC X(14)   VALUE   "211D 112703150".
      *    同日再診（老人 病院）４回目以降
           03  FILLER              PIC X(14)   VALUE   "411D 112703250".
      *    同日再診（老人 病院）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "411DE112703350".
      *
      *    同日電話再診（老人 病院）１回目
           03  FILLER              PIC X(14)   VALUE   "111S 112703450".
      *    同日電話再診（老人 病院）２，３回目
           03  FILLER              PIC X(14)   VALUE   "211S 112703550".
      *    同日電話再診（老人 病院）４回目以降
           03  FILLER              PIC X(14)   VALUE   "411S 112703650".
      *    同日電話再診（老人 病院）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "411SE112706550".
      *
      *    再診料（老人 診療所）１回目
           03  FILLER              PIC X(14)   VALUE   "112  112703710".
      *    再診料（老人 診療所）２，３回目
           03  FILLER              PIC X(14)   VALUE   "212  112703810".
      *    再診料（老人 診療所）４回目以降
           03  FILLER              PIC X(14)   VALUE   "412  112703910".
      *    再診料（老人 診療所）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "412 E112706610".
      *    再診料（老人 診療所）人工腎臓
           03  FILLER              PIC X(14)   VALUE   "412 J112704010".
      *
      *    電話再診（老人 診療所）１回目
           03  FILLER              PIC X(14)   VALUE   "112T 112704150".
      *    電話再診（老人 診療所）２，３回目
           03  FILLER              PIC X(14)   VALUE   "212T 112704250".
      *    電話再診（老人 診療所）４回目以降
           03  FILLER              PIC X(14)   VALUE   "412T 112704350".
      *    電話再診（老人 診療所）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "412TE112706750".
      *
      *    同日再診（老人 診療所）１回目
           03  FILLER              PIC X(14)   VALUE   "112D 112704450".
      *    同日再診（老人 診療所）２，３回目
           03  FILLER              PIC X(14)   VALUE   "212D 112704550".
      *    同日再診（老人 診療所）４回目以降
           03  FILLER              PIC X(14)   VALUE   "412D 112704650".
      *    同日再診（老人 診療所）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "412DE112704750".
      *
      *    同日電話再診（老人 診療所）１回目
           03  FILLER              PIC X(14)   VALUE   "112S 112704850".
      *    同日電話再診（老人 診療所）２，３回目
           03  FILLER              PIC X(14)   VALUE   "212S 112704950".
      *    同日電話再診（老人 診療所）４回目以降
           03  FILLER              PIC X(14)   VALUE   "412S 112705050".
      *    同日電話再診（老人 診療所）厚生省が定める患者
           03  FILLER              PIC X(14)   VALUE   "412SE112706850".
      *
      *
      *    小児科外来診察料(院外処方 初診)
           03  FILLER              PIC X(14)   VALUE   "100  113003510".
      *    小児科外来診察料(院内処方 初診)
           03  FILLER              PIC X(14)   VALUE   "100  113003710".
      *    小児科外来診察料(院外処方 再診)
           03  FILLER              PIC X(14)   VALUE   "200  113003610".
      *    小児科外来診察料(院内処方 再診)
           03  FILLER              PIC X(14)   VALUE   "200  113003810".
      *
      *    外来診療料
           03  FILLER              PIC X(14)   VALUE   "501  112011310".
      *    同日外来診療料
           03  FILLER              PIC X(14)   VALUE   "501D 112011710".
      *    外来診療料（老人）
           03  FILLER              PIC X(14)   VALUE   "511  112705510".
      *    同日外来診療料（老人）
           03  FILLER              PIC X(14)   VALUE   "511D 112705850".
      *
      *
       01  TBL-SINSATU-AREAR       REDEFINES   TBL-SINSATU-AREA.
           03  TBL-SINSATU-OCC         OCCURS  88    INDEXED  TBL-IDX.
      *        回数（５：外来診療料）
               05  TBL-KAISU           PIC 9(01).
      *        老人一般区分（０：一般、１：老人）
               05  TBL-ROUJIN          PIC 9(01).
      *        病院種別（１：病院、２：診療所）
               05  TBL-HOSPSBT         PIC 9(01).
      *        D:同日再診、T：電話再診、S:同日電話再診、F:初診
               05  TBL-KBN             PIC X(01).
      *        M:１５才未満、E：厚生省が定める患者、J:人工腎臓
               05  TBL-KBN2            PIC X(01).
      *        診療コード
               05  TBL-SRYCD           PIC X(09).
      *
      *01  TBL-SIN-MAX                 PIC 9(04)   VALUE   84.
       01  TBL-SIN-MAX                 PIC 9(04)   VALUE   88.
      *
      *H26.4
      *初診と再診のみとする
      *    診察料テーブル
       01  TBL-SINSATU-AREA02.
      *    初診料
           03  FILLER              PIC X(14)   VALUE   "100F 111000110".
      *    再診料（一般 病院）
           03  FILLER              PIC X(14)   VALUE   "100  112007410".
      *    同日再診（一般 病院）
           03  FILLER              PIC X(14)   VALUE   "100D 112008350".
      *
      *    小児科外来診察料(院外処方 初診)
           03  FILLER              PIC X(14)   VALUE   "200FG113003510".
      *    小児科外来診察料(院内処方 初診)
           03  FILLER              PIC X(14)   VALUE   "200FN113003710".
      *    小児科外来診察料(院外処方 再診)
           03  FILLER              PIC X(14)   VALUE   "200 G113003610".
      *    小児科外来診察料(院内処方 再診)
           03  FILLER              PIC X(14)   VALUE   "200 N113003810".
      *
      *    外来診療料
           03  FILLER              PIC X(14)   VALUE   "301  112011310".
      *    同日外来診療料
           03  FILLER              PIC X(14)   VALUE   "301D 112011710".
      *
      *    初診（妥結率５割以下）
           03  FILLER              PIC X(14)   VALUE   "120F 111012710".
      *    再診料（妥結率５割以下）
           03  FILLER              PIC X(14)   VALUE   "120  112016610".
      *    同日再診（妥結率５割以下）
           03  FILLER              PIC X(14)   VALUE   "120D 112016850".
      *    外来診療料（妥結率５割以下）
           03  FILLER              PIC X(14)   VALUE   "321  112017310".
      *    同日外来診療料（妥結率５割以下）
           03  FILLER              PIC X(14)   VALUE   "321D 112017450".
      *
       01  TBL-SINSATU-AREA02R         REDEFINES   TBL-SINSATU-AREA02.
           03  TBL2-SINSATU-OCC        OCCURS  14    INDEXED  TBL2-IDX.
      *        １：一般、２：小児科外来診察料、３：外来診療料
               05  TBL2-KAISU           PIC 9(01).
      *        １:紹介なし、２：妥結率５割以下
               05  TBL2-ETCKBN          PIC 9(01).
      *        病院種別（１：病院、２：診療所）
               05  TBL2-HOSPSBT         PIC 9(01).
      *        D:同日再診,F:初診
               05  TBL2-KBN             PIC X(01).
      *        G:院外、N:院内（小児科外来診察料）
               05  TBL2-KBN2            PIC X(01).
      *        診療コード
               05  TBL2-SRYCD           PIC X(09).
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者マスタ−
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *
      *    保険組み合わせ
       01  HKNCOMBI-REC.
           COPY    "CPHKNCOMBI.INC".
      *
      *    患者保険情報
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *
      *    患者公費情報
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *
      *    診療科履歴
       01  SRYKARRK-REC.
           COPY    "CPSRYKARRK.INC".
      *
      *    点数
           COPY    "CPTENSU.INC".
      *
      *    算定履歴
       01  SANTEI-REC.
           COPY    "CPSANTEI.INC".
      *
      *    患者個別設定テーブル
       01  PTCONF-REC.
           COPY    "CPPTCONF.INC".
      *
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
           COPY    "CPSK1005.INC".
      *
           COPY    "CPSK1006.INC".
      *
           COPY    "CPSK1001.INC".
      *    医療機関情報−所在地、連絡先 
           COPY    "CPSK1002.INC".
      *
           COPY    "CPSK1010.INC".
      *
      *    点数算定基準
           COPY    "CPSK1201.INC".
      *
      *    ＣＬＡＩＭ接続情報
           COPY  "CPSK9000.INC".
      *
      *    受診履歴
       01  JYURRK-REC.
           COPY    "CPJYURRK.INC".
      *
      *    診療行為マスタ−
       01  SRYACT-REC.
           COPY    "CPSRYACT.INC".
      *
      *    保険番号
       01  HKNNUM-REC.
           COPY    "CPHKNNUM.INC".
      *
      *    ＵＩＤテーブル
      *01  CLMUID-REC.
           COPY    "CPCLMUID.INC".
      *
      *    患者メモ
       01  PTMEMOINF-REC.
           COPY    "CPPTMEMOINF.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    スパ領域
      **** COPY    "COMMON-SPA".
      *   日付変換サブ
           COPY    "CPORCSDAY.INC".
           COPY    "CPORCSLNK.INC".
      *
      *    共通パラメタ
           COPY    "MCPAREA".
      **** COPY    "CPORCMCP.INC".
      *
           COPY    "MCPDATA.INC".
      *     
      *    患者番号変換サブ
           COPY    "CPORCSPTID.INC".
      *
      *    保険年齢・負担割合算定サブ
           COPY    "CPORCSAGECHK.INC".
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
       01  HZN-LF01-REC. 
           COPY    "CPRLF001.INC"    REPLACING  //LF01-//
                                     BY         //HZN-LF01-//.
      *
      *    全角チェック
           COPY    "CPORCXKANACONV.INC".
      *
      *    全角チェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    ＵＩＤ取得用エリア
       01 UIDIO-AREA.
           03  C-RET   PIC X(2).
           03  C-UID   PIC X(36).
       01  ST          PIC 9(2).
      * 
           COPY    "CPMML0031.INC".
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
      *01  LNK-PTID             PIC 9(10).
      *01  LNK-SRYKA            PIC X(02).
       01  LNK-TIME             PIC X(06).
      *01  LNK-HOSPID           PIC X(24).
      *01  LNK-SYSYMD           PIC 9(08).
      *01  LNK-DRCD             PIC X(05).
      *01  LNK-HKNCOMBI         PIC X(04).
       01  LNK-PARA-SINRYONAIYO PIC X(16).
       01  LNK-PARA-RENNUM      PIC X(02).
       01  LNK-PARA-MEMO        PIC X(02).
      *    スパ領域
           COPY    "COMMON-SPA".
      *
       01  WRK-LF01-REC. 
           COPY    "CPRLF001.INC"    REPLACING  //LF01//
                                     BY         //WRK-LF01//.
      *
      ******************************************************************
      *
      *PROCEDURE                       DIVISION
      *                                USING   LNK-PTID
      *                                        LNK-SRYKA
      *                                        LNK-TIME
      *                                        LNK-HOSPID
      *                                        LNK-SYSYMD
      *                                        LNK-DRCD
      *                                        LNK-HKNCOMBI
      *                                        LNK-PARA-SINRYONAIYO
      ****                                     WRK-LF01-REC
       PROCEDURE                       DIVISION
                                       USING
           LNK-TIME
           LNK-PARA-SINRYONAIYO
           LNK-PARA-RENNUM
           LNK-PARA-MEMO
           SPA-AREA
           WRK-LF01-REC
           .
      *
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
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
      *    小児科外来診療科編集
           MOVE    SPACE               TO  SYS-1006-REC
           INITIALIZE                      SYS-1006-REC
           MOVE    "1006"              TO  SYS-1006-KANRICD
           MOVE    "1"                 TO  SYS-1006-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-1006-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-1006-EDYUKYMD
      *    システム管理検索（施設基準）
           MOVE    SPA-HOSPNUM         TO  SYS-1006-HOSPNUM
           MOVE    SYS-1006-REC        TO  MCPDATA-REC
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 901-SYSKANRI-READ-SEC
           ELSE
               MOVE    SPACE               TO  SYS-1006-REC
               INITIALIZE                  SYS-1006-REC
               MOVE    1               TO  FLG-SYSKANRI
           END-IF
           MOVE    ZERO                TO  FLG-SYONIKA-ARI
           MOVE    ZERO                TO  FLG-SYONIKKR-ARI
           PERFORM UNTIL   FLG-SYSKANRI    =   1
               MOVE    MCPDATA-REC         TO  SYS-1006-REC
               IF      SYS-1006-KBNCD      =   "1"
      *            小児科外来診療科
                   IF      SYS-1006-SSTKIJUN (121) =   1
                       MOVE    1               TO  FLG-SYONIKA-ARI
                   ELSE
                       MOVE    0               TO  FLG-SYONIKA-ARI
                   END-IF
               END-IF
      *H28.4
               IF      SPA-SYSYMD      >=  "20160401"
                   IF      SYS-1006-KBNCD      =   "7"
      *                小児かかりつけ（3467)
                       IF      SYS-1006-SSTKIJUN (467) =   1
                           MOVE    1               TO  FLG-SYONIKKR-ARI
                       ELSE
                           MOVE    ZERO            TO  FLG-SYONIKKR-ARI
                       END-IF
                    END-IF
               END-IF
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 901-SYSKANRI-READ-SEC
           END-PERFORM
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
      *    システム管理検索（ＣＬＡＩＭ接続情報）
           MOVE    SPACE               TO  SYS-9000-REC
           INITIALIZE                      SYS-9000-REC
           MOVE    "9000"              TO  SYS-9000-KANRICD
           MOVE    "*"                 TO  SYS-9000-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-9000-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-9000-EDYUKYMD
           MOVE    SPA-HOSPNUM         TO  SYS-9000-HOSPNUM
           MOVE    SYS-9000-REC        TO  MCPDATA-REC
      *
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    SYSKANRI-REC        TO  SYS-9000-REC
           ELSE
               INITIALIZE                      SYS-9000-REC
           END-IF
      *    レセ電の科へ変更
           MOVE    SPA-SRYKA           TO  WRK-SRYKA
           IF     (SYS-9000-RECEDEN-FLG    =   "1" )  AND
                  (SPA-SRYKA           NOT =   "XX")
               PERFORM 1001-RECDEN-SRYKA-SEC
           END-IF
      *
      *    OPEN    I-O     LF03-FILE
      *
      *    INITIALIZE                  FLG-AREA
      *    MOVE    SPA-HOSPNUM     TO  LF03-HOSPNUM
      *    MOVE    SPA-PTID        TO  LF03-PTID
      *    MOVE    WRK-SRYKA       TO  LF03-SRYKA
      *
      *    DISPLAY "LD03 READ START WRK-SRYKA:"  WRK-SRYKA
      *
      *    PERFORM 900-LF03-READ-SEC
      *    IF      FLG-LF03        =   1
      *        DISPLAY "SPA-HOSPNUM INVALID"
      *        MOVE    SPACE           TO  LF03-REC
      *        INITIALIZE                  LF03-REC
      *        MOVE    SPA-HOSPNUM     TO  LF03-HOSPNUM
      *        MOVE    SPA-PTID        TO  LF03-PTID
      *        MOVE    WRK-SRYKA       TO  LF03-SRYKA
      *****END-IF
      *
      *    更新日取得
           INITIALIZE                  ORCSMCNDATEAREA
           CALL    "ORCSMCNDATE"       USING
                                       ORCSMCNDATEAREA
      *    UID検索
           INITIALIZE                      CLMUID-REC
           MOVE    SPA-HOSPNUM         TO  CLMUID-HOSPNUM
           MOVE    SPA-PTID            TO  CLMUID-PTID
           MOVE    WRK-SRYKA           TO  CLMUID-SRYKA
           PERFORM 903-CLMUID-READ-SEC
           IF      FLG-CLMUID          =   1
               INITIALIZE                      CLMUID-REC
               MOVE    SPA-HOSPNUM         TO  CLMUID-HOSPNUM
               MOVE    SPA-PTID            TO  CLMUID-PTID
               MOVE    WRK-SRYKA           TO  CLMUID-SRYKA
           END-IF
      *    複数ホストの時、UIDは最初のみ設定
           IF     (LNK-PARA-RENNUM     =   "01"  )
             OR   (FLG-CLMUID          =   1     )
               MOVE    ZERO                TO  FLG-UID
           ELSE
               MOVE    1                   TO  FLG-UID
           END-IF
      *    メモ登録から
           IF     LNK-PARA-MEMO        =   "@@"
               IF      FLG-CLMUID          =   ZERO
                   MOVE    1               TO  FLG-UID
               END-IF
           END-IF
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    レセ電の科へ変更処理
      *****************************************************************
       1001-RECDEN-SRYKA-SEC                SECTION.
      *
           MOVE    SPACE               TO  SYS-1005-REC
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SPA-SRYKA           TO  SYS-1005-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-1005-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-1005-EDYUKYMD
           MOVE    SPA-HOSPNUM         TO  SYS-1005-HOSPNUM
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
      *
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    SYSKANRI-REC        TO  SYS-1005-REC
      *        レセ電診療科
               IF      SYS-1005-RECESRYKA  =   SPACE
                   MOVE    "XX"                TO  WRK-SRYKA
               ELSE
                   MOVE    SYS-1005-RECESRYKA  TO  WRK-SRYKA
               END-IF
           END-IF
           .
       1001-RECDEN-SRYKA-EXT.
           EXIT.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           DISPLAY "11 START"
           MOVE    SPACE           TO  WRK-LF01-REC
           INITIALIZE              WRK-LF01-REC
      *
      *    患者読み出し
           MOVE    SPA-HOSPNUM     TO  PTINF-HOSPNUM
           MOVE    SPA-PTID        TO  PTINF-PTID
           PERFORM 900-PTINF-READ-SEC
      *
      *    MOVE    SPA-PTID        TO  WRK-LF01-PTID1
      *                                WRK-LF01-PTID2
      *    患者番号変換
           INITIALIZE                       ORCSPTIDAREA
           MOVE    SPA-HOSPNUM     TO  SPTID-HOSPNUM
           MOVE    SPA-PTID        TO  SPTID-PTID
           CALL    "ORCSPTID"      USING   ORCSPTIDAREA
                                           SPA-AREA
           MOVE    SPTID-PTNUM     TO  WRK-LF01-PTID1
                                       WRK-LF01-PTID2
      *
           INITIALIZE              UIDIO-AREA
           PERFORM 500-UUID-SET-SEC
           DISPLAY "C-UID" C-UID 
           MOVE    C-UID           TO  WRK-LF01-UID1
                                       CLMUID-UID-NEW
           PERFORM 500-UUID-SET-SEC
           MOVE    C-UID           TO  WRK-LF01-UID3
      *
           MOVE    SPA-SYSYMD      TO  WRK-WYMD
           PERFORM 500-HIZUKE-HENSYU-SEC
           MOVE    WRK-HENYMD      TO  WRK-LF01-CONFIRMDATE1
      *                                WRK-LF01-CONFIRMDATE2
                                       WRK-LF01-CONFIRMDATE3
      *
           MOVE    WRK-HENYMD      TO  WRK-LF01-UKEYMD(1:10)
           MOVE    "T"             TO  WRK-LF01-UKEYMD(11:1)
           MOVE    LNK-TIME (1:2)  TO  WRK-LF01-UKEYMD(12:2)
           MOVE    ":"             TO  WRK-LF01-UKEYMD(14:1) 
           MOVE    LNK-TIME (3:2)  TO  WRK-LF01-UKEYMD(15:2)
           MOVE    ":"             TO  WRK-LF01-UKEYMD(17:1) 
           MOVE    LNK-TIME (5:2)  TO  WRK-LF01-UKEYMD(18:2)
      *
           MOVE    "facility"      TO  WRK-LF01-IDTYPE1
                                       WRK-LF01-IDTYPE2
      *
           IF      PTINF-KANANAME  NOT =   SPACE
               MOVE    "P"         TO  WRK-LF01-KANANAME-REPCODE
               MOVE    PTINF-KANANAME
                                   TO  WRK-LF01-KANANAME
           END-IF
      *
           MOVE    "I"             TO  WRK-LF01-NAME-REPCODE
      ***  MOVE    PTINF-NAME      TO  WRK-LF01-NAME
      *    拡張漢字変換
           MOVE    PTINF-NAME      TO  WRK-KOUMOKU
           PERFORM 800-ORCSKANACHK-SEC
           MOVE    WRK-KOUMOKU     TO  WRK-LF01-NAME
      *
           MOVE    PTINF-BIRTHDAY  TO  WRK-WYMD
           PERFORM 500-HIZUKE-HENSYU-SEC
           MOVE    WRK-HENYMD      TO  WRK-LF01-BIRTHDAY
      *
           EVALUATE    PTINF-SEX
               WHEN    "1"
                   MOVE    "male"      TO  WRK-LF01-SEX
               WHEN    "2"
                   MOVE    "female"    TO  WRK-LF01-SEX
               WHEN    " "
                   MOVE    "unknown"   TO  WRK-LF01-SEX
               WHEN    OTHER
                   MOVE    "other"     TO  WRK-LF01-SEX
           END-EVALUATE
      *
           IF      PTINF-HOME-POST     =   SPACE
           AND     PTINF-HOME-ADRS     =   SPACE
           AND     PTINF-HOME-BANTI    =   SPACE
               CONTINUE
           ELSE
               MOVE    PTINF-HOME-POST     TO  WRK-POST
               PERFORM 500-POST-HENSYU-SEC
               MOVE    WRK-HENPOST         TO  WRK-LF01-HOME-POST
               MOVE    "home"          TO  WRK-LF01-HOME-KREPCODE
               STRING  PTINF-HOME-ADRS     DELIMITED   BY  SPACE
                       "　"                DELIMITED   BY  SIZE
                       PTINF-HOME-BANTI    DELIMITED   BY  SPACE
                                       INTO    WRK-LF01-HOME-ADRS
               END-STRING
           END-IF 
      *
      *
           IF      PTINF-RENRAKU-POST     =   SPACE
           AND     PTINF-RENRAKU-ADRS     =   SPACE
           AND     PTINF-RENRAKU-BANTI    =   SPACE
               CONTINUE
           ELSE
             MOVE    PTINF-RENRAKU-POST     TO  WRK-POST
             PERFORM 500-POST-HENSYU-SEC
             MOVE    WRK-HENPOST         TO  WRK-LF01-RENRAKU-POST
             MOVE    "home"          TO  WRK-LF01-RENRAKU-KREPCODE
             STRING  PTINF-RENRAKU-ADRS  DELIMITED   BY  SPACE
                     "　"                DELIMITED   BY  SIZE
                     PTINF-RENRAKU-BANTI DELIMITED   BY  SPACE
                                     INTO    WRK-LF01-RENRAKU-ADRS
             END-STRING
           END-IF 
      *
           IF       PTINF-HOME-TEL1      NOT =  SPACE
               MOVE     "?????"          TO  WRK-LF01-PHONE-AREA
               MOVE     "?????"          TO  WRK-LF01-PHONE-CITY
               MOVE     "?????"          TO  WRK-LF01-PHONE-NUM
               MOVE     PTINF-HOME-TEL1  TO  WRK-LF01-PHONE-MEMO
           END-IF
      *
           IF      PTINF-OFFICE-POST     =   SPACE
           AND     PTINF-OFFICE-ADRS     =   SPACE
           AND     PTINF-OFFICE-BANTI    =   SPACE
               CONTINUE
           ELSE
             MOVE    PTINF-OFFICE-POST     TO  WRK-POST
             PERFORM 500-POST-HENSYU-SEC
             MOVE    WRK-HENPOST         TO  WRK-LF01-OFFICE-POST
             MOVE    "business"          TO  WRK-LF01-OFFICE-KREPCODE
             STRING  PTINF-OFFICE-ADRS   DELIMITED   BY  SPACE
                     "　"                DELIMITED   BY  SIZE
                     PTINF-OFFICE-BANTI  DELIMITED   BY  SPACE
                                     INTO    WRK-LF01-OFFICE-ADRS
             END-STRING
             END-IF 
      *
      *
           IF      PTINF-KISEI-POST     =   SPACE
           AND     PTINF-KISEI-ADRS     =   SPACE
           AND     PTINF-KISEI-BANTI    =   SPACE
               CONTINUE
           ELSE
             MOVE    PTINF-KISEI-POST     TO  WRK-POST
             PERFORM 500-POST-HENSYU-SEC
             MOVE    WRK-HENPOST         TO  WRK-LF01-KISEI-POST
             MOVE    "home"          TO  WRK-LF01-KISEI-KREPCODE
             STRING  PTINF-KISEI-ADRS    DELIMITED   BY  SPACE
                     "　"                DELIMITED   BY  SIZE
                     PTINF-KISEI-BANTI   DELIMITED   BY  SPACE
                                     INTO    WRK-LF01-KISEI-ADRS
             END-STRING
           END-IF
      *                
           IF      PTINF-DEATHKBN  =   "1"
               MOVE    "true"          TO  WRK-LF01-DEATHKBN
           ELSE
               MOVE    "false"         TO  WRK-LF01-DEATHKBN
           END-IF
      *
           MOVE    "regist"        TO  WRK-LF01-UKEYMD-KREPCODE
      *    患者登録から
           IF      WRK-SRYKA       =   "XX"
               MOVE    "info"          TO  WRK-LF01-UKEYMD-KREPCODE
      *        診療科設定
               PERFORM 2009-SRYKA-SET-SEC
           END-IF
      *    メモから
           IF      LNK-PARA-MEMO       =   "@@"
               MOVE    "memo"          TO  WRK-LF01-UKEYMD-KREPCODE
           END-IF
      *
           MOVE    "false"         TO  WRK-LF01-NYUGAIKBN
      *
      *
      *    診療科名称
           MOVE    SPACE               TO  SYS-1005-REC
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           IF      SPA-SRYKA           =   "XX"
               MOVE    WRK-SRYKA           TO  SYS-1005-KBNCD
           ELSE
               MOVE    SPA-SRYKA           TO  SYS-1005-KBNCD
           END-IF
           MOVE    SPA-SYSYMD          TO  SYS-1005-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-1005-EDYUKYMD
           MOVE    SPA-HOSPNUM         TO  SYS-1005-HOSPNUM
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    SYSKANRI-REC        TO  SYS-1005-REC
               MOVE    SYS-1005-SRYKANAME  TO  WRK-LF01-SRYNAME
                                           WRK-LF01-CRE001-DPERTNAME
                                           WRK-LF01-CRE301-DPERTNAME
               MOVE    WRK-SRYKA           TO  WRK-LF01-CRE001-DPERTID
                                           WRK-LF01-CRE301-DPERTID
               MOVE    "I"                 TO  WRK-LF01-SRYREP
           END-IF
      *
           MOVE    SPACE               TO  WRK-C-UID
      *
      *    保険情報  
           INITIALIZE                  HKNCOMBI-REC
           MOVE    SPA-HOSPNUM     TO  COMB-HOSPNUM
           MOVE    SPA-PTID        TO  COMB-PTID
           MOVE    HKNCOMBI-REC    TO  MCPDATA-REC
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_hkncombi"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-COMB-READ-SEC
           ELSE
               INITIALIZE                  HKNCOMBI-REC
               MOVE    1               TO  FLG-HKNCOMBI
           END-IF
      *
           MOVE    ZERO                TO  IDX
           MOVE    ZERO                TO  IDX-HZN
           MOVE    SPACE               TO   WRK-FTNRATEMEI
           PERFORM UNTIL       (IDX            =   20   )  OR
                               (FLG-HKNCOMBI   =   1    )
           DISPLAY "保険情報 START"
112500         IF     (SPA-SYSYMD            >=  COMB-TEKSTYMD)  AND
112800                (SPA-SYSYMD            <=  COMB-TEKEDYMD)  AND
                      (COMB-DELKBN           =   SPACE        )
                   ADD     1                 TO  IDX
      *
      *            負担率計算
                   INITIALIZE                  ORCSAGECHKAREA
                   MOVE    COMB-HOSPNUM        TO  AGECHK-HOSPNUM
                   MOVE    COMB-PTID           TO  AGECHK-PTID
                   MOVE    SPA-SYSYMD          TO  AGECHK-SRYYMD
                   MOVE    PTINF-BIRTHDAY      TO  AGECHK-BIRTHDAY
                   MOVE    COMB-HKNCOMBINUM    TO  AGECHK-HKNCOMBINUM
                   CALL    "ORCSAGECHK"        USING
                                               ORCSAGECHKAREA
                                               SPA-AREA
      *            負担率
                   IF      AGECHK-RC           =   ZERO
                       COMPUTE WRK-FTNRATE         =   AGECHK-FTNRATE
                                                   /   100
                   ELSE
                       COMPUTE WRK-FTNRATE         =   COMB-GAI-KFTNRATE
                                                   /   100
                   END-IF
                   MOVE    WRK-FTNRATE         TO   WRK-Z9
                   MOVE    WRK-Z9              TO   WRK-FTNRATEMEI
      *
      *   主保険情報読み出し
                   IF      COMB-HKNID          NOT =   ZERO
      *                負担率
                       MOVE    WRK-FTNRATEMEI      TO
                                               WRK-LF01-OUTRATIO (IDX)
      *                １回目
                       IF      FLG-UID             =   ZERO
                           MOVE    COMB-HKNCOMBINUM    TO
                                               CLMUID-HKNCOMBI (IDX)
      *
                           INITIALIZE              UIDIO-AREA
                           PERFORM 500-UUID-SET-SEC
                           MOVE    C-UID               TO
                                               WRK-LF01-UID2    (IDX)
                                               CLMUID-UID       (IDX)
                       ELSE
      *                ２回目から
                           PERFORM 2004-UID-TBL-SEC
                       END-IF
      *
                       IF      SPA-HKNCOMBINUM     =   COMB-HKNCOMBINUM
                           MOVE    C-UID           TO  WRK-C-UID
                           MOVE    IDX             TO  IDX-HZN
                       END-IF
      *
                       MOVE    SPA-SYSYMD          TO  WRK-WYMD
                       PERFORM 500-HIZUKE-HENSYU-SEC
                       MOVE    WRK-HENYMD          TO  
                               WRK-LF01-CONFIRMDATE2(IDX)
                       INITIALIZE                  PTHKNINF-REC
                       MOVE    SPA-HOSPNUM         TO  PTHKN-HOSPNUM
                       MOVE    SPA-PTID            TO  PTHKN-PTID
                       MOVE    COMB-HKNID          TO  PTHKN-HKNID
                       MOVE    SPA-SYSYMD          TO  PTHKN-TEKSTYMD
                       MOVE    SPA-SYSYMD          TO  PTHKN-TEKEDYMD
                       MOVE    PTHKNINF-REC        TO  MCPDATA-REC
                       PERFORM 910-PTHKNINF-INV-SEC
                       MOVE    PTHKN-HKNJANUM  
                               TO  WRK-LF01-HKNJANUM (IDX)
                       IF      PTHKN-KIGO          =   SPACE
                           MOVE    "記載なし"     
                               TO  WRK-LF01-KIGO     (IDX)
                       ELSE
                           MOVE    PTHKN-KIGO      
                               TO  WRK-LF01-KIGO     (IDX)
                       END-IF
                       IF      PTHKN-NUM           =   SPACE
                           MOVE    "記載なし"     
                               TO  WRK-LF01-NUM      (IDX)
                       ELSE
                           MOVE    PTHKN-NUM       
                               TO  WRK-LF01-NUM      (IDX)
                       END-IF
      *H28.10
      *                家族以外を本人とする（労災・自賠責対応）
      ***              IF      PTHKN-HONKZKKBN =   "1"
      *                    MOVE    "true"      
      *                        TO  WRK-LF01-HONKZKKBN (IDX)
      *                ELSE
      *                    MOVE    "false"     
      *                        TO  WRK-LF01-HONKZKKBN (IDX)
      ***              END-IF
                       IF      PTHKN-HONKZKKBN =   "2"
                           MOVE    "false"     
                               TO  WRK-LF01-HONKZKKBN (IDX)
                       ELSE
                           MOVE    "true"      
                               TO  WRK-LF01-HONKZKKBN (IDX)
                       END-IF
      *
                       MOVE    PTHKN-TEKSTYMD  TO  WRK-WYMD
                       PERFORM 500-HIZUKE-HENSYU-SEC
                       MOVE    WRK-HENYMD      
                               TO  WRK-LF01-TEKSTYMD (IDX)
                       MOVE    PTHKN-TEKEDYMD  TO  WRK-WYMD
                       PERFORM 500-HIZUKE-HENSYU-SEC
                       MOVE    WRK-HENYMD      
                               TO  WRK-LF01-TEKEDYMD (IDX)
                       PERFORM VARYING IDW FROM    1   BY  1
                               UNTIL   IDW >       MML0031-TMAX
                         IF    PTHKN-HKNNUM  =  MML0031-HOKEN (IDW)
                               MOVE    MML0031-NAME(IDW) 
                                       TO  WRK-LF01-HKNSBT  (IDX)
      *                        保険種別
      *                        PERFORM 2001-HKNNUM-SET-SEC
                               MOVE    99        TO  IDW
                         END-IF
                      END-PERFORM
      *                 
                      PERFORM 2001-HKNNUM-SET-SEC
                   ELSE
      *                主保険なし
      *                １回目
                       IF      FLG-UID             =   ZERO
                           MOVE    COMB-HKNCOMBINUM    TO
                                               CLMUID-HKNCOMBI (IDX)
      *                 
                           INITIALIZE              UIDIO-AREA
                           PERFORM 500-UUID-SET-SEC
                           MOVE    C-UID               TO
                                               WRK-LF01-UID2    (IDX)
                                               CLMUID-UID       (IDX)
                       ELSE
      *                ２回目から
                           PERFORM 2004-UID-TBL-SEC
                       END-IF
      *
                       IF      SPA-HKNCOMBINUM     =   COMB-HKNCOMBINUM
                           MOVE    C-UID           TO  WRK-C-UID
                           MOVE    IDX             TO  IDX-HZN
                       END-IF
      *
                       MOVE    SPA-SYSYMD          TO  WRK-WYMD
                       PERFORM 500-HIZUKE-HENSYU-SEC
                       MOVE    WRK-HENYMD          TO  
                               WRK-LF01-CONFIRMDATE2(IDX)
                       MOVE    "9999" 
                                               TO  WRK-LF01-HKNJANUM
                                                                (IDX)
                       MOVE    "公費単独"      TO  WRK-LF01-HKNSBT
                                                                (IDX)
                       MOVE    "XX"            TO  WRK-LF01-HKNSBTCODE
                                                                 (IDX)
                       MOVE    "記載なし"      TO  WRK-LF01-KIGO (IDX)
                       MOVE    "記載なし"      TO  WRK-LF01-NUM  (IDX)
                       MOVE    "true"          TO  WRK-LF01-HONKZKKBN
                                                                 (IDX)
                       MOVE    COMB-TEKSTYMD   TO  WRK-WYMD
                       PERFORM 500-HIZUKE-HENSYU-SEC
                       MOVE    WRK-HENYMD      TO  WRK-LF01-TEKSTYMD
                                                               (IDX)
                       MOVE    COMB-TEKEDYMD   TO  WRK-WYMD
                       PERFORM 500-HIZUKE-HENSYU-SEC
                       MOVE    WRK-HENYMD      TO  WRK-LF01-TEKEDYMD
                                                               (IDX)
                   END-IF
      *
      *   公費読み出し
                   IF      COMB-KOHHKNNUM (1)  NOT =   SPACE
                       PERFORM 20012-KOHID-HENSYU-SEC
                       PERFORM VARYING IDY1 FROM    1   BY  1
                               UNTIL   IDY1 >       4
                               OR      WRK-KOHID(IDY1)    =   ZERO
                           INITIALIZE              PTKOHINF-REC
                           MOVE    SPA-HOSPNUM     TO  PTKOH-HOSPNUM
                           MOVE    SPA-PTID        TO  PTKOH-PTID
                           MOVE    WRK-KOHID(IDY1) TO  PTKOH-KOHID
                           MOVE    SPA-SYSYMD      TO  PTKOH-TEKSTYMD
                           MOVE    SPA-SYSYMD      TO  PTKOH-TEKEDYMD
                           MOVE    PTKOHINF-REC    TO  MCPDATA-REC
                           PERFORM 910-PTKOHINF-INV-SEC
                           MOVE    IDY1            TO
                                           WRK-LF01-PRIORITY (IDX IDY1)
                     IF    PTKOH-FTNJANUM          =   SPACE
                           MOVE    "mikinyu"       TO
                                            WRK-LF01-FTNJANUM(IDX IDY1)
                     ELSE
                           MOVE    PTKOH-FTNJANUM  TO
                                            WRK-LF01-FTNJANUM(IDX IDY1)
                     END-IF
                     IF    PTKOH-JKYSNUM           =   SPACE
                           MOVE    "mikinyu"       TO
                                            WRK-LF01-JKYSNUM (IDX IDY1)
                     ELSE
                           MOVE    PTKOH-JKYSNUM   TO
                                            WRK-LF01-JKYSNUM (IDX IDY1)
                     END-IF
                           MOVE    PTKOH-TEKSTYMD  TO  WRK-WYMD
                           PERFORM 500-HIZUKE-HENSYU-SEC
                           MOVE    WRK-HENYMD      TO
                                        WRK-LF01-TTEKSTYMD (IDX IDY1)
                           MOVE    PTKOH-TEKEDYMD  TO  WRK-WYMD
                           PERFORM 500-HIZUKE-HENSYU-SEC
                           MOVE    WRK-HENYMD      TO
                                        WRK-LF01-TTEKEDYMD (IDX IDY1)
      *??
      *                    負担率・負担額編集
                           PERFORM 400-KOHFTN-HENSYU-SEC
      *??
      *                    公費名称
                           MOVE    WRK-KOHMEI (IDY1)   TO
                                           WRK-LF01-KOHINAME (IDX IDY1)
      *
                       END-PERFORM    
                   END-IF
               END-IF
      *
               MOVE    "tbl_hkncombi"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 900-COMB-READ-SEC
           END-PERFORM
      *    カーソルクロース
           MOVE    "tbl_hkncombi"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *    使用保険 (claim:insuranceUid)
           MOVE    WRK-C-UID           TO  WRK-LF01-FIL1
           IF      IDX-HZN             >   ZERO
               PERFORM 2002-HKNCOMBI-LIST-SEC
           END-IF
      *
      *    初診／再診
           MOVE    SPACE               TO  WRK-SYOYMD
           MOVE    ZERO                TO  WRK-SYOSIN 
           MOVE    SPACE               TO  WRK-LSTYMD
           MOVE    SPACE               TO  WRK-LSTSRYKA
      *
      *    診療科歴を検索
           MOVE    SPACE               TO  SRYKARRK-REC
           INITIALIZE                  SRYKARRK-REC
           MOVE    SPA-HOSPNUM         TO  KARRK-HOSPNUM
           MOVE    SPA-PTID            TO  KARRK-PTID
      *
           MOVE    SRYKARRK-REC        TO  MCPDATA-REC
           MOVE    "tbl_srykarrk"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_srykarrk"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 975-SRYKARRK-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SRYKARRK
               MOVE    SPACE               TO  SRYKARRK-REC
               INITIALIZE                  SRYKARRK-REC
           END-IF
           PERFORM UNTIL       FLG-SRYKARRK    =   1
      *
      *        初診算定日
               IF     (KARRK-SYOSINYMD2 NOT =  SPACE      ) AND
                      (KARRK-SYOSINYMD2    >=  WRK-SYOYMD )
                   MOVE    KARRK-SYOSINYMD2    TO  WRK-SYOYMD
               END-IF
      *        最終受診日
               IF     (KARRK-LASTYMD   NOT =   SPACE      ) AND
                      (KARRK-LASTYMD       >=  WRK-LSTYMD )
                   MOVE    KARRK-LASTYMD       TO  WRK-LSTYMD
                   MOVE    KARRK-SRYKA         TO  WRK-LSTSRYKA
               END-IF
      *
               MOVE    "tbl_srykarrk"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 975-SRYKARRK-READ-SEC
           END-PERFORM
      *
           MOVE    "tbl_srykarrk"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
      *    初診料算定有無
           IF      WRK-SYOYMD          =   SPACE
      *            初診算定
               MOVE    1               TO  WRK-SYOSIN
           END-IF
      *
      *    初診料算定日が診療日の時、再診とする
           IF      WRK-SYOSIN          =   1
               IF      WRK-SYOYMD          =   SPA-SYSYMD
                   MOVE    ZERO            TO  WRK-SYOSIN
               END-IF
           END-IF
      *
           IF      WRK-SYOSIN         =   ZERO
      *
               MOVE    WRK-SYOYMD      TO  WRK-WYMD
               PERFORM 500-HIZUKE-HENSYU-SEC
               MOVE    WRK-HENYMD      TO  WRK-LF01-CONFIRMDATE4
           END-IF
      *
           MOVE    "tbl_tensu"         TO  WRK-LF01-ID
      *    医療機関情報−所在地、連絡先
           MOVE    SPACE               TO  SYS-1002-REC
           INITIALIZE                  SYS-1002-REC
           MOVE    "1002"              TO  SYS-1002-KANRICD
           MOVE    "*"                 TO  SYS-1002-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-1002-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-1002-EDYUKYMD
           MOVE    SPA-HOSPNUM         TO  SYS-1002-HOSPNUM
           MOVE    SYS-1002-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    SYSKANRI-REC        TO  SYS-1002-REC
           ELSE
               INITIALIZE                  SYS-1002-REC
           END-IF
      *    医療機関ＩＤ編集
           MOVE    SPACE               TO  SYS-1001-REC
           INITIALIZE                  SYS-1001-REC
           MOVE    "1001"              TO  SYS-1001-KANRICD
           MOVE    "*"                 TO  SYS-1001-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-1001-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-1001-EDYUKYMD
           MOVE    SPA-HOSPNUM         TO  SYS-1001-HOSPNUM
           MOVE    SYS-1001-REC        TO  MCPDATA-REC
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    SYSKANRI-REC        TO  SYS-1001-REC
      ******** EVALUATE    SYS-1001-HOSPSBT    ALSO    WRK-SYOSIN
      *            WHEN    "1"                 ALSO    1
      *                MOVE    "111000110"     TO  WRK-LF01-IJICD
      *                MOVE    "110"           TO
      *                        WRK-LF01-BUNDLE-CLASSCODE    
      *            WHEN    "1"                 ALSO    ZERO
      *                MOVE    "112000110"     TO  WRK-LF01-IJICD    
      *                MOVE    "120"           TO
      *                        WRK-LF01-BUNDLE-CLASSCODE    
      *            WHEN    "2"                 ALSO    1
      *                MOVE    "111003610"     TO  WRK-LF01-IJICD    
      *                MOVE    "110"           TO
      *                        WRK-LF01-BUNDLE-CLASSCODE    
      *            WHEN    "2"                 ALSO    ZERO
      *                MOVE    "112000210"     TO  WRK-LF01-IJICD
      *                MOVE    "120"           TO
      *                        WRK-LF01-BUNDLE-CLASSCODE    
      *            WHEN    OTHER
      *                DISPLAY "*** ORCL0011 IJICD ERR HOSPSBT="
      *                        SYS-1001-HOSPSBT " SYOSIN=" WRK-SYOSIN 
      *********END-EVALUATE
      * 作成者 施設情報名
      *        拡張漢字変換
               MOVE    SYS-1001-HOSPNAME    TO  WRK-KOUMOKU
               PERFORM 800-ORCSKANACHK-SEC
               MOVE    WRK-KOUMOKU          TO  SYS-1001-HOSPNAME
      *
               MOVE  SYS-1001-HOSPNAME      TO  
                     WRK-LF01-CRE001-FACILITYNAME
                     WRK-LF01-CRE101-FACILITYNAME
                     WRK-LF01-CRE301-FACILITYNAME
      *管理者名
      *        拡張漢字変換
               MOVE    SYS-1001-KANRINAME   TO  WRK-KOUMOKU
               PERFORM 800-ORCSKANACHK-SEC
               MOVE    WRK-KOUMOKU          TO  SYS-1001-KANRINAME
      *
               MOVE  SYS-1001-KANRINAME     TO  WRK-LF01-CRE001-FULLNAME
                                                WRK-LF01-CRE101-FULLNAME
      *                                         WRK-LF01-CRE201-FULLNAME
                                                WRK-LF01-CRE301-FULLNAME
      *医療機関コード
               MOVE  SYS-1001-HOSPCD     TO  WRK-LF01-CRE001-PERSONALID
                                             WRK-LF01-CRE101-PERSONALID
                                             WRK-LF01-CRE301-PERSONALID
               MOVE  "doctor"               TO  WRK-LF01-CRE001-LICENSE
                                                WRK-LF01-CRE101-LICENSE
                                                WRK-LF01-CRE301-LICENSE
               MOVE  SYS-1001-HOSPID     TO  WRK-LF01-CRE001-FACILITYID
                                             WRK-LF01-CRE101-FACILITYID
                                             WRK-LF01-CRE301-FACILITYID
      *郵便番号
               MOVE  SYS-1002-POST(1:3)     TO  WRK-LF01-CRE001-ZIP(1:3)
                                                WRK-LF01-CRE101-ZIP(1:3)
                                                WRK-LF01-CRE301-ZIP(1:3)
               MOVE  "-"                    TO  WRK-LF01-CRE001-ZIP(4:1)
                                                WRK-LF01-CRE101-ZIP(4:1)
                                                WRK-LF01-CRE301-ZIP(4:1)
               MOVE  SYS-1002-POST(4:4)     TO  WRK-LF01-CRE001-ZIP(5:4)
                                                WRK-LF01-CRE101-ZIP(5:4)
                                                WRK-LF01-CRE301-ZIP(5:4)
      *住所
               MOVE  SYS-1002-ADRS       TO  WRK-LF01-CRE001-ADRFULLNAME
                                             WRK-LF01-CRE101-ADRFULLNAME
                                             WRK-LF01-CRE301-ADRFULLNAME
      *        PERFORM UNTIL       (IDX            =   20   )
               PERFORM VARYING IDX FROM    1   BY  1
                               UNTIL   IDX >       20
                 IF    WRK-LF01-HONKZKKBN(IDX) NOT =   SPACE 
                       MOVE  "MML0031"      
                             TO  WRK-LF01-HKNSBTTBL(IDX)
                       MOVE  SYS-1001-HOSPNAME      
                             TO  WRK-LF01-CRE201-FACILITYNAME(IDX)
                       MOVE  SYS-1001-KANRINAME 
                             TO  WRK-LF01-CRE201-FULLNAME(IDX)
                       MOVE  SYS-1001-HOSPCD        
                             TO  WRK-LF01-CRE201-PERSONALID(IDX)
                       MOVE  "doctor"               
                             TO  WRK-LF01-CRE201-LICENSE(IDX)
                       MOVE  SYS-1001-HOSPID         
                             TO  WRK-LF01-CRE201-FACILITYID(IDX)
                       MOVE  SYS-1005-SRYKANAME  
                             TO  WRK-LF01-CRE201-DPERTNAME(IDX)
                       MOVE  WRK-SRYKA           
                             TO  WRK-LF01-CRE201-DPERTID(IDX)
                       MOVE  SYS-1002-POST(1:3) 
                                            TO  WRK-LF01-CRE201-ZIP(IDX)
                                                                 (1:3)
                       MOVE  "-"            
                                            TO  WRK-LF01-CRE201-ZIP(IDX)
                                                                  (4:1)
                       MOVE  SYS-1002-POST(4:4)     
                                            TO  WRK-LF01-CRE201-ZIP(IDX)
                                                                   (5:4)
                       MOVE  SYS-1002-ADRS  
                                            TO  
                             WRK-LF01-CRE201-ADRFULLNAME(IDX)
                  END-IF
               END-PERFORM
           END-IF     
      *
      *    ドクター
           IF      SPA-DRCD            =   "@@@@@"
               CONTINUE
           ELSE
               PERFORM 2001-DRCD-NAME-SEC
               MOVE    SYS-1010-NAME   TO  WRK-LF01-CRE301-FULLNAME
               MOVE    SPA-DRCD        TO  WRK-LF01-CRE301-PERSONALID
           END-IF
      *H27.1
      *    ステム管理 妥結率検索
           PERFORM 2003-SYSKANRI-DAKETU-SEC
      *
      *    診察料コードを決定する
           PERFORM 2020-SRYCD-SET-SEC
      *
           IF      WRK-LF01-IJICD       NOT =   SPACE
               INITIALIZE                       TNS-TENSU-REC
               MOVE    WRK-LF01-IJICD       TO  TNS-SRYCD
               PERFORM 900-TENSU-INV-SEC
               IF       FLG-TENSU       =       ZERO
                   MOVE    TNS-NAME        TO  WRK-LF01-HOSPSBT
      *            小児科外来診察料で同日再診の時
                   IF     (WRK-LF01-IJICD(1:3) =   "113") AND
                          (WRK-LSTYMD          =   SPA-SYSYMD)
                       MOVE    "小児科外来診療料・同日再診"
                                               TO  WRK-LF01-HOSPSBT
      *H28.4
                       IF      FLG-SYONIKKR-OK =   1
                           MOVE    "小児かかりつけ診療料・同日再診"
                                               TO  WRK-LF01-HOSPSBT
                       END-IF
                   END-IF
               ELSE
                   DISPLAY "*** ORCL0011 TEN INVALID KEY=" 
                           WRK-LF01-IJICD 
               END-IF
           END-IF
      *TEST
             DISPLAY "*** ORCL0011 =" 
                     ",WRK-LF01-IJICD:" WRK-LF01-IJICD
                     ",:" WRK-LF01-HOSPSBT
      *
      *    診察料コードを決定する
           MOVE    LNK-PARA-SINRYONAIYO
                                       TO  WRK-LF01-YYKMEMO
      *
      *    受付メモ編集
           PERFORM 2009-PTMEMOINF-SEC
      *
           MOVE    1                  TO  FLG-END
      *
           .
       200-MAIN-EXT.
           EXIT.
      *H26.12
      *****************************************************************
      *    ステム管理（妥結率）設定処理
      *****************************************************************
       2003-SYSKANRI-DAKETU-SEC         SECTION.
      *
           MOVE    ZERO                TO  WRK-DAKT50-KBN
      *
      *    病院・許可病床数２００以上
           IF     (SYS-1001-HOSPSBT    =   "1"  )
              AND (SYS-1001-BEDSU      >=  200  )
              AND (SPA-SYSYMD          >=  "20150101")
      *
               MOVE    SPACE               TO  SYS-1201-REC
               INITIALIZE                  SYS-1201-REC
               MOVE    "1201"              TO  SYS-1201-KANRICD
               MOVE    "A0000001"          TO  SYS-1201-KBNCD
               MOVE    SPA-SYSYMD          TO  SYS-1201-STYUKYMD
               MOVE    SPA-SYSYMD          TO  SYS-1201-EDYUKYMD
               MOVE    SPA-HOSPNUM         TO  SYS-1201-HOSPNUM
               MOVE    SYS-1201-REC        TO  SYSKANRI-REC
               MOVE    SYSKANRI-REC        TO  MCPDATA-REC
      *
               PERFORM 900-SYSKANRI-INV-SEC
               IF      FLG-SYSKANRI        =   ZERO
                   MOVE    SYSKANRI-REC        TO  SYS-1201-REC
      *            妥結率以下
                   IF      SYS-1201-DAKETUKBN  =   "1"
                       MOVE    1                   TO  WRK-DAKT50-KBN
                   END-IF
               END-IF
           END-IF
      *
           .
       2003-SYSKANRI-DAKETU-EXT.
           EXIT.
      * 
      *****************************************************************
      *    ２回目からのUID設定処理
      *****************************************************************
       2004-UID-TBL-SEC              SECTION.
      *
           PERFORM VARYING     IDX-U   FROM    1   BY  1
                   UNTIL       IDX-U   >   20
               IF      CLMUID-HKNCOMBI (IDX-U) =   COMB-HKNCOMBINUM
                   MOVE    CLMUID-UID  (IDX-U) TO  C-UID
                   MOVE    CLMUID-UID  (IDX-U) TO  WRK-LF01-UID2 (IDX)
                   MOVE    20                  TO  IDX-U
               END-IF
           END-PERFORM
           .
       2004-UID-TBL-EXT.
           EXIT.
      * 
      *****************************************************************
      *    ドクター設定処理
      *****************************************************************
       2001-DRCD-NAME-SEC              SECTION.
      *
           MOVE    SPACE               TO  SYS-1010-REC
           INITIALIZE                      SYS-1010-REC
           MOVE    "1010"              TO  SYS-1010-KANRICD
           MOVE    SPA-DRCD            TO  SYS-1010-KBNCD
           MOVE    SPA-SYSYMD          TO  SYS-1010-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-1010-EDYUKYMD
           MOVE    SPA-HOSPNUM         TO  SYS-1010-HOSPNUM
           MOVE    SYS-1010-REC        TO  MCPDATA-REC
      *
           PERFORM 900-SYSKANRI-INV-SEC
           IF      FLG-SYSKANRI        =   ZERO
               MOVE    SYSKANRI-REC        TO  SYS-1010-REC
           ELSE
               INITIALIZE                      SYS-1010-REC
           END-IF
      *
      *    拡張漢字変換
           MOVE    SYS-1010-NAME       TO  WRK-KOUMOKU
           PERFORM 800-ORCSKANACHK-SEC
           MOVE    WRK-KOUMOKU         TO  SYS-1010-NAME
           .
       2001-DRCD-NAME-EXT.
           EXIT.
      * 
      *****************************************************************
      *    診療科設定処理
      *****************************************************************
       2009-SRYKA-SET-SEC              SECTION.
      *
           MOVE    SPACE               TO  WRK-SRYKA
      *
           MOVE    SPACE               TO  SYS-1005-REC
           INITIALIZE                      SYS-1005-REC
           MOVE    "1005"              TO  SYS-1005-KANRICD
           MOVE    SPA-SYSYMD          TO  SYS-1005-STYUKYMD
           MOVE    SPA-SYSYMD          TO  SYS-1005-EDYUKYMD
           MOVE    SPA-HOSPNUM         TO  SYS-1005-HOSPNUM
           MOVE    SYS-1005-REC        TO  MCPDATA-REC
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-SYSKANRI
                   MOVE    MCPDATA-REC         TO  SYS-1005-REC
                   MOVE    SYS-1005-KBNCD      TO  WRK-SRYKA
               ELSE
                   INITIALIZE                      SYS-1005-REC
               END-IF
           ELSE
               INITIALIZE                      SYS-1005-REC
           END-IF
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       2009-SRYKA-SET-EXT.
           EXIT.
      * 
      *****************************************************************
      *    保険種別編集処理
      *****************************************************************
       2001-HKNNUM-SET-SEC              SECTION.
      *
           EVALUATE    PTHKN-HKNNUM 
               WHEN    "060"
      *            国保の場合は、ゼロを設定
                   MOVE    "00"    TO  WRK-LF01-HKNSBTCODE (IDX)
               WHEN    "971"
      *            労災
                   MOVE    "R1"    TO  WRK-LF01-HKNSBTCODE (IDX)
                   MOVE    "9999"  TO  WRK-LF01-HKNJANUM (IDX)
                   MOVE    "労災"  TO  WRK-LF01-HKNSBT  (IDX)
               WHEN    "973"
      *            自賠責
                   MOVE    "R3"    TO  WRK-LF01-HKNSBTCODE (IDX)
                   MOVE    "9999"  TO  WRK-LF01-HKNJANUM (IDX)
                   MOVE    "自賠責"    TO  WRK-LF01-HKNSBT  (IDX)
               WHEN    "975"
      *            公害
                   MOVE    "K5"    TO  WRK-LF01-HKNSBTCODE (IDX)
                   MOVE    "9999"  TO  WRK-LF01-HKNJANUM (IDX)
                   MOVE    "公害"  TO  WRK-LF01-HKNSBT  (IDX)
               WHEN    OTHER
                   EVALUATE    PTHKN-HKNNUM(1:2)
                   WHEN    "98"
      *                自費
                       MOVE    "Z"         TO  WRK-LF01-HKNSBTCODE
                                                            (IDX)(1:1)
                       MOVE    PTHKN-HKNNUM(3:1)
                                           TO  WRK-LF01-HKNSBTCODE
                                                            (IDX)(2:1)
                       MOVE    "9999" 
                                           TO  WRK-LF01-HKNJANUM (IDX)
                       MOVE    "自費" 
                                           TO  WRK-LF01-HKNSBT  (IDX)
                   WHEN    "90"
      *                治験
                       MOVE    "A"         TO  WRK-LF01-HKNSBTCODE
                                                            (IDX)(1:1)
                       MOVE    PTHKN-HKNNUM(3:1)
                                           TO  WRK-LF01-HKNSBTCODE
                                                            (IDX)(2:1)
                       MOVE    "9999" 
                                           TO  WRK-LF01-HKNJANUM (IDX)
                       MOVE    "治験" 
                                           TO  WRK-LF01-HKNSBT  (IDX)
                   WHEN    "91"
      *                治験
                       MOVE    "B"         TO  WRK-LF01-HKNSBTCODE
                                                            (IDX)(1:1)
                       MOVE    PTHKN-HKNNUM(3:1)
                                           TO  WRK-LF01-HKNSBTCODE
                                                            (IDX)(2:1)
                       MOVE    "9999" 
                                           TO  WRK-LF01-HKNJANUM (IDX)
                       MOVE    "治験" 
                                           TO  WRK-LF01-HKNSBT  (IDX)
                   WHEN    OTHER
      *                その他（下２桁）
                       MOVE    PTHKN-HKNNUM    TO  WRK-999
                       MOVE    WRK-999         TO  WRK-ZZZ
                       MOVE    WRK-ZZZ(2:2)    TO  WRK-LF01-HKNSBTCODE
                                                                (IDX)
                   END-EVALUATE
           END-EVALUATE
      *
           .
       2001-HKNNUM-SET-EXT.
           EXIT.
      * 
      *****************************************************************
      *    公費個別処理
      *****************************************************************
       20012-KOHID-HENSYU-SEC              SECTION.
      *
           INITIALIZE                      WRK-KOHI-AREA
                                           WRK-KOHI-AREA-X
           MOVE    ZERO                    TO  TBL-MAX
      *
      *
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       4
               MOVE    COMB-KOHID    (IDZ) TO  WRK-KOHID-O     (IDZ)
               MOVE    COMB-KOHHKNNUM(IDZ) TO  WRK-KOHHKNNUM-O (IDZ)
      *        公費名称
               MOVE    COMB-KOH-TANSEIDONAME(IDZ)
                                           TO  WRK-KOHMEI-O    (IDZ)
      *        公費−外来−上限区分
               MOVE    COMB-KOH-GAIJGNKBN (IDZ)
                                           TO  WRK-GAIJGNKBN-O (IDZ)
           END-PERFORM
      *
      *H26.11  並び替えを廃止する
           PERFORM VARYING     IDZ     FROM    1   BY  1
                   UNTIL      (IDZ         >   4 )
               IF      WRK-KOHID-O (IDZ)   >   ZERO
                   ADD     1                   TO  TBL-MAX
                   MOVE    WRK-KOHI-TBL (IDZ)  TO  WRK-KOHI-TBL-X
                                                           (TBL-MAX)
               END-IF
           END-PERFORM
      *****
           GO  TO  20012-KOHID-HENSYU-EXT
      *
      *****
      *
      *    優先順位に並べ替え
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ >       WRK-SRT-KOHHKNNUM-MAX
                   OR      TBL-MAX     =   4 
               PERFORM VARYING IDY FROM    1   BY  1
                       UNTIL   IDY >       4
                   IF      WRK-SRT-KOHHKNNUM   (IDZ)
                                   =   WRK-KOHHKNNUM-O (IDY)
                       ADD     1               TO  TBL-MAX
                       MOVE    WRK-KOHI-TBL    (IDY)   TO
                                           WRK-KOHI-TBL-X (TBL-MAX)
                       INITIALIZE          WRK-KOHI-TBL   (IDY)
                       MOVE    4               TO  IDY
                   END-IF
               END-PERFORM
           END-PERFORM
      *
      *    すべて並べ替えた時 
           IF      TBL-MAX                 =   4
               GO  TO  20012-KOHID-HENSYU-EXT
           END-IF
      *
      *    地方公費の並び替え
           PERFORM VARYING IDZ FROM    1    BY  1
                   UNTIL   IDZ >       3
               COMPUTE IDX1    =   IDZ     +   1
               PERFORM VARYING IDY FROM    IDX1    BY  1
                       UNTIL   IDY >       4
                   IF      WRK-KOHHKNNUM-O (IDZ) >   
                                           WRK-KOHHKNNUM-O (IDY)
                   OR      WRK-KOHHKNNUM-O (IDZ) =   SPACE 
                       MOVE    WRK-KOHI-TBL    (IDZ) TO  
                                           WRK-KOHI
                       MOVE    WRK-KOHI-TBL    (IDY) TO  
                                           WRK-KOHI-TBL(IDZ)
                       MOVE    WRK-KOHI              TO  
                                           WRK-KOHI-TBL(IDY)
                   END-IF
               END-PERFORM
           END-PERFORM
      *
      *    地方公費の追加
           PERFORM VARYING IDZ FROM    1   BY  1
                   UNTIL   IDZ         >   4
                   OR      TBL-MAX     =   4 
               IF      WRK-KOHID-O (IDZ)   >   ZERO
                   ADD     1               TO  TBL-MAX
                   MOVE    WRK-KOHI-TBL (IDZ)
                           TO  WRK-KOHI-TBL-X (TBL-MAX)
               END-IF    
           END-PERFORM
076800     .
076900 20012-KOHID-HENSYU-EXT.
077000     EXIT.
      *
      *****************************************************************
      *    保険組合せリスト処理
      *****************************************************************
       2002-HKNCOMBI-LIST-SEC        SECTION.
      *
           INITIALIZE                  HZN-LF01-REC
           MOVE    1                   TO  IDX
           MOVE    WRK-LF01-TBL(IDX-HZN)   TO  HZN-LF01-TBL (1)
           PERFORM VARYING     IDY     FROM    1   BY  1
                   UNTIL      (IDY     >   20  )  OR
                              (IDX     >=  20  )
               IF      IDX-HZN         NOT =   IDY
                   ADD     1               TO  IDX
                   MOVE    WRK-LF01-TBL(IDY)   TO  HZN-LF01-TBL (IDX)
               END-IF
           END-PERFORM
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL       IDX     >   20
               MOVE    HZN-LF01-TBL(IDX)   TO  WRK-LF01-TBL (IDX)
           END-PERFORM
      *
           .
       2002-HKNCOMBI-LIST-EXT.
           EXIT.
      *
      *****************************************************************
      *    負担率・負担額編集処理
      *****************************************************************
       400-KOHFTN-HENSYU-SEC        SECTION.
      *
      *
           MOVE    SPACE               TO  HKNNUM-REC
           MOVE    SPA-HOSPNUM         TO  HKN-HOSPNUM
      *    保険番号（公費）
           MOVE    PTKOH-KOHNUM        TO  HKN-HKNNUM
      *    支払区分
           MOVE    PTKOH-PAYKBN        TO  HKN-PAYKBN
           MOVE    SPA-SYSYMD          TO  HKN-TEKSTYMD
           MOVE    SPA-SYSYMD          TO  HKN-TEKEDYMD
      *
           MOVE    HKNNUM-REC          TO  MCPDATA-REC
           MOVE    "tbl_hknnum"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_hknnum"        TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 980-HKNNUM-READ-SEC
           ELSE
               INITIALIZE              HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
           MOVE    "tbl_hknnum"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           IF      WRK-GAIJGNKBN (IDY1)    =   SPACE
      *        本人−外来−回−負担割合
               COMPUTE WRK-FTNRATE         =   HKN-HON-GAIKFTNRATE
                                           /   100
               MOVE    WRK-FTNRATE         TO  WRK-Z9
               MOVE    WRK-Z9              TO  WRK-FTNRATEMEI
               MOVE    WRK-FTNRATEMEI      TO  WRK-LF01-RATIO (IDX IDY1)
               MOVE    "ratio"             TO  WRK-LF01-RATIO-CODE
                                                              (IDX IDY1)
           ELSE
      *        上限額
               IF      HKN-HON-GAIKKOTGAK  =   ZERO
      *            本人−外来−日−上限額
                   MOVE    HKN-HON-GAIDJGNGAK  TO  WRK-ZZ9
               ELSE
      *            本人−外来−回−上限額
                   MOVE    HKN-HON-GAIKKOTGAK  TO  WRK-ZZ9
               END-IF
               MOVE    WRK-ZZ9             TO  WRK-LF01-RATIO (IDX IDY1)
               MOVE    "fix"               TO  WRK-LF01-RATIO-CODE
                                                              (IDX IDY1)
           END-IF
           .
       400-KOHFTN-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    診察料コードを決定処理
      *****************************************************************
       2020-SRYCD-SET-SEC        SECTION.
      *
      *    受診履歴より診察回数を求める
           PERFORM 1000-SINSATU-KAISU-SEC
      *
           MOVE    ZERO                TO  FLG-ARIS
      *H28.4
           MOVE    ZERO                TO  FLG-SYONIKKR-OK
      *    小児かかりつけ診療料判定
           IF     (SPA-SYSYMD          >=  "20160401" )
      *    未就学前
             AND  (AGECHK-SYUGAKUKBN   =   1          )
             AND  (FLG-SYONIKKR-ARI    =   1          )
               PERFORM 20202-SYONIKAKARI-HEN-SEC
               IF      FLG-ARIS        =   1
                   GO      TO      2020-SRYCD-SET-EXT
               END-IF
           END-IF
      *
      *    小児科外来診療料
           IF      (FLG-SYONIKA-ARI    =   1   )  AND
                  ((WRK-NENREI-YY      <   3   )  OR
                   (WRK-NENREI-YY      =   3   AND
                    WRK-NENREI-MM      =   ZERO ))
               PERFORM 20201-SYONIKA-HEN-SEC
               IF      FLG-ARIS        =   1
                   GO      TO      2020-SRYCD-SET-EXT
               END-IF
           END-IF
      *
      *H27.1
           IF      SPA-SYSYMD          >=  "20150101"
      *        H27.1からのコード設定
               PERFORM 20210-SRYCD-SET02-SEC
               GO      TO      2020-SRYCD-SET-EXT
           END-IF
      *
      *    診察料コードを決定する
           IF      WRK-SYOSIN          =   1
               MOVE    "11"                TO  WRK-SRYKBN
               MOVE    "F"                 TO  WRK-KBN
      *        診察コードをテーブルより決定
               PERFORM 2001-SRYCD-TBL-SEC
               MOVE    "110"           TO
                       WRK-LF01-BUNDLE-CLASSCODE    
           ELSE
      *        同日再診料算定
               IF      WRK-LSTYMD          =   SPA-SYSYMD
                   MOVE    "12"                TO  WRK-SRYKBN
                   MOVE    "D"                 TO  WRK-KBN
      *            診察コードをテーブルより決定
                   PERFORM 2001-SRYCD-TBL-SEC
               ELSE
      *        再診料算定
                   MOVE    "12"                TO  WRK-SRYKBN
                   MOVE    SPACE               TO  WRK-KBN
      *            診察コードをテーブルより決定
                   PERFORM 2001-SRYCD-TBL-SEC
               END-IF
               MOVE    "120"           TO
                       WRK-LF01-BUNDLE-CLASSCODE    
           END-IF
           .
       2020-SRYCD-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴より診察回数を求める処理
      *****************************************************************
       1000-SINSATU-KAISU-SEC          SECTION.
      *
           MOVE    ZERO                TO  WRK-SINSATU-CNT
           MOVE    ZERO                TO  FLG-15MIMAN
           MOVE    ZERO                TO  WRK-15MIMAN-ARI
      *
      *    年齢計算
      *    MOVE    PTINF-BIRTHDAY      TO  WRK-YMDS1
      *    MOVE    SPA-SYSYMD          TO  WRK-YMDS2
      *    COMPUTE WRK-NENREI-YY       =   WRK-YYS2
      *                                -   WRK-YYS1
      *    IF      WRK-YMDS1(5:4)      >   WRK-YMDS2(5:4)
      *        COMPUTE WRK-NENREI-YY   =   WRK-NENREI-YY
      *                                    -   1
      *        COMPUTE WRK-NENREI-MM   =  (WRK-MMS2  +  12 )
      *                                    -   WRK-MMS1
      *    ELSE
      *        COMPUTE WRK-NENREI-MM   =   WRK-MMS2
      *                                    -   WRK-MMS1
      *    END-IF
      *    IF      WRK-DDS1            >   WRK-DDS2
      *        COMPUTE WRK-NENREI-MM   =   WRK-NENREI-MM
      *                                    -   1
      *    END-IF
      *H28.4
      *    年齢算定
           INITIALIZE                  ORCSAGECHKAREA
           MOVE    SPA-HOSPNUM         TO  AGECHK-HOSPNUM
           MOVE    SPA-PTID            TO  AGECHK-PTID
           MOVE    SPA-SYSYMD          TO  AGECHK-SRYYMD
           MOVE    PTINF-BIRTHDAY      TO  AGECHK-BIRTHDAY
           CALL    "ORCSAGECHK"        USING
                                       ORCSAGECHKAREA
                                       SPA-AREA
           MOVE    AGECHK-NENREI2-YY   TO  WRK-NENREI-YY
           MOVE    AGECHK-NENREI2-MM   TO  WRK-NENREI-MM
           MOVE    AGECHK-NENREI2-DD   TO  WRK-NENREI-DD
      *
      *    １５歳になる年月日を計算
           MOVE    PTINF-BIRTHDAY      TO  WRK-BIRTHDAY
           COMPUTE WRK-BIRTH-YY        =   WRK-BIRTH-YY    +  15
      *
      *    受診履歴より受診回数を求める
      *    受診歴を検索する（診療月１日から診療日までの範囲）
           MOVE    SPACE               TO  JYURRK-REC
           INITIALIZE                  JYURRK-KEY
           MOVE    SPA-HOSPNUM         TO  JYURRK-HOSPNUM
           MOVE    SPA-PTID            TO  JYURRK-PTID
      *
      *    Ｈ１５年６月よりすべて１回目とする
           IF      SPA-SYSYMD          >=  "20030601"
               MOVE    SPA-SYSYMD          TO  JYURRK-SRYYMD
           ELSE
               MOVE    SPA-SYSYMD          TO  JYURRK-SRYYMD
               MOVE    "01"                TO  JYURRK-SRYYMD(7:2)
           END-IF
           MOVE    SPA-SYSYMD          TO  JYURRK-UPSRYYMD
           MOVE    "2"                 TO  JYURRK-NYUGAIKBN
      *
           MOVE    JYURRK-REC          TO  MCPDATA-REC
           MOVE    "tbl_jyurrk"        TO  MCP-TABLE
           MOVE    "key14"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_jyurrk"        TO  MCP-TABLE
               MOVE    "key14"             TO  MCP-PATHNAME
               PERFORM 970-JYURRK-READ-SEC
           ELSE
               MOVE    SPACE               TO  JYURRK-REC
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
           PERFORM
                   UNTIL    FLG-JYURRK     =   1
               IF      JYURRK-RENNUM       =   1
                   MOVE    ZERO            TO  FLG-SYONIKA
               END-IF
               MOVE    ZERO                TO  FLG-CHK
               IF      FLG-CHK             =   ZERO
      *            受診履歴に同日他科算定がないこと
                   PERFORM 10001-DOUJI-CHK-SEC
               END-IF
      *
               IF     (JYURRK-EDANUM       =   1   )  AND
                      (JYURRK-DOUJI-RENNUM =   1  OR  ZERO )
                   CONTINUE
               ELSE
                   MOVE    1               TO  FLG-CHK
               END-IF
      *        受診回数
               IF      FLG-CHK         =   ZERO
                   ADD     1               TO  WRK-SINSATU-CNT
               END-IF
      *
               MOVE    "tbl_jyurrk"        TO  MCP-TABLE
               MOVE    "key14"             TO  MCP-PATHNAME
               PERFORM 970-JYURRK-READ-SEC
           END-PERFORM
           MOVE    "tbl_jyurrk"        TO  MCP-TABLE
           MOVE    "key14"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *!   １５歳未満再診科算定有り
      *    IF     (WRK-NENREI-YY       =   15              )  AND
      *           (WRK-BIRTHDAY(1:6)   =   SPA-SYSYMD (1:6))
      *        IF      FLG-15MIMAN         =   1
      *            MOVE    1               TO  WRK-15MIMAN-ARI
      *        END-IF
      *!   END-IF
           .
       1000-SINSATU-KAISU-EXT.
           EXIT.
      *
      *****************************************************************
      *    受診履歴に同日他科算定チェック処理
      *****************************************************************
       10001-DOUJI-CHK-SEC                  SECTION.
      *
           IF      JYURRK-SRYKBN (01)      =   "01"
               CONTINUE
           ELSE
               MOVE    1                   TO  FLG-CHK
               GO      TO      10001-DOUJI-CHK-EXT
           END-IF
      *
           MOVE    ZERO                TO  FLG-SINSATU
           MOVE    ZERO                TO  FLG-SYOSIN
           PERFORM VARYING     IDX     FROM    1   BY  1
                   UNTIL      (IDX     >   15  )  OR
                              (FLG-SINSATU         =   1     )  OR
                              (JYURRK-ZAINUM (IDX) =   ZERO  )
      *
               MOVE    SPACE               TO  SRYACT-REC
               INITIALIZE                  SRYACT-REC
               MOVE    SPA-HOSPNUM         TO  SRY-HOSPNUM
               MOVE    "2"                 TO  SRY-NYUGAIKBN
               MOVE    JYURRK-PTID         TO  SRY-PTID
               MOVE    JYURRK-SRYKA        TO  SRY-SRYKA
               MOVE    JYURRK-SRYYMD(1:6)  TO  SRY-SRYYM
               MOVE    JYURRK-ZAINUM (IDX)
                                           TO  SRY-ZAINUM
      *
               MOVE    SRYACT-REC          TO  MCPDATA-REC
               MOVE    "tbl_sryact"        TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 910-DBSELECT-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    "tbl_sryact"        TO  MCP-TABLE
                   MOVE    "key2"              TO  MCP-PATHNAME
                   PERFORM 930-SRYACT-READ-SEC
                ELSE
                   INITIALIZE                  SRYACT-REC
                   MOVE    1               TO  FLG-SRYACT
               END-IF
      *
               PERFORM
                       UNTIL  (FLG-SRYACT      =   1     )  OR
                              (FLG-SINSATU     =   1     )
                   PERFORM VARYING     IDY     FROM    1   BY  1
                           UNTIL   (IDY        >   5   )  OR
                                   (FLG-SINSATU          =   1     )  OR
                                   (SRY-SRYCD (IDY)      =   SPACE )
                       PERFORM 100011-IPN-DOUJI-CHK-SEC
                   END-PERFORM
      *
                   MOVE    "tbl_sryact"        TO  MCP-TABLE
                   MOVE    "key2"              TO  MCP-PATHNAME
                   PERFORM 930-SRYACT-READ-SEC
               END-PERFORM
               MOVE    "tbl_sryact"        TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 990-DBCLOSE-SEC
      *
           END-PERFORM
      *
           IF    ((FLG-SINSATU         =   1   )  OR
                  (FLG-SYONIKA         =   1   ))  AND
                  (FLG-SYOSIN          =   ZERO )
               MOVE    ZERO            TO  FLG-CHK
           ELSE
               MOVE    1               TO  FLG-CHK
           END-IF
      *
      *    初診料算定時、回数をクリアする
           IF      FLG-SYOSIN          =   1
               MOVE    ZERO            TO  WRK-SINSATU-CNT
           END-IF
      *
           .
       10001-DOUJI-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    一般同日他科算定チェック処理
      *****************************************************************
       100011-IPN-DOUJI-CHK-SEC        SECTION.
      *
      *    診察料検索
           SET     TBL-IDX             TO  1
           SEARCH  TBL-SINSATU-OCC     VARYING   TBL-IDX
               AT   END
                   MOVE    ZERO               TO  FLG-ARI
                   MOVE    SPACE              TO  WRK-KBN
                   MOVE    SPACE              TO  WRK-KBN2
               WHEN   SRY-SRYCD (IDY)     =   TBL-SRYCD (TBL-IDX)
                   MOVE    1                  TO  FLG-ARI
                   MOVE    TBL-KBN  (TBL-IDX) TO  WRK-KBN
                   MOVE    TBL-KBN2 (TBL-IDX) TO  WRK-KBN2
           END-SEARCH
      *
           IF      FLG-ARI         =   1
               MOVE    1               TO  FLG-SINSATU
      *        小児科外来診察料あり
               IF      SRY-SRYCD(IDY)(1:3)     =   "113"
                   MOVE    1           TO  FLG-SYONIKA
               END-IF
      *!       １５歳未満の受診あり
      *        IF      JYURRK-SRYYMD       <   WRK-BIRTHDAY
      *            MOVE    1               TO  FLG-15MIMAN
      *!       END-IF
           ELSE
               EVALUATE    SRY-SRYCD (IDY)
      *            在宅患者訪問診察料
                   WHEN    "114001110"
      *            在宅末期医療総合診察料
                   WHEN    "114007610"
                   WHEN    "114007710"
                       MOVE    1               TO  FLG-SINSATU
               END-EVALUATE
           END-IF
      *    初診料は算定外とする
           IF     (SRY-SRYKBN          =   "11" )  OR
                  (SRY-SRYCD(IDY)      =   "113003510"  OR
                                           "113003710" )
               MOVE    1               TO  FLG-SYOSIN
           END-IF
      *
           .
       100011-IPN-DOUJI-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    診察料をテーブルより決定処理
      *****************************************************************
       2001-SRYCD-TBL-SEC              SECTION.
      *
           IF      WRK-SRYKBN          =   "11"
               MOVE    1               TO  WRK-KAISU
           ELSE
      ******   EVALUATE    WRK-SINSATU-CNT
      *            WHEN    0
      *                MOVE    1               TO  WRK-KAISU
      *            WHEN    1
      *            WHEN    2
      *                MOVE    2               TO  WRK-KAISU
      *            WHEN    OTHER
      *                MOVE    4               TO  WRK-KAISU
      ******** END-EVALUATE
      *        病院で２００床以上は外来診療料とする
               IF      (SYS-1001-HOSPSBT       =   "1"  )  AND
                       (SYS-1001-BEDSUIPN      >=  200  )
                   MOVE    5               TO  WRK-KAISU
               ELSE
      *        以外はすべて１回目とする
                   MOVE    1               TO  WRK-KAISU
               END-IF
           END-IF
      *
           MOVE    SPACE               TO  WRK-KBN2
      *!!! １５才未満
      *    IF    ((WRK-NENREI-YY       <   15 ) OR
      *           (WRK-15MIMAN-ARI     =   1  )) AND
      *          ( WRK-KAISU           =   4  )
      *        MOVE    4                   TO  WRK-KAISU
      *        MOVE    "M"                 TO  WRK-KBN2
      *!!! END-IF
      *    老人
           IF      WRK-NENREI-YY       >=  70
               MOVE    1               TO  FLG-ROUJIN
           ELSE
               MOVE    ZERO            TO  FLG-ROUJIN
           END-IF
      *Ｈ１８／４改正対応
      *    すべて一般
           MOVE    SYS-1001-HOSPSBT    TO  WRK-HOSPSBT
           IF      SPA-SYSYMD(1:6)     >=  "200604"
               MOVE    ZERO                TO  FLG-ROUJIN
               IF      WRK-KBN             =   "F"
                   MOVE    1               TO  WRK-HOSPSBT
               END-IF
           END-IF
      *Ｈ２２年４月改正
      *    すべて病院（診療所廃止）
           IF      SPA-SYSYMD(1:6)     >=  "201004"
               MOVE    1               TO  WRK-HOSPSBT
           END-IF
      *
      *    診察料セット
           SET     TBL-IDX             TO  1
           SEARCH  TBL-SINSATU-OCC     VARYING   TBL-IDX
                   AT   END
                       MOVE    SPACE           TO  WRK-LF01-IJICD
                       DISPLAY "*** ORCL0011 IJICD ERR HOSPSBT="
                               SYS-1001-HOSPSBT " SYOSIN=" WRK-SYOSIN 
                   WHEN   (WRK-KAISU           =   TBL-KAISU (TBL-IDX))
                     AND  (FLG-ROUJIN          =   TBL-ROUJIN(TBL-IDX))
                     AND  (WRK-HOSPSBT         =   TBL-HOSPSBT(TBL-IDX))
                     AND  (WRK-KBN             =   TBL-KBN    (TBL-IDX))
                     AND  (WRK-KBN2            =   TBL-KBN2   (TBL-IDX))
                     AND  (WRK-SRYKBN          =   TBL-SRYCD(TBL-IDX)
                                                                (2:2))
                       MOVE    TBL-SRYCD (TBL-IDX)
                                               TO  WRK-LF01-IJICD
           END-SEARCH
      *
           .
       2001-SRYCD-TBL-EXT.
           EXIT.
      *
      *****************************************************************
      *    小児科外来診察料変換処理
      *****************************************************************
       20201-SYONIKA-HEN-SEC        SECTION.
      *
      *    ３歳になる年月日を計算
           MOVE    PTINF-BIRTHDAY      TO  WRK-BIRTHDAY
           COMPUTE WRK-BIRTH-YY        =   WRK-BIRTH-YY    +  3
      *    ３歳到達月に適用
           IF      WRK-BIRTHDAY(1:6)   <   SPA-SYSYMD (1:6)
               GO      TO      20201-SYONIKA-HEN-EXT
           END-IF
      *
           IF      (WRK-NENREI-YY      =   3 )  AND
                   (WRK-NENREI-MM      =   ZERO)  AND
                   (PTINF-BIRTHDAY(7:2)    <=  SPA-SYSYMD(7:2))
      *        ３歳の誕生日以前で、当月に診察があった時
               IF      WRK-LSTYMD(1:6)     =   SPA-SYSYMD(1:6)
                   IF     (WRK-LSTYMD          =   SPA-SYSYMD) AND
                          (FLG-SYONIKA         =   ZERO      )
                       GO      TO      20201-SYONIKA-HEN-EXT
                   END-IF
               ELSE
                   GO      TO      20201-SYONIKA-HEN-EXT
               END-IF
           END-IF
           MOVE    1                   TO  FLG-ARIS
      *
      *    診察料コードを決定する
           IF      WRK-SYOSIN          =   1
      *        初診
               IF      SYS-1001-SYOHOKBN    =   "0"
      *            院内
                   MOVE    "113003710"         TO  WRK-LF01-IJICD
               ELSE
      *            院外
                   MOVE    "113003510"         TO  WRK-LF01-IJICD
               END-IF
               MOVE    "130"           TO  WRK-LF01-BUNDLE-CLASSCODE
           ELSE
      *        再診
               IF      SYS-1001-SYOHOKBN    =   "0"
      *            院内
                   MOVE    "113003810"         TO  WRK-LF01-IJICD
               ELSE
      *            院外
                   MOVE    "113003610"         TO  WRK-LF01-IJICD
               END-IF
               MOVE    "130"           TO  WRK-LF01-BUNDLE-CLASSCODE
           END-IF
      *
           .
       20201-SYONIKA-HEN-EXT.
           EXIT.
      *H27.1
      *****************************************************************
      *    診察料コード決定処理（Ｈ２７年１月から）
      *****************************************************************
       20210-SRYCD-SET02-SEC        SECTION.
      *
      *    診察料コードを決定する
           IF      WRK-SYOSIN          =   1
               MOVE    "11"                TO  WRK-SRYKBN
               MOVE    "F"                 TO  WRK-KBN
      *        診察コードをテーブルより決定
               PERFORM 20210-SRYCD-TBL02-SEC
               MOVE    "110"               TO  WRK-LF01-BUNDLE-CLASSCODE
           ELSE
      *        同日再診料算定
               IF      WRK-LSTYMD          =   SPA-SYSYMD
                   MOVE    "12"                TO  WRK-SRYKBN
                   MOVE    "D"                 TO  WRK-KBN
      *            診察コードをテーブルより決定
                   PERFORM 20210-SRYCD-TBL02-SEC
               ELSE
      *        再診料算定
                   MOVE    "12"                TO  WRK-SRYKBN
                   MOVE    SPACE               TO  WRK-KBN
      *            診察コードをテーブルより決定
                   PERFORM 20210-SRYCD-TBL02-SEC
               END-IF
               MOVE    "120"               TO  WRK-LF01-BUNDLE-CLASSCODE
           END-IF
      *
           .
       20210-SRYCD-SET02-EXT.
           EXIT.
      *****************************************************************
      *    診察料をテーブルより決定処理
      *****************************************************************
       20210-SRYCD-TBL02-SEC              SECTION.
      *
           MOVE    1                   TO  WRK-KAISU
           IF      WRK-SRYKBN          =   "12"
      *        一般病床数
               IF     (SYS-1001-HOSPSBT    =   "1"  )  AND
                      (SYS-1001-BEDSUIPN   >=  200  )
      *            200床以上は外来診察料
                   MOVE    3               TO  WRK-KAISU
               END-IF
           END-IF
      *
           IF      WRK-SRYKBN          =   "11"
               MOVE    ZERO                TO  WRK-HOSPSBT
           ELSE
               MOVE    SPA-HOSPSBT         TO  WRK-HOSPSBT
           END-IF
      *H27.1
      *    妥結率５割以下
           IF     (WRK-DAKT50-KBN      =   1          )
               MOVE    "2"             TO  WRK-ETCKBN
           ELSE
               MOVE    "0"             TO  WRK-ETCKBN
           END-IF
      *
      *    診察料セット
           SET     TBL2-IDX             TO  1
           SEARCH  TBL2-SINSATU-OCC     VARYING   TBL2-IDX
               AT   END
                   MOVE    SPACE           TO  WRK-LF01-IJICD
               WHEN   (WRK-KAISU           =   TBL2-KAISU(TBL2-IDX))
                 AND  (WRK-KBN             =   TBL2-KBN  (TBL2-IDX))
                 AND  (WRK-ETCKBN          =   TBL2-ETCKBN(TBL2-IDX))
                   MOVE    TBL2-SRYCD (TBL2-IDX)
                                               TO  WRK-LF01-IJICD
           END-SEARCH
      *
           .
       20210-SRYCD-TBL02-EXT.
           EXIT.
      *H28.4
      *****************************************************************
      *    小児かかりつけ診療料判定編集処理
      *****************************************************************
       20202-SYONIKAKARI-HEN-SEC        SECTION.
      *
           MOVE    ZERO                TO  FLG-SYOUNI-ARI
      *    小児かかりつけ診療
           INITIALIZE                  PTCONF-REC
           MOVE    PTINF-HOSPNUM       TO  PTCONF-HOSPNUM
           MOVE    PTINF-PTID          TO  PTCONF-PTID
           MOVE    "SYOUNIKAKARI"      TO  PTCONF-CKEY
      *
           MOVE    PTCONF-REC          TO  MCPDATA-REC
           MOVE    "tbl_ptconf"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           MOVE    "DBSELECT"          TO  MCP-FUNC
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptconf"        TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 930-PTCONF-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTCONF
               INITIALIZE                  PTCONF-REC
           END-IF
           MOVE    "tbl_ptconf"        TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           IF      FLG-PTCONF          =   ZERO
               IF      PTCONF-CDATA(1:1)   =   "1"
                   MOVE    1               TO  FLG-SYOUNI-ARI
               END-IF
           END-IF
           IF      FLG-SYOUNI-ARI      =   ZERO
               GO      TO      20202-SYONIKAKARI-HEN-EXT
           END-IF
      *
      *    ３歳以上の算定履歴判定
           IF      WRK-NENREI-YY       >=  3
               PERFORM 10011-SYONIKKR-RRK-SEC 
               IF      FLG-SYOUNIKA-CHK    =   ZERO
                   GO      TO      20202-SYONIKAKARI-HEN-EXT
               END-IF
           END-IF
      *
           MOVE    1                   TO  FLG-ARIS
           MOVE    1                   TO  FLG-SYONIKKR-OK
      *    診察料コードを決定する
           IF      WRK-SYOSIN          =   1
      *        初診
               IF      SYS-1001-SYOHOKBN    =   "0"
      *            院内
                   MOVE    "113019910"         TO  WRK-LF01-IJICD
               ELSE
      *            院外
                   MOVE    "113019710"         TO  WRK-LF01-IJICD
               END-IF
               MOVE    "130"           TO  WRK-LF01-BUNDLE-CLASSCODE
           ELSE
      *        再診
               IF      SYS-1001-SYOHOKBN    =   "0"
      *            院内
                   MOVE    "113020010"         TO  WRK-LF01-IJICD
               ELSE
      *            院外
                   MOVE    "113019810"         TO  WRK-LF01-IJICD
               END-IF
               MOVE    "130"           TO  WRK-LF01-BUNDLE-CLASSCODE
           END-IF
           .
       20202-SYONIKAKARI-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    小児かかりつけ診療回数チェック処理
      *****************************************************************
       10011-SYONIKKR-RRK-SEC                  SECTION.
      *
           MOVE    ZERO                TO  FLG-SYOUNIKA-CHK
      *    算定履歴検索
           MOVE    SPACE               TO  SANTEI-REC
           INITIALIZE                  SANTEI-REC
           MOVE    SPA-HOSPNUM         TO  SANTEI-HOSPNUM
           MOVE    SPA-PTID            TO  SANTEI-PTID
           MOVE    "1130%"             TO  SANTEI-SRYCD
           MOVE    ZERO                TO  SANTEI-NYUGAIKBN
           MOVE    ZERO                TO  SANTEI-SRYKA
           MOVE    SPA-SYSYMD(1:6)     TO  SANTEI-SRYYM
           MOVE    ZERO                TO  SANTEI-HKNCOMBINUM
      *
           MOVE    SANTEI-REC          TO  MCPDATA-REC
           MOVE    "tbl_santei"        TO  MCP-TABLE
           MOVE    "key16"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "key16"             TO  MCP-PATHNAME
               PERFORM 920-SANTEI-READ-SEC
           ELSE
               MOVE    1                   TO  FLG-SANTEI
           END-IF
      *
           PERFORM
               UNTIL      (FLG-SANTEI      =   1 )
                       OR (FLG-SYOUNIKA-CHK    NOT =   ZERO )
               EVALUATE    SANTEI-SRYCD
      *        小児かかりつけ診療科
               WHEN    "113019710"
               WHEN    "113019910"
               WHEN    "113019810"
               WHEN    "113020010"
                   MOVE    1               TO  FLG-SYOUNIKA-CHK
               END-EVALUATE
      *
               MOVE    "tbl_santei"        TO  MCP-TABLE
               MOVE    "key16"             TO  MCP-PATHNAME
               PERFORM 920-SANTEI-READ-SEC
           END-PERFORM
           MOVE    "tbl_santei"        TO  MCP-TABLE
           MOVE    "key16"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           .
       10011-SYONIKKR-RRK-EXT.
           EXIT.
      *
      *****************************************************************
      *    受付メモ編集処理
      *****************************************************************
        2009-PTMEMOINF-SEC        SECTION.
      *
           MOVE    SPACE               TO  PTMEMOINF-REC
           INITIALIZE                  PTMEMOINF-REC
           MOVE    SPA-HOSPNUM         TO  PTMEMOINF-HOSPNUM
           MOVE    SPA-PTID            TO  PTMEMOINF-PTID
           MOVE    2                   TO  PTMEMOINF-MEMOKBN
           MOVE    SPA-SYSYMD          TO  PTMEMOINF-SYSYMD
      *
           MOVE    PTMEMOINF-REC       TO  MCPDATA-REC
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 910-PTMEMOINF-READ-SEC
           ELSE
               MOVE    1               TO  FLG-PTMEMOINF
               INITIALIZE                  PTMEMOINF-REC
           END-IF
           MOVE    SPACE               TO  WRK-MEMO
           PERFORM UNTIL    FLG-PTMEMOINF  =   1
               IF      PTMEMOINF-SRYKA     =   "00"
                   IF      WRK-MEMO        =   SPACE
                       MOVE    PTMEMOINF-MEMO  TO  WRK-MEMO
                   END-IF
               ELSE
                   IF      PTMEMOINF-SRYKA     =   SPA-SRYKA
                       MOVE    PTMEMOINF-MEMO  TO  WRK-MEMO
                   END-IF
               END-IF
               MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
               MOVE    "key2"              TO  MCP-PATHNAME
               PERFORM 910-PTMEMOINF-READ-SEC
           END-PERFORM
           MOVE    "tbl_ptmemoinf"     TO  MCP-TABLE
           MOVE    "key2"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           MOVE    SPACE               TO  WRK-MEMO-G
           MOVE    WRK-MEMO            TO  WRK-MEMO-OK
           IF      WRK-MEMO        NOT =   SPACE
      *        改行を"@"とする
               INSPECT     WRK-MEMO    REPLACING  ALL  X"0A"
                                                  BY   "/"
               UNSTRING    WRK-MEMO    DELIMITED BY "＊＊＊＊＊"
                     INTO  WRK-MEMO-01
                           WRK-MEMO-02
                           WRK-MEMO-03
                           WRK-MEMO-04
                           WRK-MEMO-05
               END-UNSTRING
               IF      WRK-MEMO-01     NOT =   SPACE
                   MOVE    WRK-MEMO-01     TO  WRK-MEMO-OK
               END-IF
               IF      WRK-MEMO-02     NOT =   SPACE
                   IF      WRK-MEMO-02(1:1)    =   "/"
                       MOVE    WRK-MEMO-02(2:) TO  WRK-MEMO-OK
                   ELSE
                       MOVE    WRK-MEMO-02     TO  WRK-MEMO-OK
                   END-IF
               END-IF
               IF      WRK-MEMO-03     NOT =   SPACE
                   IF      WRK-MEMO-03(1:1)    =   "/"
                       MOVE    WRK-MEMO-03(2:) TO  WRK-MEMO-OK
                   ELSE
                       MOVE    WRK-MEMO-03     TO  WRK-MEMO-OK
                   END-IF
               END-IF
               IF      WRK-MEMO-04     NOT =   SPACE
                   IF      WRK-MEMO-04(1:1)    =   "/"
                       MOVE    WRK-MEMO-04(2:) TO  WRK-MEMO-OK
                   ELSE
                       MOVE    WRK-MEMO-04     TO  WRK-MEMO-OK
                   END-IF
               END-IF
               IF      WRK-MEMO-05     NOT =   SPACE
                   IF      WRK-MEMO-05(1:1)    =   "/"
                       MOVE    WRK-MEMO-05(2:) TO  WRK-MEMO-OK
                   ELSE
                       MOVE    WRK-MEMO-05     TO  WRK-MEMO-OK
                   END-IF
               END-IF
               INITIALIZE                  ORCXKANACONVAREA
               MOVE    1000                TO  KANACONV-LEN
               MOVE    1000                TO  KANACONV-STLEN
               MOVE    0                   TO  KANACONV-CONV-FLAG
               MOVE    0                   TO  KANACONV-CHAR-TYPE
               MOVE    WRK-MEMO-OK         TO  KANACONV-INDATA
               CALL    "kanaconv"          USING ORCXKANACONVAREA
               MOVE    KANACONV-OUTDATA    TO  WRK-MEMO-OK
           END-IF
      *    受付メモ
           MOVE    WRK-MEMO-OK         TO  WRK-LF01-UKE-MEMO
           .
        2009-PTMEMOINF-EXT.
           EXIT.
      *****************************************************************
      *    日付変換処理
      *****************************************************************
       500-HIZUKE-HENSYU-SEC        SECTION.
      *
           IF      WRK-WYMD         =   SPACE
               MOVE    ALL "0"          TO  WRK-WYMD
           END-IF
      *
           IF      WRK-WYMD         =   ALL "9"
               MOVE    "99991231"       TO  WRK-WYMD
           END-IF
      *
           MOVE    WRK-WYY          TO  WRK-HENYY
           MOVE    WRK-WMM          TO  WRK-HENMM
           MOVE    WRK-WDD          TO  WRK-HENDD
           .
       500-HIZUKE-HENSYU--EXT.
           EXIT.
      *
      *****************************************************************
      *    ＵＩＤ取得処理
      *****************************************************************
       500-UUID-SET-SEC             SECTION.
      *
           INITIALIZE     UIDIO-AREA.
           CALL    "orcuidset" USING ST UIDIO-AREA.
           DISPLAY "UUID CALL" UIDIO-AREA.
      *    WIN-EXEC GRAPH "DLL_orcuidset", UIDIO-AREA, " ", " ",
      *                                    UIDIO-AREA, ST
           .
       500-UUID-SET-EXT.
           EXIT.
      *
      *****************************************************************
      *    郵便番号変換処理
      *****************************************************************
       500-POST-HENSYU-SEC        SECTION.
      *
           IF      WRK-POST        =   SPACE
               MOVE    SPACE           TO  WRK-HENPOST
           ELSE
               MOVE    WRK-POST(1:3)   TO  WRK-HENPOST (1:3)
               MOVE    "-"             TO  WRK-HENPOST (4:1)
               MOVE    WRK-POST(4:4)   TO  WRK-HENPOST (5:4)       
           END-IF
           .
       500-POST-HENSYU-EXT.
           EXIT.
      *
      *****************************************************************
      *    全角拡張漢字変換処理
      *****************************************************************
       800-ORCSKANACHK-SEC        SECTION.
      *
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"                 TO  KANACHK-SYORI
           MOVE    WRK-KOUMOKU         TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"       USING
                                       ORCSKANACHKAREA
           MOVE    KANACHK-MAE-INPUT   TO  WRK-KOUMOKU
           .
       800-ORCSKANACHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    終了　　処理
      *****************************************************************
       300-END-SEC                 SECTION.
      *
           IF      FLG-CLMUID          =   ZERO
      *        UID更新処理
               MOVE    SMCNDATE-YMD        TO  CLMUID-UPYMD
               MOVE    SMCNDATE-HMS        TO  CLMUID-UPHMS
      *
               MOVE    CLMUID-REC          TO  MCPDATA-REC
               MOVE    "DBUPDATE"          TO  MCP-FUNC
               MOVE    "tbl_clm_uid"       TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               CALL    "ORCDBMAIN"         USING
                                               MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
               IF      MCP-RC          NOT =   ZERO 
                   DISPLAY "ORCL0011 UPD CLMUID-KEY =>" CLMUID-KEY  "."
               END-IF
           ELSE
      *        UID登録処理
               MOVE    SMCNDATE-YMD        TO  CLMUID-CREYMD
               MOVE    SMCNDATE-YMD        TO  CLMUID-UPYMD
               MOVE    SMCNDATE-HMS        TO  CLMUID-UPHMS
      *
               MOVE    CLMUID-REC          TO  MCPDATA-REC
               MOVE    "DBINSERT"          TO  MCP-FUNC
               MOVE    "tbl_clm_uid"       TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               CALL    "ORCDBMAIN"         USING
                                               MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
               IF      MCP-RC          NOT =   ZERO 
                   DISPLAY "ORCL0011 INS CLMUID-KEY =>" CLMUID-KEY  "."
               END-IF
           END-IF
      *
           .
       300-END-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者マスター読込処理
      *****************************************************************
       900-PTINF-READ-SEC         SECTION.
      *
           MOVE    PTINF-REC           TO  MCPDATA-REC
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptinf"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
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
           MOVE    "tbl_ptinf"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       900-PTINF-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者保険情報マスタ読込
      *****************************************************************
       910-PTHKNINF-INV-SEC         SECTION.
      *
           MOVE    "tbl_pthkninf"      TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_pthkninf"      TO  MCP-TABLE
               MOVE    "key3"              TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-PTHKNINF
                   MOVE    MCPDATA-REC         TO  PTHKNINF-REC
               ELSE
                   MOVE    1                   TO  FLG-PTHKNINF
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTHKNINF
           END-IF
      *
           MOVE    "tbl_pthkninf"      TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       910-PTHKNINF-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    患者公費情報マスタ読込
      *****************************************************************
       910-PTKOHINF-INV-SEC         SECTION.
      *
           MOVE    "tbl_ptkohinf"      TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_ptkohinf"      TO  MCP-TABLE
               MOVE    "key3"              TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-PTKOHINF
                   MOVE    MCPDATA-REC         TO  PTKOHINF-REC
               ELSE
                   MOVE    1                   TO  FLG-PTKOHINF
               END-IF
           ELSE
               MOVE    1                   TO  FLG-PTKOHINF
           END-IF
      *
           MOVE    "tbl_ptkohinf"      TO  MCP-TABLE
           MOVE    "key3"              TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       910-PTKOHINF-INV-EXT.
           EXIT.
      *****************************************************************
      *    ＵＩＤデータ読込処理
      *****************************************************************
       903-CLMUID-READ-SEC         SECTION.
      *
           MOVE    CLMUID-REC          TO  MCPDATA-REC
           MOVE    "tbl_clm_uid"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_clm_uid"       TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  CLMUID-REC
                   MOVE    ZERO                TO  FLG-CLMUID
               ELSE
                   MOVE    1                   TO  FLG-CLMUID
                   INITIALIZE                  CLMUID-REC
               END-IF
           ELSE
               MOVE    1                   TO  FLG-CLMUID
               INITIALIZE                  CLMUID-REC
           END-IF
      *
           MOVE    "tbl_clm_uid"       TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       903-CLMUID-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険組合せマスター読込
      *****************************************************************
       900-COMB-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
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
      *    管理マスター読込処理
      *****************************************************************
       901-SYSKANRI-READ-SEC        SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    ZERO                TO  FLG-SYSKANRI
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           .
       901-SYSKANRI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    管理マスター読込（キー）
      *****************************************************************
       900-SYSKANRI-INV-SEC         SECTION.
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_syskanri"      TO  MCP-TABLE
               MOVE    "key10"             TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    MCPDATA-REC         TO  SYSKANRI-REC
                   MOVE    ZERO                TO  FLG-SYSKANRI
               ELSE
                   MOVE    1                   TO  FLG-SYSKANRI
               END-IF
           ELSE
               MOVE    1                   TO  FLG-SYSKANRI
           END-IF
      *
           MOVE    "tbl_syskanri"      TO  MCP-TABLE
           MOVE    "key10"             TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
      *
           .
       900-SYSKANRI-INV-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療科歴データ主キー検索
      *****************************************************************
       975-SRYKARRK-READ-SEC           SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SRYKARRK-REC
               MOVE    ZERO                TO  FLG-SRYKARRK
           ELSE
               MOVE    1                   TO  FLG-SRYKARRK
               INITIALIZE                  SRYKARRK-REC
           END-IF
      *
           .
       975-SRYKARRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    点数読込
      *****************************************************************
       900-TENSU-INV-SEC           SECTION.
      *
           MOVE    SPA-SYSYMD          TO  TNS-YUKOSTYMD
           MOVE    SPA-SYSYMD          TO  TNS-YUKOEDYMD
      *
           MOVE    SPA-HOSPNUM         TO  TNS-HOSPNUM
           MOVE    TNS-TENSU-REC       TO  MCPDATA-REC
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 910-DBSELECT-SEC
           IF      MCP-RC              =   ZERO
               MOVE    "tbl_tensu"         TO  MCP-TABLE
               MOVE    "key"               TO  MCP-PATHNAME
               PERFORM 920-DBFETCH-SEC
               IF      MCP-RC              =   ZERO
                   MOVE    ZERO                TO  FLG-TENSU
                   MOVE    MCPDATA-REC         TO  TNS-TENSU-REC
               ELSE
                   MOVE    1                   TO  FLG-TENSU
               END-IF
           ELSE
               MOVE    1                   TO  FLG-TENSU
           END-IF
      *
           MOVE    "tbl_tensu"         TO  MCP-TABLE
           MOVE    "key"               TO  MCP-PATHNAME
           PERFORM 990-DBCLOSE-SEC
           .
       900-TENSU-INV-EXT.
           EXIT.
      ******************************************************************
      *    受診履歴マスター読込
      *****************************************************************
       970-JYURRK-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  JYURRK-REC
               MOVE    ZERO            TO  FLG-JYURRK
           ELSE
               INITIALIZE                  JYURRK-REC
               MOVE    1               TO  FLG-JYURRK
           END-IF
      *
           .
       970-JYURRK-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    診療行為マスター読込
      *****************************************************************
       930-SRYACT-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  SRYACT-REC
               MOVE    ZERO            TO  FLG-SRYACT
           ELSE
               INITIALIZE                  SRYACT-REC
               MOVE    1               TO  FLG-SRYACT
           END-IF
      *
           .
       930-SRYACT-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    保険番号マスタ次検索処理
      *****************************************************************
       980-HKNNUM-READ-SEC             SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  HKNNUM-REC
               MOVE    ZERO            TO  FLG-HKNNUM
           ELSE
               INITIALIZE              HKNNUM-REC
               MOVE    1               TO  FLG-HKNNUM
           END-IF
           .
       980-HKNNUM-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者メモ読込処理
      *****************************************************************
       910-PTMEMOINF-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  PTMEMOINF-REC
               MOVE    ZERO                TO  FLG-PTMEMOINF
           ELSE
               INITIALIZE                      PTMEMOINF-REC
               MOVE    1                   TO  FLG-PTMEMOINF
           END-IF
      *
           .
       910-PTMEMOINF-READ-EXT.
           EXIT.
      *****************************************************************
      *    患者特記事項読み込み
      *****************************************************************
       930-PTCONF-READ-SEC         SECTION.
      *
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC     TO  PTCONF-REC
               MOVE    ZERO            TO  FLG-PTCONF
           ELSE
               INITIALIZE                  PTCONF-REC
               MOVE    1               TO  FLG-PTCONF
           END-IF
      *
           .
       930-PTCONF-READ-EXT.
           EXIT.
      *****************************************************************
      *    算定歴マスタ読み込み
      *****************************************************************
       920-SANTEI-READ-SEC         SECTION.
      *
           MOVE    "tbl_santei"        TO  MCP-TABLE
           PERFORM 920-DBFETCH-SEC
           IF      MCP-RC              =   ZERO
               MOVE    MCPDATA-REC         TO  SANTEI-REC
               MOVE    ZERO                TO  FLG-SANTEI
           ELSE
               INITIALIZE                      SANTEI-REC
               MOVE    1                   TO  FLG-SANTEI
           END-IF
      *
           .
       920-SANTEI-READ-EXT.
           EXIT.
      *
      *****************************************************************
      *    テーブル検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"      TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
       910-DBSELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       920-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"       TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
       920-DBFETCH-EXT.
           EXIT.
      *
      *****************************************************************
      *    ＤＢクロース処理
      *****************************************************************
       990-DBCLOSE-SEC         SECTION.
      *
           MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
grpsys     CALL    "ORCDBMAIN"         USING   MCPAREA
                                               MCPDATA-REC
                                               SPA-AREA
           .
       990-DBCLOSE-EXT.
           EXIT.
      *
