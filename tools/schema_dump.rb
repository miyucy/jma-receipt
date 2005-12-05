#! /usr/bin/env ruby

PSQL = 'psql'
PG_DUMP = 'pg_dump'

TABLE='table'
VIEW='view'

def table_list_sql(type)
  relkind = nil
  if type == TABLE
    relkind = "r"
  elsif type == VIEW
    relkind = "v"
  else
    return ""
  end
  sql  = "SELECT c.relname "
  sql += "  FROM pg_catalog.pg_class c "
  sql += "  LEFT JOIN pg_catalog.pg_user u ON u.usesysid = c.relowner "
  sql += "  LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace "
  sql += " WHERE c.relkind = '#{relkind}' "
  sql += "   AND n.nspname NOT IN ('pg_catalog', 'pg_toast') "
  sql += "   AND pg_catalog.pg_table_is_visible(c.oid) "
  sql += " ORDER BY 1; "
end

def tschema_parse(schema)
  table_schema = Array.new
  schema.each {|line|
    next if line =~ /^$/
    next if line =~ /^--/
    next if line =~ /^--/
    next if line =~ /^SET/
    table_schema << line
    table_schema << "\n" if line =~ /\;$/
  }
  table_schema
end

def vschema_parse(schema)
  table_schema = Array.new
  schema.each {|line|
    next if line =~ /^$/
    next if line =~ /^--/
    next if line =~ /^--/
    next if line =~ /^SET/
    line.gsub!(/, /,",\n           ")
    line.gsub!(/(OR |AND |FROM |WHERE |LEFT |USING |GROUP |ON )/){|s|
      sprintf("\n%11s", s)
    }
    line.gsub!(/[^\s+](SELECT )/){|s|
      sprintf("\n%11s", s)
    }
    table_schema << line
    table_schema << "\n" if line =~ /\;$/
  }
  table_schema
end

def dump_table(outputdir, db, type)
  sql = table_list_sql(type)
  table_list = `#{PSQL} -c "#{sql}" -t #{db}`
  table_list.each{|table|
    table.strip!.chomp!
    next if table.empty?
    print "..." + table + "\n"
    schema = `#{PG_DUMP} -s -O -t #{table} #{db}`
    if type == TABLE
      table_schema = tschema_parse(schema)
    elsif type == VIEW
      table_schema = vschema_parse(schema)
    end
    Dir.mkdir(outputdir) if (!File.exists?(outputdir))
    file = File.open(outputdir + "/" + table + ".sql", "w")
    file.print table_schema
    file.close
  }
end

require 'optparse'

db='orca'
outputdir = "./sql/schema"

OptionParser.new {|opt|
  begin
    opt.on('-d', '--db', 'database name'){|v|
      db = v.to_s
    }
    opt.on('-O', '--outputdir', 'output dir'){|v|
      outputdir = v.to_s
    }
    opt.parse!(ARGV)
  rescue
    puts opt
    exit
  end
}

dump_table(outputdir, db, TABLE)
dump_table(outputdir, db, VIEW)
