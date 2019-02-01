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
       PROGRAM-ID.             ORCSKANACHK.
      *****************************************************************
      *  システム名        : ＯＲＣＡ
      *  サブシステム名    : 
      *  コンポーネント名  : 半角チェック処理
      *  返却エラーコード  : 0:正常　1:半角混在、２：変換エラー
      *  管理者            : 
      *  作成日付    作業者        記述
      *****************************************************************
      *  プログラム修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  01.00.01    NACL-多々納  02/08/09  入力・出力領域をX(1000)へ
      *  01.00.02    NACL-多々納  04/09/30  全角エラー追加
      *  01.00.03    NACL-多々納  05/08/10  kanaconv 使用へ変更
      *  04.01.00    NACL-多々納  08/01/17  全角空白判定追加
      *  04.05.00    NACL-多々納  09/12/11  全角空白削除追加
      *  04.06.00    NACL-多々納  10/10/01  入力・出力領域をX(5000)へ
      *  05.01.00    NACL-多々納  17/09/26  改行コード判定追加
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
      *    フラグ領域
       01  FLG-AREA.
           03  FLG-ERR             PIC 9(01).
           03  FLG-KANA            PIC 9(01).
           03  FLG-KANA2           PIC 9(01).
           03  FLG-KANJI           PIC 9(01).
           03  FLG-KANJI-ERR       PIC 9(01).
           03  FLG-KUHAKU          PIC 9(01).
           03  FLG-ZENKAKU1        PIC 9(01).
           03  FLG-ZENKAKU2        PIC 9(01).
      *
      *    添字領域
       01  IDX-AREA.
           03  IDX                 PIC 9(04).
           03  IDY                 PIC 9(04).
           03  IDX-MAX             PIC 9(04).
           03  IDX-MAX2            PIC 9(04).
           03  IDX1                PIC 9(04).
           03  IDX2                PIC 9(04).
           03  IDX3                PIC 9(04).
           03  IDX4                PIC 9(04).
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
           03  WRK-MEISYO              PIC X(5000).
      *
           03  WRK-ERRCD               PIC X(02).
      *
           03  WRK-MAX-CNT             PIC 9(04).
      *
           03  WRK-IDX1                PIC 9(04).
           03  WRK-IDX2                PIC 9(04).
      *
      *    変換テーブル
       01  TBL-HENKAN-AREA.
           03  FILLER              PIC X(01)   VALUE   "0".
           03  FILLER              PIC X(02)   VALUE   "０".
           03  FILLER              PIC X(01)   VALUE   "1".
           03  FILLER              PIC X(02)   VALUE   "１".
           03  FILLER              PIC X(01)   VALUE   "2".
           03  FILLER              PIC X(02)   VALUE   "２".
           03  FILLER              PIC X(01)   VALUE   "3".
           03  FILLER              PIC X(02)   VALUE   "３".
           03  FILLER              PIC X(01)   VALUE   "4".
           03  FILLER              PIC X(02)   VALUE   "４".
           03  FILLER              PIC X(01)   VALUE   "5".
           03  FILLER              PIC X(02)   VALUE   "５".
           03  FILLER              PIC X(01)   VALUE   "6".
           03  FILLER              PIC X(02)   VALUE   "６".
           03  FILLER              PIC X(01)   VALUE   "7".
           03  FILLER              PIC X(02)   VALUE   "７".
           03  FILLER              PIC X(01)   VALUE   "8".
           03  FILLER              PIC X(02)   VALUE   "８".
           03  FILLER              PIC X(01)   VALUE   "9".
           03  FILLER              PIC X(02)   VALUE   "９".
      *英字
           03  FILLER              PIC X(01)   VALUE   "A".
           03  FILLER              PIC X(02)   VALUE   "Ａ".
           03  FILLER              PIC X(01)   VALUE   "B".
           03  FILLER              PIC X(02)   VALUE   "Ｂ".
           03  FILLER              PIC X(01)   VALUE   "C".
           03  FILLER              PIC X(02)   VALUE   "Ｃ".
           03  FILLER              PIC X(01)   VALUE   "D".
           03  FILLER              PIC X(02)   VALUE   "Ｄ".
           03  FILLER              PIC X(01)   VALUE   "E".
           03  FILLER              PIC X(02)   VALUE   "Ｅ".
           03  FILLER              PIC X(01)   VALUE   "F".
           03  FILLER              PIC X(02)   VALUE   "Ｆ".
           03  FILLER              PIC X(01)   VALUE   "G".
           03  FILLER              PIC X(02)   VALUE   "Ｇ".
           03  FILLER              PIC X(01)   VALUE   "H".
           03  FILLER              PIC X(02)   VALUE   "Ｈ".
           03  FILLER              PIC X(01)   VALUE   "I".
           03  FILLER              PIC X(02)   VALUE   "Ｉ".
           03  FILLER              PIC X(01)   VALUE   "J".
           03  FILLER              PIC X(02)   VALUE   "Ｊ".
           03  FILLER              PIC X(01)   VALUE   "K".
           03  FILLER              PIC X(02)   VALUE   "Ｋ".
           03  FILLER              PIC X(01)   VALUE   "L".
           03  FILLER              PIC X(02)   VALUE   "Ｌ".
           03  FILLER              PIC X(01)   VALUE   "N".
           03  FILLER              PIC X(02)   VALUE   "Ｎ".
           03  FILLER              PIC X(01)   VALUE   "M".
           03  FILLER              PIC X(02)   VALUE   "Ｍ".
           03  FILLER              PIC X(01)   VALUE   "O".
           03  FILLER              PIC X(02)   VALUE   "Ｏ".
           03  FILLER              PIC X(01)   VALUE   "P".
           03  FILLER              PIC X(02)   VALUE   "Ｐ".
           03  FILLER              PIC X(01)   VALUE   "Q".
           03  FILLER              PIC X(02)   VALUE   "Ｑ".
           03  FILLER              PIC X(01)   VALUE   "R".
           03  FILLER              PIC X(02)   VALUE   "Ｒ".
           03  FILLER              PIC X(01)   VALUE   "S".
           03  FILLER              PIC X(02)   VALUE   "Ｓ".
           03  FILLER              PIC X(01)   VALUE   "T".
           03  FILLER              PIC X(02)   VALUE   "Ｔ".
           03  FILLER              PIC X(01)   VALUE   "U".
           03  FILLER              PIC X(02)   VALUE   "Ｕ".
           03  FILLER              PIC X(01)   VALUE   "V".
           03  FILLER              PIC X(02)   VALUE   "Ｖ".
           03  FILLER              PIC X(01)   VALUE   "W".
           03  FILLER              PIC X(02)   VALUE   "Ｗ".
           03  FILLER              PIC X(01)   VALUE   "X".
           03  FILLER              PIC X(02)   VALUE   "Ｘ".
           03  FILLER              PIC X(01)   VALUE   "Y".
           03  FILLER              PIC X(02)   VALUE   "Ｙ".
           03  FILLER              PIC X(01)   VALUE   "Z".
           03  FILLER              PIC X(02)   VALUE   "Ｚ".
      *英字
           03  FILLER              PIC X(01)   VALUE   "a".
           03  FILLER              PIC X(02)   VALUE   "ａ".
           03  FILLER              PIC X(01)   VALUE   "b".
           03  FILLER              PIC X(02)   VALUE   "ｂ".
           03  FILLER              PIC X(01)   VALUE   "c".
           03  FILLER              PIC X(02)   VALUE   "ｃ".
           03  FILLER              PIC X(01)   VALUE   "d".
           03  FILLER              PIC X(02)   VALUE   "ｄ".
           03  FILLER              PIC X(01)   VALUE   "e".
           03  FILLER              PIC X(02)   VALUE   "ｅ".
           03  FILLER              PIC X(01)   VALUE   "f".
           03  FILLER              PIC X(02)   VALUE   "ｆ".
           03  FILLER              PIC X(01)   VALUE   "g".
           03  FILLER              PIC X(02)   VALUE   "ｇ".
           03  FILLER              PIC X(01)   VALUE   "h".
           03  FILLER              PIC X(02)   VALUE   "ｈ".
           03  FILLER              PIC X(01)   VALUE   "i".
           03  FILLER              PIC X(02)   VALUE   "ｉ".
           03  FILLER              PIC X(01)   VALUE   "j".
           03  FILLER              PIC X(02)   VALUE   "ｊ".
           03  FILLER              PIC X(01)   VALUE   "k".
           03  FILLER              PIC X(02)   VALUE   "ｋ".
           03  FILLER              PIC X(01)   VALUE   "l".
           03  FILLER              PIC X(02)   VALUE   "ｌ".
           03  FILLER              PIC X(01)   VALUE   "n".
           03  FILLER              PIC X(02)   VALUE   "ｎ".
           03  FILLER              PIC X(01)   VALUE   "m".
           03  FILLER              PIC X(02)   VALUE   "ｍ".
           03  FILLER              PIC X(01)   VALUE   "o".
           03  FILLER              PIC X(02)   VALUE   "ｏ".
           03  FILLER              PIC X(01)   VALUE   "p".
           03  FILLER              PIC X(02)   VALUE   "ｐ".
           03  FILLER              PIC X(01)   VALUE   "q".
           03  FILLER              PIC X(02)   VALUE   "ｑ".
           03  FILLER              PIC X(01)   VALUE   "r".
           03  FILLER              PIC X(02)   VALUE   "ｒ".
           03  FILLER              PIC X(01)   VALUE   "s".
           03  FILLER              PIC X(02)   VALUE   "ｓ".
           03  FILLER              PIC X(01)   VALUE   "t".
           03  FILLER              PIC X(02)   VALUE   "ｔ".
           03  FILLER              PIC X(01)   VALUE   "u".
           03  FILLER              PIC X(02)   VALUE   "ｕ".
           03  FILLER              PIC X(01)   VALUE   "v".
           03  FILLER              PIC X(02)   VALUE   "ｖ".
           03  FILLER              PIC X(01)   VALUE   "w".
           03  FILLER              PIC X(02)   VALUE   "ｗ".
           03  FILLER              PIC X(01)   VALUE   "x".
           03  FILLER              PIC X(02)   VALUE   "ｘ".
           03  FILLER              PIC X(01)   VALUE   "y".
           03  FILLER              PIC X(02)   VALUE   "ｙ".
           03  FILLER              PIC X(01)   VALUE   "z".
           03  FILLER              PIC X(02)   VALUE   "ｚ".
      *
           03  FILLER              PIC X(01)   VALUE   "-".
           03  FILLER              PIC X(02)   VALUE   "−".
           03  FILLER              PIC X(01)   VALUE   "(".
           03  FILLER              PIC X(02)   VALUE   "（".
           03  FILLER              PIC X(01)   VALUE   ")".
           03  FILLER              PIC X(02)   VALUE   "）".
           03  FILLER              PIC X(01)   VALUE   "\".
           03  FILLER              PIC X(02)   VALUE   "¥".
           03  FILLER              PIC X(01)   VALUE   ".".
           03  FILLER              PIC X(02)   VALUE   "．".
           03  FILLER              PIC X(01)   VALUE   "/".
           03  FILLER              PIC X(02)   VALUE   "／".
           03  FILLER              PIC X(01)   VALUE   "<".
           03  FILLER              PIC X(02)   VALUE   "＜".
           03  FILLER              PIC X(01)   VALUE   ">".
           03  FILLER              PIC X(02)   VALUE   "＞".
           03  FILLER              PIC X(01)   VALUE   "*".
           03  FILLER              PIC X(02)   VALUE   "＊".
           03  FILLER              PIC X(01)   VALUE   "?".
           03  FILLER              PIC X(02)   VALUE   "？".
           03  FILLER              PIC X(01)   VALUE   "%".
           03  FILLER              PIC X(02)   VALUE   "％".
           03  FILLER              PIC X(01)   VALUE   "+".
           03  FILLER              PIC X(02)   VALUE   "＋".
           03  FILLER              PIC X(01)   VALUE   "!".
           03  FILLER              PIC X(02)   VALUE   "！".
           03  FILLER              PIC X(01)   VALUE   "#".
           03  FILLER              PIC X(02)   VALUE   "＃".
           03  FILLER              PIC X(01)   VALUE   "&".
           03  FILLER              PIC X(02)   VALUE   "＆".
           03  FILLER              PIC X(01)   VALUE   "=".
           03  FILLER              PIC X(02)   VALUE   "＝".
           03  FILLER              PIC X(01)   VALUE   ",".
           03  FILLER              PIC X(02)   VALUE   "，".
           03  FILLER              PIC X(01)   VALUE   "_".
           03  FILLER              PIC X(02)   VALUE   "＿".
           03  FILLER              PIC X(01)   VALUE   "@".
           03  FILLER              PIC X(02)   VALUE   "＠".
           03  FILLER              PIC X(01)   VALUE   "[".
           03  FILLER              PIC X(02)   VALUE   "［".
           03  FILLER              PIC X(01)   VALUE   "]".
           03  FILLER              PIC X(02)   VALUE   "］".
      *
       01  TBL-HENKAN-AREA-R           REDEFINES   TBL-HENKAN-AREA.
           03  TBL-HENKAN-OCC          OCCURS   83
                                       INDEXED  TBL-IDX.
               05  TBL-HALF            PIC X(01).
               05  TBL-ZEN             PIC X(02).
       01  TBL-MAX                     PIC 9(04)   VALUE   83.
      *
      *****************************************************************
      *    サブプロ用　領域
      *****************************************************************
      *
           COPY    "CPORCXKANACONV2.INC".
      *
      *    拡張文字対応
           COPY    "CPORCSSTRING.INC".
      *
      *****************************************************************
      *    連絡　領域
      *****************************************************************
       LINKAGE                     SECTION.
      *
           COPY    "CPORCSKANACHK.INC".
      *
       PROCEDURE                    DIVISION    USING
           ORCSKANACHKAREA.
      *
      *****************************************************************
      *    主　　処理
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
      *    最大桁数判定
           MOVE    ZERO                TO  IDX-MAX
           PERFORM VARYING     IDX     FROM    5000 BY  -1
                   UNTIL       IDX     <   1
               IF     KANACHK-MAE-INPUT (IDX:1)    NOT =   SPACE
                   MOVE    IDX             TO  IDX-MAX
                   MOVE    1               TO  IDX
               END-IF
           END-PERFORM
           IF      IDX-MAX             =   ZERO
               MOVE    ZERO                TO  KANACHK-MAX
               MOVE    SPACE               TO  KANACHK-OUT-INPUT
           ELSE
               MOVE    IDX-MAX             TO  KANACHK-MAX
           END-IF
      *TEST
      *    DISPLAY " KANACHK-MAX:"  KANACHK-MAX
      *    DISPLAY " KANACHK-MAE-INPUT:"  KANACHK-MAE-INPUT
      *                    (1:KANACHK-MAX)
      *
           IF      IDX-MAX             >   ZERO
      *        全角の内容判定
               PERFORM 1000-KOUMOKU-CHK-SEC
      *
               EVALUATE    KANACHK-SYORI
                   WHEN    "1"
      *            全角判定処理
                   PERFORM 100-ZENKAKU-CHECK-SEC
                   WHEN    "2"
      *            全角置換処理
                   PERFORM 200-ZENKAKU-HENKAN-SEC
               END-EVALUATE
      *H29.9
      *        改行コードチェック
               PERFORM 1009-KAIGYO-CHK-SEC
           END-IF
      *
           .
       000-PROC-EXT.
           EXIT PROGRAM
           .
      *
      *****************************************************************
      *    全角チェック処理
      *****************************************************************
       1000-KOUMOKU-CHK-SEC           SECTION.
      *
           INITIALIZE                  ORCXKANACONVAREA
           MOVE    KANACHK-MAX-CNT     TO  KANACONV-LEN
           IF      KANACHK-MAX-CNT     =   ZERO
               MOVE    IDX-MAX             TO  KANACONV-LEN
           END-IF
           MOVE    5000                TO  KANACONV-STLEN
           MOVE    0                   TO  KANACONV-CONV-FLAG
           MOVE    0                   TO  KANACONV-CHAR-TYPE
           MOVE    KANACHK-MAE-INPUT   TO  KANACONV-INDATA
           CALL    "kanaconv"          USING ORCXKANACONVAREA
      *
           MOVE    KANACONV-OUTDATA    TO  KANACHK-MAE-INPUT
           MOVE    KANACONV-OUTDATA    TO  KANACHK-OUT-INPUT
           IF      KANACONV-MAXLEN     =   IDX-MAX
               MOVE    ZERO                TO  KANACHK-RC2
           ELSE
               MOVE    7                   TO  KANACHK-RC2
           END-IF
           MOVE    KANACONV-MAXLEN     TO  IDX-MAX
           MOVE    KANACONV-MAXLEN     TO  KANACHK-MAX
           IF      KANACHK-MAX-CNT     =   ZERO
               MOVE    5000                TO  KANACHK-MAX-CNT
           END-IF
      *
           .
       1000-KOUMOKU-CHK-EXT.
           EXIT.
      *
      *H29.9
      *****************************************************************
      *    改行判定処理
      *****************************************************************
       1009-KAIGYO-CHK-SEC           SECTION.
      *
      *    改行判定
           INITIALIZE                  ORCSSTRINGAREA
           MOVE    "search"            TO  ORCSSTR-COMMAND
           MOVE    KANACHK-OUT-INPUT   TO  ORCSSTR-STRING1
           MOVE    X"0A"               TO  ORCSSTR-STRING2
           CALL    "orcsstring"        USING
                                       ORCSSTRINGAREA
           IF      ORCSSTR-NUM1    NOT =   ZERO
               MOVE    1                   TO  KANACHK-RC4
           END-IF
           .
       1009-KAIGYO-CHK-EXT.
           EXIT.
      *
      *
      *****************************************************************
      *    全角判定処理
      *****************************************************************
       100-ZENKAKU-CHECK-SEC           SECTION.
      *
           MOVE    ZERO                TO  FLG-KANJI
           MOVE    ZERO                TO  FLG-KANA
           MOVE    ZERO                TO  FLG-KUHAKU
      *
           INITIALIZE                  ORCXKANACONVAREA
           MOVE    KANACHK-MAX-CNT     TO  KANACONV-LEN
           MOVE    5000                TO  KANACONV-STLEN
           MOVE    0                   TO  KANACONV-CONV-FLAG
           MOVE    15                  TO  KANACONV-CHAR-TYPE
           MOVE    KANACHK-MAE-INPUT   TO  KANACONV-INDATA
           CALL    "kanaconv"          USING ORCXKANACONVAREA
           IF      KANACONV-RETURN     =   ZERO
      *        全角のみ
               MOVE    1                   TO  FLG-KANJI
               INITIALIZE                  ORCXKANACONVAREA
               MOVE    KANACHK-MAX-CNT     TO  KANACONV-LEN
               MOVE    5000                TO  KANACONV-STLEN
               MOVE    1                   TO  KANACONV-CONV-FLAG
               MOVE    15                  TO  KANACONV-CHAR-TYPE
               MOVE    KANACHK-MAE-INPUT   TO  KANACONV-INDATA
               CALL    "kanaconv"          USING
                                           ORCXKANACONVAREA
               IF      KANACONV-MAXLEN     =   IDX-MAX
                   CONTINUE
               ELSE
      *            半角空白の置換えあり
                   MOVE    8                   TO  KANACHK-RC2
               END-IF
               MOVE    KANACONV-OUTDATA    TO  KANACHK-OUT-INPUT
               MOVE    2                   TO  KANACHK-SYUBETU
               MOVE    KANACONV-MAXLEN     TO  KANACHK-MAX
           ELSE
      *        半角のみの判定
               INITIALIZE                  ORCXKANACONVAREA
               MOVE    KANACHK-MAX-CNT     TO  KANACONV-LEN
               MOVE    5000                TO  KANACONV-STLEN
               MOVE    0                   TO  KANACONV-CONV-FLAG
               MOVE    113                 TO  KANACONV-CHAR-TYPE
               MOVE    KANACHK-MAE-INPUT   TO  KANACONV-INDATA
               CALL    "kanaconv"          USING
                                           ORCXKANACONVAREA
               IF      KANACONV-RETURN     =   ZERO
                   MOVE    1                   TO  KANACHK-SYUBETU
                   MOVE    KANACONV-MAXLEN     TO  KANACHK-MAX
                   MOVE    KANACONV-MAXLEN     TO  IDX-MAX
      *            間に空白があるかの判定
                   PERFORM 1001-KUHAKU-CHK-SEC
               ELSE
      *            混在エラー
                   MOVE    1                   TO  KANACHK-RC
               END-IF
           END-IF
      *
      *    全角空白の判定
           IF     (KANACHK-SYUBETU     =   2    )  AND
                  (KANACHK-RC          =   ZERO )
               PERFORM 1003-ZENSPACE-CHK-SEC
           END-IF
           .
       100-ZENKAKU-CHECK-EXT.
           EXIT.
      *
      *****************************************************************
      *    間に半角空白があるかの判定処理
      *****************************************************************
       1001-KUHAKU-CHK-SEC           SECTION.
      *
           INITIALIZE                  ORCXKANACONVAREA
           MOVE    KANACHK-MAX-CNT     TO  KANACONV-LEN
           MOVE    5000                TO  KANACONV-STLEN
           MOVE    0                   TO  KANACONV-CONV-FLAG
           MOVE    112                 TO  KANACONV-CHAR-TYPE
           MOVE    KANACHK-MAE-INPUT   TO  KANACONV-INDATA
           CALL    "kanaconv"          USING
                                       ORCXKANACONVAREA
           IF      KANACONV-RETURN NOT =   ZERO
               MOVE    8                   TO  KANACHK-RC2
           END-IF
      *
           .
       1001-KUHAKU-CHK-EXT.
           EXIT.
      *****************************************************************
      *    全角空白判定処理
      *****************************************************************
       1003-ZENSPACE-CHK-SEC           SECTION.
      *
           IF      KANACHK-SYORIKBN    =   "1"
      *        最後の全角空白削除
               PERFORM 10031-LASTDEL-HEN-SEC
           END-IF
      *
           MOVE    ZERO                TO  FLG-ZENKAKU1
           MOVE    ZERO                TO  FLG-ZENKAKU2
           MOVE    ZERO                TO  WRK-IDX1
           MOVE    ZERO                TO  WRK-IDX2
           PERFORM VARYING     IDX     FROM    1   BY  2
                   UNTIL       IDX     >   KANACHK-MAX
               IF      KANACHK-OUT-INPUT(IDX:2)    =   "　"
                   MOVE    1               TO  FLG-ZENKAKU2
                   MOVE    IDX             TO  WRK-IDX2
               ELSE
                   MOVE    1               TO  FLG-ZENKAKU1
                   MOVE    IDX             TO  WRK-IDX1
               END-IF
           END-PERFORM
           IF      FLG-ZENKAKU2        =   1
               IF      FLG-ZENKAKU1        =   1
      *            全角空白あり
                   MOVE    1               TO  KANACHK-RC3
      *            最後が全角空白
                   IF      WRK-IDX1        <   WRK-IDX2
                       MOVE    3               TO  KANACHK-RC3
                   END-IF
               ELSE
      *            全角空白のみ
                   MOVE    2               TO  KANACHK-RC3
               END-IF
           END-IF
           .
       1003-ZENSPACE-CHK-EXT.
           EXIT.
      *****************************************************************
      *    最後の全角空白削除処理
      *****************************************************************
       10031-LASTDEL-HEN-SEC           SECTION.
      *
           MOVE    ZERO                TO  WRK-IDX1
           MOVE    SPACE               TO  WRK-MEISYO
           COMPUTE WRK-IDX2            =   KANACHK-MAX   -  1
           PERFORM VARYING     IDX     FROM    WRK-IDX2  BY  -2
                   UNTIL       IDX     <   1
               IF      KANACHK-OUT-INPUT(IDX:2)    =   "　"
                   CONTINUE
               ELSE
                   COMPUTE WRK-IDX1        =   IDX     +   1
                   MOVE    KANACHK-OUT-INPUT(1:WRK-IDX1)
                                               TO  WRK-MEISYO
                   MOVE    2                   TO  IDX
               END-IF
               IF      IDX             =   1
                   MOVE    2               TO  IDX
               END-IF
           END-PERFORM
           MOVE    WRK-MEISYO          TO  KANACHK-OUT-INPUT
           MOVE    WRK-IDX1            TO  KANACHK-MAX
           .
       10031-LASTDEL-HEN-EXT.
           EXIT.
      *
      *****************************************************************
      *    全角処理
      *****************************************************************
       200-ZENKAKU-HENKAN-SEC           SECTION.
      *
           MOVE    2                   TO  KANACHK-SYUBETU
      *
           INITIALIZE                  ORCXKANACONVAREA
           MOVE    KANACHK-MAX-CNT     TO  KANACONV-LEN
           MOVE    5000                TO  KANACONV-STLEN
           MOVE    1                   TO  KANACONV-CONV-FLAG
           MOVE    15                  TO  KANACONV-CHAR-TYPE
           MOVE    KANACHK-MAE-INPUT   TO  KANACONV-INDATA
           CALL    "kanaconv"          USING
                                       ORCXKANACONVAREA
           IF      KANACONV-RETURN     =   ZERO
               MOVE    2                   TO  KANACHK-SYUBETU
               MOVE    KANACONV-OUTDATA    TO  KANACHK-OUT-INPUT
               MOVE    KANACONV-MAXLEN     TO  KANACHK-MAX
           ELSE
               MOVE    2                   TO  KANACHK-RC
           END-IF
      *
      *    全角空白の判定
           IF     (KANACHK-SYUBETU     =   2    )  AND
                  (KANACHK-RC          =   ZERO )
               PERFORM 1003-ZENSPACE-CHK-SEC
           END-IF
           .
       200-ZENKAKU-HENKAN-EXT.
           EXIT.
      *
