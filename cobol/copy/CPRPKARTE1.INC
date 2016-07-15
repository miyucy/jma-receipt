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
        01  RPKARTE1-REC.
            03  RPKARTE1-PCONTEXT               PIC S9(9)   BINARY.
            03  RPKARTE1-OBJECT                 PIC X(8).
            03  RPKARTE1-MODE                   PIC S9(9)   BINARY.
            03  RPKARTE1-RECORDNAME             PIC X(128).
            03  RPKARTE1-DATA.
      *       karte_no1を設定
              05  RPKARTE1-REPORT-ID            PIC X(30).
      *       SYS-1031-PRTNM(1)
              05  RPKARTE1-PRINTER              PIC X(20).
              05  RPKARTE1-PTINF.
                07  RPKARTE1-PTNUM              PIC X(20).
                07  RPKARTE1-NAME               PIC X(50).
                07  RPKARTE1-KANANAME           PIC X(50).
                07  RPKARTE1-BIRTHDAY           PIC X(10).
                07  RPKARTE1-SEX                PIC X(1).
      *         KYUSEI-NAME
                07  RPKARTE1-KYUSEI-NAME        PIC X(50).
      *         KYUSEI-KANANAME
                07  RPKARTE1-KYUSEI-KANANAME    PIC X(50).
                07  RPKARTE1-TABOO              PIC X(100)  OCCURS  2.
                07  RPKARTE1-ALLERGY            PIC X(100)  OCCURS  2.
                07  RPKARTE1-KANSENSYO          PIC X(100)  OCCURS  2.
                07  RPKARTE1-COMMENT            PIC X(100)  OCCURS  2.
      *         状態名称１～３
                07  RPKARTE1-CONDITION          PIC X(20)   OCCURS  3.
      *         PTINF-CREYMD
                07  RPKARTE1-CREYMD             PIC X(10).
      *         KARRK-SYOSINYMD2
                07  RPKARTE1-SYOSHINYMD         PIC X(10).
                07  RPKARTE1-JOB                PIC X(20).
                07  RPKARTE1-SETAINUSI          PIC X(50).
                07  RPKARTE1-HOME-ADDRESS-G.
      *           HOME-ADRS(1):PTINF-HOME-ADRS / (2):PTINF-HOME-BANTI
                  09  RPKARTE1-HOME-ADRS        PIC X(100)  OCCURS  2.
      *           XXX-XXXX
                  09  RPKARTE1-HOME-POST        PIC X(8).
                  09  RPKARTE1-HOME-TEL1        PIC X(15).
                  09  RPKARTE1-HOME-TEL2        PIC X(15).
                07  RPKARTE1-RENRAKU-G.
                  09  RPKARTE1-RENRAKU_ADRS     PIC X(100)  OCCURS  2.
                  09  RPKARTE1-RENRAKU_ZOKUGARA PIC X(30).
                  09  RPKARTE1-RENRAKU_POST     PIC X(8).
                  09  RPKARTE1-RENRAKU_TEL1     PIC X(15).
                  09  RPKARTE1-RENRAKU_TEL2     PIC X(15).
                07  RPKARTE1-OFFICE-G.
                  09  RPKARTE1-OFFICE-NAME      PIC X(50).
                  09  RPKARTE1-OFFICE-ADRS      PIC X(100)  OCCURS  2.
                  09  RPKARTE1-OFFICE-POST      PIC X(8).
                  09  RPKARTE1-OFFICE_TEL       PIC X(15).
                07  RPKARTE1-KISEI-G.
                  09  RPKARTE1-KISEI_NAME       PIC X(50).
                  09  RPKARTE1-KISEI_ADRS       PIC X(100)  OCCURS  2.
                  09  RPKARTE1-KISEI_POST       PIC X(8).
                  09  RPKARTE1-KISEI_TEL        PIC X(15).
              05  RPKARTE1-HKNCOMBI-G.
                07  RPKARTE1-HKNCOMBI           PIC X(4).
      *             COMB-GAI-KFTNRATE
                07  RPKARTE1-GAI-KFTNRATE       PIC X(3).
      *             COMB-NYU-KFTNRATE
                07  RPKARTE1-NYU-KFTNRATE       PIC X(3).
                07  RPKARTE1-HKNNUM             PIC X(3).
      *             保険の種類名称
                07  RPKARTE1-HKNNAME            PIC X(20).
                07  RPKARTE1-HOKEN-G.
                  09  RPKARTE1-HKNJANAME        PIC X(100).
                  09  RPKARTE1-HKNJANUM         PIC X(8).
                  09  RPKARTE1-HKNJA-ADRS       PIC X(100)  OCCURS  2.
                  09  RPKARTE1-HKNJA-TEL        PIC X(15).
                  09  RPKARTE1-KIGO             PIC X(80).
                  09  RPKARTE1-NUM              PIC X(80).
                  09  RPKARTE1-CONTKBN          PIC X(1).
                  09  RPKARTE1-HOJOKBN          PIC X(1).
      *           保険年齢
                  09  RPKARTE1-HOKEN-AGE        PIC X(3).
                  09  RPKARTE1-HONKZKKBN        PIC X(1).
                  09  RPKARTE1-HIHKNJANAME      PIC X(100).
                  09  RPKARTE1-TEKSTYMD         PIC X(10).
                  09  RPKARTE1-TEKEDYMD         PIC X(10).
                07  RPKARTE1-ROSAI-G.
                  09  RPKARTE1-RSI-HKNKBN        PIC X(1).
                  09  RPKARTE1-RSI-KOFUNUM       PIC X(14).
                  09  RPKARTE1-RSI-NENKINNUM     PIC X(9).
                  09  RPKARTE1-RSI-RYOSTYMD      PIC X(10).
                  09  RPKARTE1-RSI-RYOEDYMD      PIC X(10).
                  09  RPKARTE1-RSI-SAIGAIKBN     PIC X(1).
                  09  RPKARTE1-RSI-SAIGAINAME    PIC X(20).
                  09  RPKARTE1-RSI-SHOBYOYMD     PIC X(10).
                  09  RPKARTE1-RSI-JIGYOUNAME    PIC X(50).
      *           東京都、北海道等
                  09  RPKARTE1-PREFNAME          PIC X(10).
      *           千代田区、札幌市等
                  09  RPKARTE1-CITYNAME          PIC X(50).
                07  RPKARTE1-KOHI-G              OCCURS  4.
                  09  RPKARTE1-KOH-HKNNUM        PIC X(3).
                  09  RPKARTE1-KOH-TANSEIDONAME  PIC X(20).
                  09  RPKARTE1-KOH-FTNJANUM      PIC X(8).
                  09  RPKARTE1-KOH-JKYSNUM       PIC X(20).
                  09  RPKARTE1-KOH-TEKSTYMD      PIC X(10).
                  09  RPKARTE1-KOH-TEKEDTYMD     PIC X(10).
              05  RPKARTE1-HOSP-G.
                07  RPKARTE1-HOSPNAME            PIC X(60).
              05  RPKARTE1-BYOMEI-G              OCCURS  1000.
      *             カルテに記載する（編集後の）病名
                07  RPKARTE1-BYOMEI              PIC X(160).
      *             PTBYO-SYUBYOFLG
                07  RPKARTE1-SYUBYOFLG           PIC X(1).
      *             PTBYO-UTAGAIFLG
                07  RPKARTE1-UTAGAIFLG           PIC X(1).
                07  RPKARTE1-SRYYMD              PIC X(10).
                07  RPKARTE1-TENKIYMD            PIC X(10).
      *             PTBYO-TENKIKBN
                07  RPKARTE1-TENKIKBN            PIC X(1).
