require "sqlite3"
require "yaml"
require "plugin"

module JMA::Plugin
  class DB
    def initialize(dbpath)
      @db = SQLite3::Database.new(dbpath)
      @db.type_translation = true
      tables = @db.execute("SELECT tbl_name FROM sqlite_master WHERE TYPE=?", "table").flatten
      create_table unless tables.include?("system")
    end

    def create_table
      @db.execute_batch(<<-SQL,JMA::Plugin::VERSION)
        CREATE TABLE system(version TEXT NOT NULL);
        CREATE TABLE control(
          id           INTEGER PRIMARY KEY,
          name         TEXT NOT NULL,
          version      TEXT NOT NULL, 
          description  TEXT, 
          vendor       TEXT NOT NULL,
          date         TEXT NOT NULL,
          url          TEXT NOT NULL,
          install      TEXT NOT NULL,
          link         TEXT NOT NULL,
          available    TEXT NOT NULL 
        );
      SQL
      @db.execute("INSERT INTO system VALUES (?);",JMA::Plugin::VERSION)
    end

    def version
      return @db.get_first_row("SELECT version FROM system;")[0]
    end

    def insert(control)
      @db.transaction {
        ids = @db.execute("SELECT id FROM control WHERE name=? AND version=?;",
          control[:name],
          control[:version])
        return unless ids.empty?
        @db.execute("INSERT INTO control (name,version,description,vendor,date,url,install,link,available) VALUES(?,?,?,?,?,?,?,?,?);",
          control[:name],
          control[:version],
          control[:description],
          control[:vendor],
          control[:date],
          control[:url],
          "FALSE", #install
          "FALSE", #link
          "TRUE"   #available
        )
      }
    end

    def id(name,version)
      ret = @db.execute("SELECT id FROM control WHERE name=? AND version=?;", name,version)
      return ret ? ret[0] : nil
    end

    def available(name,version)
      _id = id(name,version)
      @db.transaction {
        @db.execute("UPDATE control SET available=? WHERE id=?;","TRUE",_id)
      }
    end

    def disavailable(name,version)
      _id = id(name,version)
      @db.transaction {
        @db.execute("UPDATE control SET available=? WHERE id=?;","FALSE",_id)
      }
    end

    def delete_unavailable
      @db.transaction {
        @db.execute("DELETE FROM control WHERE available=? AND install=?;","FALSE","FALSE")
      }
    end

    def install(name,version)
      _id = id(name,version)
      list = @db.execute("SELECT id FROM control WHERE name = (SELECT name FROM control WHERE id=?) AND install='TRUE';",_id)
      if list.empty?
        @db.execute("UPDATE control SET install=? WHERE id=?;","TRUE",_id)
      end
    end

    def uninstall(name,version)
      _id = id(name,version)
      @db.execute("UPDATE control SET link=?,install=? WHERE id=?;","FALSE","FALSE",_id)
    end

    def install?(name,version)
      c = get_control(name,version)
      return c[:install] == "TRUE"
    end

    def link(name,version)
      _id = id(name,version)
      installed = @db.execute("SELECT install FROM control WHERE id=?;",_id)
      return if installed == "FALSE"
      list = @db.execute("SELECT id FROM control WHERE name = (SELECT name FROM control WHERE id=?) AND link='TRUE';",_id)
      return unless list.empty?
      @db.execute("UPDATE control SET link=? WHERE id=?;","TRUE",_id)
    end

    def unlink(name,version)
      _id = id(name,version)
      @db.execute("UPDATE control SET link=? WHERE id=?;","FALSE",_id)
    end

    def link?(name,version)
      c = get_control(name,version)
      return c[:link] == "TRUE"
    end

    def get_control(name,version)
      keys = [:id, :name,:version,:description,:vendor,:date,:url,:install,:link,:available]
      vals = @db.execute("SELECT * FROM control WHERE name=? AND version=?;",name,version).flatten
      return nil if vals.empty?
      list = keys.zip(vals)
      return  Hash[*list.flatten]
    end

    def list
      keys = @db.execute("SELECT name,version FROM control;")
      ret = keys.map{ |k| get_control(k[0],k[1])}
      ret.sort!{|a,b| 
        "#{a[:name]}-#{a[:version]}" <=> "#{b[:name]}-#{b[:version]}"
      }
      return ret
    end

    def list_available
      return list.select{|c| c[:available] == "TRUE"}
    end

    def list_installed
      return list.select{|c| c[:install] == "TRUE"}
    end

    def list_linked
      return list.select{|c| c[:link] == "TRUE"}
    end

    def list_vendor(name)
      return list.select{|c| c[:vendor] == name}
    end

  end
end
