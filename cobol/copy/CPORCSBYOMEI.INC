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
      *    病名コード検索用パラメタ      COPY (CPORCSBYOMEI.INC)
      *                                  使用プログラム (ORCSBYOMEI)
      *    設定項目
      *      処理区分  １：病名  ２：病名コード
      *      主病名フラグ
      *      病名
      *      開始日
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      *  00.00.01    NACL-藤原    04/03/17  開始日・疑いフラグの追加
      *
      *  04.05.01    NACL-藤原    09/11/25  レセ電コメント拡張対応
      *                                     補足コメントの追加
      *                                     単独使用禁止病名の追加
      *
      *  04.06.01    NACL-藤原    10/10/20  難病外来指導管理料対応
      *                                     難病外来コードの追加
      ************************************************************
      *
       01  ORCSBYOMEIAREA.
      *    処理区分    １：病名より編集
      *                ２：病名コードより編集
      *                ３：病名より編集（補足コメントあり）
      *                ４：病名コードより編集（補足コメントあり）
           03  LNK-BYO-SYORI           PIC X(01).
      *    復帰コード  １：処理区分エラー
      *                ２：病名未入力
      *                ３：病名コード未入力
      *                ４：主病名フラグエラー
      *                ９：処理区分４のとき病名不一致エラー
           03  LNK-BYO-RC              PIC X(01).
      *    主病名フラグ
      *                １：主病名 
           03  LNK-BYO-SYUBYOFLG       PIC X(01).
      *    病名
           03  LNK-BYO-BYOMEI          PIC X(200).
      *    開始日
           03  LNK-BYO-SRYYMD-IN       PIC 9(08).
      *    疑いフラグ
      *                １：急性
      *                ２：疑い
      *                ３：急性かつ疑い
           03  LNK-BYO-UTAGAIFLG-IN    PIC X(01).
      *
      *    病名情報
           03  LNK-BYOMEI-KENSAKU-AREA.
      *        基本病名コード
               05  LNK-BYO-KHNBYOMEICD PIC X(07).
      *        基本部位コード
               05  LNK-BYO-KHNBUICD    PIC X(07)   OCCURS  3.
      *        病名コード数
               05  LNK-BYO-BYOMEICDSU  PIC 9(02).
      *        疑いフラグ
               05  LNK-BYO-UTAGAIFLG   PIC X(01).
      *        慢性フラグ
               05  LNK-BYO-MANSEIKBN   PIC 9(02).
      *        難病外来コード
               05  LNK-BYO-NANBYOCD    PIC 9(02).
      *        病名文字数
               05  LNK-BYO-BYOMEIMOJI  PIC 9(03).
      *        病名編集フラグ
               05  LNK-BYO-BYOMEIHENFLG
                                       PIC X(01).
      *        移行先コード
               05  LNK-BYO-IKOSAKICD   PIC X(07).
      *        移行先病名
               05  LNK-BYO-IKOSAKICD-BYOMEI
                                       PIC X(200).
      *        移行先病名コード
               05  LNK-BYO-IKOSAKICD-INDEX
                                       PIC 9(02).
      *        病名種別 
               05  LNK-BYO-BYOMEISBT   PIC 9(01). 
      *        レセ電エラーフラグ
               05  LNK-BYO-RECEDENFLG  PIC X(01).
      *
      *    検索病名エラー情報
           03  LNK-BYOMEI-KENSAKU-ERR-AREA.
      *        １：半角チェックエラー、２：８０桁以上
               05  LNK-BYO-KANACHK-ERR PIC 9(01).
      *        単独使用禁止エラー
               05  LNK-BYO-TANDOKUKBN-ERR
                                       PIC 9(01).
      *        単独使用禁止病名
               05  LNK-BYO-TANDOKUKBN-BYOMEI
                                       PIC X(200).
      *        廃止年月日エラー
               05  LNK-BYO-HAISIYMD-ERR
                                       PIC 9(08).
      *        病名コードＭＡＸエラー
               05  LNK-BYO-BYOMEICD-MAX-ERR
                                       PIC 9(01).
      *        １：修飾語のみ、２：入力順エラー
      *        ３：病名コード存在エラー、９：基本病名複数存在
               05  LNK-BYO-BYOMEICD-ERR
                                       PIC 9(01).
      *
      *    検索病名コード情報
      *
           03  LNK-BYO-BYOMEI-MAX      PIC 9(02).
      *
           03  LNK-BYOMEICD-KENSAKU-AREA.
               05  LNK-BYO-BYOMEICD-G  OCCURS  21.
      *            病名
                   07  LNK-BYO-TBYOMEI PIC X(60).
      *            病名コード
                   07  LNK-BYO-TBYOMEICD
                                       PIC X(07).
      *            移行先コード
                   07  LNK-BYO-TIKOSAKICD 
                                       PIC X(07).
      *            廃止年月日
                   07  LNK-BYO-THAISIYMD 
                                       PIC X(08).
      *            単独使用禁止区分
                   07  LNK-BYO-TTANDOKUKBN 
                                       PIC 9(02).
      *            特定疾患コード
                   07  LNK-BYO-TTOKSKNCD
                                       PIC 9(02).
      *            難病外来コード
                   07  LNK-BYO-TNANBYOCD
                                       PIC 9(02).
      *            疑いフラグ
                   07  LNK-BYO-TUTAGAIFLG
                                       PIC X(01).
      *    病名コード最終位置
           03  LNK-BYO-HOSOKU-BYOMEICD-MAX
                                       PIC 9(02).
      *    補足コメントを除いた病名の長さ
           03  LNK-BYO-BYOMEI-LEN      PIC 9(03).
      *    補足コメントを除いた病名
           03  LNK-BYO-HOSOKU-BYOMEI-ETC
                                       PIC X(200).
      *    補足コメント
           03  LNK-BYO-HOSOKU-BYOMEI   PIC X(40).
