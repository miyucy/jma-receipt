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
       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     ORCL0031N.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : ＣＬＡＩＭ
      *  コンポーネント名  : 入院ＣＬＡＩＭサブ
      *  管理者            : 
      *  作成日付    作業者        記述
      *  04/11/09    NACL−太田    新規作成
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *****************************************************************
      *
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       INPUT-OUTPUT                    SECTION.
       FILE-CONTROL.
      *
       DATA                            DIVISION.
       FILE                            SECTION.
      *
       WORKING-STORAGE                 SECTION.
      *
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-PTNYUINRRK          PIC 9(01).
           03  FLG-KARTE-KEY           PIC 9(01).
           03  FLG-END                 PIC 9(01).
           03  FLG-ORDER               PIC 9(01).
           03  FLG-ENTRYCHK            PIC 9(01).
           03  FLG-CHRERR              PIC 9(01).
      *
      *    カウント領域
       01  CNT-AREA.
           03  CNT-ORDER               PIC 9(05).
           03  CNT-IDOKBN              PIC 9(05).
           03  CNT-ERR                 PIC 9(05).
           03  CNT-TBLID               PIC 9(05).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX0                    PIC 9(05).
           03  IDX1                    PIC 9(05).
           03  IDX2                    PIC 9(05).
           03  IDX3                    PIC 9(05).
           03  IDX4                    PIC 9(05).
           03  IDXA                    PIC 9(05).
           03  IDXB                    PIC 9(05).
           03  IDX-IJI                 PIC 9(05).
           03  IDX-CMB                 PIC 9(05).
      *
      *    一時領域
       01  WRK-AREA.
           03  WRK-IDOKBN              PIC X(03).
           03  WRK-ERRCD               PIC X(04).
           03  WRK-KARTE-KEY           PIC X(36).
           03  WRK-ORDERNUM            PIC 9(05).
           03  WRK-ITEMNUM             PIC 9(05).
           03  WRK-ITEMID              PIC X(05).
           03  WRK-REMARKS             PIC X(80).
           03  WRK-KANACHK-MAE-INPUT   PIC X(500).
           03  WRK-KANACHK-OUT-INPUT   PIC X(500).
           03  WRK-PGNAME              PIC X(20).
           03  WRK-TBLID               PIC X(20).
           03  WRK-ITEM                PIC X(10).
           03  WRK-STATUS-ITEM         PIC X(01).
           03  WRK-UKEYMD              PIC X(08).
           03  WRK-UKEHMS              PIC X(06).
           03  WRK-ORDER-CLAIMID-G.
               05  WRK-ORDER-CLAIMIDH  PIC X(02).
               05  WRK-ORDER-CLAIMIDT  PIC X(03).
           03  WRK-CMB-CD              PIC X(10).
           03  WRK-CMB-ITM-G.
               05  WRK-CMB-ITM         PIC X(200).
           03  WRK-ORDERID             PIC X(04).
      *
       01  ERRCD-AREA.
           03  ERRCD-KHNERR            PIC X(04).
           03  ERRCD-IDOERR            PIC X(04).
           03  ERRCD-ERRCD             PIC X(04)
                                       OCCURS  2.
      *
      *    固定値領域
       01  CONST-AREA.
           03  CONST-SRYTBLP-MAX       PIC 9(05)   VALUE   20.
           03  CONST-SRYTBLC-MAX       PIC 9(05)   VALUE   30.
      *
      *    項目IDコピー句
           COPY    "CPNCLAIMID.INC".
      *
      *    ORDERIDコピー句
           COPY    "CPNORDERID.INC".
      *
      *****************************************************************
      *    ファイルレイアウト
      *****************************************************************
      *
      *    患者入院履歴
       01  PTNYUINRRK-REC.
           COPY    "CPPTNYUINRRK.INC".
      *
      *    オーダーテーブル
       01  ORDER-REC.
           COPY    "CPORDER.INC".
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
      *    カナチェックパラメタ
           COPY    "CPORCSKANACHK.INC".
      *
      *    入院異動チェックサブ
           COPY    "CPORCSODR.INC".
       01  LNK-ORDER-REC.
           02  LNK-ORDER-MAX           PIC 9(03).
           02  LNK-ORDER-OCC           OCCURS   30.
           COPY    "CPORDER.INC"       REPLACING  //ORDER-//
                                       BY         //LNK-ORDER-//.
      *    ＵＩＤ取得用エリア
       01  UIDIO-AREA.
           03  C-RET                   PIC X(2).
           03  C-UID                   PIC X(36).
       01  ST                          PIC 9(2).
      *
      *    マシン日付取得サブ
           COPY    "CPORCSMCNDATE.INC".
      *
           COPY    "MCPDATA.INC".
           COPY    "MCPAREA".
           COPY    "ORCA-DBPATH".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                         SECTION.
      *
           COPY    "CPORCL0031N.INC".
      *
       01  LF04-REC. 
           COPY    "CPRLF004.INC".
      *
      ******************************************************************
      *
       PROCEDURE                       DIVISION
                                       USING
                                               SCL31N-LNK
                                               LF04-REC.
      *
      *****************************************************************
      *    主　　処理
      *****************************************************************
       000-PROC-SEC                    SECTION.
      *
           PERFORM 100-INIT-SEC
      *
           IF    ( FLG-END     =   ZERO )
               PERFORM 200-MAIN-SEC
           END-IF
      *
           PERFORM 300-END-SEC
      *
           EXIT    PROGRAM
           .
      *****************************************************************
      *    初期　処理
      *****************************************************************
       100-INIT-SEC                    SECTION.
      *
           INITIALIZE                  WRK-AREA
           INITIALIZE                  FLG-AREA
           INITIALIZE                  CNT-AREA
           INITIALIZE                  IDX-AREA
      *
           MOVE    ZERO            TO  FLG-END
           MOVE    ZERO            TO  WRK-ORDERNUM
      *
           PERFORM 1001-KARTE-KEY-CHK-SEC
           IF    ( FLG-KARTE-KEY   =   9 )
               GO  TO  100-INIT-EXT
           END-IF
      *
           PERFORM 800-MCNDATE-SEC
           MOVE    SMCNDATE-YMD        TO  WRK-UKEYMD
           MOVE    SMCNDATE-HMS        TO  WRK-UKEHMS
      *
           PERFORM 1001-KIHON-CHK-SEC
      *
           .
       100-INIT-EXT.
           EXIT.
      *
      *****************************************************************
      *    カルテキーチェック処理（重複チェック）
      *****************************************************************
       1001-KARTE-KEY-CHK-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-KARTE-KEY
           MOVE    LF04-UID8           TO  WRK-KARTE-KEY
      *
           INITIALIZE                  ORDER-REC
           MOVE    SCL31N-HOSPID       TO  ORDER-HOSPID
           MOVE    LF04-UID8           TO  ORDER-KARTE-KEY
      *
           PERFORM 900-ORDER-KEY2-SEL-SEC
           IF    ( FLG-ORDER       =   ZERO )
               PERFORM 800-KARTE-KEY-GET-SEC
               INITIALIZE                  ORDER-REC
               MOVE    SCL31N-HOSPID   TO  ORDER-HOSPID
               MOVE    C-UID           TO  ORDER-KARTE-KEY
               PERFORM 900-ORDER-KEY2-SEL-SEC
               IF    ( FLG-ORDER       =   ZERO )
                   MOVE    9           TO  FLG-KARTE-KEY
                   DISPLAY "ORCL0031N ERROR:KARTE-KEY ２重登録"
                           " PTID="        SCL31N-PTID
                           " KARTE-KEY="   LF04-UID8
                   MOVE    1           TO  FLG-END
               ELSE
                   MOVE    C-UID       TO  WRK-KARTE-KEY
                   MOVE    1           TO  FLG-KARTE-KEY
               END-IF
           END-IF
      *
           .
       1001-KARTE-KEY-CHK-EXT.
           EXIT.
      *****************************************************************
      *    基本項目チェック
      *****************************************************************
       1001-KIHON-CHK-SEC              SECTION.
      *
           INITIALIZE                  ERRCD-AREA
           MOVE    ZERO            TO  CNT-ERR
      *
           IF    ( SCL31N-HOSPID   =   SPACE )
               MOVE    "0001"      TO  ERRCD-KHNERR
               PERFORM 1001-KIHON-ERRSET-SEC
           END-IF
      *
      *    IF    ( SCL31N-SRYKA    =   SPACE )
      *        MOVE    "0002"      TO  ERRCD-KHNERR
      *        PERFORM 1001-KIHON-ERRSET-SEC
      *    END-IF
      *
           IF    ( SCL31N-PTID     =   ZERO )
               MOVE    "0003"      TO  ERRCD-KHNERR
               PERFORM 1001-KIHON-ERRSET-SEC
           END-IF
      *
           IF    ( SCL31N-PTNUM    =   SPACE )
            OR   ( SCL31N-PTNUM    =   ZERO )
               MOVE    "0004"      TO  ERRCD-KHNERR
               PERFORM 1001-KIHON-ERRSET-SEC
           END-IF
      *
      *    IF    ( SCL31N-HKNCOMBI =   ZERO )
      *        MOVE    "0005"      TO  ERRCD-KHNERR
      *        PERFORM 1001-KIHON-ERRSET-SEC
      *    END-IF
      *
           IF    ( SCL31N-NYUGAIKBN    NOT =   "1" )
               MOVE    "0006"      TO  ERRCD-KHNERR
               PERFORM 1001-KIHON-ERRSET-SEC
           END-IF
      *
           IF    ( SCL31N-SRYYMD   =   SPACE )
               MOVE    "0007"      TO  ERRCD-KHNERR
               PERFORM 1001-KIHON-ERRSET-SEC
           END-IF
      *
           .
       1001-KIHON-CHK-EXT.
           EXIT.
      *****************************************************************
      *    エラーコードセット
      *****************************************************************
       1001-KIHON-ERRSET-SEC              SECTION.
      *
           IF    ( CNT-ERR         <   2 )
               COMPUTE CNT-ERR =   CNT-ERR +   1
               MOVE    ERRCD-KHNERR    TO  ERRCD-ERRCD (CNT-ERR)
           END-IF
      *
           .
       1001-KIHON-ERRSET-EXT.
           EXIT.
      *****************************************************************
      *    主　　処理
      *****************************************************************
       200-MAIN-SEC                SECTION.
      *
           PERFORM VARYING IDXA    FROM    1   BY  1
                   UNTIL ( IDXA    >   CONST-SRYTBLP-MAX )
                    OR   ( FLG-END =   1 )
      *
               IF    ( LF04-SRYCDTBL (IDXA) 
                                   =   NCLAIMID-NYUINNM )
      *
                   COMPUTE WRK-ORDERNUM
                       =   WRK-ORDERNUM    +   1
      *
                   EVALUATE    LF04-SRYCD (IDXA)
                   WHEN    NORDERID-ORDER-NYUIN
                   WHEN    NORDERID-ORDER-KYUSYOKU
                           PERFORM 2001-NYUINIDO-SEC
                   WHEN    OTHER
                       MOVE    "0008"  TO  WRK-ERRCD
                       MOVE    "000"   TO  WRK-IDOKBN
                       PERFORM 20011-ZAIERR-HEN-SEC
                   END-EVALUATE
      *
               END-IF
      *
           END-PERFORM
      *
           .
       200-MAIN-EXT.
           EXIT.
      *
      *****************************************************************
      *    入院異動処理
      *****************************************************************
       2001-NYUINIDO-SEC                   SECTION.
      *
           PERFORM 20011-NYUINIDOKBN-CHK-SEC
      *
           IF    ( ERRCD-ERRCD (1) =   SPACE )
            AND  ( ERRCD-IDOERR    =   SPACE )
                   PERFORM 20011-NYUINIDO-SYORI-SEC
      *
           ELSE
               IF    ( ERRCD-ERRCD (1) NOT =   SPACE )
                   MOVE    ERRCD-ERRCD (1) TO  WRK-ERRCD
                   PERFORM 20011-ZAIERR-HEN-SEC
               ELSE
                   MOVE    ERRCD-IDOERR    TO  WRK-ERRCD
                   PERFORM 20011-ZAIERR-HEN-SEC
               END-IF
           END-IF
      *
           .
       2001-NYUINIDO-EXT.
           EXIT.
      *****************************************************************
      *    入院異動区分チェック処理
      *****************************************************************
       20011-NYUINIDOKBN-CHK-SEC       SECTION.
      *
           MOVE    ZERO            TO  CNT-ORDER
                                       CNT-IDOKBN
      *
           MOVE    SPACE           TO  WRK-IDOKBN
      *
           MOVE    SPACE           TO  ERRCD-IDOERR
      *
           PERFORM VARYING IDXB    FROM    1   BY  1
                   UNTIL ( IDXB        >   CONST-SRYTBLC-MAX )
      *
               IF    ( LF04-TBLID (IDXA IDXB)
                                   =   NCLAIMID-NYUIDONM )
      *
                       COMPUTE CNT-ORDER   =   CNT-ORDER   +   1
      *
                   EVALUATE    LF04-SRYCD (IDXA) 
                   WHEN    NORDERID-ORDER-NYUIN
                       IF    (  LF04-IJICD (IDXA IDXB)
                                               =   NORDERID-NYUINCL2
                                               OR  NORDERID-TAIINCL2
                                               OR  NORDERID-GAIHKCL2
                                               OR  NORDERID-GBACKCL2
                                                                     )
                           COMPUTE CNT-IDOKBN  =   CNT-IDOKBN  +   1
                           MOVE    LF04-IJICD (IDXA IDXB)
                                       TO  WRK-IDOKBN
                       END-IF
                   WHEN    NORDERID-ORDER-KYUSYOKU
                       IF    (  LF04-IJICD (IDXA IDXB)
                                               =   NORDERID-FNORLCL2
                                               OR  NORDERID-FSPCLCL2
                                               OR  NORDERID-FSELECL2
                                               OR  NORDERID-FSTOPCL2
                                                                     )
                           COMPUTE CNT-IDOKBN  =   CNT-IDOKBN  +   1
                           MOVE    LF04-IJICD (IDXA IDXB)
                                       TO  WRK-IDOKBN
                       END-IF
                   END-EVALUATE
      *
               END-IF
      *
           END-PERFORM
      *
           IF    ( CNT-ORDER           <=  ZERO )
               MOVE    "0009"          TO  ERRCD-IDOERR
               GO  TO  20011-NYUINIDOKBN-CHK-EXT
           END-IF
      *
           IF    ( CNT-IDOKBN          <=  ZERO )
               MOVE    "0010"          TO  ERRCD-IDOERR
               GO  TO  20011-NYUINIDOKBN-CHK-EXT
           END-IF
      *
           IF    ( CNT-ORDER           >   1 )
               MOVE    "0011"          TO  ERRCD-IDOERR
               GO  TO  20011-NYUINIDOKBN-CHK-EXT
           END-IF
      *
           IF    ( CNT-IDOKBN          >   1 )
               MOVE    "0012"          TO  ERRCD-IDOERR
               GO  TO  20011-NYUINIDOKBN-CHK-EXT
           END-IF
      *
           .
       20011-NYUINIDOKBN-CHK-EXT.
           EXIT.
      *
      *****************************************************************
      *    剤エラー編集処理
      *****************************************************************
       20011-ZAIERR-HEN-SEC            SECTION.
      *
           MOVE    ZERO                TO  WRK-ITEMNUM
      *
           PERFORM VARYING IDXB    FROM    1   BY  1
                   UNTIL ( IDXB    >   CONST-SRYTBLC-MAX )
                    OR   ( FLG-END =   1 )
      *
               PERFORM VARYING IDX-IJI FROM    1   BY  1
                       UNTIL ( IDX-IJI >   NCLAIMID-ITEM-MAX )
                        OR   ( FLG-END =   1 )
                   IF    ( LF04-TBLID (IDXA IDXB)
                                   =   NCLAIMID-ITEMNM (IDX-IJI) )
                       MOVE    NCLAIMID-ITEMID (IDX-IJI)
                                       TO  WRK-ITEMID
                       PERFORM 20011-ORDER-INSERT-SEC
                   END-IF
               END-PERFORM
      *
           END-PERFORM
      *
           .
       20011-ZAIERR-HEN-EXT.
           EXIT.
      *****************************************************************
      *    入院異動処理
      *****************************************************************
       20011-NYUINIDO-SYORI-SEC        SECTION.
      *
           INITIALIZE                  SODR-AREA
           INITIALIZE                  LNK-ORDER-REC
      *
      *    引渡しオーダー情報設定処理
           PERFORM 20011-LNK-ORDER-SET-SEC
      *
           MOVE   SCL31N-HOSPID        TO  SODR-HOSPID
           MOVE   LF04-UID8            TO  SODR-UID8
           MOVE   SCL31N-NYUGAIKBN     TO  SODR-NYUGAIKBN
           MOVE   SCL31N-PTNUM         TO  SODR-PTNUM
           MOVE   SCL31N-PTID          TO  SODR-PTID
           MOVE   SCL31N-SRYKA         TO  SODR-SRYKA
           MOVE   SCL31N-SRYYMD        TO  SODR-SRYYMD
           MOVE   SCL31N-HKNCOMBI      TO  SODR-HKNCOMBI
           MOVE   SCL31N-DRCD          TO  SODR-DRCD
           MOVE   WRK-UKEYMD           TO  SODR-UKEYMD
           MOVE   WRK-UKEHMS           TO  SODR-UKEHMS
      *
           MOVE    "0"                 TO  SODR-PROCKBN
      *
           MOVE   "CLAIM"              TO  SODR-OPID
           MOVE   WRK-UKEYMD           TO  SODR-UPYMD
           MOVE   WRK-UKEHMS           TO  SODR-UPHMS
      *
           MOVE        SPACE           TO  WRK-PGNAME
      *
           INITIALIZE  WRK-ORDER-CLAIMID-G
           MOVE    LF04-SRYCD (IDXA)   TO  WRK-ORDER-CLAIMIDH
           MOVE    WRK-IDOKBN          TO  WRK-ORDER-CLAIMIDT
           MOVE    WRK-ORDER-CLAIMID-G TO  WRK-CMB-CD
           PERFORM 2300-ORDERID-CHK-SEC
           MOVE    WRK-CMB-ITM         TO  SODR-ORDERID
      *
           EVALUATE    SODR-ORDERID
           WHEN   NORDERID-NYUINID
      *
               PERFORM 20011-ORCSODR01-ITM-CHK-SEC
      *
               MOVE    "ORCSODR01"     TO  WRK-PGNAME
      *
           WHEN   NORDERID-TAIINID
      *
               PERFORM 20011-ORCSODR02-ITM-CHK-SEC
      *
               MOVE    "ORCSODR02"     TO  WRK-PGNAME
      *
           WHEN   NORDERID-GAIHKID
           WHEN   NORDERID-GBACKID
           WHEN   NORDERID-FNORLID
           WHEN   NORDERID-FSPCLID
           WHEN   NORDERID-FSELEID
           WHEN   NORDERID-FSTOPID
      *
               PERFORM 20011-ORCSODR03-ITM-CHK-SEC
      *
               MOVE    "ORCSODR03"     TO  WRK-PGNAME
      *
           END-EVALUATE
      *
           IF    ( WRK-PGNAME      NOT =   SPACE )
               CALL    WRK-PGNAME      USING   SODR-AREA
                                               LNK-ORDER-REC
               IF    ( SODR-RC     NOT =   ZERO )
                   MOVE    1           TO  FLG-END
               END-IF
           END-IF
      *
           .
       20011-NYUINIDO-SYORI-EXT.
           EXIT.
      *****************************************************************
      *    引渡しオーダー情報設定処理
      *****************************************************************
       20011-LNK-ORDER-SET-SEC         SECTION.
      *
           MOVE    ZERO                TO  LNK-ORDER-MAX
      *
           PERFORM VARYING IDXB    FROM    1   BY  1
                   UNTIL ( IDXB    >   CONST-SRYTBLC-MAX )
      *
               MOVE    ALL "9"     TO  WRK-ITEMID
      *
               MOVE    SPACE       TO  WRK-ITEM
                                       WRK-REMARKS
                                       WRK-STATUS-ITEM
      *
               IF    ( LF04-TBLID (IDXA IDXB)  NOT = SPACE )
                AND  ( LF04-TBLID (IDXA IDXB)  NOT = NCLAIMID-NYUIDONM )
      *
                   PERFORM VARYING IDX-IJI FROM    1   BY  1
                           UNTIL ( IDX-IJI     >   NCLAIMID-ITEM-MAX )
                            OR   ( WRK-ITEMID  NOT =   ALL "9" )
      *
                       IF    ( LF04-TBLID (IDXA IDXB)
                                   =   NCLAIMID-ITEMNM (IDX-IJI) )
      *
                           MOVE    NCLAIMID-ITEMID (IDX-IJI)
                                       TO  WRK-ITEMID
                       END-IF
      *
                   END-PERFORM
      *
                   MOVE    LF04-IJICD (IDXA IDXB)
                                       TO  WRK-ITEM
      *
                   EVALUATE    WRK-ITEMID
                   WHEN    NCLAIMID-TAIINCDID
                       MOVE    LF04-ALSNAME (IDXA IDXB)
                                       TO  WRK-REMARKS
                   WHEN    NCLAIMID-SYOKAIID
                       MOVE    LF04-SRYMEMO (IDXA IDXB)
                                       TO  WRK-REMARKS
                   END-EVALUATE
      *
                   MOVE    "0"         TO  WRK-STATUS-ITEM
                   PERFORM 20011-LNK-ORDER-HEN-SEC
      *
               END-IF
      *
           END-PERFORM
      *
           .
       20011-LNK-ORDER-SET-EXT.
           EXIT.
      *****************************************************************
      *    引渡しオーダー情報設定処理
      *****************************************************************
       20011-LNK-ORDER-HEN-SEC         SECTION.
      *
           IF    ( LNK-ORDER-MAX      >=  CONST-SRYTBLC-MAX )
               GO  TO  20011-LNK-ORDER-HEN-EXT
           END-IF
      *
           COMPUTE LNK-ORDER-MAX   =   LNK-ORDER-MAX   +   1
      *
           MOVE    LNK-ORDER-MAX       TO  IDX1
      *
           MOVE    SCL31N-HOSPID       TO  LNK-ORDER-HOSPID    (IDX1)
           MOVE    WRK-KARTE-KEY       TO  LNK-ORDER-KARTE-KEY (IDX1)
           MOVE    SCL31N-NYUGAIKBN    TO  LNK-ORDER-NYUGAIKBN (IDX1)
           MOVE    SCL31N-PTNUM        TO  LNK-ORDER-PTNUM     (IDX1)
           MOVE    SCL31N-PTID         TO  LNK-ORDER-PTID      (IDX1)
           MOVE    SCL31N-SRYKA        TO  LNK-ORDER-SRYKA     (IDX1)
           MOVE    SCL31N-SRYYMD       TO  LNK-ORDER-SRYYMD    (IDX1)
           MOVE    SCL31N-HKNCOMBI     TO  LNK-ORDER-HKNCOMBI  (IDX1)
           MOVE    SCL31N-DRCD         TO  LNK-ORDER-DRCD      (IDX1)
      *
           INITIALIZE                      WRK-ORDER-CLAIMID-G
           MOVE    LF04-SRYCD (IDXA)   TO  WRK-ORDER-CLAIMIDH
           MOVE    WRK-IDOKBN          TO  WRK-ORDER-CLAIMIDT
           MOVE    WRK-ORDER-CLAIMID-G TO  WRK-CMB-CD
           PERFORM 2300-ORDERID-CHK-SEC
           IF    ( WRK-CMB-ITM         =   SPACE )
               MOVE    LF04-SRYCD (IDXA)
                                       TO  LNK-ORDER-ORDERID   (IDX1)
           ELSE
               MOVE    WRK-CMB-ITM     TO  LNK-ORDER-ORDERID   (IDX1)
           END-IF
      *
           MOVE    WRK-ORDERNUM        TO  LNK-ORDER-ORDERNUM  (IDX1)
           MOVE    IDX1                TO  LNK-ORDER-ITEMNUM   (IDX1)
           MOVE    WRK-UKEYMD          TO  LNK-ORDER-UKEYMD    (IDX1)
           MOVE    WRK-UKEHMS          TO  LNK-ORDER-UKEHMS    (IDX1)
      *
           MOVE    WRK-ITEMID          TO  LNK-ORDER-ITEMID    (IDX1)
      *
           MOVE    WRK-ITEM            TO  WRK-KANACHK-MAE-INPUT
           PERFORM 800-HANKAKU-CHK-SEC
           IF    ( FLG-ENTRYCHK        =   ZERO )
               MOVE    WRK-ITEM        TO  LNK-ORDER-ITEM      (IDX1)
           ELSE
               MOVE    SPACE           TO  LNK-ORDER-ITEM      (IDX1)
           END-IF
      *
           MOVE    WRK-STATUS-ITEM     TO  LNK-ORDER-STATUS-ITEM (IDX1)
           IF    ( FLG-KARTE-KEY       =   ZERO )
               MOVE    "0"         TO  LNK-ORDER-KEYGENERATE     (IDX1)
           ELSE
               MOVE    "1"         TO  LNK-ORDER-KEYGENERATE     (IDX1)
           END-IF
      *
           EVALUATE    WRK-ITEMID
           WHEN    NCLAIMID-TAIINCDID
               MOVE    WRK-REMARKS TO  WRK-KANACHK-MAE-INPUT
               PERFORM 800-ZENKAKU-CHK-SEC
               IF    ( FLG-ENTRYCHK        =   ZERO )
                   MOVE    WRK-KANACHK-OUT-INPUT
                                   TO  LNK-ORDER-REMARKS       (IDX1)
               ELSE
                   MOVE    SPACE   TO  LNK-ORDER-REMARKS       (IDX1)
               END-IF
           WHEN    NCLAIMID-SYOKAIID
               MOVE    WRK-REMARKS TO  WRK-KANACHK-MAE-INPUT
               PERFORM 800-HANKAKU-CHK-SEC
               IF    ( FLG-ENTRYCHK        =   ZERO )
                   MOVE    WRK-KANACHK-OUT-INPUT
                                   TO  LNK-ORDER-REMARKS       (IDX1)
               ELSE
                   MOVE    SPACE   TO  LNK-ORDER-REMARKS       (IDX1)
               END-IF
           END-EVALUATE
      *
      *
           .
       20011-LNK-ORDER-HEN-EXT.
           EXIT.
      *****************************************************************
      *    入院処理項目チェック（必須項目抜け）
      *****************************************************************
       20011-ORCSODR01-ITM-CHK-SEC     SECTION.
      *
      *    入院区分チェック
           PERFORM 20011-NYUKBN-CHK-SEC
      *
      *    病棟コードチェック
           PERFORM 20011-BTUNUM-CHK-SEC
      *
      *    病室コードチェック
           PERFORM 20011-BRMNUM-CHK-SEC
      *
      *    入院科チェック
           PERFORM 20011-NYUINKA-CHK-SEC
      *
      *    保険組合せチェック
           PERFORM 20011-HKNCOMBI-CHK-SEC
      *
           .
       20011-ORCSODR01-ITM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    退院処理項目チェック（必須項目抜け）
      *****************************************************************
       20011-ORCSODR02-ITM-CHK-SEC     SECTION.
      *
      *    入院科チェック
           PERFORM 20011-NYUINKA-CHK-SEC
      *
      *    保険組合せチェック
           PERFORM 20011-HKNCOMBI-CHK-SEC
      *
           .
       20011-ORCSODR02-ITM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    会計処理項目チェック（必須項目抜け）
      *****************************************************************
       20011-ORCSODR03-ITM-CHK-SEC     SECTION.
      *
      *    入院科チェック
           PERFORM 20011-NYUINKA-CHK-SEC
      *
      *    保険組合せチェック
           PERFORM 20011-HKNCOMBI-CHK-SEC
      *
           .
       20011-ORCSODR03-ITM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院区分チェック
      *****************************************************************
       20011-NYUKBN-CHK-SEC            SECTION.
      *
      *    入院区分チェック
           MOVE    NCLAIMID-NYUKBNNM   TO  WRK-TBLID
           PERFORM 20011-ITEM-CNT-CHK-SEC
           IF        ( CNT-TBLID   =   ZERO )
               MOVE    NCLAIMID-NYUKBNID
                                       TO  WRK-ITEMID
               MOVE    SPACE           TO  WRK-ITEM
               MOVE    "4"             TO  WRK-STATUS-ITEM
               PERFORM 20011-LNK-ORDER-HEN-SEC
           END-IF
      *
           .
       20011-NYUKBN-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病棟コードチェック
      *****************************************************************
       20011-BTUNUM-CHK-SEC            SECTION.
      *
      *    病棟コードチェック
           MOVE    NCLAIMID-BTUNUMNM   TO  WRK-TBLID
           PERFORM 20011-ITEM-CNT-CHK-SEC
           IF        ( CNT-TBLID   =   ZERO )
               MOVE    NCLAIMID-BTUNUMID
                                       TO  WRK-ITEMID
               MOVE    SPACE           TO  WRK-ITEM
               MOVE    "4"             TO  WRK-STATUS-ITEM
               PERFORM 20011-LNK-ORDER-HEN-SEC
           END-IF
      *
           .
       20011-BTUNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    病室コードチェック
      *****************************************************************
       20011-BRMNUM-CHK-SEC            SECTION.
      *
      *    病室コードチェック
           MOVE    NCLAIMID-BRMNUMNM   TO  WRK-TBLID
           PERFORM 20011-ITEM-CNT-CHK-SEC
           IF        ( CNT-TBLID   =   ZERO )
               MOVE    NCLAIMID-BRMNUMID
                                       TO  WRK-ITEMID
               MOVE    SPACE           TO  WRK-ITEM
               MOVE    "4"             TO  WRK-STATUS-ITEM
               PERFORM 20011-LNK-ORDER-HEN-SEC
           END-IF
      *
           .
       20011-BRMNUM-CHK-EXT.
           EXIT.
      *****************************************************************
      *    入院科チェック処理
      *****************************************************************
       20011-NYUINKA-CHK-SEC           SECTION.
      *
      *    入院科チェック
           MOVE    NCLAIMID-NYUINKANM  TO  WRK-TBLID
           PERFORM 20011-ITEM-CNT-CHK-SEC
           IF        ( CNT-TBLID   =   ZERO )
               MOVE    NCLAIMID-NYUINKAID
                                       TO  WRK-ITEMID
               MOVE    SCL31N-SRYKA    TO  WRK-ITEM
               MOVE    "4"             TO  WRK-STATUS-ITEM
               PERFORM 20011-LNK-ORDER-HEN-SEC
           END-IF
      *
           .
       20011-NYUINKA-CHK-EXT.
           EXIT.
      *****************************************************************
      *    保険組合せチェック処理
      *****************************************************************
       20011-HKNCOMBI-CHK-SEC          SECTION.
      *
      *    保険組合せチェック
           MOVE    NCLAIMID-HKNCOMBINM  TO  WRK-TBLID
           PERFORM 20011-ITEM-CNT-CHK-SEC
           IF        ( CNT-TBLID   =   ZERO )
               MOVE    NCLAIMID-HKNCOMBIID
                                       TO  WRK-ITEMID
               MOVE    SCL31N-HKNCOMBI TO  WRK-ITEM
               MOVE    "4"             TO  WRK-STATUS-ITEM
               PERFORM 20011-LNK-ORDER-HEN-SEC
           END-IF
      *
           .
       20011-HKNCOMBI-CHK-EXT.
           EXIT.
      *****************************************************************
      *    項目出現回数チェック処理
      *****************************************************************
       20011-ITEM-CNT-CHK-SEC          SECTION.
      *
           MOVE    ZERO                TO  CNT-TBLID
      *
           PERFORM VARYING IDXB    FROM    1   BY  1
                   UNTIL ( IDXB    >   CONST-SRYTBLC-MAX )
      *
               IF    ( LF04-TBLID (IDXA IDXB)
                                   =   WRK-TBLID )
                   COMPUTE CNT-TBLID
                       =   CNT-TBLID   +   1
               END-IF
      *
           END-PERFORM
      *
           .
       20011-ITEM-CNT-CHK-EXT.
           EXIT.
      *****************************************************************
      *    オーダー追加処理
      *****************************************************************
       20011-ORDER-INSERT-SEC          SECTION.
      *
           MOVE    ZERO                TO  FLG-CHRERR
      *
           COMPUTE WRK-ITEMNUM =   WRK-ITEMNUM +   1
      *
           INITIALIZE                      ORDER-REC
           MOVE    SCL31N-HOSPID       TO  ORDER-HOSPID
           MOVE    WRK-KARTE-KEY       TO  ORDER-KARTE-KEY
           MOVE    SCL31N-NYUGAIKBN    TO  ORDER-NYUGAIKBN
           MOVE    SCL31N-PTNUM        TO  ORDER-PTNUM
           MOVE    SCL31N-PTID         TO  ORDER-PTID
           MOVE    SCL31N-SRYKA        TO  ORDER-SRYKA
           MOVE    SCL31N-SRYYMD       TO  ORDER-SRYYMD
           MOVE    SCL31N-HKNCOMBI     TO  ORDER-HKNCOMBI
           MOVE    SCL31N-DRCD         TO  ORDER-DRCD
           MOVE    WRK-ORDERNUM        TO  ORDER-ORDERNUM
           MOVE    WRK-ITEMNUM         TO  ORDER-ITEMNUM
           MOVE    WRK-UKEYMD          TO  ORDER-UKEYMD
           MOVE    WRK-UKEHMS          TO  ORDER-UKEHMS
      *
           INITIALIZE                      WRK-ORDERID
      *
           MOVE    LF04-SRYCD (IDXA)   TO  WRK-KANACHK-MAE-INPUT
           PERFORM 800-HANKAKU-CHK-SEC
           IF    ( FLG-ENTRYCHK        =   ZERO )
               MOVE    LF04-SRYCD (IDXA)
                                       TO  WRK-ORDERID
           ELSE
               MOVE    SPACE           TO  WRK-ORDERID
               MOVE    1               TO  FLG-CHRERR
           END-IF
      *
           INITIALIZE                      WRK-ORDER-CLAIMID-G
           MOVE    LF04-SRYCD (IDXA)   TO  WRK-ORDER-CLAIMIDH
           MOVE    WRK-IDOKBN          TO  WRK-ORDER-CLAIMIDT
           MOVE    WRK-ORDER-CLAIMID-G TO  WRK-CMB-CD
           PERFORM 2300-ORDERID-CHK-SEC
           IF    ( WRK-CMB-ITM         =   SPACE )
               MOVE    LF04-SRYCD (IDXA)
                                       TO  ORDER-ORDERID
           ELSE
               MOVE    WRK-CMB-ITM     TO  ORDER-ORDERID
           END-IF
      *
           MOVE    ERRCD-ERRCD (1)     TO  ORDER-ERRCD1
           MOVE    ERRCD-ERRCD (2)     TO  ORDER-ERRCD2
           MOVE    WRK-ITEMID          TO  ORDER-ITEMID
      *
           MOVE    LF04-IJICD (IDXA IDXB)
                                       TO  WRK-KANACHK-MAE-INPUT
           PERFORM 800-HANKAKU-CHK-SEC
           IF    ( FLG-ENTRYCHK        =   ZERO )
               MOVE    LF04-IJICD (IDXA IDXB)
                                       TO  ORDER-ITEM
           ELSE
               MOVE    SPACE           TO  ORDER-ITEM
               MOVE    1               TO  FLG-CHRERR
           END-IF
           MOVE    WRK-ERRCD           TO  ORDER-ERRCD-ORDER
      *    IF    ( FLG-CHRERR          =   ZERO )
      *        項目チェック無し
               MOVE    SPACE           TO  ORDER-ERRCD-ITEM
      *    ELSE
      *        文字化け
      *        MOVE    "090?"          TO  ORDER-ERRCD-ITEM
      *    END-IF
      *
           MOVE    "1"                 TO  ORDER-STATUS-ORDER
           MOVE    SPACE               TO  ORDER-STATUS-ITEM
           IF    ( FLG-KARTE-KEY       =   ZERO )
               MOVE    "0"             TO  ORDER-KEYGENERATE
           ELSE
               MOVE    "1"             TO  ORDER-KEYGENERATE
           END-IF
           MOVE    SPACE               TO  ORDER-TERMID
           MOVE    "CLAIM"             TO  ORDER-OPID
           MOVE    WRK-UKEYMD          TO  ORDER-CREYMD
                                           ORDER-UPYMD
           MOVE    WRK-UKEHMS          TO  ORDER-UPHMS
      *
           PERFORM 900-ORDER-KEY-SEL-SEC
           IF    ( FLG-ORDER           =   ZERO )
               DISPLAY "ORCL0031N ERROR:ORDER INSERT CHK ERR"
                       " PTID="        SCL31N-PTID
                       " KARTE-KEY="   LF04-UID8
               MOVE    1               TO  FLG-END
               GO  TO  20011-ORDER-INSERT-EXT
           END-IF
      *
           MOVE    ORDER-REC           TO  MCPDATA-REC
           MOVE    PATH-TBL-ORDER-KEY  TO  MCP-PATH
           PERFORM 910-DBINSERT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               DISPLAY "ORCL0031N ERROR:ORDER INSERT ERR"
                       " PTID="        SCL31N-PTID
                       " KARTE-KEY="   LF04-UID8
               MOVE    1               TO  FLG-END
           END-IF
      *
           .
       20011-ORDER-INSERT-EXT.
           EXIT.
      *****************************************************************
      *    オーダーＩＤチェック処理
      *****************************************************************
       2300-ORDERID-CHK-SEC            SECTION.
      *
           INITIALIZE                  WRK-CMB-ITM-G
           PERFORM VARYING IDX-CMB FROM    1   BY  1
                   UNTIL ( IDX-CMB         >   NORDERID-MAX )
                    OR   ( WRK-CMB-ITM NOT =   SPACE )
      *
               IF    ( NORDERID-CLAIMID (IDX-CMB)  =   WRK-CMB-CD )
                   MOVE    NORDERID-ORCAID  (IDX-CMB)
                                       TO  WRK-CMB-ITM
               END-IF
      *
           END-PERFORM
      *
           .
       2300-ORDERID-CHK-EXT.
           EXIT.
      *****************************************************************
      *    終了処理
      *****************************************************************
       300-END-SEC                     SECTION.
      *
      *
           .
       300-END-EXT.
           .
           EXIT.
      *****************************************************************
      *    カルテキーチェック処理
      *****************************************************************
       800-KARTE-KEY-GET-SEC           SECTION.
      *
           INITIALIZE  UIDIO-AREA.
           CALL    "orcuidset" USING   ST
                                       UIDIO-AREA.
      *
           .
       800-KARTE-KEY-GET-EXT.
           EXIT.
      *****************************************************************
      *    半角文字チェック
      *****************************************************************
       800-HANKAKU-CHK-SEC              SECTION.
      *
           MOVE    ZERO            TO  FLG-ENTRYCHK
      *
           IF  ( WRK-KANACHK-MAE-INPUT
                                   =   SPACE )
               GO  TO  800-HANKAKU-CHK-EXT
           END-IF
      *
           MOVE    SPACE           TO  ORCSKANACHKAREA
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "1"             TO  KANACHK-SYORI
           MOVE    WRK-KANACHK-MAE-INPUT
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    =   ZERO )
               IF      ( KANACHK-SYUBETU   NOT =   1 )
                   DISPLAY "HANKAKU CHK ERR : " WRK-KANACHK-MAE-INPUT
                   MOVE    1       TO  FLG-ENTRYCHK
               END-IF
           ELSE
                   DISPLAY "HANKAKU CHK ERR : " WRK-KANACHK-MAE-INPUT
                   MOVE    1       TO  FLG-ENTRYCHK
           END-IF
      *
           .
       800-HANKAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    全角文字チェック
      *****************************************************************
       800-ZENKAKU-CHK-SEC             SECTION.
      *
           MOVE    ZERO            TO  FLG-ENTRYCHK
           MOVE    SPACE           TO  WRK-KANACHK-OUT-INPUT
      *
           IF  ( WRK-KANACHK-MAE-INPUT
                                   =   SPACE )
               GO  TO  800-ZENKAKU-CHK-EXT
           END-IF
      *
           MOVE    SPACE           TO  ORCSKANACHKAREA
           INITIALIZE                  ORCSKANACHKAREA
           MOVE    "2"             TO  KANACHK-SYORI
           MOVE    WRK-KANACHK-MAE-INPUT
                                   TO  KANACHK-MAE-INPUT
           CALL    "ORCSKANACHK"   USING   ORCSKANACHKAREA
           IF      ( KANACHK-RC    =   ZERO )
               MOVE    KANACHK-OUT-INPUT
                                   TO  WRK-KANACHK-OUT-INPUT
               IF      ( KANACHK-SYUBETU   NOT =   2 )
                   DISPLAY "ZENKAKU CHK ERR : " WRK-KANACHK-MAE-INPUT
                   MOVE    1       TO  FLG-ENTRYCHK
               END-IF
           ELSE
                   DISPLAY "ZENKAKU CHK ERR : " WRK-KANACHK-MAE-INPUT
                   MOVE    KANACHK-OUT-INPUT
                                   TO  WRK-KANACHK-OUT-INPUT
                   MOVE    1       TO  FLG-ENTRYCHK
           END-IF
      *
           .
       800-ZENKAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    マシン日付取得サブ
      *****************************************************************
       800-MCNDATE-SEC         SECTION.
      *
           CALL    "ORCSMCNDATE"   USING   ORCSMCNDATEAREA
      *
           .
      *
       800-MCNDATE-EXT.
           EXIT.
      *****************************************************************
      *    オーダー検索処理(KEY)
      *****************************************************************
       900-ORDER-KEY-SEL-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-ORDER
      *
           MOVE    ORDER-REC           TO  MCPDATA-REC
           MOVE    PATH-TBL-ORDER-KEY  TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-ORDER
           END-IF
      *
           MOVE    PATH-TBL-ORDER-KEY  TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-ORDER-KEY-SEL-EXT.
           EXIT.
      *****************************************************************
      *    オーダー検索処理(KEY2)
      *****************************************************************
       900-ORDER-KEY2-SEL-SEC      SECTION.
      *
           MOVE    ZERO                TO  FLG-ORDER
      *
           MOVE    ORDER-REC           TO  MCPDATA-REC
           MOVE    PATH-TBL-ORDER-KEY2 TO  MCP-PATH
           PERFORM 910-DBSELECT-SEC
           IF    ( MCP-RC          NOT =   ZERO )
               MOVE    1               TO  FLG-ORDER
           END-IF
      *
           MOVE    PATH-TBL-ORDER-KEY2 TO  MCP-PATH
           PERFORM 910-DBCLOSE-SEC
      *
           .
       900-ORDER-KEY2-SEL-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       910-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
           IF    ( MCP-RC          =   ZERO )
               PERFORM 910-DBFETCH-SEC
           END-IF
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ検索処理
      *****************************************************************
       911-DBSELECT-SEC                SECTION.
      *
           MOVE    "DBSELECT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DB-SELECT-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢ読み込み処理
      *****************************************************************
       910-DBFETCH-SEC                 SECTION.
      *
           MOVE    "DBFETCH"           TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBFETCH-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢクローズ処理
      *****************************************************************
       910-DBCLOSE-SEC                 SECTION.
      *
      *    MOVE    "DBCLOSECURSOR"     TO  MCP-FUNC
      *    CALL    "MCPSUB"            USING
      *                                MCPAREA
      *                                MCPDATA-REC
      *
           .
      *
       910-DBCLOSE-EXT.
           EXIT.
      *****************************************************************
      *    ＤＢインサート処理
      *****************************************************************
       910-DBINSERT-SEC                SECTION.
      *
           MOVE    "DBINSERT"          TO  MCP-FUNC
           CALL    "MCPSUB"            USING
                                       MCPAREA
                                       MCPDATA-REC
      *
           .
      *
       910-DBINSERT-EXT.
           EXIT.
