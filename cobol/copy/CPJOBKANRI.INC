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
      ************************************************************
      *         ジョブ管理    COPY   (CPJOBKANRI.INC)            *
      ************************************************************
      ************************************************************
      *  コピー句修正履歴
      * Maj/Min/Rev  修正者       日付      内容
      ************************************************************
      *01  JOBKANRI-REC.
      *キー
           03  JOB-KEY.
      *ジョブ管理コード
               05  JOB-JOBID            PIC  9(07).
      *シェルＩＤ
               05  JOB-SHELLID          PIC  X(08).
      *シェルＭＳＧ
           03  JOB-SHELLMSG             PIC  X(100).
      *端末ＩＤ
           03  JOB-TERMID               PIC  X(32).
      *オペーレータＩＤ
           03  JOB-OPID                 PIC  X(16).
      *オペーレータＩＤ
           03  JOB-PGID                 PIC  X(20).
      *ジョブ開始年月日
           03  JOB-STARTYMD             PIC  X(08).
      *ジョブ終了年月日
           03  JOB-ENDYMD               PIC  X(08).
      *ジョブ開始時間
           03  JOB-STARTTIME            PIC  X(08).
      *ジョブ終了時間
           03  JOB-ENDTIME              PIC  X(08).
      *ステップ開始時間
           03  JOB-STEPSTARTTIME        PIC  X(08).
      *ステップ終了時間
           03  JOB-STEPENDTIME          PIC  X(08).
      *パラメータ
           03  JOB-PARAM                PIC  X(256).
      *エラーコード
           03  JOB-ERRCD                PIC  X(04).
      *診療年月日
           03  JOB-SRYYMD               PIC  X(08).
      *患者ＩＤ
           03  JOB-PTID                 PIC  9(10).
      *更新件数
           03  JOB-UPDCNT               PIC  9(10).
      *予備
           03  JOB-YOBI                 PIC  X(500).
