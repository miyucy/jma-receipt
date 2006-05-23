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
       IDENTIFICATION              DIVISION.
       PROGRAM-ID.                 ORCMCPSUB.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 共通
      *  コンポーネント名  : ＤＢサブ（バッチ用）
      *  管理者            : 
      *  作成日付    作業者        記述
      *  00/12/01    MCC           新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    MCC-藤原     01/08/07  CPPTKOHINF.INC 追加     
      *  01.00.02    MCC-多々納   02/04/04  CPADRS.INC 追加     
      *  01.00.03    MCC-藤原     01/04/09  CPUSERBYOMEI.INC 追加     
      *  NYUIN.15    NACL-太田    02/11/19  CPNYUKSNCHK.INC追加
      *****************************************************************
       ENVIRONMENT                 DIVISION.
       CONFIGURATION               SECTION.
      *
       DATA                        DIVISION.
       FILE                        SECTION.  
      *
           COPY    "CPMCPDBWRK.INC". 
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *    システム管理マスタ
           COPY    "CPSYSKANRI.INC".
      *
      *    病名
       01  BYOMEI-REC.
           COPY    "CPBYOMEI.INC".
      *    チェックマスタ
       01  CHK-REC.
       COPY    "CPCHK.INC".
      *    入力コードマスタ
       01  INPUTCD-REC.
           COPY    "CPINPUTCD.INC".
      *    患者番号変換
       01  PTNUM-REC.
           COPY    "CPPTNUM.INC".
      *
      *    点数マスタ−
           COPY    "CPTENSU.INC".
      *    パラメタテーブル
       01  PARA-REC.
           COPY    "CPPARA.INC".
      *
      *    患者マスタ
       01  PTINF-REC.
           COPY    "CPPTINF.INC".
      *    旧姓履歴
       01  KYUSEIRRK-REC.
           COPY    "CPKYUSEIRRK.INC".
      *
      *    点数マスタ−
       01  TENSUPLUS-REC.
           COPY    "CPTENSUPLUS.INC".
      *
       01  PTHKNINF-REC.
           COPY    "CPPTHKNINF.INC".
      *
       01  PTKOHINF-REC.
           COPY    "CPPTKOHINF.INC".
      *    住所マスタ
       01  ADRS-REC.
           COPY    "CPADRS.INC".
      *    自院病名マスタ
       01  USERBYOMEI-REC.
           COPY    "CPUSERBYOMEI.INC".
      *    請求管理マスタ
           COPY    "CPRCF010.INC".
      *
      *---- (NYUIN.15) LINE ADD START    -----------------------------
      *    入院料加算チェックマスター
       01  NYUKSNCHK-REC.
           COPY    "CPNYUKSNCHK.INC".
      *---- (NYUIN.15) LINE ADD END      -----------------------------
      *
      *    入院略称
       01  NYURYAKUSHO-REC.
           COPY    "CPNYUINRYAKUSHO.INC".
      *
      *
           COPY    'ORCA-DBCOMM'.
           COPY    'ORCA-DBPATH'.
      *
       LINKAGE                     SECTION.
           COPY    'MCPAREA'.
           COPY    "CPORCMCP.INC".
           COPY    "MCPDATA.INC".
      *
           COPY    "CPMCPDBPRO.INC". 
