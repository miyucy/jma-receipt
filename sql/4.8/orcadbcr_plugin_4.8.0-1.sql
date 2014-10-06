CREATE TABLE tbl_plugin (
  name varchar(256) not null,
  version varchar(256) not null,
  description varchar(1024),
  vender varchar(256) not null,
  create_date date not null,
  url varchar(512) not null,
  install boolean not null,
  link boolean not null,
  available boolean not null,
  PRIMARY KEY(name,version)
);
