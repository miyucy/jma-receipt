--                                --
-- ORCA DataBase Table Definition --
--                                --
-- ジョブログ管理                 --
--                                --
-- Table Name  : TBL_KOHPLUS      --
-- Create Date : 2006/10/23       --
--                                --

CREATE TABLE tbl_joblog (
  logymd character(8) NOT NULL,
  logtime character(6) NOT NULL,
  progname character varying(20) NOT NULL,
  kbnid character(1) NOT NULL,
  object_yym character(6),
  result character(1),
  errcode character(4),
  msg character varying(200),
  constraint tbl_joblog_primary_key PRIMARY KEY
	 (logymd, logtime, progname, kbnid)
);
