      *******************************************************************
      * Project code name "ORCA"
      * Æü°åÉ¸½à¥ì¥»¥×¥È¥½¥Õ¥È¡ÊJMA standard receipt software¡Ë
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
       PROGRAM-ID.             ORCSKANACHK.
      *****************************************************************
      *  ¥·¥¹¥Æ¥àÌ¾        : £Ï£Ò£Ã£Á
      *  ¥µ¥Ö¥·¥¹¥Æ¥àÌ¾    : 
      *  ¥³¥ó¥Ý¡¼¥Í¥ó¥ÈÌ¾  : È¾³Ñ¥Á¥§¥Ã¥¯½èÍý
      *  ÊÖµÑ¥¨¥é¡¼¥³¡¼¥É  : 0:Àµ¾ï¡¡1:È¾³Ñº®ºß¡¢£²¡§ÊÑ´¹¥¨¥é¡¼
      *  ´ÉÍý¼Ô            : 
      *  ºîÀ®ÆüÉÕ    ºî¶È¼Ô        µ­½Ò
      *  01.00.01    NACL-Â¿¡¹Ç¼  02/08/09  ÆþÎÏ¡¦½ÐÎÏÎÎ°è¤òX(1000)¤Ø
      *****************************************************************
      *
       ENVIRONMENT             DIVISION.
       CONFIGURATION               SECTION.
       INPUT-OUTPUT                SECTION.
       FILE-CONTROL.
      *
      *
       DATA                    DIVISION.
      *FILE                        SECTION.
      *
      *
       WORKING-STORAGE             SECTION.
      *
      *    ¥Õ¥é¥°ÎÎ°è
       01  FLG-AREA.
           03  FLG-ERR             PIC 9(01).
           03  FLG-KANA            PIC 9(01).
           03  FLG-KANA2           PIC 9(01).
           03  FLG-KANJI           PIC 9(01).
           03  FLG-KUHAKU          PIC 9(01).
      *
      *    Åº»úÎÎ°è
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX-MAX             PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
      *
      *
        01  WRK-AREA.
           03  WRK-WYMD.
               05  WRK-WGO             PIC X(01).
               05  WRK-WYY             PIC 9(02).
               05  WRK-WMM             PIC 9(02).
               05  WRK-WDD             PIC 9(02).
           03  WRK-SYMD.
               05  WRK-SYY             PIC 9(04).
               05  WRK-SMM             PIC 9(02).
               05  WRK-SDD             PIC 9(02).
      *
           03  WRK-INDAY.
               05  WRK-YY              PIC X(10).
               05  WRK-MM              PIC X(02).
               05  WRK-DD              PIC X(02).
      *
           03  WRK-HMM                 PIC 9(02).
           03  WRK-HDD                 PIC 9(02).
      *
           03  WRK-MOJI                PIC X(01).
           03  WRK-KIGO                PIC X(01).
           03  WRK-ZENMOJI             PIC X(02).
           03  WRK-ZENMOJI2            PIC X(02).
      *
           03  WRK-MEISYO              PIC X(1000).
      *
           03  WRK-ERRCD               PIC X(02).
      *
      *    ÊÑ´¹¥Æ¡¼¥Ö¥ë
       01  TBL-HENKAN-AREA.
           03  FILLER              PIC X(01)   VALUE   "0".
           03  FILLER              PIC X(02)   VALUE   "£°".
           03  FILLER              PIC X(01)   VALUE   "1".
           03  FILLER              PIC X(02)   VALUE   "£±".
           03  FILLER              PIC X(01)   VALUE   "2".
           03  FILLER              PIC X(02)   VALUE   "£²".
           03  FILLER              PIC X(01)   VALUE   "3".
           03  FILLER              PIC X(02)   VALUE   "£³".
           03  FILLER              PIC X(01)   VALUE   "4".
           03  FILLER              PIC X(02)   VALUE   "£´".
           03  FILLER              PIC X(01)   VALUE   "5".
           03  FILLER              PIC X(02)   VALUE   "£µ".
           03  FILLER              PIC X(01)   VALUE   "6".
           03  FILLER              PIC X(02)   VALUE   "£¶".
           03  FILLER              PIC X(01)   VALUE   "7".
           03  FILLER              PIC X(02)   VALUE   "£·".
           03  FILLER              PIC X(01)   VALUE   "8".
           03  FILLER              PIC X(02)   VALUE   "£¸".
           03  FILLER              PIC X(01)   VALUE   "9".
           03  FILLER              PIC X(02)   VALUE   "£¹".
      *±Ñ»ú
           03  FILLER              PIC X(01)   VALUE   "A".
           03  FILLER              PIC X(02)   VALUE   "£Á".
           03  FILLER              PIC X(01)   VALUE   "B".
           03  FILLER              PIC X(02)   VALUE   "£Â".
           03  FILLER              PIC X(01)   VALUE   "C".
           03  FILLER              PIC X(02)   VALUE   "£Ã".
           03  FILLER              PIC X(01)   VALUE   "D".
           03  FILLER              PIC X(02)   VALUE   "£Ä".
           03  FILLER              PIC X(01)   VALUE   "E".
           03  FILLER              PIC X(02)   VALUE   "£Å".
           03  FILLER              PIC X(01)   VALUE   "F".
           03  FILLER              PIC X(02)   VALUE   "£Æ".
           03  FILLER              PIC X(01)   VALUE   "G".
           03  FILLER              PIC X(02)   VALUE   "£Ç".
           03  FILLER              PIC X(01)   VALUE   "H".
           03  FILLER              PIC X(02)   VALUE   "£È".
           03  FILLER              PIC X(01)   VALUE   "I".
           03  FILLER              PIC X(02)   VALUE   "£É".
           03  FILLER              PIC X(01)   VALUE   "J".
           03  FILLER              PIC X(02)   VALUE   "£Ê".
           03  FILLER              PIC X(01)   VALUE   "K".
           03  FILLER              PIC X(02)   VALUE   "£Ë".
           03  FILLER              PIC X(01)   VALUE   "L".
           03  FILLER              PIC X(02)   VALUE   "£Ì".
           03  FILLER              PIC X(01)   VALUE   "N".
           03  FILLER              PIC X(02)   VALUE   "£Î".
           03  FILLER              PIC X(01)   VALUE   "M".
           03  FILLER              PIC X(02)   VALUE   "£Í".
           03  FILLER              PIC X(01)   VALUE   "O".
           03  FILLER              PIC X(02)   VALUE   "£Ï".
           03  FILLER              PIC X(01)   VALUE   "P".
           03  FILLER              PIC X(02)   VALUE   "£Ð".
           03  FILLER              PIC X(01)   VALUE   "Q".
           03  FILLER              PIC X(02)   VALUE   "£Ñ".
           03  FILLER              PIC X(01)   VALUE   "R".
           03  FILLER              PIC X(02)   VALUE   "£Ò".
           03  FILLER              PIC X(01)   VALUE   "S".
           03  FILLER              PIC X(02)   VALUE   "£Ó".
           03  FILLER              PIC X(01)   VALUE   "T".
           03  FILLER              PIC X(02)   VALUE   "£Ô".
           03  FILLER              PIC X(01)   VALUE   "U".
           03  FILLER              PIC X(02)   VALUE   "£Õ".
           03  FILLER              PIC X(01)   VALUE   "V".
           03  FILLER              PIC X(02)   VALUE   "£Ö".
           03  FILLER              PIC X(01)   VALUE   "W".
           03  FILLER              PIC X(02)   VALUE   "£×".
           03  FILLER              PIC X(01)   VALUE   "X".
           03  FILLER              PIC X(02)   VALUE   "£Ø".
           03  FILLER              PIC X(01)   VALUE   "Y".
           03  FILLER              PIC X(02)   VALUE   "£Ù".
           03  FILLER              PIC X(01)   VALUE   "Z".
           03  FILLER              PIC X(02)   VALUE   "£Ú".
      *±Ñ»ú
           03  FILLER              PIC X(01)   VALUE   "a".
           03  FILLER              PIC X(02)   VALUE   "£á".
           03  FILLER              PIC X(01)   VALUE   "b".
           03  FILLER              PIC X(02)   VALUE   "£â".
           03  FILLER              PIC X(01)   VALUE   "c".
           03  FILLER              PIC X(02)   VALUE   "£ã".
           03  FILLER              PIC X(01)   VALUE   "d".
           03  FILLER              PIC X(02)   VALUE   "£ä".
           03  FILLER              PIC X(01)   VALUE   "e".
           03  FILLER              PIC X(02)   VALUE   "£å".
           03  FILLER              PIC X(01)   VALUE   "f".
           03  FILLER              PIC X(02)   VALUE   "£æ".
           03  FILLER              PIC X(01)   VALUE   "g".
           03  FILLER              PIC X(02)   VALUE   "£ç".
           03  FILLER              PIC X(01)   VALUE   "h".
           03  FILLER              PIC X(02)   VALUE   "£è".
           03  FILLER              PIC X(01)   VALUE   "i".
           03  FILLER              PIC X(02)   VALUE   "£é".
           03  FILLER              PIC X(01)   VALUE   "j".
           03  FILLER              PIC X(02)   VALUE   "£ê".
           03  FILLER              PIC X(01)   VALUE   "k".
           03  FILLER              PIC X(02)   VALUE   "£ë".
           03  FILLER              PIC X(01)   VALUE   "l".
           03  FILLER              PIC X(02)   VALUE   "£ì".
           03  FILLER              PIC X(01)   VALUE   "n".
           03  FILLER              PIC X(02)   VALUE   "£î".
           03  FILLER              PIC X(01)   VALUE   "m".
           03  FILLER              PIC X(02)   VALUE   "£í".
           03  FILLER              PIC X(01)   VALUE   "o".
           03  FILLER              PIC X(02)   VALUE   "£ï".
           03  FILLER              PIC X(01)   VALUE   "p".
           03  FILLER              PIC X(02)   VALUE   "£ð".
           03  FILLER              PIC X(01)   VALUE   "q".
           03  FILLER              PIC X(02)   VALUE   "£ñ".
           03  FILLER              PIC X(01)   VALUE   "r".
           03  FILLER              PIC X(02)   VALUE   "£ò".
           03  FILLER              PIC X(01)   VALUE   "s".
           03  FILLER              PIC X(02)   VALUE   "£ó".
           03  FILLER              PIC X(01)   VALUE   "t".
           03  FILLER              PIC X(02)   VALUE   "£ô".
           03  FILLER              PIC X(01)   VALUE   "u".
           03  FILLER              PIC X(02)   VALUE   "£õ".
           03  FILLER              PIC X(01)   VALUE   "v".
           03  FILLER              PIC X(02)   VALUE   "£ö".
           03  FILLER              PIC X(01)   VALUE   "w".
           03  FILLER              PIC X(02)   VALUE   "£÷".
           03  FILLER              PIC X(01)   VALUE   "x".
           03  FILLER              PIC X(02)   VALUE   "£ø".
           03  FILLER              PIC X(01)   VALUE   "y".
           03  FILLER              PIC X(02)   VALUE   "£ù".
           03  FILLER              PIC X(01)   VALUE   "z".
           03  FILLER              PIC X(02)   VALUE   "£ú".
      *
           03  FILLER              PIC X(01)   VALUE   "-".
           03  FILLER              PIC X(02)   VALUE   "¡Ý".
           03  FILLER              PIC X(01)   VALUE   "(".
           03  FILLER              PIC X(02)   VALUE   "¡Ê".
           03  FILLER              PIC X(01)   VALUE   ")".
           03  FILLER              PIC X(02)   VALUE   "¡Ë".
           03  FILLER              PIC X(01)   VALUE   "\".
           03  FILLER              PIC X(02)   VALUE   "¡ï".
           03  FILLER              PIC X(01)   VALUE   ".".
           03  FILLER              PIC X(02)   VALUE   "¡¥".
           03  FILLER              PIC X(01)   VALUE   "/".
           03  FILLER              PIC X(02)   VALUE   "¡¿".
           03  FILLER              PIC X(01)   VALUE   "<".
           03  FILLER              PIC X(02)   VALUE   "¡ã".
           03  FILLER              PIC X(01)   VALUE   ">".
           03  FILLER              PIC X(02)   VALUE   "¡ä".
           03  FILLER              PIC X(01)   VALUE   "*".
           03  FILLER              PIC X(02)   VALUE   "¡ö".
           03  FILLER              PIC X(01)   VALUE   "?".
           03  FILLER              PIC X(02)   VALUE   "¡©".
           03  FILLER              PIC X(01)   VALUE   "%".
           03  FILLER              PIC X(02)   VALUE   "¡ó".
           03  FILLER              PIC X(01)   VALUE   "+".
           03  FILLER              PIC X(02)   VALUE   "¡Ü".
           03  FILLER              PIC X(01)   VALUE   "!".
           03  FILLER              PIC X(02)   VALUE   "¡ª".
           03  FILLER              PIC X(01)   VALUE   "#".
           03  FILLER              PIC X(02)   VALUE   "¡ô".
           03  FILLER              PIC X(01)   VALUE   "&".
           03  FILLER              PIC X(02)   VALUE   "¡õ".
           03  FILLER              PIC X(01)   VALUE   "=".
           03  FILLER              PIC X(02)   VALUE   "¡á".
           03  FILLER              PIC X(01)   VALUE   ",".
           03  FILLER              PIC X(02)   VALUE   "¡¤".
           03  FILLER              PIC X(01)   VALUE   "_".
           03  FILLER              PIC X(02)   VALUE   "¡²".
           03  FILLER              PIC X(01)   VALUE   "@".
           03  FILLER              PIC X(02)   VALUE   "¡÷".
           03  FILLER              PIC X(01)   VALUE   "[".
           03  FILLER              PIC X(02)   VALUE   "¡Î".
           03  FILLER              PIC X(01)   VALUE   "]".
           03  FILLER              PIC X(02)   VALUE   "¡Ï".
      *
       01  TBL-HENKAN-AREA-R           REDEFINES   TBL-HENKAN-AREA.
           03  TBL-HENKAN-OCC          OCCURS   83
                                       INDEXED  TBL-IDX.
               05  TBL-HALF            PIC X(01).
               05  TBL-ZEN             PIC X(02).
       01  TBL-MAX                     PIC 9(04)   VALUE   83.
      *
      *****************************************************************
      *    ¥µ¥Ö¥×¥íÍÑ¡¡ÎÎ°è
      *****************************************************************
      *
      *****************************************************************
      *    Ï¢Íí¡¡ÎÎ°è
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSKANACHK.INC".
     *
       PROCEDURE                    DIVISION    USING
           ORCSKANACHKAREA.
     *
      *****************************************************************
      *    ¼ç¡¡¡¡½èÍý
      *****************************************************************
       000-PROC-SEC                 SECTION.
      *
           INITIALIZE                  FLG-AREA
           INITIALIZE                  IDX-AREA
           INITIALIZE                  WRK-AREA
      *
           MOVE    ZERO                TO  KANACHK-RC
           MOVE    ZERO                TO  KANACHK-RC2
           MOVE    SPACE               TO  KANACHK-OUT-INPUT
      *    ºÇÂç·å¿ôÈ½Äê
           MOVE    ZERO                TO  IDX-MAX
           PERFORM VARYING     IDX     FROM    1000 BY  -1
                   UNTIL       IDX     <   1
               IF     KANACHK-MAE-INPUT (IDX:1)    NOT =   SPACE
                   MOVE    IDX             TO  IDX-MAX
                   MOVE    1               TO  IDX
               END-IF
           END-PERFORM
           IF      IDX-MAX             =   ZERO
               MOVE    ZERO                TO  KANACHK-MAX
               MOVE    SPACE               TO  KANACHK-OUT-INPUT
               GO      TO      000-PROC-EXT
           END-IF
      *
           EVALUATE    KANACHK-SYORI
               WHEN    "1"
      *            Á´³ÑÈ½Äê½èÍý
                   PERFORM 100-ZENKAKU-CHECK-SEC
               WHEN    "2"
      *            Á´³ÑÃÖ´¹½èÍý
                   PERFORM 200-ZENKAKU-HENKAN-SEC
           END-EVALUATE
      *
           .
       000-PROC-EXT.
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    Á´³ÑÈ½Äê½èÍý
      *****************************************************************
       100-ZENKAKU-CHECK-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-KANJI
           MOVE    ZERO                TO  FLG-KANA
           MOVE    ZERO                TO  FLG-KUHAKU
           PERFORM VARYING     IDX     FROM    1  BY  1
                   UNTIL       IDX     >   IDX-MAX
               IF     (KANACHK-MAE-INPUT (IDX:1)
                                           =   SPACE   )  OR
                      (KANACHK-MAE-INPUT (IDX:1)
                                           =   X"0A"   )
                   IF      KANACHK-MAE-INPUT (IDX:1)
                                               =   SPACE
                       MOVE    1               TO  FLG-KUHAKU
                   END-IF
               ELSE
                   IF     (KANACHK-MAE-INPUT (IDX:1)
                                          >=  X"A1"  )
                       MOVE    1               TO  FLG-KANJI
                   ELSE
                       MOVE    KANACHK-MAE-INPUT (IDX:1)
                                                   TO  WRK-MOJI
                       PERFORM 2001-MOJI-CHK-SEC
      *                ±Ñ¿ô»ú°Ê³°¤ÎÆþÎÏ¤¢¤ê
                       IF      WRK-ZENMOJI         =   SPACE
                           MOVE    1               TO  FLG-KANA2
                       END-IF
                       MOVE    1               TO  FLG-KANA
                   END-IF
               END-IF
           END-PERFORM
      *    Á´³Ñ¡¦È¾³Ñº®ºß
           IF     (FLG-KANJI           =   1  )  AND
                  (FLG-KANA            =   1  )
               IF      FLG-KANA2           =   1
                   MOVE    9                   TO  KANACHK-RC2
               END-IF
               MOVE    1                   TO  KANACHK-RC
               GO      TO      100-ZENKAKU-CHECK-EXT
           END-IF
      *    È¾³Ñ¤Î»þ¡¢°Ê²¼¤Î½èÍý¤Ê¤·
           IF      FLG-KANJI           =   ZERO
               MOVE    1                   TO  KANACHK-SYUBETU
               MOVE    IDX-MAX             TO  KANACHK-MAX
               MOVE    KANACHK-MAE-INPUT   TO  KANACHK-OUT-INPUT
               IF      FLG-KANA2           =   1
      *            ±Ñ¿ô»ú°Ê³°¤Î¹àÌÜ¤¢¤ê
                   MOVE    9                   TO  KANACHK-RC2
               ELSE
      *            ´Ö¤Ë¶õÇò¤¢¤ê
                   IF      FLG-KUHAKU          =   1
                       MOVE    8                   TO  KANACHK-RC2
                   END-IF
               END-IF
           ELSE
      *        Á´³Ñ½èÍý
               PERFORM 1020-ZENKAKU-SYORI-SEC
      *        ´Ö¤Ë¶õÇò¤¢¤ê
               IF      FLG-KUHAKU          =   1
                   MOVE    8                   TO  KANACHK-RC2
               END-IF
           END-IF
      *
           .
       100-ZENKAKU-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    Á´³Ñ½èÍý
      *****************************************************************
       1020-ZENKAKU-SYORI-SEC           SECTION.
      *
           MOVE    2                   TO  KANACHK-SYUBETU
      *
           MOVE    SPACE               TO  WRK-MEISYO
           MOVE    1                   TO  IDY
           MOVE    1                   TO  IDX
           PERFORM
                   UNTIL       IDX     >   IDX-MAX
               EVALUATE    KANACHK-MAE-INPUT (IDX:1)
      *            È¾³Ñ¶õÇò¤òÁ´³Ñ¤Î¤Ø
                   WHEN    SPACE
                       MOVE    "¡¡"            TO  WRK-MEISYO(IDY:2)
                       ADD     1               TO  IDX
                       ADD     2               TO  IDY
                   WHEN    OTHER
                       MOVE    KANACHK-MAE-INPUT (IDX:2)
                                               TO  WRK-MEISYO(IDY:2)
                       ADD     2               TO  IDX
                       ADD     2               TO  IDY
               END-EVALUATE
           END-PERFORM
      *    ºÇÂç·å¿ô
           COMPUTE KANACHK-MAX         =   IDY  -   1
           MOVE    WRK-MEISYO          TO  KANACHK-OUT-INPUT
      *
           .
       1020-ZENKAKU-SYORI-EXT.
           EXIT.
      *
      *****************************************************************
      *    Á´³Ñ½èÍý
      *****************************************************************
       200-ZENKAKU-HENKAN-SEC           SECTION.
      *
      *TEST
      *    DISPLAY "KANAHCK IDX-MAX:" IDX-MAX
      *            ",KANACHK-MAE-INPUT:" KANACHK-MAE-INPUT
      *TEST
           MOVE    2                   TO  KANACHK-SYUBETU
      *
           MOVE    SPACE               TO  WRK-MEISYO
           MOVE    1                   TO  IDY
           MOVE    1                   TO  IDX
           MOVE    ZERO                TO  FLG-ERR
           PERFORM
                   UNTIL      (IDX         >   IDX-MAX  )  OR
                              (FLG-ERR     =   1    )
      *        Á´³ÑÈ½Äê
               IF      KANACHK-MAE-INPUT (IDX:1)
                                           >=  X"A1"
                   MOVE    KANACHK-MAE-INPUT (IDX:2)
                                           TO  WRK-MEISYO(IDY:2)
                   ADD     2               TO  IDX
                   ADD     2               TO  IDY
               ELSE
                   EVALUATE    KANACHK-MAE-INPUT (IDX:1)
                       WHEN    SPACE
      *                    È¾³Ñ¶õÇò¤òÁ´³Ñ¤Î¤Ø
                           MOVE    "¡¡"            TO  WRK-MEISYO(IDY:2)
                           ADD     1               TO  IDX
                           ADD     2               TO  IDY
                       WHEN    X"0A" 
      *                    ²þ¹Ô¤Ï¤½¤Î¤Þ¤Þ
                           MOVE    KANACHK-MAE-INPUT (IDX:1)
                                                   TO  WRK-MEISYO(IDY:1)
                           ADD     1               TO  IDX
                           ADD     1               TO  IDY
                       WHEN    OTHER
      *                    ±Ñ¿ô»úÊÑ´¹¥Á¥§¥Ã¥¯
                           MOVE    KANACHK-MAE-INPUT (IDX:1)
                                                   TO  WRK-MOJI
                           PERFORM 2001-MOJI-CHK-SEC
                           IF      WRK-ZENMOJI         =   SPACE
      *                        ÊÑ´¹¥¨¥é¡¼
                               MOVE    1               TO  FLG-ERR
                           ELSE
                               MOVE    WRK-ZENMOJI     TO  WRK-MEISYO
                                                           (IDY:2)
                               ADD     1               TO  IDX
                               ADD     2               TO  IDY
                           END-IF
                   END-EVALUATE
               END-IF
           END-PERFORM
      *
           IF      FLG-ERR         NOT =   ZERO
               MOVE    2                   TO  KANACHK-RC
               GO      TO      200-ZENKAKU-HENKAN-EXT
           END-IF
      *
      *    ºÇÂç·å¿ô
           COMPUTE KANACHK-MAX         =   IDY  -   1
           MOVE    WRK-MEISYO          TO  KANACHK-OUT-INPUT
      *
           .
       200-ZENKAKU-HENKAN-EXT.
           EXIT.
      *
      *****************************************************************
      *    Á´³Ñ½èÍý
      *****************************************************************
       2001-MOJI-CHK-SEC           SECTION.
      *
           SET     TBL-IDX             TO  1
           SEARCH      TBL-HENKAN-OCC  VARYING   TBL-IDX
                   AT  END
                       MOVE    SPACE           TO  WRK-ZENMOJI
                   WHEN    WRK-MOJI        =   TBL-HALF (TBL-IDX)
                       MOVE    TBL-ZEN (TBL-IDX)
                                                TO  WRK-ZENMOJI
           END-SEARCH
           .
       2001-MOJI-CHK-EXT.
           EXIT.
      *
      *
